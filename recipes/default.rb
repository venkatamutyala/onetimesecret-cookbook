#
# Cookbook Name:: onetimesecret
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'onetimesecret::packages'
include_recipe 'onetimesecret::ruby'
include_recipe 'onetimesecret::redis'

execute "install bundler" do
  command "sudo gem install bundler"
  creates "/usr/local/bin/bundler"

  action :run
end

include_recipe 'runit'

user "ots" do
  action :create
  comment "one time secret user "
  uid 1999
  gid "users"
  home "/home/ots"
  shell "/bin/bash"
  password "$1$JJsvHslV$szsCjVEroftprNn4JHtDi."
  supports :manage_home => true
end

directory "/etc/onetime" do
  owner "root"
  group "root"
  mode "0755"

  action :create
end

git "/home/ots/onetimesecret" do
  repository "https://github.com/onetimesecret/onetimesecret.git"
  reference "master"
  user "ots"
  group "users"
  action :sync
end

%w{/var/log/onetime /var/run/onetime /var/lib/onetime}.each do |dir|
  directory dir do
    owner "ots"
    group "users"
    mode "0755"

    action :create
  end
end

execute "copy the files in" do
  command "cp -r /home/ots/onetimesecret/etc/* /etc/onetime/"
  creates "/etc/onetime/fortunes"
  user "root"
  action :run
end

bash "configure onetimesecret" do
  user "ots"
  cwd "/home/ots/onetimesecret/"
  creates "/etc/onetime/fortunes"
  creates "maybe"
  code <<-EOH
    STATUS=0
    bundle install --frozen --deployment --without=dev || STATUS=1
    bin/ots init || STATUS=1
    exit $STATUS
  EOH
end

template "/etc/onetime/config" do
  source "config.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/onetime/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

runit_service "redis-server"
runit_service "thin"
