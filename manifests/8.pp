class java::8 {
  include ::java::params

  $distribution = hiera( 'java::distribution', 'jre' )

  validate_re( $distribution, '^(jre|jdk)$' )

  $distribution_class = "::java::8::${distribution}"

  if ! defined( $distribution_class ) {
    fail( "Java distribution \"${distribution}\" is not supported for version 8." )
  } else {
    include $distribution_class
  }
}
