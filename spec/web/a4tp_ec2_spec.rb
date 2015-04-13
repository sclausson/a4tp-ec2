require 'spec_helper'

describe "Automation for the People Webserver on #{ENV['TARGET_HOST']}" do

  it 'has httpd installed' do
  	expect(package('httpd')).to be_installed
  end

  it 'has httpd enabled and started' do
  	expect(service('httpd')).to be_enabled
  	expect(service('httpd')).to be_running
  end
  
  it 'responds on port 80' do
    expect(port 80).to be_listening 'tcp'
  end

  it 'contains a file /var/www/html/index.html' do
  	expect(file('/var/www/html/index.html')).to be_file
  end

  it "returns Automation for the People in the HTML body" do
  	expect(command('curl localhost:80').stdout).to match /Automation for the People/
  end

end

