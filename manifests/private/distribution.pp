define java::private::distribution(
  $default      = undef,
  $distribution = 'jre',
  $version      = $name,
) {
  include ::apt
  include ::java::params

  validate_re( $distribution, '^(jre|jdk)$' )
  validate_re( $version, '^[0-9]$' )

  if $default == undef {
    $real_default = hiera( 'java::default_version', undef ) ? {
      $version => true,
      default  => undef,
    }
  } else {
    $real_default = $default
  }

  if has_key( $::java::params::java, $version ) {
    $config = $::java::params::java[$version]

    if has_key( $config, $distribution ) {
      $alternative      = $config[$distribution]['alternative']
      $alternative_path = $config[$distribution]['alternative_path']
      $package_name     = $config[$distribution]['package']
      $java_home        = $config[$distribution]['java_home']
      $ppa              = $config[$distribution]['ppa']

      $jre_flag = $package_name ? {
        /headless/ => '--jre-headless',
        default    => '--jre',
      }
    } else {
      fail( "Java distribution \"${distribution}\" is not supported for version ${version}." )
    }
  } else {
    fail( "Java major version ${version} is not supported." )
  }

  # configure a PPA?
  if $ppa {
    if ! defined( Apt::Ppa[$ppa['uri']] ) {
      ::apt::ppa { $ppa['uri']: } ->
      ::apt::pin { $ppa['name']:
        originator => $ppa['origin'],
        priority   => 400,
      } ->
      Class['::apt::update']
    }

    Class['::apt::update'] -> Package[$package_name]
  }

  # install the distribution
  package { $package_name: }

  # set as the system default?
  if $real_default {
    package { 'java-common':
      ensure  => present,
      require => Package[$package_name],
    } ->

    exec { 'update-java-alternatives':
      command => "update-java-alternatives --set ${alternative} ${jre_flag}",
      unless  => "test /etc/alternatives/java -ef '${alternative_path}'",
      before  => Exec['ensure-java-certs'],
    } ->

    exec { 'ensure-java-certs':
      command => '/var/lib/dpkg/info/ca-certificates-java.postinst configure',
      creates => '/etc/ssl/certs/java/cacerts',
    }
  }
}
