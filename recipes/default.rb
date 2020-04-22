#
# Cookbook:: testing_cookbook
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# apt_update 'update_sources' do
#   action :update
# end
#
# package 'python3-pip'

bash 'python3-pip' do code <<-EOL
  sudo apt-get update
  sudo apt-get -y install python3-pip
  EOL
end

package 'default-jdk'

package 'default-jre'

package 'packer'

bash 'install chef' do  code <<-EOL
  wget https://packages.chef.io/files/stable/chef-workstation/0.2.43/ubuntu/18.04/chef-workstation_0.2.43-1_amd64.deb
  sudo dpkg -i chef-workstation_*.deb
  rm chef-workstation_*.deb
  EOL
end

file '/home/ubuntu/requirements.txt' do
  mode '0777'
  action :create_if_missing
end

directory '/home/ubuntu/Downloads' do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end

template '/home/ubuntu/requirements.txt' do
  source 'requirements.txt.erb'
end


bash 'pip install requirements.txt' do
  code <<-EOL
  pip3 install -r /home/ubuntu/requirements.txt
  EOL
end
