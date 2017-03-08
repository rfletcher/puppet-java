class java::7 {
  include ::java::params

  $distribution = hiera( 'java::distribution', 'jre' )

  validate_re( $distribution, '^(jre|jdk)$' )

  $distribution_class = "::java::7::${distribution}"

  if ! defined( $distribution_class ) {
    fail( "Java distribution \"${distribution}\" is not supported for version 7." )
  } else {
    include $distribution_class
  }
}
