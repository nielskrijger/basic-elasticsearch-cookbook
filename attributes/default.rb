default['elasticsearch']['user'] = 'elasticsearch'
default['elasticsearch']['uid'] = nil # set to nil to let system pick
default['elasticsearch']['group'] = 'elasticsearch'
default['elasticsearch']['gid'] = nil # set to nil to let system pick
default['elasticsearch']['version'] = '1.1.0'
default['elasticsearch']['url'] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.tar.gz"

default['elasticsearch']['port'] = 9200
default['elasticsearch']['min_mem'] = '256m'
default['elasticsearch']['max_mem'] = '1gb'

default['elasticsearch']['install_dir'] = '/usr/local'
default['elasticsearch']['dir'] = "#{node['elasticsearch']['install_dir']}/elasticsearch"
default['elasticsearch']['home_dir'] = '/var/lib/elasticsearch'
default['elasticsearch']['conf_dir'] = '/etc/elasticsearch'
default['elasticsearch']['data_dir'] = '/var/lib/elasticsearch'
default['elasticsearch']['logs_dir'] = '/var/log/elasticsearch'
default['elasticsearch']['work_dir'] = '/tmp/elasticsearch'