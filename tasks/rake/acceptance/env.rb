# Parameter for rake tasks containing the default available Vagrant Baseboxes
ENV['boxes'] ||= 'puppetmaster,puppetnode1,puppetnode2'

# Assemble new Gem PATH to be able to use the vagrant gem
system_gem_path = %x[gem environment gempath].chomp
vagrant_gem_path = %x[vagrant gem environment gempath].chomp

if ! system_gem_path.eql? vagrant_gem_path
  Gem.clear_paths

  ENV['GEM_PATH'] = "#{vagrant_gem_path}:#{system_gem_path}"
end
