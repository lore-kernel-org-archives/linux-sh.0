From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 May 2008 13:38:36 +0000
Subject: [PATCH] sh: update Migo-R defconfig
Message-Id: <20080522133836.12554.82253.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update the Migo-R defconfig to include support for KEYSC, I2C, RTC and
NAND and NOR MTD devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/migor_defconfig |  294 +++++++++++++++++++++++++++++++--------
 1 file changed, 237 insertions(+), 57 deletions(-)

--- 0001/arch/sh/configs/migor_defconfig
+++ work/arch/sh/configs/migor_defconfig	2008-05-22 14:49:31.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.24
-# Wed Feb  6 21:52:20 2008
+# Linux kernel version: 2.6.26-rc3
+# Thu May 22 14:30:07 2008
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -20,6 +20,7 @@ CONFIG_LOCKDEP_SUPPORT=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_ARCH_NO_VIRT_TO_BUS=y
+CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -36,18 +37,16 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
-# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
 # CONFIG_CGROUPS is not set
-CONFIG_FAIR_GROUP_SCHED=y
-CONFIG_FAIR_USER_SCHED=y
-# CONFIG_FAIR_CGROUP_SCHED is not set
+# CONFIG_GROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -61,11 +60,13 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -77,11 +78,15 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 # CONFIG_MODULE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
@@ -105,7 +110,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_CLASSIC_RCU=y
-# CONFIG_PREEMPT_RCU is not set
 
 #
 # System type
@@ -118,6 +122,7 @@ CONFIG_CPU_SHX2=y
 # CONFIG_CPU_SUBTYPE_SH7203 is not set
 # CONFIG_CPU_SUBTYPE_SH7206 is not set
 # CONFIG_CPU_SUBTYPE_SH7263 is not set
+# CONFIG_CPU_SUBTYPE_MXG is not set
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7706 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
@@ -135,6 +140,7 @@ CONFIG_CPU_SHX2=y
 # CONFIG_CPU_SUBTYPE_SH7751R is not set
 # CONFIG_CPU_SUBTYPE_SH7760 is not set
 # CONFIG_CPU_SUBTYPE_SH4_202 is not set
+# CONFIG_CPU_SUBTYPE_SH7723 is not set
 # CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 # CONFIG_CPU_SUBTYPE_SH7780 is not set
@@ -142,6 +148,7 @@ CONFIG_CPU_SHX2=y
 # CONFIG_CPU_SUBTYPE_SHX3 is not set
 # CONFIG_CPU_SUBTYPE_SH7343 is not set
 CONFIG_CPU_SUBTYPE_SH7722=y
+# CONFIG_CPU_SUBTYPE_SH7366 is not set
 # CONFIG_CPU_SUBTYPE_SH5_101 is not set
 # CONFIG_CPU_SUBTYPE_SH5_103 is not set
 
@@ -255,7 +262,6 @@ CONFIG_HZ%0
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_RCU_TRACE=y
 CONFIG_GUSA=y
 
 #
@@ -323,8 +329,6 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -376,7 +380,90 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0xffffffff
+CONFIG_MTD_PHYSMAP_LEN=0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=0
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+CONFIG_MTD_NAND_PLATFORM=y
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -385,11 +472,13 @@ CONFIG_BLK_DEV=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT
 CONFIG_BLK_DEV_RAM_SIZE@96
-CONFIG_BLK_DEV_RAM_BLOCKSIZE24
+# CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -461,6 +550,7 @@ CONFIG_SMC91X=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -482,13 +572,20 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
 # Input Device Drivers
 #
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_KEYBOARD_SH_KEYSC=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
@@ -508,6 +605,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -531,16 +629,40 @@ CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
-
-#
-# SPI support
-#
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+CONFIG_I2C_SH_MOBILE=y
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 
 #
@@ -553,12 +675,22 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
 # CONFIG_DAB is not set
 
 #
@@ -592,6 +724,8 @@ CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 # CONFIG_USB_ARCH_HAS_EHCI is not set
 # CONFIG_USB is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -608,6 +742,7 @@ CONFIG_USB_GADGET_SELECTED=y
 CONFIG_USB_GADGET_M66592=y
 CONFIG_USB_M66592=y
 CONFIG_SUPERH_BUILT_IN_M66592=y
+# CONFIG_USB_GADGET_PXA27X is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
@@ -623,7 +758,9 @@ CONFIG_USB_G_SERIAL=y
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -640,15 +777,31 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_TEST is not set
 
 #
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+CONFIG_RTC_DRV_RS5C372=y
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+
+#
 # SPI RTC drivers
 #
 
 #
 # Platform RTC drivers
 #
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -657,10 +810,6 @@ CONFIG_RTC_INTF_DEV=y
 # on-CPU RTC drivers
 #
 CONFIG_RTC_DRV_SH=y
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -673,13 +822,10 @@ CONFIG_RTC_DRV_SH=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
 # CONFIG_QUOTA is not set
-# CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -720,10 +866,13 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
@@ -743,6 +892,7 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN24
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
@@ -763,48 +913,77 @@ CONFIG_EARLY_PRINTK=y
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
-# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Crypto core or helper
+#
 # CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-# CONFIG_CRYPTO_ECB is not set
-# CONFIG_CRYPTO_CBC is not set
-# CONFIG_CRYPTO_PCBC is not set
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-# CONFIG_CRYPTO_CTR is not set
-# CONFIG_CRYPTO_GCM is not set
-# CONFIG_CRYPTO_CCM is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-# CONFIG_CRYPTO_DES is not set
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
-# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
 
@@ -812,6 +991,7 @@ CONFIG_CRYPTO_HW=y
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
