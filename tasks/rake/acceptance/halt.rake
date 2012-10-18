require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

namespace :acceptance do
  desc "Halt the test environment, with optional parameter: boxes=<comma_separated_list_of_baseboxes_to_teardown>"
  task :halt do
    require 'vagrant'

    env = Vagrant::Environment.new(:cwd => File.expand_path('../../..', __FILE__),
                                   :ui_class => Vagrant::UI::Basic)

    ENV['boxes'].split(',').each { |basebox|
      if ! env.vms[:"#{basebox}"].nil?
        puts "Removing #{basebox} snapshot..."
        env.cli("sandbox", "off", :"#{basebox}")
        puts "Snapshot removed."

        puts "Checking #{basebox} state..."
        state = env.vms[:"#{basebox}"].state

        puts "Stopping #{basebox}..."
        env.cli("halt", :"#{basebox}") if state == :running
        puts "#{basebox} halted."
      else
        puts "Vagrant VM '#{basebox}' doesn't exist..."
      end
    }
  end

end
