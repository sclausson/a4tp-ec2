#
# Cookbook Name:: apache-test
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "httpd"

service "httpd" do 
	action [:enable, :start]
end

template "/var/www/html/index.html" do
	source 'index.html.erb'
	mode '0644'
end

#get rid of Amazon Linux's annoying welcome page
file "/var/www/html/index.php" do
	action :delete
end

