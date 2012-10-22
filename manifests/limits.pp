# Class role::limits
class role::limits {

  include limits

  limits::conf { 'oracle-soft-nofile': domain => 'oracle', type => 'soft', item => 'nofile', value => '1024' }
  limits::conf { 'oracle-hard-nofile': domain => 'oracle', type => 'hard', item => 'nofile', value => '65536' }
  limits::conf { 'oracle-soft-nproc': domain => 'oracle', type => 'soft', item => 'nproc', value => '2047' }
  limits::conf { 'oracle-hard-nproc': domain => 'oracle', type => 'hard', item => 'nproc', value => '16384' }
  limits::conf { 'oracle-hard-stack': domain => 'oracle', type => 'hard', item => 'stack', value => '10240' }

}
