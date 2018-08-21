/*
 * Copyright 2017 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-b"
}

variable "network_name" {
  default = "tf-lb-basic"
}

provider "google" {
  region = "${var.region}"
}

resource "google_compute_network" "default" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "default" {
  name                     = "${var.network_name}"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = "${google_compute_network.default.self_link}"
  region                   = "${var.region}"
  private_ip_google_access = true
}

data "template_file" "group1-startup-script" {
  template = "${file("${format("%s/gceme.sh.tpl", path.module)}")}"

  vars {
    PROXY_PATH = ""
  }
}

module "mig1" {
  source            = "GoogleCloudPlatform/managed-instance-group/google"
  version           = "1.1.13"
  region            = "${var.region}"
  zone              = "${var.zone}"
  name              = "group1"
  size              = 2
  service_port      = 80
  service_port_name = "http"
  http_health_check = false
  target_pools      = ["${module.gce-lb-fr.target_pool}"]
  target_tags       = ["allow-service1"]
  startup_script    = "${data.template_file.group1-startup-script.rendered}"
  network           = "${google_compute_subnetwork.default.name}"
  subnetwork        = "${google_compute_subnetwork.default.name}"
}

module "gce-lb-fr" {
  source       = "../../"
  region       = "${var.region}"
  name         = "group1-lb"
  service_port = "${module.mig1.service_port}"
  target_tags  = ["${module.mig1.target_tags}"]
  network      = "${google_compute_subnetwork.default.name}"
}

output "load-balancer-ip" {
  value = "${module.gce-lb-fr.external_ip}"
}
