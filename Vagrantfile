# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = [
          { "ip" => "172.16.0.2",
            "canonical" => "puppetmaster.example.com",
            "aliases" => ["puppet", "puppet.example.com"] },
          { "ip" => "172.16.0.3",
            "canonical" => "puppetnode1-centos6-x86_64.example.com",
            "aliases" => ["puppetnode1-centos6-x86_64"] },
	  { "ip" => "172.16.0.4",
            "canonical" => "puppetnode2-centos5-x86_64.example.com",
	    "aliases" => ["puppetnode2-centos5-x86_64"] }
        ]

Vagrant::Config.run do |config|
  config.vm.define :puppetmaster do |master|
    master.vm.box = "puppetmaster"
    master.vm.box_url = "https://yum.cegeka.be/vagrant/baseboxes/puppetmaster.box"
    master.vm.network :hostonly, "172.16.0.2"
    master.vm.host_name = "puppetmaster.example.com"
    master.vmhosts.list = hosts
    master.vm.share_folder("v-root", "/vagrant", ".", :owner => "puppet", :group => "puppet")
    master.vm.provision :puppet, :pp_path => "/tmp/vagrant-puppet", :facter => { "test" => ENV['test'], "version" => ENV['version'] } do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "provision.pp"
      puppet.options = [ "--verbose", "--reportdir", "/vagrant/target/reports" ]
    end
  end

  config.vm.define :puppetnode1 do |node1|
    node1.vm.box = "puppetnode1-centos6-x86_64"
    node1.vm.box_url = "https://yum.cegeka.be/vagrant/baseboxes/puppetnode1-centos6-x86_64.box"
    node1.vm.network :hostonly, "172.16.0.3"
    node1.vm.host_name = "puppetnode1-centos6-x86_64.example.com"
    node1.vmhosts.list = hosts
    node1.vm.provision :puppet_server do |puppet|
      puppet.puppet_server = "puppet.example.com"
      puppet.options = ["--report", "true"]
    end
  end

  config.vm.define :puppetnode2 do |node2|
    node2.vm.box = "puppetnode2-centos5-x86_64"
    node2.vm.box_url = "https://yum.cegeka.be/vagrant/baseboxes/puppetnode2-centos5-x86_64.box"
    node2.vm.network :hostonly, "172.16.0.4"
    node2.vm.host_name = "puppetnode2-centos5-x86_64.example.com"
    node2.vmhosts.list = hosts
    node2.vm.provision :puppet_server do |puppet|
      puppet.puppet_server = "puppet.example.com"
      puppet.options = ["--report", "true"]
    end
  end
end
