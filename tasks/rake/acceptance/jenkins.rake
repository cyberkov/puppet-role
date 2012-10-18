require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

namespace "jenkins" do

  desc "Provision the test environment and run acceptance RSpec tests"
  task :run_acceptance_tests => [:provision] do
    require 'vagrant'

    env = Vagrant::Environment.new(:cwd => File.expand_path('../../..', __FILE__),
				   :ui_class => Vagrant::UI::Basic)

    puppet_vms = ENV['boxes'].split(',')
    puppet_vms.delete('puppetmaster')

    puppet_vms.each { |box|
      puppetnode_fqdn = env.vms[:"#{box}"].config.vm.host_name
      puts "Going to check if provisioning for puppet node #{puppetnode_fqdn} has finished."
      until File.directory?("#{REPORTS_DIR}/#{puppetnode_fqdn}")
        puts "Directory #{REPORTS_DIR}/#{puppetnode_fqdn} not yet available... Checking again in a few seconds..."
        sleep 5
      end
    }

    Rake::Task["transform_puppet_reports"].invoke

    report = "ci"
    Rake::Task["spec"].invoke
  end

  desc "Fetch artifact from upstream project"
  task :fetch_upstream_artifact do
    $:.unshift(File.join(File.dirname(__FILE__), 'lib'))
    require 'jenkins_helper'

    FileUtils.mkdir_p("#{RESULTS}/dist")

    jenkins_helper = JenkinsHelper.new
    jenkins_helper.fetch_artifact("puppet-modules", "modules/target/dist", "puppet-modules-dependencies.yaml", "#{RESULTS}/dist")
    jenkins_helper.fetch_artifact("puppet-modules", "modules/target/dist", "puppet-modules.yaml", "#{RESULTS}/dist")
  end

end
