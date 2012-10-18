require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

namespace :acceptance do
  desc "Destroy the test environment, with optional parameter: boxes=<comma_separated_list_of_baseboxes_to_teardown>"
  task :destroy do
    require 'vagrant'

    env = Vagrant::Environment.new(:cwd => File.expand_path('../../..', __FILE__),
                                   :ui_class => Vagrant::UI::Basic)

    ENV['boxes'].split(',').each { |basebox|
      if ! env.vms[:"#{basebox}"].nil?
        puts "Removing #{basebox} snapshot..."
        env.cli("sandbox", "off", :"#{basebox}")

        puts "Destroying #{basebox}..."
        env.cli("destroy", "--force", :"#{basebox}")

        puts "#{basebox} destroyed."
      else
        puts "Vagrant VM '#{basebox}' doesn't exist..."
      end
    }
  end

end
