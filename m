From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 11:08:46 +0000
Subject: [PATCH] sh: update r2d defconfigs with usb, spi and rtc
Message-Id: <20080207110846.9587.42743.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update the defconfigs for r2d-plus and r2d-1 since we now have new drivers
for sm501 usb, spi-over-sci and epson r9701 rtc in mainline.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/rts7751r2d1_defconfig    |  340 +++++++++++++++++++++++-------
 arch/sh/configs/rts7751r2dplus_defconfig |  340 +++++++++++++++++++++++-------
 2 files changed, 530 insertions(+), 150 deletions(-)

--- 0001/arch/sh/configs/rts7751r2d1_defconfig
+++ work/arch/sh/configs/rts7751r2d1_defconfig	2008-02-07 16:28:24.000000000 +0900
@@ -1,9 +1,10 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Tue Aug 14 18:04:44 2007
+# Linux kernel version: 2.6.24
+# Thu Feb  7 16:25:55 2008
 #
 CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -36,9 +37,14 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 # CONFIG_BLK_DEV_INITRD is not set
@@ -53,6 +59,7 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -65,6 +72,13 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+CONFIG_PROFILING=y
+# CONFIG_MARKERS is not set
+CONFIG_OPROFILE=y
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -91,13 +105,17 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
+# CONFIG_PREEMPT_RCU is not set
 
 #
 # System type
 #
 CONFIG_CPU_SH4=y
 # CONFIG_CPU_SUBTYPE_SH7619 is not set
+# CONFIG_CPU_SUBTYPE_SH7203 is not set
 # CONFIG_CPU_SUBTYPE_SH7206 is not set
+# CONFIG_CPU_SUBTYPE_SH7263 is not set
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7706 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
@@ -105,6 +123,8 @@ CONFIG_CPU_SH4=y
 # CONFIG_CPU_SUBTYPE_SH7709 is not set
 # CONFIG_CPU_SUBTYPE_SH7710 is not set
 # CONFIG_CPU_SUBTYPE_SH7712 is not set
+# CONFIG_CPU_SUBTYPE_SH7720 is not set
+# CONFIG_CPU_SUBTYPE_SH7721 is not set
 # CONFIG_CPU_SUBTYPE_SH7750 is not set
 # CONFIG_CPU_SUBTYPE_SH7091 is not set
 # CONFIG_CPU_SUBTYPE_SH7750R is not set
@@ -113,14 +133,15 @@ CONFIG_CPU_SH4=y
 CONFIG_CPU_SUBTYPE_SH7751R=y
 # CONFIG_CPU_SUBTYPE_SH7760 is not set
 # CONFIG_CPU_SUBTYPE_SH4_202 is not set
-# CONFIG_CPU_SUBTYPE_ST40STB1 is not set
-# CONFIG_CPU_SUBTYPE_ST40GX1 is not set
+# CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 # CONFIG_CPU_SUBTYPE_SH7780 is not set
 # CONFIG_CPU_SUBTYPE_SH7785 is not set
 # CONFIG_CPU_SUBTYPE_SHX3 is not set
 # CONFIG_CPU_SUBTYPE_SH7343 is not set
 # CONFIG_CPU_SUBTYPE_SH7722 is not set
+# CONFIG_CPU_SUBTYPE_SH5_101 is not set
+# CONFIG_CPU_SUBTYPE_SH5_103 is not set
 
 #
 # Memory management options
@@ -130,6 +151,7 @@ CONFIG_MMU=y
 CONFIG_PAGE_OFFSET=0x80000000
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x04000000
+CONFIG_29BIT=y
 CONFIG_VSYSCALL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
@@ -147,6 +169,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPARSEMEM_STATIC=y
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
@@ -168,23 +191,22 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SH_FPU=y
 # CONFIG_SH_STORE_QUEUES is not set
 CONFIG_CPU_HAS_INTEVT=y
-CONFIG_CPU_HAS_INTC_IRQ=y
 CONFIG_CPU_HAS_SR_RB=y
 CONFIG_CPU_HAS_PTEA=y
