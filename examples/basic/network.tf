/**
 * Copyright 2019 Google LLC
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

resource "google_compute_network" "network" {
  name                    = "load-balancer-module-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "load-balancer-module-subnetwork"
  region        = var.region
  network       = google_compute_network.network.self_link
  ip_cidr_range = "10.0.0.0/16"
}

resource "google_compute_router" "router" {
  name    = "load-balancer-module-router"
  region  = var.region
  network = google_compute_network.network.self_link
}

module "cloud_nat" {
  project_id = var.project_id
  region     = var.region
  name       = "load-balancer-module-nat"
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  router     = google_compute_router.router.name
}
