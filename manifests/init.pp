# manifests/init.pp - manage razor stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# this module is part of a whole bunch of modules, please have a look at the exim module

class razor {
  case $::operatingsystem {
    gentoo: { include razor::gentoo }
    default: { include razor::base }
  }
}
