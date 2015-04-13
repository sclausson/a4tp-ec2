#provides a couple of helpful methods we can call for getting stack resource info
require 'aws-sdk'

class Stack

  attr_reader :stack_name, :asg, :ips, :hostnames

  @@cfn = AWS::CloudFormation.new
  @@as = AWS::AutoScaling.new

  def initialize(stack_name)
    @stack_name = stack_name
    get_stack_asg
    get_ip_addresses
    get_hostnames
  end

  def get_stack_asg
      stack = @@cfn.stacks[@stack_name]
      stack.resources.each do |resource|
        case resource.resource_type
        when "AWS::AutoScaling::AutoScalingGroup"
          asg_id = resource.physical_resource_id
          @asg = @@as.groups[asg_id]
        end
      end
      return @asg
  end

  def get_ip_addresses
    @ips = []
    @asg.ec2_instances.each do |i|
        @ips << i.private_ip_address
    end
    return @ips
  end

  def get_hostnames
    @hostnames = []
    @asg.ec2_instances.each do |i|
        @hostnames << i.private_dns_name.split('.').first
    end
    return @hostnames
  end

  def output_value(output_key)
    output = @@cfn.stacks["#{@stack_name}"].outputs.select {|o| o.key == "#{output_key}"}
    return output.first.value
  end

end
