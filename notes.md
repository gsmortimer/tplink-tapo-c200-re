# TAPO C200 Notes

### OS Overview
Based on OpenWRT, rebranded as "SLP".
Login: root:slprealtek

**Configurtation Similarities with a typical OpenWRT distribution:**
* U-Boot bootloader (accesible by typing "slp" at boot) (mtd4)
* Linux Kernel stored in seperate Flash partition (mtd5)
* RootFS stored in a SquashFS partition (mtd6)
* UCI used for all configuration
* Lua is installed, not clear if it is used for anything.

**Configuration Differences from a typical OpenWRT distribution:**
* OverlayFS is tmpfs and not stored in Flash (filesystem is not persistent)
* User configuration is stored in a small partition (mtd3) encrypted with DES-ECB, password known
* UCI configuration is stored and retrieved by /bin/uc_convert
* Passwords in UCI are B64 encoding of some ciphertext (unknown)
* Firmware updates are automatically downloaded from TP-Link website

### Tips

* No SSH server, but telnetd is avaialble: telnetd -p24 -l /bin/sh

  Note: loopback telnet already running on port 23, so another port must be specified
 
