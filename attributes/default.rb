default["heartbleed-provisioner"]["ssl_certificate_file"] = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
default["heartbleed-provisioner"]["ssl_certificate_key"] = "/etc/ssl/private/ssl-cert-snakeoil.key"
default["heartbleed-provisioner"]["challenge_www_root"] = "/var/www/challenge-site"
default["heartbleed-provisioner"]["user"] = "jason"

override['openssh']['server']['strict_modes'] = 'no'