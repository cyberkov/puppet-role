require 'acceptance/spec_helper'

describe 'Default node for oracle' do

  context "when node definition is ntp" do

    context "Checking server tik.cegeka.be" do
      ntp_entry = "server tik.cegeka.be"

      it "should contain #{ntp_entry}" do
      	return_code = @env.vms[:centos5].channel.sudo("grep '#{ntp_entry}' /etc/ntp.conf 2> /dev/null 1> /dev/null")
      	return_code.should eql(0)
      end
    end

    context "Checking server tak.cegeka.be" do
      ntp_entry = "server tak.cegeka.be"

      it "should contain #{ntp_entry}" do
        return_code = @env.vms[:centos5].channel.sudo("grep '#{ntp_entry}' /etc/ntp.conf 2> /dev/null 1> /dev/null")
        return_code.should eql(0)
      end
    end

    context "Checking process that needs to be running" do
      process = 'ntpd'

      it "should have running service #{process}" do
        return_code = @env.vms[:centos5].channel.sudo("ps -ef | grep #{process} | grep -vc grep")
        return_code.should eql(0)
      end
    end

  end

end
