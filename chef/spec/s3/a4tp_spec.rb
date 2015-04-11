require 'spec_helper'

host = "http://a4tp-test-1.s3-website-us-east-1.amazonaws.com/"

describe 'automation for the people website' do

  it "returns Automation for the People in the HTML body" do
  	expect(command("curl #{host}").stdout).to match /Automation For The People/
  end

end
