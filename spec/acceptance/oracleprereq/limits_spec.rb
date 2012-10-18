require 'acceptance/spec_helper'

describe 'Default node for oracle' do

  context "when node definition is limits" do

    context "Checking soft limits for nofile" do
      limits_entry = "oracle soft nofile 1024"

      it "should contain #{limits_entry}" do
      	return_code = @env.vms[:puppetnode2].channel.sudo("grep '#{limits_entry}' /etc/security/limits.conf 2> /dev/null 1> /dev/null")
      	return_code.should eql(0)
      end
    end

    context "Checking hard limits for nofile" do
      limits_entry = "oracle hard nofile 65536"

      it "should contain #{limits_entry}" do
        return_code = @env.vms[:puppetnode2].channel.sudo("grep '#{limits_entry}' /etc/security/limits.conf 2> /dev/null 1> /dev/null")
        return_code.should eql(0)
      end
    end

    context "Checking soft limits for nproc" do
      limits_entry = "oracle soft nproc 2047"

      it "should contain #{limits_entry}" do
        return_code = @env.vms[:puppetnode2].channel.sudo("grep '#{limits_entry}' /etc/security/limits.conf 2> /dev/null 1> /dev/null")
        return_code.should eql(0)
      end
    end

    context "Checking hard limits for nproc" do
      limits_entry = "oracle hard nproc 16384"

      it "should contain #{limits_entry}" do
        return_code = @env.vms[:puppetnode2].channel.sudo("grep '#{limits_entry}' /etc/security/limits.conf 2> /dev/null 1> /dev/null")
        return_code.should eql(0)
      end
    end

  end

end
