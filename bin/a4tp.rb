require 'opendelivery'
require 'aws-sdk'
require 'trollop'

@opts = Trollop::options do
	opt :stackName, "Unique name of the CloudFormation stack used to create a4tp resources", :type => String, :required => true
	opt :template, "Name of the Cfn Template that describes our infrastructure", :type => String, :required => true
	opt :keyname, "Name of a valid EC2 keypair that can be used to access the instances",	:type => String, :required => true
	opt :instancetype, "The type of instance to launch (ex. m3.medium)", :type => String, :required => true
end

@stack = OpenDelivery::Stack.new

def create_params
	params = {
		"KeyName" => @opts[:keyname], 
		"InstanceType" => @opts[:instancetype]
	}
end

params = create_params
template = File.expand_path("../../cloudformation/#{@opts[:template]}", __FILE__)

@stack.create(@opts[:stackName], template, params, true)

@stack.watch(@opts[:stackName], 5)