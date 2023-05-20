#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Usage: make_img <https://update_url/update.zip>"
    exit 1
fi

if [[ ! -d "abootimg" ]]; then
  git clone https://github.com/codeworkx/abootimg
fi

if [[ ! -d "mkbootimg" ]]; then
  git clone https://github.com/osm0sis/mkbootimg
  make -C mkbootimg
fi

export OPENSSL_CONF=$(pwd)/openssl.conf

rm -rf update.zip update_package ramdisk initrd.img boot_image

wget $1

unzip update.zip -d update_package

mkdir -p boot_image
mkbootimg/unpackbootimg -i update_package/boot.img -o boot_image

abootimg/abootimg-unpack-initrd boot_image/boot.img-ramdisk

cat <<EOF >>  ramdisk/default.prop
ro.secure=0
ro.allow.mock.location=0
ro.debuggable=1
persist.sys.usb.config=mass_storage,adb
persist.service.adb.enable=1
EOF

abootimg/abootimg-pack-initrd

./mkbootimg/mkbootimg \
--kernel  ./boot.img-kernel \
--ramdisk ./initrd.img \
--cmdline "$(cat boot_image/boot.img-cmdline)" \
--base "$(cat boot_image/boot.img-base)" \
--board "$(cat boot_image/boot.img-board)" \
--pagesize "$(cat boot_image/boot.img-pagesize)" \
--ramdisk_offset "$(cat boot_image/boot.img-ramdisk_offset)" \
--second_offset "$(cat boot_image/boot.img-second_offset)" \
--tags_offset "$(cat boot_image/boot.img-tags_offset)" \
--kernel_offset "$(cat boot_image/boot.img-kernel_offset)" \
--output ./boot-new.img

echo "Try new boot.img with"
echo "> fastboot boot boot_new.img"
echo "You can flash afterwards with"
echo "> fastboot flash boot boot_new.img"
