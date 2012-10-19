require 'acceptance/spec_helper'

describe 'Default node for tomcat' do

  context "when node definition is tomcat" do

    context "Checking required packages" do
      packages = ['tomcat']

      packages.each { |package|
        it "should contain package #{package}" do
          return_code = @env.vms[:centos5].channel.sudo("rpm -q #{package}")
          return_code.should eql(0)
        end
      }
    end

    context "Checking processes that need to be running" do
      processes = ['tomcat']

      processes.each { |process|
        it "should have running service #{process}" do
          return_code = @env.vms[:centos5].channel.sudo("ps -ef | grep #{process} | grep -vc grep")
          return_code.should eql(0)
        end
      }
    end

  end

end
