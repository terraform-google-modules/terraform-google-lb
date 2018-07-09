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

resource "google_compute_forwarding_rule" "default" {
  project               = "${var.project}"
  name                  = "${var.name}"
  target                = "${google_compute_target_pool.default.self_link}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "${var.service_port}"
}

resource "google_compute_target_pool" "default" {
  project          = "${var.project}"
  name             = "${var.name}"
  region           = "${var.region}"
  session_affinity = "${var.session_affinity}"

  health_checks = [
    "${google_compute_http_health_check.default.self_link}",
  ]
}

resource "google_compute_http_health_check" "default" {
  project     = "${var.project}"
  name        = "${var.name}-hc"
  port        = "${var.hc_port}"
  request_path = "${var.hc_path}"
}

resource "google_compute_firewall" "default-lb-fw-ips" {
  project  = "${var.project}"
  name    = "${var.name}-lb-ips"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["${var.service_port}"]
  }

  source_ranges = ["${var.source_ranges}"]
  target_tags   = ["${var.target_tags}"]
}

resource "google_compute_firewall" "default-hc" {
  project   = "${var.project}"
  name    = "${var.name}-hc"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["${var.hc_port}"]
  }

  source_ranges = ["209.85.152.0/22", "209.85.204.0/22","35.191.0.0/16"]
  target_tags   = ["${var.target_tags}"]
}