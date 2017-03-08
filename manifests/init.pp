class java(
  $distribution = 'jre',
  $version      = undef,
) {
  include ::java::params

  validate_re( $distribution, '^(jre|jdk)$' )
  validate_re( $version, '^[0-9]?$' )

  if $version =~ /^[0-9]$/ {
    $major_version = $version
  } else {
    $major_version = $::java::params::java['default']
  }

  $distribution_class = "::java::${major_version}::${distribution}"

  if ! defined( $distribution_class ) {
    fail( "Java distribution \"${distribution}\" is not supported for version ${major_version}." )
  } else {
    include $distribution_class
  }
}
