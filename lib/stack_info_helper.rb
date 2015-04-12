#provides a couple of helpful methods we can call for getting stack resource info
require 'aws-sdk'

class Stack

  attr_reader :stack_name, :asg, :ips

  def initialize(stack_name)
    @stack_name = stack_name
    get_stack_asg
    get_ip_addresses
  end

  def get_stack_asg
      cfn = AWS::CloudFormation.new
      as = AWS::AutoScaling.new

      stack = cfn.stacks[@stack_name]
      stack.resources.each do |resource|
        case resource.resource_type
        when "AWS::AutoScaling::AutoScalingGroup"
          asg_id = resource.physical_resource_id
          @asg = as.groups[asg_id]
        end
      end
      return @asg
  end

  def get_ip_addresses
    cfn = AWS::CloudFormation.new
    as = AWS::AutoScaling.new

    instanceCollections = []
    #asg = get_stack_asg
    instanceCollections << @asg.ec2_instances

    @ips = []

    instanceCollections.each do |ic|
      ic.each do |instance|
        @ips << instance.private_ip_address
      end
    end
    return @ips
  end
end
