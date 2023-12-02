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

variable "name" {
  type        = string
  description = "Name of the load balancer and prefix for supporting resources."
}

variable "project" {
  type        = string
  description = "The project to deploy to, if not set the default provider project is used."
  default     = null
}

variable "region" {
  type        = string
  description = "Region of the created GCP resources from this module."
}

variable "network" {
  type        = string
  description = "Name of the network to create resources in."
}

variable "network_project" {
  type        = string
  description = "Name of the project where the network resides. Useful for shared VPC. Default is var.project."
}

variable "create_firewall_rules" {
  description = "Whether to create firewall rules for health check and proxy"
  type        = bool
  default     = false
}

variable "target_tags" {
  description = "List of target tags to allow traffic using firewall rule."
  type        = list(string)
}


variable "address" {
  description = "IP address of the external load balancer, if not provided, an ephemeral address will be created"
  type        = string
  default     = null
}

variable "create_proxy_only_subnet" {
  description = "Whether to create the proxy only subnet for the region"
  type        = bool
  default     = false
}

variable "proxy_only_subnet_cidr" {
  type        = string
  description = "The CIDR block of the proxy only subnet"
}

variable "port_front_end" {
  description = "Port of the load balancer front end"
  type        = number
}

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    check_interval_sec  = optional(number)
    healthy_threshold   = optional(number)
    timeout_sec         = optional(number)
    unhealthy_threshold = optional(number)
    tcp_health_check = object({
      request            = optional(string)
      response           = optional(string)
      port               = optional(number)
      port_name          = optional(string)
      port_specification = optional(string)
      proxy_header       = optional(string)
      }
    )
    }
  )
}

variable "backend" {
  description = "backend attributes"
  type = object({
    port             = optional(number)
    port_name        = optional(string)
    description      = optional(string)
    backend_type     = string #INSTANCE_GROUP, NETWORK_ENDPOINT_GROUP
    session_affinity = optional(string)
    timeout_sec      = optional(number)

    log_config = object({
      enable      = optional(bool)
      sample_rate = optional(number)
    })

    groups = list(object({
      group = string

      balancing_mode               = optional(string)
      capacity_scaler              = optional(number)
      description                  = optional(string)
      max_connections              = optional(number)
      max_connections_per_instance = optional(number)
      max_connections_per_endpoint = optional(number)
      max_rate                     = optional(number)
      max_rate_per_instance        = optional(number)
      max_rate_per_endpoint        = optional(number)
      max_utilization              = optional(number)
    }))
  })
}

