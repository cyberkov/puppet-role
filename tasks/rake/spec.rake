require 'rspec/core/rake_task'

require File.expand_path('../../env', __FILE__)

desc "Run puppet module RSpec tests"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["--format", "doc", "--color"]
  t.fail_on_error = false
  t.pattern = 'spec/{classes,defines,hosts,functions}/*_spec.rb'
end
