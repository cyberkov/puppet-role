require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

namespace :acceptance do
  desc "Provision the test environment, with required parameters: test=<name_of_test> version=<version_of_puppet-modules> and optional parameter: boxes=<comma_separated_list_of_baseboxes_to_setup>"
  task :provision do
    require 'vagrant'

    env = Vagrant::Environment.new(:cwd => File.expand_path('../../..', __FILE__),
                                   :ui_class => Vagrant::UI::Basic)

    ENV['test'] ||= 'empty'

    FileUtils.mkpath("#{REPORTS_DIR}")

    puts "Provisioning with version #{ENV['version']}"

    ENV['boxes'].split(',').each { |basebox|
      if ! env.vms[:"#{basebox}"].nil?
        puts "Rolling back #{basebox} to known state..."
        env.cli("sandbox", "rollback", :"#{basebox}")

        puts "Provisioning #{basebox}..."
        env.cli("provision", :"#{basebox}")
        puts "#{basebox} provisioned."
      else
        puts "Vagrant VM '#{basebox}' doesn't exist..."
      end
    }
  end

end
