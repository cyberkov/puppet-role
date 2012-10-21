require 'acceptance/spec_helper'

describe 'Default node for oracle' do

  context "when node definition is oracleprereq" do

    context "Checking required lib packages" do
      lib_packages = ['compat-libstdc++-33', 'glibc-devel.x86_64', 'glibc-devel.i386', 'glibc-headers', 'libaio', 'libaio-devel', 'numactl-devel', 'elfutils-libelf-devel',
                      'unixODBC.x86_64', 'unixODBC.i386', 'unixODBC-devel', 'xorg-x11-xauth']

      lib_packages.each { |lib_package|
        it "should contain package #{lib_package}" do
          return_code = @platform.channel.sudo("rpm -q #{lib_package}")
          return_code.should eql(0)
	end
      }
    end

    context "Checking required build packages" do
      build_packages = [ 'make', 'cpp', 'libstdc++-devel', 'gcc', 'gcc-c++', 'compat-db']

      build_packages.each { |build_package|
        it "should contain package #{build_package}" do
          return_code = @platform.channel.sudo("rpm -q #{build_package}")
          return_code.should eql(0)
        end
      }
    end

    context "Checking required system tools" do
      system_packages = [ 'ksh', 'pdksh', 'bind-utils', 'smartmontools', 'ftp', 'libgomp', 'unzip', 'sysstat']

      system_packages.each { |system_package|
        it "should contain package #{system_package}" do
          return_code = @platform.channel.sudo("rpm -q #{system_package}")
          return_code.should eql(0)
        end
      }
    end

    context "Checking required oracle packages" do
      oracle_packages = ['oracleasmlib', 'oracleasm-support']

      oracle_packages.each { |oracle_package|
        it "should contain package #{oracle_package}" do
          return_code = @platform.channel.sudo("rpm -q #{oracle_package}")
          return_code.should eql(0)
        end
      }
    end

    context "Checking processes that need to be running" do
      processes = ['multipathd']

      processes.each { |process|
        it "should have running service #{process}" do
          return_code = @platform.channel.sudo("ps -ef | grep #{process} | grep -vc grep")
          return_code.should eql(0)
        end
      }
    end

    context "Checking oracleasm scanexclude" do
      oracleasm_entry = "ORACLEASM_SCANEXCLUDE=\"sd\""

      it "should contain #{oracleasm_entry}" do
        return_code = @platform.channel.sudo("grep '#{oracleasm_entry}' /etc/sysconfig/oracleasm 2> /dev/null 1> /dev/null")
        return_code.should eql(0)
      end
    end

  end

end
