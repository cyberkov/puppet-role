require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

require 'rspec/core/rake_task'

namespace :acceptance do
  desc "Run acceptance RSpec tests, with required parameters: test=<name_of_test> and optional parameter: report=ci"
  RSpec::Core::RakeTask.new(:spec) do |t|
    test = ENV['test'] || "empty"

    if ENV['report'] == "ci"
      begin
        require 'ci/reporter/rake/rspec_loader'
      rescue LoadError
        fail 'Cannot load ci_reporter, did you install it?'
      end

      format = "CI::Reporter::RSpec"
      ENV['CI_REPORTS'] = "#{REPORTS_DIR}/acceptance"
    else
      format = "doc"
    end

    if ENV['fail_on_error'] == 'false'
      fail_on_error = false
    else
      fail_on_error = true
    end

    t.rspec_opts = ["--format", "#{format}", "--color"]
    t.fail_on_error = fail_on_error
    t.pattern = "spec/acceptance/#{test}/**/*_spec.rb"
  end
end
