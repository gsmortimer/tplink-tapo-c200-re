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
* Ubus is used extensively

**Configuration Differences from a typical OpenWRT distribution:**
* OverlayFS is tmpfs and not stored in Flash (filesystem is not persistent)
* User configuration is stored in a small partition (mtd3) encrypted with DES-ECB, password known
* UCI configuration is stored and retrieved by /bin/uc_convert
* Passwords in UCI are B64 encoding of some ciphertext (unknown)
* Firmware updates are automatically downloaded from TP-Link website
* Webserver (modified uhttpd) running on port 443 accepting do, get and set methods with JSON requests, does not serve files.

**Custom processes**
* /bin/tp_manage (UDP port 20002)
* /usr/bin/ledd    LED Control
* /usr/bin/system_state_audio
* /usr/sbin/connModed
* /usr/bin/dsd
* /bin/cloud-brd
* /bin/cloud-service
* /bin/cloud-client
* /usr/bin/rtspd   RTSP Streaming server (port 922)
* /usr/bin/p2pd
* /bin/dn_switch
* /bin/storage_manager
* /bin/cet
* /bin/vda
* /bin/wtd
* /bin/nvid  (UDP port 3702)
* /usr/bin/motord    Camera motor control (+IR filter?)
* /usr/sbin/uhttpd   Customised http server, (port 443)
* 

### Tips

* No SSH server, but telnetd is avaialble: telnetd -p24 -l /bin/sh

  Note: loopback telnet already running on port 23, so another port must be specified
 