+CONFIG_CPU_HAS_FPU=y
 
 #
 # Board support
 #
 # CONFIG_SH_7751_SYSTEMH is not set
 # CONFIG_SH_SECUREEDGE5410 is not set
-# CONFIG_SH_HS7751RVOIP is not set
 CONFIG_SH_RTS7751R2D=y
 # CONFIG_SH_LANDISK is not set
 # CONFIG_SH_TITAN is not set
 # CONFIG_SH_LBOX_RE2 is not set
 
 #
-# RTS7751R2D options
+# RTS7751R2D Board Revision
 #
 # CONFIG_RTS7751R2D_PLUS is not set
 CONFIG_RTS7751R2D_1=y
@@ -198,6 +220,7 @@ CONFIG_SH_PCLK_FREQ`000000
 # CONFIG_TICK_ONESHOT is not set
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 
 #
 # CPU Frequency scaling
@@ -227,11 +250,15 @@ CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ%0
+# CONFIG_SCHED_HRTICK is not set
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_RCU_TRACE=y
+CONFIG_GUSA=y
+# CONFIG_GUSA_RB is not set
 
 #
 # Boot options
@@ -250,10 +277,7 @@ CONFIG_SH_PCIDMA_NONCOHERENT=y
 CONFIG_PCI_AUTO=y
 CONFIG_PCI_AUTO_UPDATE_RESOURCES=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCCARD is not set
 CONFIG_HOTPLUG_PCI=y
 # CONFIG_HOTPLUG_PCI_FAKE is not set
@@ -281,6 +305,7 @@ CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -299,6 +324,7 @@ CONFIG_IP_FIB_HASH=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -324,10 +350,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -335,6 +357,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -356,6 +379,7 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -371,6 +395,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT
 CONFIG_BLK_DEV_RAM_SIZE@96
@@ -420,6 +445,7 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
@@ -493,7 +519,9 @@ CONFIG_ATA=y
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
 # CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC_OLD is not set
@@ -508,14 +536,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_WINBOND is not set
 CONFIG_PATA_PLATFORM=y
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -530,25 +551,31 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_SMC91X is not set
+# CONFIG_ENC28J60 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
@@ -560,6 +587,7 @@ CONFIG_8139TOO=y
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
 # CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -570,6 +598,10 @@ CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -577,6 +609,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -585,11 +618,15 @@ CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
 # CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
 # CONFIG_TR is not set
 
 #
@@ -597,13 +634,21 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -622,7 +667,6 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -650,6 +694,7 @@ CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -674,11 +719,9 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT%6
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
@@ -687,16 +730,30 @@ CONFIG_DEVPORT=y
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_SH_SCI=y
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_ABITUGURU3 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
 # CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM70 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
 # CONFIG_SENSORS_SIS5595 is not set
@@ -708,6 +765,13 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -720,16 +784,12 @@ CONFIG_MFD_SM501=y
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
 CONFIG_DAB=y
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Display device support
-#
-# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
@@ -738,6 +798,7 @@ CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
 # CONFIG_FB_SYS_FILLRECT is not set
 # CONFIG_FB_SYS_COPYAREA is not set
 # CONFIG_FB_SYS_IMAGEBLIT is not set
@@ -777,6 +838,12 @@ CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_PM3 is not set
 CONFIG_FB_SM501=y
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -844,6 +911,7 @@ CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_BT87X is not set
 # CONFIG_SND_CA0106 is not set
 # CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_OXYGEN is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
 # CONFIG_SND_DARLA20 is not set
@@ -868,6 +936,7 @@ CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_HDA_INTEL is not set
 # CONFIG_SND_HDSP is not set
 # CONFIG_SND_HDSPM is not set
+# CONFIG_SND_HIFIER is not set
 # CONFIG_SND_ICE1712 is not set
 # CONFIG_SND_ICE1724 is not set
 # CONFIG_SND_INTEL8X0 is not set
@@ -885,16 +954,27 @@ CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_TRIDENT is not set
 # CONFIG_SND_VIA82XX is not set
 # CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VIRTUOSO is not set
 # CONFIG_SND_VX222 is not set
 CONFIG_SND_YMFPCI=m
 CONFIG_SND_YMFPCI_FIRMWARE_IN_KERNEL=y
 # CONFIG_SND_AC97_POWER_SAVE is not set
 
 #
+# SPI devices
+#
+
+#
 # SUPERH devices
 #
 
 #
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_CAIAQ is not set
+
+#
 # System on Chip audio support
 #
 # CONFIG_SND_SOC is not set
@@ -904,6 +984,10 @@ CONFIG_SND_YMFPCI_FIRMWARE_IN_KERNEL=y
 #
 
 #
+# ALSA SoC audio for Freescale SOCs
+#
+
+#
 # Open Sound System
 #
 CONFIG_SOUND_PRIME=m
@@ -914,19 +998,104 @@ CONFIG_AC97_BUS=m
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# USB Gadget Support
+# may also be needed; see USB_STORAGE Help for more information
 #
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+CONFIG_USB_LIBUSUAL=y
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_MON is not set
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
+# CONFIG_USB_AUERSWALD is not set
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
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
 # CONFIG_NEW_LEDS is not set
@@ -949,13 +1118,17 @@ CONFIG_RTC_INTF_DEV=y
 #
 # SPI RTC drivers
 #
+# CONFIG_RTC_DRV_MAX6902 is not set
+CONFIG_RTC_DRV_R9701=y
+# CONFIG_RTC_DRV_RS5C348 is not set
 
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
@@ -963,20 +1136,7 @@ CONFIG_RTC_INTF_DEV=y
 #
 # on-CPU RTC drivers
 #
-CONFIG_RTC_DRV_SH=y
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
+# CONFIG_RTC_DRV_SH is not set
 
 #
 # Userspace I/O
@@ -1034,7 +1194,6 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1053,10 +1212,7 @@ CONFIG_RAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
 # CONFIG_SMB_FS is not set
@@ -1070,10 +1226,6 @@ CONFIG_RAMFS=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_437 is not set
@@ -1114,30 +1266,22 @@ CONFIG_NLS_CODEPAGE_932=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 
 #
-# Profiling support
-#
-CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 CONFIG_EARLY_SCIF_CONSOLE=y
 CONFIG_EARLY_SCIF_CONSOLE_PORT=0xffe80000
@@ -1149,7 +1293,53 @@ CONFIG_EARLY_PRINTK=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-# CONFIG_CRYPTO is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_SEQIV is not set
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
 
 #
 # Library routines
--- 0001/arch/sh/configs/rts7751r2dplus_defconfig
+++ work/arch/sh/configs/rts7751r2dplus_defconfig	2008-02-07 16:24:45.000000000 +0900
@@ -1,9 +1,10 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Tue Aug 14 16:33:08 2007
+# Linux kernel version: 2.6.24
+# Thu Feb  7 16:17:47 2008
 #
 CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -36,9 +37,14 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 # CONFIG_BLK_DEV_INITRD is not set
@@ -53,6 +59,7 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -65,6 +72,13 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+CONFIG_PROFILING=y
+# CONFIG_MARKERS is not set
+CONFIG_OPROFILE=y
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -91,13 +105,17 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
+# CONFIG_PREEMPT_RCU is not set
 
 #
 # System type
 #
 CONFIG_CPU_SH4=y
 # CONFIG_CPU_SUBTYPE_SH7619 is not set
+# CONFIG_CPU_SUBTYPE_SH7203 is not set
 # CONFIG_CPU_SUBTYPE_SH7206 is not set
+# CONFIG_CPU_SUBTYPE_SH7263 is not set
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7706 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
@@ -105,6 +123,8 @@ CONFIG_CPU_SH4=y
 # CONFIG_CPU_SUBTYPE_SH7709 is not set
 # CONFIG_CPU_SUBTYPE_SH7710 is not set
 # CONFIG_CPU_SUBTYPE_SH7712 is not set
+# CONFIG_CPU_SUBTYPE_SH7720 is not set
+# CONFIG_CPU_SUBTYPE_SH7721 is not set
 # CONFIG_CPU_SUBTYPE_SH7750 is not set
 # CONFIG_CPU_SUBTYPE_SH7091 is not set
 # CONFIG_CPU_SUBTYPE_SH7750R is not set
@@ -113,14 +133,15 @@ CONFIG_CPU_SH4=y
 CONFIG_CPU_SUBTYPE_SH7751R=y
 # CONFIG_CPU_SUBTYPE_SH7760 is not set
 # CONFIG_CPU_SUBTYPE_SH4_202 is not set
-# CONFIG_CPU_SUBTYPE_ST40STB1 is not set
-# CONFIG_CPU_SUBTYPE_ST40GX1 is not set
+# CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 # CONFIG_CPU_SUBTYPE_SH7780 is not set
 # CONFIG_CPU_SUBTYPE_SH7785 is not set
 # CONFIG_CPU_SUBTYPE_SHX3 is not set
 # CONFIG_CPU_SUBTYPE_SH7343 is not set
 # CONFIG_CPU_SUBTYPE_SH7722 is not set
+# CONFIG_CPU_SUBTYPE_SH5_101 is not set
+# CONFIG_CPU_SUBTYPE_SH5_103 is not set
 
 #
 # Memory management options
@@ -130,6 +151,7 @@ CONFIG_MMU=y
 CONFIG_PAGE_OFFSET=0x80000000
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x04000000
+CONFIG_29BIT=y
 CONFIG_VSYSCALL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
@@ -147,6 +169,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPARSEMEM_STATIC=y
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
@@ -168,23 +191,22 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SH_FPU=y
 # CONFIG_SH_STORE_QUEUES is not set
 CONFIG_CPU_HAS_INTEVT=y
-CONFIG_CPU_HAS_INTC_IRQ=y
 CONFIG_CPU_HAS_SR_RB=y
 CONFIG_CPU_HAS_PTEA=y
+CONFIG_CPU_HAS_FPU=y
 
 #
 # Board support
 #
 # CONFIG_SH_7751_SYSTEMH is not set
 # CONFIG_SH_SECUREEDGE5410 is not set
-# CONFIG_SH_HS7751RVOIP is not set
 CONFIG_SH_RTS7751R2D=y
 # CONFIG_SH_LANDISK is not set
 # CONFIG_SH_TITAN is not set
 # CONFIG_SH_LBOX_RE2 is not set
 
 #
-# RTS7751R2D options
+# RTS7751R2D Board Revision
 #
 CONFIG_RTS7751R2D_PLUS=y
 # CONFIG_RTS7751R2D_1 is not set
@@ -198,6 +220,7 @@ CONFIG_SH_PCLK_FREQ`000000
 # CONFIG_TICK_ONESHOT is not set
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 
 #
 # CPU Frequency scaling
