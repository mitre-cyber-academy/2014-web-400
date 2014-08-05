#
# Cookbook Name:: heartbleed-provisioner
# Recipe:: default
#
# Copyright 2014, MITRE
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'openssh::default'

user_home = "/home/#{node["heartbleed-provisioner"]["user"]}"
user_ssh_dir = "#{user_home}/.ssh"
authorized_keys = "#{user_ssh_dir}/authorized_keys"

remote_file "/tmp/openssl_1.0.1-4ubuntu5.11_amd64.deb" do
  source "http://launchpadlibrarian.net/161943230/openssl_1.0.1-4ubuntu5.11_amd64.deb"
  mode 0644
end

dpkg_package "openssl" do
  source "/tmp/openssl_1.0.1-4ubuntu5.11_amd64.deb"
  action :install
end

bash "lock-openssl" do
  code "apt-mark hold openssl"
  not_if "dpkg --get-selections | grep 'openssl' | grep 'hold'"
end

include_recipe "apache2::default"
include_recipe "apache2::mod_ssl"

remote_directory node["heartbleed-provisioner"]["challenge_www_root"] do
  source "challenge-site"
  owner "root"
  group "root"
  mode 0755
end

# Otherwise we cannot generate public key from ssh-keygen
file node["heartbleed-provisioner"]["ssl_certificate_key"] do
  mode 0600
end

web_app "challenge-site" do
  server_name node['hostname']
  server_port "443"
  server_aliases ["*"]
  docroot node["heartbleed-provisioner"]["challenge_www_root"]
  enable true
end

package "lshell" do
  action :install
end

cookbook_file "/etc/lshell.conf" do
  source "lshell.conf"
end

user node["heartbleed-provisioner"]["user"] do
  home user_home
  shell "/usr/bin/lshell"
  supports :manage_home => true
  action :create
end

directory user_home do
  mode 0500
  user node["heartbleed-provisioner"]["user"]
  group node["heartbleed-provisioner"]["user"]
end

directory user_ssh_dir do
  action :create
  mode 0500
  user node["heartbleed-provisioner"]["user"]
  group node["heartbleed-provisioner"]["user"]
end

bash "copy-private-key" do
  code "ssh-keygen -y -f #{node['heartbleed-provisioner']['ssl_certificate_key']} > #{user_ssh_dir}/authorized_keys"
end

file authorized_keys do
  mode 0400
  user node["heartbleed-provisioner"]["user"]
  group node["heartbleed-provisioner"]["user"]
  action :touch
end

cookbook_file "#{user_ssh_dir}/id_rsa" do
  source "id_rsa"
  mode 0400
  user node["heartbleed-provisioner"]["user"]
  group node["heartbleed-provisioner"]["user"]
end