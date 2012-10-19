require 'acceptance/spec_helper'

describe 'Default node' do

  context "when node definition is limits" do

    it "should have a root user" do
      return_code = @env.vms[:centos6].channel.sudo("id root")
      return_code.should eql(0)
    end

    it "should have the bash RPM installed" do
      return_code = @env.vms[:centos6].channel.sudo("rpm -q bash")
      return_code.should eql(0)
    end
  end
end
