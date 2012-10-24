# Class: role::tomcat::jdk
#
class role::tomcat::jdk {
  sunjdk::instance { 'installing sunjdk':
    ensure      => 'present',
    jdk_version => '1.6.0_32-fcs.i586'
  }
}
