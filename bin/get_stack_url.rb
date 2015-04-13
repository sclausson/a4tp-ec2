require 'trollop'
require_relative '../lib/stack_info_helper.rb'

opts = Trollop::options do
  opt :stackName,  "CloudFormation Stack (e.g., ABC-123-WEB)", :type => String
end

url = Stack.new(opts[:stackName]).output_value("WebsiteURL")

puts "#{url}"