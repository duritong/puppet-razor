# modules/razor/manifests/init.pp - manage razor stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# this module is part of a whole bunch of modules, please have a look at the exim module
#

# modules_dir { "razor": }

class razor {
    case $operatingsystem {
        gentoo: { include razor::gentoo }
        default: { include razor::base }
    }
}

class razor::base {
    package{'razor':
        ensure => installed,
        notify => Exec[razor_setup],
        require => Class[amavsid-new],
    }

    exec{'razor_setup':
        command => '/usr/sbin/usermod -s /bin/bash amavis && /bin/su - amavis -c \"razor-admin -create && razor-admin -register -user=admin+razor@immerda.ch\" && /usr/sbin/usermod -s /bin/false amavis',
        refreshonly => true,
    }

}

class razor::gentoo inherits razor::base {
    Package[razor]{
        category => 'mail-filter',
    }
}
