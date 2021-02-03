#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'Tapo bin extraction. Customised for V1.0.17.'
    echo "Usage: $0 <bin file>"
    exit 1
fi

#512 byte header of some sort
dd if=$1 of=header bs=256 count=2

#boot partition
dd if=$1 of=boot.img bs=256 skip=2 count=256 

#kernel.1024 bytes shorter than the expected 5732 blocks
dd if=$1 of=kernel.img bs=256 skip=258 count=5728

#root squashfs longer than the expected 21660 blocks
dd if=$1 of=rootfs.squashfs bs=256 skip=5986 count=25509 

# some files at the end to split (not on block boundaries
# found by trial and error
dd if=$1 of=data bs=256 skip=31495

#tar.gz containing some device-specific files
dd if=data of=data1.tar.gz bs=1 count=64436 

# 256 byte raw data
dd if=data of=data2 bs=1 skip=64436 count=256

#tar.gz containing some device-specific files
dd if=data of=data3.tar.gz bs=1 skip=64692 count=63262

#Just my ramblings....

#dd if=$1 of=mtd1 bs=256 skip=474 count=40
#dd if=$1 of=mtd2 bs=256 skip=514 count=512
#dd if=$1 of=mtd3 bs=256 skip=1026 count=256
#dd if=$1 of=mtd4 bs=256 skip=1282 count=256
#dd if=$1 of=mtd7 bs=256 skip=28930 count=25500
#dd if=$1 of=mtd8 bs=256 skip=1538 count=31232

#mtd0    0x000000000000  0x00000001d800 Bytes  Blocks 0        472
#mtd1    0x00000001d800  0x000000020000 Bytes  Blocks 472      512  
#mtd2    0x000000020000  0x000000040000 Bytes  Blocks 512      1024
#mtd3    0x000000040000  0x000000050000 Bytes
#mtd4    0x000000050000  0x000000060000 Bytes
#mtd5    0x000000060000  0x0000001c6400 Bytes  Blocks 256      5732 
#mtd6    0x0000001c6400  0x000000710000 Bytes  Blocks 7268     21660
#mtd7    0x000000710000  0x000000800000 Bytes
#mtd8    0x000000060000  0x000000800000 Bytes
