class role::tomcat {

  stage { 'pre': before => Stage['main'] }

  class { 'cegekarepos': stage => 'pre' }

  Yum::Repo <| title == 'os' |>
  Yum::Repo <| title == 'updates' |>
  Yum::Repo <| title == 'cegeka-noarch-unstable' |>
  Yum::Repo <| title == 'cegeka-unsigned' |>

  class { 'tomcat': }

  tomcat::conf::setenv { 'setting env':
    java_options => [
    '-Xms512m',
    '-Xmx1024m',
    '-XX:PermSize=256m',
    '-XX:MaxPermSize=512m',
    '-Denv.ENVIRONMENT=test'
    ],
  }

  tomcat::conf::role { 'adding foo role':
    rolename => 'foo'
  }

  tomcat::conf::user { 'adding tomcat user':
    username => 'tomcat',
    password => 'tomcat',
    roles    => 'manager-gui,foo'
  }

}
