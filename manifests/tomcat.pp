# Class: role::tomcat
#
class role::tomcat {

  stage { 'first': before => Stage['second'] }
  class { 'cegekarepos':  stage => 'first' }

  stage { 'second': before => Stage['main'] }

  class { 'role::tomcat::jdk': stage => 'second' }

  Yum::Repo <| title == 'os' |>
  Yum::Repo <| title == 'updates' |>
  Yum::Repo <| title == 'optional' |>
  Yum::Repo <| title == 'epel' |>
  Yum::Repo <| title == 'cegeka-public' |>
  Yum::Repo <| title == 'cegeka-noarch-unstable' |>
  Yum::Repo <| title == 'cegeka-unsigned-i386' |>
  Yum::Repo <| title == 'newrelic' |>
  Yum::Repo <| title == 'puppetlabs' |>
  Yum::Repo <| title == 'puppetlabs-dependencies' |>

  # Environment variables
  $tomcat_version = '6.0.32-4'
  $tomcat_instance_root_dir = '/data'

  # Install tomcat $version
  tomcat::server { "tomcat-${tomcat_version}":
    tomcat_version => $tomcat_version,
  }

  # Create a tomcat instance $name
  tomcat::instance { 'tomcat00':
    tomcat_instance_root_dir    => $tomcat_instance_root_dir,
    tomcat_instance_number      => '00',
    tomcat_instance_gid         => '1001',
    tomcat_instance_uid         => '1101',
    tomcat_instance_password    => '$1$JOOZyS5c$JDJq9SdMWVZi8IRT/Lh2H1',
    tomcat_version              => $tomcat_version,
    tomcat_options              => [
      { 'SERVER_PORT' => '8050' },
      { 'HTTP_PORT' => '8080' },
      { 'AJP_PORT' => '8010' },
      { 'TOMCAT_INSTANCE_PROPS' => '"-Xmx256m -XX:MaxPermSize=128m
              -Dtn.tomcat.server.port=$SERVER_PORT -Dtn.tomcat.connector.http.port=$HTTP_PORT
              -Dtn.tomcat.connector.ajp.port=$AJP_PORT
              -Dtn.tomcat.connector.ajp.maxThreads=200
              -Dtn.tomcat.engine.jvmRoute=${TOMCAT_NAME}${TOMCAT_NUMBER}"' }
    ]
  }
  tomcat::instance { 'tomcat01':
    tomcat_instance_root_dir    => $tomcat_instance_root_dir,
    tomcat_instance_number      => '01',
    tomcat_instance_gid         => '1002',
    tomcat_instance_uid         => '1102',
    tomcat_instance_password    => '$1$RsbEbpxH$D.K//oczNSeSwqbfDSNwX.',
    tomcat_version              => $tomcat_version,
    tomcat_options              => [
      { 'SERVER_PORT' => '8051' },
      { 'HTTP_PORT' => '8081' },
      { 'AJP_PORT' => '8011' },
      { 'TOMCAT_INSTANCE_PROPS' => '"-Xmx256m -XX:MaxPermSize=128m
              -Dtn.tomcat.server.port=$SERVER_PORT -Dtn.tomcat.connector.http.port=$HTTP_PORT
              -Dtn.tomcat.connector.ajp.port=$AJP_PORT
              -Dtn.tomcat.connector.ajp.maxThreads=200
              -Dtn.tomcat.engine.jvmRoute=${TOMCAT_NAME}${TOMCAT_NUMBER}"' }
    ]
  }


  tomcat::instance::role { 'adding tomcat role':
    tomcat_instance_root_dir => $tomcat_instance_root_dir,
    tomcat_instance_number   => '00',
    rolename                 => 'tomcat'
  }
  tomcat::instance::role { 'adding manager role':
    tomcat_instance_root_dir => $tomcat_instance_root_dir,
    tomcat_instance_number   => '00',
    rolename                 => 'manager'
  }

  tomcat::instance::user { 'adding tomcat user':
    tomcat_instance_root_dir => $tomcat_instance_root_dir,
    tomcat_instance_number   => '00',
    username                 => 'tomcat',
    password                 => 'tomcat',
    roles                    => 'tomcat'
  }
  tomcat::instance::user { 'adding manager user':
    tomcat_instance_root_dir => $tomcat_instance_root_dir,
    tomcat_instance_number   => '00',
    username                 => 'manager',
    password                 => 'manageme',
    roles                    => 'manager'
  }

  tomcat::instance::jaas { 'setting tomcat jaas config':
    tomcat_instance_root_dir => $tomcat_instance_root_dir,
    tomcat_instance_number   => '00',
    loginconf                => "simbaJAAS {
          org.test.jaas.loginmodule.DatabaseLoginModule SUFFICIENT debug=true;
          org.test.jaas.loginmodule.FallbackDatabaseLoginModule REQUIRED debug=true;
      };\n"
  }
}
