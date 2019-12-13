# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id = attribute('project_id')
region = attribute('region')

control "gcp" do
  title "GCP Forwarding Rules"

  describe google_compute_forwarding_rules(project: "#{project_id}", region:"#{region}") do
    its('count') { should be 3}
    its('forwarding_rule_names') { should include "basic-load-balancer-default" }
    its('forwarding_rule_names') { should include "basic-load-balancer-no-hc" }
    its('forwarding_rule_names') { should include "basic-load-balancer-custom-hc" }
  end

  describe google_compute_forwarding_rule(project: "#{project_id}", region:"#{region}", name: "basic-load-balancer-default") do
    its('load_balancing_scheme') { should match "EXTERNAL" }
  end

  describe google_compute_forwarding_rule(project: "#{project_id}", region:"#{region}", name: "basic-load-balancer-no-hc") do
    its('load_balancing_scheme') { should match "EXTERNAL" }
  end

  describe google_compute_forwarding_rule(project: "#{project_id}", region:"#{region}", name: "basic-load-balancer-custom-hc") do
    its('load_balancing_scheme') { should match "EXTERNAL" }
  end
end
