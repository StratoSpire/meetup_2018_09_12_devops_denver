/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "example-network" {
  source       = "../../modules/network"
  project_id   = "${module.example-project.project_id}"
  network_name = "meetup-example-network"

  subnets = [
    {
      subnet_name   = "us-central1-01"
      subnet_ip     = "10.1.0.0/16"
      subnet_region = "us-central1"

      subnet_private_access = true
    },
  ]

  secondary_ranges = {
    us-central1-01 = [
      {
        range_name    = "us-central1-01-gke-01-pod"
        ip_cidr_range = "10.5.0.0/16"
      },
      {
        range_name    = "us-central1-01-gke-01-service"
        ip_cidr_range = "10.6.0.0/16"
      },
    ]
  }
}
