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

variable "project" {
  type        = string
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable "region" {
  type        = string
  description = "Region used for GCP resources."
}

variable "network" {
  type        = string
  description = "Name of the network to create resources in."
  default     = "default"
}

variable "firewall_project" {
  type        = string
  description = "Name of the project to create the firewall rule in. Useful for shared VPC. Default is var.project."
  default     = ""
}

variable "name" {
  type        = string
  description = "Name for the forwarding rule and prefix for supporting resources."
}

variable "service_port" {
  type        = number
  description = "TCP port your service is listening on."
}

variable "target_tags" {
  description = "List of target tags to allow traffic using firewall rule."
  type        = list(string)
  default     = null
}

variable "target_service_accounts" {
  description = "List of target service accounts to allow traffic using firewall rule."
  type        = list(string)
  default     = null
}

variable "session_affinity" {
  type        = string
  description = "How to distribute load. Options are `NONE`, `CLIENT_IP` and `CLIENT_IP_PROTO`"
  default     = "NONE"
}

variable "disable_health_check" {
  type        = bool
  description = "Disables the health check on the target pool."
  default     = false
}

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    port                = number
    request_path        = string
    host                = string
  })
  default = {
    check_interval_sec  = null
    healthy_threshold   = null
    timeout_sec         = null
    unhealthy_threshold = null
    port                = null
    request_path        = null
    host                = null
  }
}

variable "ip_address" {
  description = "IP address of the external load balancer, if empty one will be assigned."
  default     = null
}

variable "ip_protocol" {
  description = "The IP protocol for the frontend forwarding rule and firewall rule. TCP, UDP, ESP, AH, SCTP or ICMP."
  default     = "TCP"
}

variable "allowed_ips" {
  description = "The IP address ranges which can access the load balancer."
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "labels" {
  description = "The labels to attach to resources created by this module."
  default     = {}
  type        = map(string)
}
