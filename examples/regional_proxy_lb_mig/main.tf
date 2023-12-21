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
  tags      = ["dummy-ig"]
  port_name = "app1"
}

module "instance_template" {
  source       = "terraform-google-modules/vm/google//modules/instance_template"
  version      = "~> 10.0"
  project_id   = var.project_id
  subnetwork   = google_compute_subnetwork.default.id
  machine_type = "e2-small"
  service_account = {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }
  subnetwork_project = var.project_id
  tags               = local.tags
  labels             = { env = "test" }

  source_image         = "debian-11-bullseye-v20231004"
  source_image_family  = "debian-11"
  source_image_project = "debian-cloud"

  # install nginx and serve a simple web page
  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      set -euo pipefail
      export DEBIAN_FRONTEND=noninteractive
      apt update
      apt install -y nginx-light jq
      NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
      IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
      METADATA=$(curl -f -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=True" | jq 'del(.["startup-script"])')
      cat <<EOF > /var/www/html/index.html
      <pre>
      Name: $NAME
      IP: $IP
      Metadata: $METADATA
      </pre>
      EOF
    EOF1

  }
}

module "mig" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "~> 10.0"
  project_id        = var.project_id
  region            = var.region
  target_size       = 2
  hostname          = "mig-simple"
  instance_template = module.instance_template.self_link
  named_ports = [{
    name = local.port_name
    port = 80
  }]
}


module "regional_proxy_lb" {
  source  = "terraform-google-modules/lb/google//modules/regional_proxy_lb"
  version = "~> 4.0"

  name                     = "my-tcp-lb"
  region                   = var.region
  project                  = var.project_id
  network_project          = var.project_id
  network                  = google_compute_network.default.id
  target_tags              = local.tags
  port_front_end           = 101
  create_proxy_only_subnet = true
  proxy_only_subnet_cidr   = "10.129.0.0/23"
  create_firewall_rules    = true
  health_check = {
    description        = "Health check to determine whether instances are responsive and able to do work"
    check_interval_sec = 10
    tcp_health_check = {
      port_specification = "USE_SERVING_PORT"
    }
  }


  backend = {
    description  = "load balancer with MIG as backend 1"
    port_name    = local.port_name
    description  = "load balancer with MIG as backend 2"
    backend_type = "INSTANCE_GROUP"
    #confirmed
    session_affinity = "CLIENT_IP"
    timeout_sec      = 50 #default 30

    log_config = {
      enable      = true
      sample_rate = 0.8
    }

    groups = [{
      group = module.mig.instance_group

      balancing_mode               = "UTILIZATION"
      capacity_scaler              = 0.5
      description                  = "an instance group"
      max_connections_per_instance = 1000
      max_rate_per_instance        = null
      max_utilization              = 0.9
    }]
  }
}
