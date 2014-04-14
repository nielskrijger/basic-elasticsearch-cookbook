include_recipe "ark"
include_recipe "java"

#
# Create user and group
#

group node['elasticsearch']['group'] do
  system true
  gid node['elasticsearch']['gid']
end

user node['elasticsearch']['user'] do
  group node['elasticsearch']['group']
  home node['elasticsearch']['home_dir']
  system true
  action :create
  manage_home true
  uid node['elasticsearch']['uid']
end

#
# Create directories
#

directories = [node['elasticsearch']['data_dir'],
               node['elasticsearch']['conf_dir'],
               node['elasticsearch']['logs_dir'],
               node['elasticsearch']['work_dir']]
directories.each do |dir|
  directory dir do
    action :create
    recursive true
    owner node['elasticsearch']['user']
    group node['elasticsearch']['group']
    mode '0755'
  end
end

#
# Install elasticsearch
#

ark "elasticsearch" do
  url node['elasticsearch']['url']
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  version node['elasticsearch']['version']
  prefix_root node['elasticsearch']['install_dir']
  prefix_home node['elasticsearch']['install_dir']

  not_if do
    link = "#{node['elasticsearch']['dir']}"
    target = "#{node['elasticsearch']['install_dir']}/elasticsearch-v#{node['elasticsearch']['version']}"
    binary = "#{target}/bin/elasticsearch"

    ::File.directory?(target) && ::File.symlink?(link) && ::File.readlink(link) == target && ::File.exists?(binary)
  end
end

#
# Create elasticsearch configuration
#

template "/etc/init/elasticsearch.conf" do
  mode '0644'
  source "init.elasticsearch.conf.erb"
end

service "elasticsearch" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end