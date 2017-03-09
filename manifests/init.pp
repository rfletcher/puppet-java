class java(
  $distribution = 'jre',
  $version      = undef,
) {
  include ::java::params

  validate_re( $distribution, '^(jre|jdk)$' )

  if is_array( $version ) {
    $distribution_classes = suffix( prefix( $version, '::java::' ), "::${distribution}" )
  } else {
    validate_re( "${version}", '^[0-9]?$' ) # must cast int to string

    if $version =~ /^[0-9]$/ {
      $major_version = $version
    } else {
      $major_version = $::java::params::java['default']
    }

    $distribution_classes = ["::java::${major_version}::${distribution}"]
  }

  include $distribution_classes
}
