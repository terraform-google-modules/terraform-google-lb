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

locals {
  ports_num  = "${length(split(",", var.service_port))}"
  ports_tail = "${slice(split(",", var.service_port), 1, local.ports_num)}"
}

resource "google_compute_address" "multiport" {
  count = "${local.ports_num > 1 || var.force_static_ip ? 1 : 0}"
  name  = "${var.name}"
}

resource "google_compute_forwarding_rule" "default" {
  project               = "${var.project}"
  name                  = "${var.name}"
  target                = "${google_compute_target_pool.default.self_link}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "${element(split(",", var.service_port), 0)}"
  ip_address            = "${element(concat(google_compute_address.multiport.*.address, list("")), 0)}"
}

resource "google_compute_forwarding_rule" "multiport" {
  project               = "${var.project}"
  count                 = "${length(local.ports_tail)}"
  name                  = "${var.name}-${element(local.ports_tail, count.index)}"
  target                = "${google_compute_target_pool.default.self_link}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "${element(local.ports_tail, count.index)}"
  ip_address            = "${element(google_compute_address.multiport.*.address, 0)}"
}

resource "google_compute_target_pool" "default" {
  project          = "${var.project}"
  name             = "${var.name}"
  region           = "${var.region}"
  session_affinity = "${var.session_affinity}"

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]
}

resource "google_compute_http_health_check" "default" {
  project             = "${var.project}"
  name                = "${var.name}-hc"
  request_path        = "${var.health_check_path}"
  port                = "${length(var.health_check_port) > 0 ? var.health_check_port : var.service_port}"
  timeout_sec         = "${var.health_check_timeout}"
  check_interval_sec  = "${var.health_check_interval}"
  healthy_threshold   = "${var.healthy_threshold}"
  unhealthy_threshold = "${var.unhealthy_threshold}"
}

resource "google_compute_firewall" "default-lb-fw" {
  project = "${var.firewall_project == "" ? var.project : var.firewall_project}"
  name    = "${var.name}-vm-service"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["${length(var.health_check_port) > 0 ? var.health_check_port : var.service_port}"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.target_tags}"]
}
