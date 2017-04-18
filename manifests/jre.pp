class java::jre {
  include ::java::params

  $version = hiera( 'java::version' )

  validate_re( $version, '^[0-9]?$' )

  if $version =~ /^[0-9]$/ {
    $major_version = $version
  } else {
    $major_version = $::java::params::java['default']
  }

  $distribution_class = "::java::${major_version}::jre"

  if ! defined( $distribution_class ) {
    fail( "Java distribution \"jre\" is not supported for version ${major_version}." )
  } else {
    include $distribution_class
  }
}
