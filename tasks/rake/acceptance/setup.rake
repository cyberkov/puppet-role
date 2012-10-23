require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

namespace :acceptance do
  desc "Setup a new test environment, with optional parameter: boxes=<comma_separated_list_of_baseboxes_to_setup>"
  task :setup do
    require 'vagrant'

    env = Vagrant::Environment.new(:cwd => File.expand_path('../../..', __FILE__),
                                   :ui_class => Vagrant::UI::Basic)

    boxes ||= Array.new
    boxes.push('puppetmaster')
    boxes += ENV['boxes'].split(',')

    ENV['boxes'].split(',').each { |basebox|
      if ! env.vms[:"#{basebox}"].nil?
        puts "Checking #{basebox} state..."
        state = env.vms[:"#{basebox}"].state

        puts "Setting up #{basebox}..."
        if ! (state == :running)
          if ("#{basebox}" == 'puppetmaster')
            env.cli("up", :"#{basebox}")
          else
            env.cli("up", :"#{basebox}", "--no-provision")
        end
        puts "#{basebox} is running..."

        puts "Creating snapshot of initial #{basebox} state..."
        env.cli("sandbox", "on", :"#{basebox}")
        puts "Snapshot created."

      else
        puts "Vagrant VM '#{basebox}' doesn't exist..."
      end
    }
  end

end
