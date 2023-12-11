/**
 * Copyright 2023 Google LLC
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



locals {
  ip_cidr_range = "10.0.0.0/16"
}

resource "google_compute_network" "default" {
  name                    = "regional-proxy-mig-network"
  auto_create_subnetworks = "false"
  project                 = var.project_id
}

resource "google_compute_subnetwork" "default" {
  name          = "load-balancer-module-subnetwork"
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.default.self_link
  ip_cidr_range = local.ip_cidr_range
}


resource "google_compute_router" "default" {
  name    = "load-balancer-module-router"
  region  = var.region
  project = var.project_id
  network = google_compute_network.default.self_link
}


module "cloud_nat" {
  project_id = var.project_id
  region     = var.region
  name       = "load-balancer-module-nat"
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  router     = google_compute_router.default.name
}

resource "google_compute_firewall" "all-internal" {
  name          = "fw-all-internal"
  network       = google_compute_network.default.name
  source_ranges = [local.ip_cidr_range]
  project       = var.project_id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }
}
