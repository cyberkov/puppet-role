require File.expand_path('../../env', __FILE__)

desc "Create RPM package from puppet module."
task :rpm do
  $:.unshift(File.join(File.dirname(__FILE__), 'lib', 'packaging'))
  require 'rpm_packager'

  puts "Creating RPM package from puppet module..."
  module_name = ENV['JOB_NAME'].split('-')[1]

  rpm_packager = RpmPackager.new
  output = rpm_packager.build(module_name)
  puts output
end
