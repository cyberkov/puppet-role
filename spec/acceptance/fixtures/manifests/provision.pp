class provision( $version = $::version, $test = $::test, $provisioning_path = '/tmp/vagrant-puppet' ) {

  if $version == '' {
    fail("No package version provided for puppet-modules")
  }

  if $test == '' {
    fail("No test provided")
  }

  yumrepo { 'cegeka-noarch-unstable':
    enabled         => '1',
    baseurl         => 'https://yum.cegeka.be/cegeka-noarch/unstable',
    gpgcheck        => '1',
    descr           => 'Cegeka YUM Repository',
    metadata_expire => '10m',
    sslcacert       => '/etc/pki/tls/certs/ca-bundle.crt',
    sslverify       => 'True',
    sslclientcert   => "/etc/cegeka/ssl/certs/${::fqdn}.pem",
    sslclientkey    => "/etc/cegeka/ssl/private_keys/${::fqdn}.pem"
  }

  package { 'cegeka-puppet-modules':
    ensure  => $version,
    require => Yumrepo['cegeka-noarch-unstable']
  }

  file { '/etc/puppet/manifests/site.pp':
    ensure  => file,
    content => file("${provisioning_path}/manifests/examples/${test}.pp"),
  }

  service { 'puppetmaster':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    subscribe => File['/etc/puppet/manifests/site.pp']
  }
}

class { 'provision': }
