
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM alpine:3.8 as builder

RUN apk add --no-cache \
        bash \
        git \
        go \
        make \
        musl-dev

ENV GOPATH="/root/go"

ARG BUILD_PROVIDER_GOOGLE_VERSION="1.17.1"
ENV PROVIDER_GOOGLE_VERSION="${BUILD_PROVIDER_GOOGLE_VERSION}"

RUN mkdir -p /root/.terraform.d/plugins && \
    mkdir -p $GOPATH/src/github.com/terraform-providers && \
    cd $GOPATH/src/github.com/terraform-providers && \
    git clone https://github.com/terraform-providers/terraform-provider-google.git && \
    cd terraform-provider-google && \
    git fetch --all --tags --prune && \
    git checkout tags/v${PROVIDER_GOOGLE_VERSION} -b v${PROVIDER_GOOGLE_VERSION} && \
    make build && \
    mv $GOPATH/bin/terraform-provider-google /root/.terraform.d/plugins

FROM alpine:3.8

RUN apk add --no-cache \
        bash \
        curl \
        git \
        jq \
        make \
        python3

ENV GOOGLE_APPLICATION_CREDENTIALS="/root/.google_sa_key.json"

ENV PATH /google-cloud-sdk/bin:$PATH

ARG BUILD_CLOUD_SDK_VERSION="216.0.0"
ENV CLOUD_SDK_VERSION="${BUILD_CLOUD_SDK_VERSION}"

RUN curl -LO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version

ARG BUILD_TERRAFORM_VERSION="0.11.8"
ENV TERRAFORM_VERSION="${BUILD_TERRAFORM_VERSION}"

RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin

COPY --from=builder /root/.terraform.d/plugins /root/.terraform.d/plugins

ARG BUILD_PROVIDER_GSUITE_VERSION="0.1.8"
ENV PROVIDER_GSUITE_VERSION="${BUILD_PROVIDER_GSUITE_VERSION}"

RUN curl -LO https://github.com/DeviaVir/terraform-provider-gsuite/releases/download/v${PROVIDER_GSUITE_VERSION}/terraform-provider-gsuite_${PROVIDER_GSUITE_VERSION}_linux_amd64.tgz && \
    tar xzf terraform-provider-gsuite_${PROVIDER_GSUITE_VERSION}_linux_amd64.tgz && \
    rm terraform-provider-gsuite_${PROVIDER_GSUITE_VERSION}_linux_amd64.tgz && \
    mv terraform-provider-gsuite_v${PROVIDER_GSUITE_VERSION} ~/.terraform.d/plugins/terraform-provider-gsuite

WORKDIR /root