@@ -227,11 +250,15 @@ CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ%0
+# CONFIG_SCHED_HRTICK is not set
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_RCU_TRACE=y
+CONFIG_GUSA=y
+# CONFIG_GUSA_RB is not set
 
 #
 # Boot options
@@ -250,10 +277,7 @@ CONFIG_SH_PCIDMA_NONCOHERENT=y
 CONFIG_PCI_AUTO=y
 CONFIG_PCI_AUTO_UPDATE_RESOURCES=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCCARD is not set
 CONFIG_HOTPLUG_PCI=y
 # CONFIG_HOTPLUG_PCI_FAKE is not set
@@ -281,6 +305,7 @@ CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -299,6 +324,7 @@ CONFIG_IP_FIB_HASH=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -324,10 +350,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -335,6 +357,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -356,6 +379,7 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -371,6 +395,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT
 CONFIG_BLK_DEV_RAM_SIZE@96
@@ -420,6 +445,7 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
@@ -493,7 +519,9 @@ CONFIG_ATA=y
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
 # CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC_OLD is not set
@@ -508,14 +536,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_WINBOND is not set
 CONFIG_PATA_PLATFORM=y
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -530,25 +551,31 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_SMC91X is not set
+# CONFIG_ENC28J60 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
@@ -560,6 +587,7 @@ CONFIG_8139TOO=y
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
 # CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -570,6 +598,10 @@ CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -577,6 +609,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -585,11 +618,15 @@ CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
 # CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
 # CONFIG_TR is not set
 
 #
