class java::ssl(
  $ensure          = present,
  $bits            = 2048,
  $ca_country      = 'US',
  $ca_org          = 'None',
  $ca_unit         = 'None',
  $cert_expiration = 36500,
  $dir             = '/usr/share/java-ssl',
  $node_name,
  $password,
  $root_cert,
  $root_key,
) {
  # configure static SSL config

  file { $dir:
    ensure  => $ensure ? { absent => $ensure, default => directory, },
    force   => true,
    mode    => '0550',
    recurse => true,
  }

  file { "${dir}/ca.key":
    ensure  => $ensure,
    content => $root_key,
    mode    => '0440',
    require => File[$dir],
    notify  => Exec['update-java-ssl'],
  }

  file { "${dir}/ca.crt":
    ensure  => $ensure,
    content => $root_cert,
    mode    => '0440',
    require => File[$dir],
    notify  => Exec['update-java-ssl'],
  }

  # configure dynamic SSL config generation

  $java_ssl_path = "${dir}/java-ssl.yaml"

  # see `pydoc java-ssl`
  $java_ssl_config = {
    cert => {
      subject => {
        country      => $ca_country,
        organization => $ca_org,
        unit         => $ca_unit,
      },
      valid => $cert_expiration,
    },
    key      => { size => $bits },
    password => $password,
  }

  file { $java_ssl_path:
    ensure  => $ensure,
    content => to_yaml( {
      authority      => $java_ssl_config,
      base_directory => $dir,
      keystores      => [merge( $java_ssl_config, { name => $node_name } )],
    } ),
    notify  => Exec['update-java-ssl'],
  }

  file { '/usr/local/bin/java-ssl':
    source => 'puppet:///modules/java/java-ssl.py',
    mode   => '0555',
  }

  exec { 'update-java-ssl':
    command => "java-ssl ${java_ssl_path}",
    creates => "${dir}/${node_name}/${node_name}.kst",
    require => [
      File['/usr/local/bin/java-ssl'],
      File[$java_ssl_path],
    ],
  }
}
