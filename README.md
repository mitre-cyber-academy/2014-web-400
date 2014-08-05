heartbleed-provisioner
======================

Description: Users are provided with a heartbleed vulnerable server which they must exploit in order to obtain the private key of a user named jason which is used to decrypt a message found on a page of the site.

How to solve: First, the user will need to exploit the heartbleed vulnerability on the box, they can do so using [heartleech.](https://github.com/robertdavidgraham/heartleech) and the command `./heartleech https://host:port  --autopwn --threads 20`

Next, they will need to copy the key to a file, (I called the file heartkey) and then run the command `ssh jason@host -i/heartkey`

Once in, the user will need to take the private key and decrypt the message located on a page on the site.

TODO
====
* Lock down permissions more (currently .ssh and authorized_keys are 600 and 700 which is too high.) See [this](http://wiki.centos.org/HowTos/Network/SecuringSSH#head-b726dd17be7e9657f8cae037c6ea70c1a032ca1f) for more info on what it takes to make authorized_keys work even when permissions are lower.
* Restrict user from being able to add/remove files and stop them from seeing any dir but /home/jason
* Generate public/private key and add it to chef recipe, then encrypt a message with [this](https://www.igolder.com/pgp/encryption/) and add it to a page on the site.
* Generate and add a key.