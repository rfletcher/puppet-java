class java::params {
  case $::osfamily {
    'Debian': {
      case $::lsbdistcodename {
        'precise', 'trusty': {
          $java = {
            'default' => 7,
            7 => {
              'jdk' => {
                'package'          => 'openjdk-7-jdk',
                'alternative'      => "java-1.7.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
              },
              'jre' => {
                'package'          => 'openjdk-7-jre-headless',
                'alternative'      => "java-1.7.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
              },
            },
            8 => {
              'jdk' => {
                'package'          => 'openjdk-8-jdk',
                'alternative'      => "java-1.8.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
              },
              'jre' => {
                'package'          => 'openjdk-8-jre-headless',
                'alternative'      => "java-1.8.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
              },
            },
          }
        }
        'xenial': {
          $java = {
            'default' => 8,
            7 => {
              'jdk' => {
                'package'          => 'openjdk-7-jdk',
                'alternative'      => "java-1.7.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
              },
              'jre' => {
                'package'          => 'openjdk-7-jre-headless',
                'alternative'      => "java-1.7.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
              },
            },
            8 => {
              'jdk' => {
                'package'          => 'openjdk-8-jdk',
                'alternative'      => "java-1.8.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
              },
              'jre' => {
                'package'          => 'openjdk-8-jre-headless',
                'alternative'      => "java-1.8.0-openjdk-${::architecture}",
                'alternative_path' => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
                'java_home'        => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
              },
            },
          }
        }
        default: { fail("unsupported release ${::lsbdistcodename}") }
      }
    }
    default: { fail("unsupported platform ${::osfamily}") }
  }
}
