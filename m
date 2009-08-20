From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Aug 2009 14:02:24 +0000
Subject: [PATCH] sh: update kfr2r09 defconfig
Message-Id: <20090820140224.24054.47937.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the kfr2r09 defconfig with support for LCDC and USB gadget.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/kfr2r09_defconfig |  212 ++++++++++++++++++++++++++++++++++---
 1 file changed, 197 insertions(+), 15 deletions(-)

--- 0001/arch/sh/configs/kfr2r09_defconfig
+++ work/arch/sh/configs/kfr2r09_defconfig	2009-08-20 22:13:54.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31-rc3
-# Thu Jul 23 17:45:09 2009
+# Linux kernel version: 2.6.31-rc6
+# Thu Aug 20 21:58:52 2009
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -38,6 +38,7 @@ CONFIG_CONSTRUCTORS=y
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT2
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
@@ -132,7 +133,12 @@ CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
 CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -255,6 +261,7 @@ CONFIG_CPU_HAS_FPU=y
 #
 # CONFIG_SH_7724_SOLUTION_ENGINE is not set
 CONFIG_SH_KFR2R09=y
+# CONFIG_SH_ECOVEC is not set
 
 #
 # Timer and clock configuration
@@ -301,8 +308,8 @@ CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
 # CONFIG_SECCOMP is not set
 # CONFIG_PREEMPT_NONE is not set
-CONFIG_PREEMPT_VOLUNTARY=y
-# CONFIG_PREEMPT is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
 CONFIG_GUSA=y
 # CONFIG_SPARSE_IRQ is not set
 
@@ -313,7 +320,7 @@ CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
 CONFIG_ENTRY_OFFSET=0x00001000
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttySC1,115200"
+CONFIG_CMDLINE="console=tty0 console=ttySC1,115200"
 
 #
 # Bus options
@@ -427,6 +434,7 @@ CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_AR7_PARTS is not set
@@ -639,6 +647,7 @@ CONFIG_I2C_SH_MOBILE=y
 # Other I2C/SMBus bus drivers
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -715,7 +724,35 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+CONFIG_FB_SYS_FILLRECT=y
+CONFIG_FB_SYS_COPYAREA=y
+CONFIG_FB_SYS_IMAGEBLIT=y
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+CONFIG_FB_SYS_FOPS=y
+CONFIG_FB_DEFERRED_IO=y
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
+CONFIG_FB_SH_MOBILE_LCDC=y
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
@@ -727,15 +764,157 @@ CONFIG_SSB_POSSIBLE=y
 # Console display driver support
 #
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+# CONFIG_FONT_8x16 is not set
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+CONFIG_FONT_MINI_4x6=y
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_LOGO_LINUX_CLUT224 is not set
+# CONFIG_LOGO_SUPERH_MONO is not set
+CONFIG_LOGO_SUPERH_VGA16=y
+# CONFIG_LOGO_SUPERH_CLUT224 is not set
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_GADGET_MUSB_HDRC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+# CONFIG_USB_GADGET_DEBUG_FS is not set
+CONFIG_USB_GADGET_VBUS_DRAW=2
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_ATMEL_USBA is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_PXA25X is not set
+CONFIG_USB_GADGET_R8A66597=y
+CONFIG_USB_R8A66597=y
+# CONFIG_USB_GADGET_PXA27X is not set
+# CONFIG_USB_GADGET_S3C_HSOTG is not set
+# CONFIG_USB_GADGET_IMX is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_QE is not set
+# CONFIG_USB_GADGET_CI13XXX is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LANGWELL is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+# CONFIG_USB_ZERO is not set
+# CONFIG_USB_AUDIO is not set
+# CONFIG_USB_ETH is not set
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_USB_G_PRINTER is not set
+CONFIG_USB_CDC_COMPOSITE=y
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_SH=y
+# CONFIG_RTC_DRV_GENERIC is not set
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 CONFIG_UIO=y
@@ -763,8 +942,10 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
 CONFIG_FILE_LOCKING=y
-# CONFIG_FSNOTIFY is not set
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 # CONFIG_INOTIFY is not set
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
@@ -829,7 +1010,7 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_LATENCYTOP is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
@@ -844,6 +1025,7 @@ CONFIG_TRACING_SUPPORT=y
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_EARLY_SCIF_CONSOLE is not set
+# CONFIG_DWARF_UNWINDER is not set
 
 #
 # Security options
@@ -862,10 +1044,10 @@ CONFIG_BITREVERSE=y
 CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
-CONFIG_CRC_T10DIF=y
-CONFIG_CRC_ITU_T=y
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_CRC7=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_DECOMPRESS_GZIP=y
