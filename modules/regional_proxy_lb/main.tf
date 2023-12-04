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
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

resource "google_compute_subnetwork" "proxy_only_subnet" {
  count         = var.create_proxy_only_subnet ? 1 : 0
  name          = "proxy-only-subnet"
  ip_cidr_range = var.proxy_only_subnet_cidr
  region        = var.region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  project       = var.project
  network       = var.network
}

# forwarding rule
resource "google_compute_forwarding_rule" "default" {
  name                  = "${var.name}-fwd-rule"
  project               = var.project
  ip_protocol           = local.ip_protocol
  load_balancing_scheme = local.load_balancing_scheme
  network_tier          = "STANDARD"
  port_range            = var.port_front_end
  region                = var.region
  network               = var.network
  target                = google_compute_region_target_tcp_proxy.default.id
  ip_address            = var.address
  depends_on            = [google_compute_subnetwork.proxy_only_subnet]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name            = "${var.name}-proxy"
  project         = var.project
  region          = var.region
  backend_service = google_compute_region_backend_service.default.id
}

# backend service
resource "google_compute_region_backend_service" "default" {
  name                  = var.name
  project               = var.project
  region                = var.region
  protocol              = local.ip_protocol
  port_name             = var.backend.backend_type == "INSTANCE_GROUP" ? var.backend.port_name : null
  load_balancing_scheme = local.load_balancing_scheme
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.default.id]
  dynamic "backend" {
    for_each = toset(var.backend.groups)
    content {
      description = backend.value.description
      group       = backend.value.group

      balancing_mode               = lookup(backend.value, "balancing_mode")
      capacity_scaler              = lookup(backend.value, "capacity_scaler")
      max_connections              = lookup(backend.value, "max_connections")
      max_connections_per_instance = lookup(backend.value, "max_connections_per_instance")
      max_connections_per_endpoint = lookup(backend.value, "max_connections_per_endpoint")
      max_rate                     = lookup(backend.value, "max_rate")
      max_rate_per_instance        = lookup(backend.value, "max_rate_per_instance")
      max_rate_per_endpoint        = lookup(backend.value, "max_rate_per_endpoint")
      max_utilization              = lookup(backend.value, "max_utilization")
    }
  }

  log_config {

    enable      = var.backend.log_config.enable
    sample_rate = var.backend.log_config.sample_rate

  }
}

resource "google_compute_region_health_check" "default" {
  name    = "${var.name}-hc"
  project = var.project
  region  = var.region


  check_interval_sec  = lookup(var.health_check, "check_interval_sec", null)
  timeout_sec         = lookup(var.health_check, "timeout_sec", null)
  healthy_threshold   = lookup(var.health_check, "healthy_threshold", null)
  unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", null)


  tcp_health_check {
    request            = lookup(var.health_check.tcp_health_check, "request", null)
    response           = lookup(var.health_check.tcp_health_check, "response", null)
    port               = lookup(var.health_check.tcp_health_check, "port", null)
    port_name          = lookup(var.health_check.tcp_health_check, "port_name", null)
    port_specification = lookup(var.health_check.tcp_health_check, "port_specification", null)
    proxy_header       = lookup(var.health_check.tcp_health_check, "proxy_header", null)
  }

  log_config {
    enable = lookup(var.health_check, "logging", false)
  }
}

data "google_netblock_ip_ranges" "hcs" {
  range_type = "health-checkers"
}

# allow access from health check ranges
resource "google_compute_firewall" "default-hc-fw" {
  count         = var.create_firewall_rules ? 1 : 0
  name          = "${var.name}-allow-hc"
  direction     = "INGRESS"
  project       = var.network_project
  network       = var.network
  source_ranges = data.google_netblock_ip_ranges.hcs.cidr_blocks_ipv4
  allow {
    protocol = local.ip_protocol
  }
  target_tags = var.target_tags
}

resource "google_compute_firewall" "default-proxy-fw" {
  count         = var.create_firewall_rules ? 1 : 0
  name          = "${var.name}-allow-proxy"
  direction     = "INGRESS"
  project       = var.network_project
  network       = var.network
  source_ranges = [var.proxy_only_subnet_cidr]
  allow {
    protocol = local.ip_protocol
  }
  target_tags = var.target_tags
}
