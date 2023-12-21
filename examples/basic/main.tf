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

data "template_file" "instance_startup_script" {
  template = file("${path.module}/templates/gceme.sh.tpl")

  vars = {
    PROXY_PATH = ""
  }
}

resource "google_service_account" "instance-group" {
  account_id = "instance-group"
}

module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "~> 10.0"
  subnetwork           = google_compute_subnetwork.subnetwork.self_link
  source_image_family  = var.image_family
  source_image_project = var.image_project
  startup_script       = data.template_file.instance_startup_script.rendered

  service_account = {
    email  = google_service_account.instance-group.email
    scopes = ["cloud-platform"]
  }
}

module "managed_instance_group" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "~> 10.0"
  region            = var.region
  target_size       = 2
  hostname          = "mig-simple"
  instance_template = module.instance_template.self_link

  target_pools = [
    module.load_balancer_default.target_pool,
    module.load_balancer_no_hc.target_pool,
    module.load_balancer_custom_hc.target_pool
  ]

  named_ports = [{
    name = "http"
    port = 80
  }]
}

module "load_balancer_default" {
  source  = "terraform-google-modules/lb/google"
  version = "~> 4.0"

  name         = "basic-load-balancer-default"
  region       = var.region
  service_port = 80
  network      = google_compute_network.network.name

  target_service_accounts = [google_service_account.instance-group.email]
}

module "load_balancer_no_hc" {
  source  = "terraform-google-modules/lb/google"
  version = "~> 4.0"

  name                 = "basic-load-balancer-no-hc"
  region               = var.region
  service_port         = 80
  network              = google_compute_network.network.name
  disable_health_check = true

  target_service_accounts = [google_service_account.instance-group.email]
}

module "load_balancer_custom_hc" {
  source  = "terraform-google-modules/lb/google"
  version = "~> 4.0"

  name         = "basic-load-balancer-custom-hc"
  region       = var.region
  service_port = 8080
  network      = google_compute_network.network.name
  health_check = local.health_check

  target_service_accounts = [google_service_account.instance-group.email]
}
