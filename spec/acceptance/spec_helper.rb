require 'vagrant'

RSpec.configure do |config|
  config.before :all do
    @env = Vagrant::Environment.new(:cwd => File.expand_path('../..', __FILE__))
  end
end

