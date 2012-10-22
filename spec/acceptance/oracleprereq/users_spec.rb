require 'acceptance/spec_helper'

describe 'Default node for oracle' do

  oracle_user = 'oracle'
  oracle_primary_group = 'oinstall'
  oracle_secondary_group = 'dba'

  context "when node definition is users" do

    it "should have a user '#{oracle_user}'" do
      return_code = @platform.channel.sudo("id #{oracle_user}")
      return_code.should eql(0)
    end

    it "should have a group '#{oracle_primary_group}'" do
      return_code = @platform.channel.sudo(" /etc/group | grep #{oracle_primary_group} 2> /dev/null 1> /dev/null")
      return_code.should eql(0)
    end

    it "should have a group '#{oracle_secondary_group}'" do
      return_code = @env.vms[:centos5].channel.sudo("cat /etc/group | grep #{oracle_secondary_group} 2> /dev/null 1> /dev/null")
      return_code.should eql(0)
    end

  end

end
