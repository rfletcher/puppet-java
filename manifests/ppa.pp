class java::ppa {
  ::apt::ppa { 'ppa:openjdk-r/ppa': } ->
  ::apt::pin { 'openjdk-r':
    originator => 'LP-PPA-openjdk-r',
    priority   => 600,
    notify     => Class['::apt::update']
  }
}
