require 'spec_helper'

describe 'apache-test::default' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  
  it 'responds on port 80' do
    expect(port 80).to be_listening 'tcp'
  end

  it "returns Automation for the People in the HTML body" do
  	expect(command('curl localhost:80').stdout).to match /Automation for the People/
  end

end