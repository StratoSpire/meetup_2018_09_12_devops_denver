
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

BUILD_TERRAFORM_VERSION ?= 0.11.8
BUILD_CLOUD_SDK_VERSION ?= 216.0.0
BUILD_PROVIDER_GOOGLE_VERSION ?= 1.17.1
BUILD_PROVIDER_GSUITE_VERSION ?= 0.1.8
DOCKER_IMAGE := stratospire/$(shell basename $(shell pwd))
DOCKER_TAG ?= ${BUILD_TERRAFORM_VERSION}_${BUILD_CLOUD_SDK_VERSION}_${BUILD_PROVIDER_GOOGLE_VERSION}_${BUILD_PROVIDER_GSUITE_VERSION}

.PHONY: docker_build
docker_build:
	docker build . \
		--build-arg BUILD_TERRAFORM_VERSION=${BUILD_TERRAFORM_VERSION} \
		--build-arg BUILD_CLOUD_SDK_VERSION=${BUILD_CLOUD_SDK_VERSION} \
		--build-arg BUILD_PROVIDER_GOOGLE_VERSION=${BUILD_PROVIDER_GOOGLE_VERSION} \
		--build-arg BUILD_PROVIDER_GSUITE_VERSION=${BUILD_PROVIDER_GSUITE_VERSION} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: docker_push
docker_push:
	docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
