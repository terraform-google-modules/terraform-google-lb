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

variable project {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable region {
  description = "Region for cloud resources."
  default     = "us-central1"
}

variable network {
  description = "Name of the network to create resources in."
  default     = "default"
}

variable firewall_project {
  description = "Name of the project to create the firewall rule in. Useful for shared VPC. Default is var.project."
  default     = ""
}

variable name {
  description = "Name for the forwarding rule and prefix for supporting resources."
}

variable service_port {
  description = "TCP port your service is listening on."
}

variable target_tags {
  description = "List of target tags to allow traffic using firewall rule."
  type        = "list"
}

variable session_affinity {
  description = "How to distribute load. Options are `NONE`, `CLIENT_IP` and `CLIENT_IP_PROTO`"
  default     = "NONE"
}
