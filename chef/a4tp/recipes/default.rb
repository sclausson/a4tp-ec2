#
# Cookbook Name:: apache-test
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "httpd"

service "httpd" do 
	action [:enable, :start]
end

remote_file '/var/www/html/index.html' do
	action :create
	source "https://raw.githubusercontent.com/sclausson/a4tp-web/master/index.html"
end
