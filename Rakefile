require 'rake'
require 'rspec/core/rake_task'
require_relative './lib/stack_info_helper.rb'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  
  role = ENV['ROLE']
  stackname = ENV['STACK_NAME']

  targets = Stack.new(stackname).ips

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{role}/*_spec.rb"
    end
  end
end
