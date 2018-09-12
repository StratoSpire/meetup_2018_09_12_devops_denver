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

module "example-kubernetes-engine" {
  source            = "../../modules/kubernetes-engine"
  project_id        = "${module.example-project.project_id}"
  name              = "meetup-example-cluster"
  region            = "${module.example-network.subnets_regions[0]}"
  zones             = ["us-central1-a", "us-central1-c", "us-central1-f"]
  network           = "${module.example-network.network_name}"
  subnetwork        = "${module.example-network.subnets_names[0]}"
  ip_range_pods     = "us-central1-01-gke-01-pod"
  ip_range_services = "us-central1-01-gke-01-service"

  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = "n1-standard-1"
      min_count       = 1
      max_count       = 2
      auto_upgrade    = false
      service_account = "project-service-account@meetup-example-project-dd9e.iam.gserviceaccount.com"
    },
  ]
}
