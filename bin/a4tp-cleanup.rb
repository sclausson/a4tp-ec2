require 'trollop'
require_relative '../lib/stack_info_helper.rb'

opts = Trollop::options do
	opt :stackName, "Unique name of the CloudFormation stack used to create a4tp resources", :type => String, :required => true
end

cfn = AWS::CloudFormation.new

hostnames = Stack.new(opts[:stackname]).hostnames

#Cleanup nodes and clients from hosted chef
hostnames.each do |name|
	`knife node delete -y "#{name} -c /etc/chef/knife.rb"`
	`knife client delete -y "#{name} -c /etc/chef/knife.rb"`
end

#Delete Cfn Stack
cfn.stacks[opts[:stackname]].delete

