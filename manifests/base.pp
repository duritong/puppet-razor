class razor::base {
  package{'razor':
    ensure => installed,
    notify => Exec['razor_setup'],
  }

  case $razor_setup_address {
    "": { fail("You need to set \$razor_setup_address to an emailaddress with which we will register our razor installation") }
  }
  exec{'razor_setup':
    command => "/usr/sbin/usermod -s /bin/bash amavis && /bin/su - amavis -c \"razor-admin -create && razor-admin -register -user=${razor_setup_address}\" && /usr/sbin/usermod -s /bin/false amavis",
    refreshonly => true,
  }
}
