# Toline Vision 4 boot.img generator

Tested on Ubuntu 23.04

Get your devices latest download at `https://mytolino.de/software-updates-tolino-ereader/`

Last Tested on Vision 4 HD with 16.1.0

./make_img.sh "https://download.pageplace.de/ereader/16.1.0/OS44/update.zip"

**The Tolino servers DO NOT support reasonable secure TLS handshakes and a custom OpenSSL config is used to connect insecurely.
Proceed only if you understand the risks and potential mitigations **

### Compatibility

This is expected to work with:
Tolino Vision 4 HD
Tolino Vision 3 HD
Tolino Vision 2
Tolino Shine 2 HD
Tolino Page

But might be adaptable to the other Tolino devices as well

### Troubleshooting

If this script does not yield you a working image double modify the script to use the
original ramdisk and check if the generated boot.img is matching your update_package/boot.img

