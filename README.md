# puppet-java

Installs Java on Ubuntu LTS.

This was originally a fork of puppetlabs-java, but there's so little overlap
left that I've started anew.

## Usage

Ensure a Java JRE is available on the system:

    include ::java

Install multiple versions of java:

    include ::java::7
    include ::java::8::jdk

Check class parameters for more detail.
