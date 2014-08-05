name             'heartbleed-provisioner'
maintainer       'MITRE'
maintainer_email 'rbclark@mitre.org'
license          'All rights reserved'
description      'Installs/Configures heartbleed vulnerable server for the 2014 MITRE CTF.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'apache2'
depends          'openssh'