@@ -597,13 +634,21 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -622,7 +667,6 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -650,6 +694,7 @@ CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -674,11 +719,9 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT%6
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
@@ -687,16 +730,30 @@ CONFIG_DEVPORT=y
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_SH_SCI=y
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_ABITUGURU3 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
 # CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM70 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
 # CONFIG_SENSORS_SIS5595 is not set
@@ -708,6 +765,13 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -720,16 +784,12 @@ CONFIG_MFD_SM501=y
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
 CONFIG_DAB=y
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Display device support
-#
-# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
@@ -738,6 +798,7 @@ CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
 # CONFIG_FB_SYS_FILLRECT is not set
 # CONFIG_FB_SYS_COPYAREA is not set
 # CONFIG_FB_SYS_IMAGEBLIT is not set
@@ -777,6 +838,12 @@ CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_PM3 is not set
 CONFIG_FB_SM501=y
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -844,6 +911,7 @@ CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_BT87X is not set
 # CONFIG_SND_CA0106 is not set
 # CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_OXYGEN is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
 # CONFIG_SND_DARLA20 is not set
@@ -868,6 +936,7 @@ CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_HDA_INTEL is not set
 # CONFIG_SND_HDSP is not set
 # CONFIG_SND_HDSPM is not set
+# CONFIG_SND_HIFIER is not set
 # CONFIG_SND_ICE1712 is not set
 # CONFIG_SND_ICE1724 is not set
 # CONFIG_SND_INTEL8X0 is not set
