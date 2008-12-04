From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 09:00:39 +0000
Subject: [PATCH 06/06] sh: update se7343 defconfig
Message-Id: <20081204090039.25773.40453.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the se7343 defconfig with:
 - use 33MHz PCLK
 - increase max number of SCIFs
 - add serial console configuration to compiled-in kernel command line
 - add 8250 serial port support
 - add sh-mobile-i2c driver
 - add uio driver to export VEU and VPU
 - add usb support and isp1161 host controller
 - add dm9601 ethernet-over-usb support
 - remove smc91x support

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/se7343_defconfig |  303 ++++++++++++++++++++++++++++++++++----
 1 file changed, 274 insertions(+), 29 deletions(-)

--- 0001/arch/sh/configs/se7343_defconfig
+++ work/arch/sh/configs/se7343_defconfig	2008-12-04 16:48:17.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27
-# Wed Oct 22 19:00:21 2008
+# Linux kernel version: 2.6.28-rc6
+# Thu Dec  4 16:40:25 2008
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -74,7 +74,6 @@ CONFIG_EVENTFD=y
 # CONFIG_SHMEM is not set
 CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_PCI_QUIRKS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
@@ -127,6 +126,7 @@ CONFIG_CPU_SH4=y
 CONFIG_CPU_SH4A=y
 CONFIG_CPU_SH4AL_DSP=y
 # CONFIG_CPU_SUBTYPE_SH7619 is not set
+# CONFIG_CPU_SUBTYPE_SH7201 is not set
 # CONFIG_CPU_SUBTYPE_SH7203 is not set
 # CONFIG_CPU_SUBTYPE_SH7206 is not set
 # CONFIG_CPU_SUBTYPE_SH7263 is not set
@@ -227,7 +227,7 @@ CONFIG_SH_7343_SOLUTION_ENGINE=y
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ
-CONFIG_SH_PCLK_FREQ'000000
+CONFIG_SH_PCLK_FREQ3333333
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
@@ -274,7 +274,8 @@ CONFIG_GUSA=y
 #
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttySC0,115200"
 
 #
 # Bus options
@@ -463,6 +464,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -519,23 +521,10 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_PHYLIB is not set
-CONFIG_NET_ETHERNET=y
+# CONFIG_NET_ETHERNET is not set
 CONFIG_MII=y
-# CONFIG_AX88796 is not set
-# CONFIG_STNIC is not set
-CONFIG_SMC91X=y
-# CONFIG_SMC911X is not set
-# CONFIG_IBM_NEW_EMAC_ZMII is not set
-# CONFIG_IBM_NEW_EMAC_RGMII is not set
-# CONFIG_IBM_NEW_EMAC_TAH is not set
-# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
-# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
-# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
-# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
-# CONFIG_B44 is not set
-CONFIG_NETDEV_1000=y
-CONFIG_NETDEV_10000=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 
 #
 # Wireless LAN
@@ -543,6 +532,26 @@ CONFIG_NETDEV_10000=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_IWLWIFI_LEDS is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+CONFIG_USB_USBNET=y
+# CONFIG_USB_NET_AX8817X is not set
+CONFIG_USB_NET_CDCETHER=y
+CONFIG_USB_NET_DM9601=y
+# CONFIG_USB_NET_SMSC95XX is not set
+# CONFIG_USB_NET_GL620A is not set
+# CONFIG_USB_NET_NET1080 is not set
+# CONFIG_USB_NET_PLUSB is not set
+# CONFIG_USB_NET_MCS7830 is not set
+# CONFIG_USB_NET_RNDIS_HOST is not set
+# CONFIG_USB_NET_CDC_SUBSET is not set
+# CONFIG_USB_NET_ZAURUS is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -597,13 +606,17 @@ CONFIG_DEVKMEM=y
 #
 # Serial drivers
 #
-# CONFIG_SERIAL_8250 is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_CONSOLE is not set
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_SH_SCI=y
-CONFIG_SERIAL_SH_SCI_NR_UARTS=2
+CONFIG_SERIAL_SH_SCI_NR_UARTS=4
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
@@ -615,7 +628,51 @@ CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_SH_MOBILE=y
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_AT24 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
@@ -623,11 +680,11 @@ CONFIG_HW_RANDOM=y
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
@@ -637,7 +694,10 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
 # CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
@@ -657,6 +717,16 @@ CONFIG_VIDEO_MEDIA=y
 # Multimedia drivers
 #
 # CONFIG_MEDIA_ATTACH is not set
+CONFIG_MEDIA_TUNER=y
+# CONFIG_MEDIA_TUNER_CUSTOMIZE is not set
+CONFIG_MEDIA_TUNER_SIMPLE=y
+CONFIG_MEDIA_TUNER_TDA8290=y
+CONFIG_MEDIA_TUNER_TDA9887=y
+CONFIG_MEDIA_TUNER_TEA5761=y
+CONFIG_MEDIA_TUNER_TEA5767=y
+CONFIG_MEDIA_TUNER_MT20XX=y
+CONFIG_MEDIA_TUNER_XC2028=y
+CONFIG_MEDIA_TUNER_XC5000=y
 CONFIG_VIDEO_V4L2=y
 CONFIG_VIDEO_V4L1=y
 CONFIG_VIDEO_CAPTURE_DRIVERS=y
@@ -665,8 +735,57 @@ CONFIG_VIDEO_CAPTURE_DRIVERS=y
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 # CONFIG_VIDEO_VIVI is not set
 # CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_CPIA2 is not set
+# CONFIG_VIDEO_SAA5246A is not set
+# CONFIG_VIDEO_SAA5249 is not set
 # CONFIG_SOC_CAMERA is not set
