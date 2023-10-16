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

output "backend_services" {
  description = "The backend service resources."
  value       = google_compute_region_backend_service.default
  sensitive   = true // can contain sensitive iap_config
}

output "forwarding_rule" {
  description = "The forwarding rule of the load balancer."
  value       = google_compute_forwarding_rule.default
}


output "tcp_proxy" {
  description = "The TCP proxy used by this module."
  value       = google_compute_region_target_tcp_proxy.default.self_link
}