@@ -885,16 +954,27 @@ CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_TRIDENT is not set
 # CONFIG_SND_VIA82XX is not set
 # CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VIRTUOSO is not set
 # CONFIG_SND_VX222 is not set
 CONFIG_SND_YMFPCI=m
 CONFIG_SND_YMFPCI_FIRMWARE_IN_KERNEL=y
 # CONFIG_SND_AC97_POWER_SAVE is not set
 
 #
+# SPI devices
+#
+
+#
 # SUPERH devices
 #
 
 #
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_CAIAQ is not set
+
+#
 # System on Chip audio support
 #
 # CONFIG_SND_SOC is not set
@@ -904,6 +984,10 @@ CONFIG_SND_YMFPCI_FIRMWARE_IN_KERNEL=y
 #
 
 #
+# ALSA SoC audio for Freescale SOCs
+#
+
+#
 # Open Sound System
 #
 CONFIG_SOUND_PRIME=m
@@ -914,19 +998,104 @@ CONFIG_AC97_BUS=m
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# USB Gadget Support
+# may also be needed; see USB_STORAGE Help for more information
 #
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+CONFIG_USB_LIBUSUAL=y
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_MON is not set
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
+# CONFIG_USB_AUERSWALD is not set
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
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
 # CONFIG_NEW_LEDS is not set
@@ -949,13 +1118,17 @@ CONFIG_RTC_INTF_DEV=y
 #
 # SPI RTC drivers
 #
+# CONFIG_RTC_DRV_MAX6902 is not set
+CONFIG_RTC_DRV_R9701=y
+# CONFIG_RTC_DRV_RS5C348 is not set
 
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
@@ -963,20 +1136,7 @@ CONFIG_RTC_INTF_DEV=y
 #
 # on-CPU RTC drivers
 #
-CONFIG_RTC_DRV_SH=y
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
+# CONFIG_RTC_DRV_SH is not set
 
 #
 # Userspace I/O
@@ -1034,7 +1194,6 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1053,10 +1212,7 @@ CONFIG_RAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
 # CONFIG_SMB_FS is not set
@@ -1070,10 +1226,6 @@ CONFIG_RAMFS=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_437 is not set
@@ -1114,30 +1266,22 @@ CONFIG_NLS_CODEPAGE_932=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 
 #
-# Profiling support
-#
-CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 CONFIG_EARLY_SCIF_CONSOLE=y
 CONFIG_EARLY_SCIF_CONSOLE_PORT=0xffe80000
@@ -1149,7 +1293,53 @@ CONFIG_EARLY_PRINTK=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-# CONFIG_CRYPTO is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_SEQIV is not set
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
 
 #
 # Library routines
