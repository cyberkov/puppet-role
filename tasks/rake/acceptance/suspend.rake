require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

namespace :acceptance do
  desc "Suspend the test environment, with required parameter: boxes=<comma_separated_list_of_baseboxes_to_suspend>"
  task :suspend do
    require 'vagrant'

    env = Vagrant::Environment.new(:cwd => File.expand_path('../../..', __FILE__),
                                   :ui_class => Vagrant::UI::Basic)

    boxes ||= Array.new
    boxes.push('puppetmaster')
    boxes += ENV['boxes'].split(',')

    boxes.each { |basebox|
      if ! env.vms[:"#{basebox}"].nil?
        puts "Suspending #{basebox} ..."
        env.cli("suspend", :"#{basebox}")
      else
        puts "Vagrant VM '#{basebox}' doesn't exist..."
      end
    }
  end

end
