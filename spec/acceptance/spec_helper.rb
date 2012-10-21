require 'vagrant'

RSpec.configure do |config|
  config.before :all do
    boxes = ENV['boxes']

    @env = Vagrant::Environment.new(:cwd => File.expand_path('../..', __FILE__))
    @platform = @env.vms[:"#{boxes}"]
  end
end
