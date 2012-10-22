require 'acceptance/spec_helper'

describe 'Default node' do

  context "when node definition is empty" do

    it "should have a vagrant user" do
      return_code = @platform.channel.sudo("id vagrant")
      return_code.should eql(0)
    end

    it "should have the puppet RPM installed" do
      return_code = @platform.channel.sudo("rpm -q puppet")
      return_code.should eql(0)
    end
  end
end