+CONFIG_V4L_USB_DRIVERS=y
+# CONFIG_USB_VIDEO_CLASS is not set
+CONFIG_USB_GSPCA=m
+# CONFIG_USB_M5602 is not set
+# CONFIG_USB_GSPCA_CONEX is not set
+# CONFIG_USB_GSPCA_ETOMS is not set
+# CONFIG_USB_GSPCA_FINEPIX is not set
+# CONFIG_USB_GSPCA_MARS is not set
+# CONFIG_USB_GSPCA_OV519 is not set
+# CONFIG_USB_GSPCA_PAC207 is not set
+# CONFIG_USB_GSPCA_PAC7311 is not set
+# CONFIG_USB_GSPCA_SONIXB is not set
+# CONFIG_USB_GSPCA_SONIXJ is not set
+# CONFIG_USB_GSPCA_SPCA500 is not set
+# CONFIG_USB_GSPCA_SPCA501 is not set
+# CONFIG_USB_GSPCA_SPCA505 is not set
+# CONFIG_USB_GSPCA_SPCA506 is not set
+# CONFIG_USB_GSPCA_SPCA508 is not set
+# CONFIG_USB_GSPCA_SPCA561 is not set
+# CONFIG_USB_GSPCA_STK014 is not set
+# CONFIG_USB_GSPCA_SUNPLUS is not set
+# CONFIG_USB_GSPCA_T613 is not set
+# CONFIG_USB_GSPCA_TV8532 is not set
+# CONFIG_USB_GSPCA_VC032X is not set
+# CONFIG_USB_GSPCA_ZC3XX is not set
+# CONFIG_VIDEO_PVRUSB2 is not set
+# CONFIG_VIDEO_EM28XX is not set
+# CONFIG_VIDEO_USBVISION is not set
+# CONFIG_USB_VICAM is not set
+# CONFIG_USB_IBMCAM is not set
+# CONFIG_USB_KONICAWC is not set
+# CONFIG_USB_QUICKCAM_MESSENGER is not set
+# CONFIG_USB_ET61X251 is not set
+# CONFIG_VIDEO_OVCAMCHIP is not set
+# CONFIG_USB_OV511 is not set
+# CONFIG_USB_SE401 is not set
+# CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_STV680 is not set
+# CONFIG_USB_ZC0301 is not set
+# CONFIG_USB_PWC is not set
+# CONFIG_USB_ZR364XX is not set
+# CONFIG_USB_STKWEBCAM is not set
+# CONFIG_USB_S2255 is not set
 CONFIG_RADIO_ADAPTERS=y
+# CONFIG_USB_DSBR is not set
+# CONFIG_USB_SI470X is not set
+# CONFIG_USB_MR800 is not set
 # CONFIG_DAB is not set
 
 #
@@ -700,6 +819,7 @@ CONFIG_FB_CFB_IMAGEBLIT=m
 CONFIG_FB_SH_MOBILE_LCDC=m
 # CONFIG_FB_VIRTUAL is not set
 # CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
@@ -737,27 +857,147 @@ CONFIG_SND_DRIVERS=y
 # CONFIG_SND_SERIAL_U16550 is not set
 # CONFIG_SND_MPU401 is not set
 CONFIG_SND_SUPERH=y
+CONFIG_SND_USB=y
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_CAIAQ is not set
 # CONFIG_SND_SOC is not set
 # CONFIG_SOUND_PRIME is not set
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 # CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
 # CONFIG_HID_PID is not set
+# CONFIG_USB_HIDDEV is not set
 
 #
 # Special HID drivers
 #
 CONFIG_HID_COMPAT=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_HID_A4TECH=y
+CONFIG_HID_APPLE=y
+CONFIG_HID_BELKIN=y
+CONFIG_HID_BRIGHT=y
+CONFIG_HID_CHERRY=y
+CONFIG_HID_CHICONY=y
+CONFIG_HID_CYPRESS=y
+CONFIG_HID_DELL=y
+CONFIG_HID_EZKEY=y
+CONFIG_HID_GYRATION=y
+CONFIG_HID_LOGITECH=y
+# CONFIG_LOGITECH_FF is not set
+# CONFIG_LOGIRUMBLEPAD2_FF is not set
+CONFIG_HID_MICROSOFT=y
+CONFIG_HID_MONTEREY=y
+CONFIG_HID_PANTHERLORD=y
+# CONFIG_PANTHERLORD_FF is not set
+CONFIG_HID_PETALYNX=y
+CONFIG_HID_SAMSUNG=y
+CONFIG_HID_SONY=y
+CONFIG_HID_SUNPLUS=y
+# CONFIG_THRUSTMASTER_FF is not set
+# CONFIG_ZEROPLUS_FF is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+CONFIG_USB_ISP116X_HCD=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
+#
+
+#
+# see USB_STORAGE Help for more information
+#
+# CONFIG_USB_STORAGE is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
-# CONFIG_UIO is not set
+CONFIG_UIO=y
+# CONFIG_UIO_PDRV is not set
+# CONFIG_UIO_PDRV_GENIRQ is not set
+# CONFIG_UIO_SMX is not set
+# CONFIG_UIO_SERCOS3 is not set
 # CONFIG_STAGING is not set
+CONFIG_STAGING_EXCLUDE_BUILD=y
 
 #
 # File systems
@@ -889,8 +1129,13 @@ CONFIG_FRAME_WARN24
 # CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_LATENCYTOP is not set
-CONFIG_NOP_TRACER=y
-CONFIG_HAVE_FTRACE=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+
+#
+# Tracers
+#
 # CONFIG_DYNAMIC_PRINTK_DEBUG is not set
 # CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
