# Class role::oracleprereq
class role::oracleprereq {

  stage {'pre': before => Stage['main']}

  class { 'cegekarepos': stage => 'pre' }
  class { 'cegekausers': }
  class { '::oracleprereq': }
  class { 'common::sysadmintools': }

  Yum::Repo <| title == 'os' |>
  Yum::Repo <| title == 'updates' |>
  Yum::Repo <| title == 'oracleasm' |>

  Users::Localgroup <| title == 'oinstall' |>
  Users::Localgroup <| title == 'dba' |>
  Users::Localuser <| title == 'oracle' |>

  limits::conf { 'oracle-soft-nofile': domain => 'oracle', type => 'soft', item => 'nofile', value => '1024' }
  limits::conf { 'oracle-hard-nofile': domain => 'oracle', type => 'hard', item => 'nofile', value => '65536' }
  limits::conf { 'oracle-soft-nproc': domain  => 'oracle', type => 'soft', item => 'nproc', value  => '2047' }
  limits::conf { 'oracle-hard-nproc': domain  => 'oracle', type => 'hard', item => 'nproc', value  => '16384' }
  limits::conf { 'oracle-hard-stack': domain  => 'oracle', type => 'hard', item => 'stack', value  => '10240' }

  class { 'ntp':
    ntp_servers => ['tik.cegeka.be', 'tak.cegeka.be'],
  }

  Package <| title == 'screen' |>
  Package <| title == 'tmux' |>

  #class { 'sudo': }
  #sudo::conf { 'oracle':
  #  content  => ['User_Alias ORADM = oracle',
  #               'Cmnd_Alias ADM = /bin/su',
  #               'ORADM   ALL = ADM',
  #               'oracle ALL = NOPASSWD: MP,RESCAN'],
  #}

}
