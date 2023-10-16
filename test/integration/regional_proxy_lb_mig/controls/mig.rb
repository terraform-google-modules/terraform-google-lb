# Copyright 2023 Google LLC
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

project_id = input('project_id')
region = input('region')

control "forwarding_rule" do
  title "Forwarding Rules"

  describe google_compute_forwarding_rules(project: "#{project_id}", region:"#{region}") do
    its('count') { should be 1}
    its('forwarding_rule_names') { should include "my-tcp-lb-fwd-rule" }
  end

  describe google_compute_forwarding_rule(project: "#{project_id}", region:"#{region}", name: "my-tcp-lb-fwd-rule") do
    its('load_balancing_scheme') { should match "EXTERNAL_MANAGED" }
  end

end


control "proxy" do
  title "Regional Target TCP Proxy"
  describe command("gcloud beta compute target-tcp-proxies list --project=#{project_id} --regions=#{region} --format json") do
    its('exit_status') { should be 0 }
    its('stderr') { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)
      else
        {}
      end
    end
    it { expect(data.first).to include(name: 'my-tcp-lb-proxy') }
  end
end

control "backend_service" do
  title "Backend Services"

  describe google_compute_region_backend_service(project: "#{project_id}", region:"#{region}", name:"my-tcp-lb") do
    it { should exist }
    its('protocol') { should eq 'TCP' }
  end

end

#Inspec provided resources such as google_compute_health_check(s) and google_compute_region_health_check(s) didn't work for some reason. Hence using gcloud command instead
control "health_check" do
  title "Health checks"
  describe command("gcloud  compute health-checks list --project=#{project_id} --regions=#{region} --format json") do
    its('exit_status') { should be 0 }
    its('stderr') { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)
      else
        {}
      end
    end
    it { expect(data.first).to include(name: 'my-tcp-lb-hc') }
  end
end

control "firewall" do
  title "Firewall Rules"

  describe google_compute_firewalls(project: "#{project_id}") do
    its('count') { should be >=2}
    its('firewall_names') { should include "my-tcp-lb-allow-hc" }
    its('firewall_names') { should include "my-tcp-lb-allow-proxy" }
  end

end
