From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 08 Aug 2008 05:30:13 +0000
Subject: [PATCH] sh: Update sh7763rdp defconfig
Message-Id: <489BD9E5.7080600@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/configs/sh7763rdp_defconfig |  113 ++++++++++++++++++++++++++++++-----
 1 files changed, 97 insertions(+), 16 deletions(-)

diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index 83f3fe5..baf830c 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -1,15 +1,17 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc4
-# Fri Jun  6 12:20:17 2008
+# Linux kernel version: 2.6.27-rc2
+# Fri Aug  8 13:44:20 2008
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
+CONFIG_ARCH_DEFCONFIG="arch/sh/configs/shx3_defconfig"
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_TIME=y
@@ -19,7 +21,6 @@ CONFIG_LOCKDEP_SUPPORT=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_ARCH_NO_VIRT_TO_BUS=y
-CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

 #
@@ -83,10 +84,16 @@ CONFIG_PROFILING=y
 # CONFIG_MARKERS is not set
 CONFIG_OPROFILE=y
 CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set
+# CONFIG_HAVE_IOREMAP_PROT is not set
 # CONFIG_HAVE_KPROBES is not set
 # CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_ARCH_TRACEHOOK is not set
 # CONFIG_HAVE_DMA_ATTRS is not set
+# CONFIG_USE_GENERIC_SMP_HELPERS is not set
+CONFIG_HAVE_CLK=y
 CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -96,12 +103,13 @@ CONFIG_MODULES=y
 # CONFIG_MODULE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
+CONFIG_KMOD=y
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set

 #
 # IO Schedulers
@@ -177,6 +185,7 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_ENTRY_OFFSET=0x00001000
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -258,6 +267,7 @@ CONFIG_HZ%0
 # CONFIG_SCHED_HRTICK is not set
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
+CONFIG_SECCOMP=y
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
@@ -282,10 +292,6 @@ CONFIG_CMDLINE="console=ttySC2,115200 root=/dev/sda1 rootdelay"
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-
-#
-# Networking
-#
 CONFIG_NET=y

 #
@@ -361,6 +367,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_CFG80211 is not set
 CONFIG_WIRELESS_EXT=y
+CONFIG_WIRELESS_EXT_SYSFS=y
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
@@ -377,6 +384,8 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -471,6 +480,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -515,10 +525,10 @@ CONFIG_SCSI_WAIT_SCAN=m
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_DH is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -546,7 +556,9 @@ CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
+CONFIG_SH_ETH=y
 # CONFIG_SMC91X is not set
+# CONFIG_SMC911X is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
@@ -613,7 +625,11 @@ CONFIG_INPUT=y
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set

@@ -644,6 +660,7 @@ CONFIG_HW_RANDOM=y
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set

 #
@@ -655,6 +672,7 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multifunction device drivers
 #
+# CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set

@@ -679,7 +697,34 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+CONFIG_FB_FOREIGN_ENDIAN=y
+CONFIG_FB_BOTH_ENDIAN=y
+# CONFIG_FB_BIG_ENDIAN is not set
+# CONFIG_FB_LITTLE_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_SH_MOBILE_LCDC is not set
+CONFIG_FB_SH7760=y
+# CONFIG_FB_VIRTUAL is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
@@ -688,8 +733,22 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_DISPLAY_SUPPORT is not set

 #
-# Sound
-#
+# Console display driver support
+#
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
+CONFIG_LOGO_SUPERH_MONO=y
+CONFIG_LOGO_SUPERH_VGA16=y
+CONFIG_LOGO_SUPERH_CLUT224=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_SUPPORT=y
@@ -788,11 +847,27 @@ CONFIG_USB_MON=y
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_GADGET is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set

 #
@@ -865,6 +940,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -874,12 +950,11 @@ CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -949,6 +1024,7 @@ CONFIG_FRAME_WARN24
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_EARLY_SCIF_CONSOLE is not set
@@ -1003,6 +1079,10 @@ CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
@@ -1042,6 +1122,7 @@ CONFIG_BITREVERSE=y
 # CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+CONFIG_CRC_T10DIF=y
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
-- 
1.5.6.2

