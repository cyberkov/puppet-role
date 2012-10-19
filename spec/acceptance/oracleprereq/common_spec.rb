require 'acceptance/spec_helper'

describe 'Default node for common' do

  context "when node definition is common" do

    context "Checking required sysadmin tools" do
      sysadmin_tools = [ 'screen', 'tmux']

      sysadmin_tools.each { |sysadmin_tool|
        it "should contain package #{sysadmin_tool}" do
          return_code = @env.vms[:centos5].channel.sudo("rpm -q #{sysadmin_tool}")
          return_code.should eql(0)
        end
      }
    end

  end

end
