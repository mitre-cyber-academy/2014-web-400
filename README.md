heartbleed-provisioner
======================

Description: Users are provided with a heartbleed vulnerable server which they must exploit in order to obtain the private key of a user named jason which is used to decrypt a message found on a page of the site.

How to solve: First, the user will need to exploit the heartbleed vulnerability on the box, they can do so using [heartleech.](https://github.com/robertdavidgraham/heartleech) and the command `./heartleech host:port  --autopwn --threads 20`

Next, they will need to copy the key to a file, (I called the file heartkey) and then run the command `chown 600 heartkey` in order to set the permissions to an acceptable value and run `ssh jason@host -i`pwd`/heartkey` to gain access to the box.

Once in, the user will need to take the private key and decrypt the message located on a page on the site.