require File.expand_path('../../../env', __FILE__)
require File.expand_path('../../acceptance/env', __FILE__)

def parse_reports(puppet_reports_directories)
  require 'yaml'

  puppet_reports_directories.each { |puppet_report_dir|
    puts "Parsing yaml files in #{puppet_report_dir}"

    Dir.glob("#{puppet_report_dir}/*.yaml").each do|yaml_file|
      report_log = File.dirname(yaml_file) + "/" + File.basename(File.dirname(yaml_file)) + "-" + File.basename(yaml_file).gsub(".yaml", ".log")
      puts "Parsing yaml file #{yaml_file} to #{report_log}"

      report = YAML.load(File.open(yaml_file))
      puts report
      log = report.ivars['logs']

      File.open(report_log, 'w') {|f|
        log.each do |l|
          level = l.ivars['level']
          source = l.ivars['source']
          message = l.ivars['message']

          if source != "Puppet"
            f.write("#{level}: #{source}: #{message}\n")
          else
            f.write("#{level}: #{message}\n")
          end
        end
      }
    end
  }

end

namespace :acceptance do
  desc "Transform Puppet Reports from YAML to LOG format."
  task :transform_puppet_reports do
    puppet_reports_directories = []
    Dir.glob("#{REPORTS_DIR}/puppet*") { |puppet_reports_dir|
      puppet_reports_directories << "#{puppet_reports_dir}"
    }

    parse_reports(puppet_reports_directories)
  end
end

