From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 18 Jun 2008 09:31:46 +0000
Subject: [PATCH 2/2] sh: Update Solution Enginge 7712 defconfig
Message-Id: <4858D602.7000902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable SH-Ether support and NFS userland support.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/configs/se7712_defconfig |  660 ++++++++++++++++---------------------
 1 files changed, 285 insertions(+), 375 deletions(-)

diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index 240a1ce..7be79cd 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -1,53 +1,57 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc4
-# Wed Mar 28 10:19:02 2007
+# Linux kernel version: 2.6.26-rc6
+# Wed Jun 18 16:36:08 2008
 #
 CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-# CONFIG_GENERIC_TIME is not set
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_NO_VIRT_TO_BUS=y
+CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT2
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -55,33 +59,41 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 # CONFIG_BUG is not set
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 # CONFIG_BASE_FULL is not set
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 # CONFIG_SHMEM is not set
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 CONFIG_TINY_SHMEM=y
 CONFIG_BASE_SMALL=1
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 # CONFIG_MODULE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set

 #
 # IO Schedulers
@@ -95,57 +107,17 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_DEFAULT_CFQ is not set
 CONFIG_DEFAULT_NOOP=y
 CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_CLASSIC_RCU=y

 #
 # System type
 #
-CONFIG_SOLUTION_ENGINE=y
-CONFIG_SH_SOLUTION_ENGINE=y
-# CONFIG_SH_7751_SOLUTION_ENGINE is not set
-# CONFIG_SH_7300_SOLUTION_ENGINE is not set
-# CONFIG_SH_7343_SOLUTION_ENGINE is not set
-# CONFIG_SH_73180_SOLUTION_ENGINE is not set
-# CONFIG_SH_7751_SYSTEMH is not set
-# CONFIG_SH_HP6XX is not set
-# CONFIG_SH_SATURN is not set
-# CONFIG_SH_DREAMCAST is not set
-# CONFIG_SH_MPC1211 is not set
-# CONFIG_SH_SH03 is not set
-# CONFIG_SH_SECUREEDGE5410 is not set
-# CONFIG_SH_HS7751RVOIP is not set
-# CONFIG_SH_7710VOIPGW is not set
-# CONFIG_SH_RTS7751R2D is not set
-# CONFIG_SH_HIGHLANDER is not set
-# CONFIG_SH_EDOSK7705 is not set
-# CONFIG_SH_SH4202_MICRODEV is not set
-# CONFIG_SH_LANDISK is not set
-# CONFIG_SH_TITAN is not set
-# CONFIG_SH_SHMIN is not set
-# CONFIG_SH_7206_SOLUTION_ENGINE is not set
-# CONFIG_SH_7619_SOLUTION_ENGINE is not set
-# CONFIG_SH_LBOX_RE2 is not set
-# CONFIG_SH_UNKNOWN is not set
-
-#
-# Processor selection
-#
 CONFIG_CPU_SH3=y
-
-#
-# SH-2 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7604 is not set
 # CONFIG_CPU_SUBTYPE_SH7619 is not set
-
-#
-# SH-2A Processor Support
-#
+# CONFIG_CPU_SUBTYPE_SH7203 is not set
 # CONFIG_CPU_SUBTYPE_SH7206 is not set
-
-#
-# SH-3 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7300 is not set
+# CONFIG_CPU_SUBTYPE_SH7263 is not set
+# CONFIG_CPU_SUBTYPE_MXG is not set
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7706 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
@@ -153,10 +125,8 @@ CONFIG_CPU_SH3=y
 # CONFIG_CPU_SUBTYPE_SH7709 is not set
 # CONFIG_CPU_SUBTYPE_SH7710 is not set
 CONFIG_CPU_SUBTYPE_SH7712=y
-
-#
-# SH-4 Processor Support
-#
+# CONFIG_CPU_SUBTYPE_SH7720 is not set
+# CONFIG_CPU_SUBTYPE_SH7721 is not set
 # CONFIG_CPU_SUBTYPE_SH7750 is not set
 # CONFIG_CPU_SUBTYPE_SH7091 is not set
 # CONFIG_CPU_SUBTYPE_SH7750R is not set
@@ -165,37 +135,37 @@ CONFIG_CPU_SUBTYPE_SH7712=y
 # CONFIG_CPU_SUBTYPE_SH7751R is not set
 # CONFIG_CPU_SUBTYPE_SH7760 is not set
 # CONFIG_CPU_SUBTYPE_SH4_202 is not set
-
-#
-# ST40 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_ST40STB1 is not set
-# CONFIG_CPU_SUBTYPE_ST40GX1 is not set
-
-#
-# SH-4A Processor Support
-#
+# CONFIG_CPU_SUBTYPE_SH7723 is not set
+# CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 # CONFIG_CPU_SUBTYPE_SH7780 is not set
 # CONFIG_CPU_SUBTYPE_SH7785 is not set
-
-#
-# SH4AL-DSP Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH73180 is not set
+# CONFIG_CPU_SUBTYPE_SHX3 is not set
 # CONFIG_CPU_SUBTYPE_SH7343 is not set
 # CONFIG_CPU_SUBTYPE_SH7722 is not set
+# CONFIG_CPU_SUBTYPE_SH7366 is not set
+# CONFIG_CPU_SUBTYPE_SH5_101 is not set
+# CONFIG_CPU_SUBTYPE_SH5_103 is not set

 #
 # Memory management options
 #
+CONFIG_QUICKLIST=y
 CONFIG_MMU=y
 CONFIG_PAGE_OFFSET=0x80000000
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x02000000
+CONFIG_29BIT=y
 CONFIG_VSYSCALL=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+CONFIG_MAX_ACTIVE_REGIONS=1
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -203,21 +173,21 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPARSEMEM_STATIC=y
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
+CONFIG_NR_QUICK=2

 #
 # Cache configuration
 #
 # CONFIG_SH_DIRECT_MAPPED is not set
-# CONFIG_SH_WRITETHROUGH is not set
-# CONFIG_SH_OCRAM is not set
-CONFIG_CF_ENABLER=y
-# CONFIG_CF_AREA5 is not set
-CONFIG_CF_AREA6=y
-CONFIG_CF_BASE_ADDR=0xb8000000
+CONFIG_CACHE_WRITEBACK=y
+# CONFIG_CACHE_WRITETHROUGH is not set
+# CONFIG_CACHE_OFF is not set

 #
 # Processor features
@@ -230,14 +200,25 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_HAS_INTEVT=y
 CONFIG_CPU_HAS_IPR_IRQ=y
 CONFIG_CPU_HAS_SR_RB=y
+CONFIG_CPU_HAS_DSP=y
+
+#
+# Board support
+#
+CONFIG_SOLUTION_ENGINE=y
+CONFIG_SH_SOLUTION_ENGINE=y
+# CONFIG_SH_AP325RXA is not set

 #
 # Timer and clock configuration
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ
-# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SH_PCLK_FREQf666666
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y

 #
 # CPU Frequency scaling
@@ -252,7 +233,6 @@ CONFIG_SH_PCLK_FREQf666666
 #
 # Companion Chips
 #
-# CONFIG_HD6446X_SERIES is not set

 #
 # Additional SuperH Device Drivers
@@ -268,48 +248,40 @@ CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ%0
+# CONFIG_SCHED_HRTICK is not set
 # CONFIG_KEXEC is not set
-# CONFIG_SMP is not set
+# CONFIG_CRASH_DUMP is not set
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
+CONFIG_GUSA=y
+# CONFIG_GUSA_RB is not set

 #
 # Boot options
 #
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
-# CONFIG_UBC_WAKEUP is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"

 #
 # Bus options
 #
-# CONFIG_PCI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+CONFIG_CF_ENABLER=y
+# CONFIG_CF_AREA5 is not set
+CONFIG_CF_AREA6=y
+CONFIG_CF_BASE_ADDR=0xb8000000
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCCARD is not set

 #
-# PCI Hotplug Support
-#
-
-#
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_FLAT is not set
 # CONFIG_BINFMT_MISC is not set

 #
-# Power management options (EXPERIMENTAL)
-#
-# CONFIG_PM is not set
-
-#
 # Networking
 #
 CONFIG_NET=y
@@ -317,7 +289,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -325,6 +296,7 @@ CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
 CONFIG_NET_KEY=y
 # CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
@@ -335,11 +307,10 @@ CONFIG_ASK_IP_FIB_HASH=y
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
-# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_IP_PNP_BOOTP is not set
+CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -356,30 +327,17 @@ CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -392,15 +350,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 CONFIG_NET_SCHED=y
-CONFIG_NET_SCH_FIFO=y
-CONFIG_NET_SCH_CLK_JIFFIES=y
-# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
-# CONFIG_NET_SCH_CLK_CPU is not set

 #
 # Queueing/Scheduling
@@ -409,6 +359,7 @@ CONFIG_NET_SCH_CBQ=y
 CONFIG_NET_SCH_HTB=y
 CONFIG_NET_SCH_HFSC=y
 CONFIG_NET_SCH_PRIO=y
+# CONFIG_NET_SCH_RR is not set
 CONFIG_NET_SCH_RED=y
 CONFIG_NET_SCH_SFQ=y
 CONFIG_NET_SCH_TEQL=y
@@ -416,7 +367,6 @@ CONFIG_NET_SCH_TBF=y
 CONFIG_NET_SCH_GRED=y
 CONFIG_NET_SCH_DSMARK=y
 CONFIG_NET_SCH_NETEM=y
-CONFIG_NET_SCH_INGRESS=y

 #
 # Classification
@@ -430,50 +380,55 @@ CONFIG_NET_CLS_FW=y
 # CONFIG_NET_CLS_U32 is not set
 # CONFIG_NET_CLS_RSVP is not set
 # CONFIG_NET_CLS_RSVP6 is not set
+# CONFIG_NET_CLS_FLOW is not set
 # CONFIG_NET_EMATCH is not set
 # CONFIG_NET_CLS_ACT is not set
-# CONFIG_NET_CLS_POLICE is not set
 CONFIG_NET_CLS_IND=y
-CONFIG_NET_ESTIMATOR=y
+CONFIG_NET_SCH_FIFO=y

 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
 CONFIG_FIB_RULES=y

 #
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
 # Device Drivers
 #

 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set

 #
 # User Modules And Translation Layers
@@ -486,6 +441,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set

 #
 # RAM/ROM/Flash chip drivers
@@ -511,7 +467,6 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set

 #
 # Mapping drivers for chip access
@@ -534,44 +489,25 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
 # CONFIG_MTD_ONENAND is not set

 #
-# Parallel port support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set

 #
@@ -579,6 +515,7 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
@@ -600,6 +537,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m

 #
 # SCSI Transports
@@ -607,94 +545,72 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_MV is not set
 CONFIG_PATA_PLATFORM=y
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
-
-#
-# Ethernet (10 or 100Mbit)
-#
-# CONFIG_NET_ETHERNET is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
-#
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+CONFIG_MDIO_BITBANG=y
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_STNIC is not set
+CONFIG_SH_ETH=y
+# CONFIG_SMC91X is not set
+# CONFIG_SMC911X is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_E1000E_ENABLED is not set
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set

 #
@@ -712,6 +628,7 @@ CONFIG_NETDEVICES=y
 # Character devices
 #
 # CONFIG_VT is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set

 #
@@ -729,99 +646,78 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=m
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set

 #
-# Hardware Monitoring support
+# Sonics Silicon Backplane
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set

 #
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
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set

 #
-# Digital Video Broadcasting Devices
+# Multimedia drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_DAB is not set

 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
-# Sound
+# Display device support
 #
-# CONFIG_SOUND is not set
+# CONFIG_DISPLAY_SUPPORT is not set

 #
-# USB support
+# Sound
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_SOUND is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 # CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set

 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
-
-#
-# USB Gadget Support
-#
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y

@@ -835,40 +731,10 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 # CONFIG_LEDS_TRIGGER_TIMER is not set
 # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
-
-#
-# InfiniBand support
-#
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_RTC_CLASS is not set
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
-
-#
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
+# CONFIG_UIO is not set

 #
 # File systems
@@ -878,20 +744,21 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 # CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
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
@@ -920,7 +787,6 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set

 #
@@ -936,68 +802,67 @@ CONFIG_RAMFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
 # CONFIG_JFFS2_SUMMARY is not set
 # CONFIG_JFFS2_FS_XATTR is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
-# CONFIG_NFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
 # CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set

 #
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set

 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN24
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT
 # CONFIG_DETECT_SOFTLOCKUP is not set
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
@@ -1005,21 +870,28 @@ CONFIG_LOG_BUF_SHIFT
 # CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FRAME_POINTER=y
-# CONFIG_FORCED_INLINING is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_EARLY_SCIF_CONSOLE is not set
+# CONFIG_DEBUG_BOOTMEM is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_4KSTACKS is not set
+# CONFIG_IRQSTACKS is not set
 # CONFIG_SH_KGDB is not set

 #
@@ -1027,62 +899,100 @@ CONFIG_FRAME_POINTER=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y

 #
-# Cryptographic options
+# Crypto core or helper
 #
-CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=y
 CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_AUTHENC=y
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
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 CONFIG_CRYPTO_SHA1=y
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_LRW is not set
-CONFIG_CRYPTO_DES=y
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
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-CONFIG_CRYPTO_DEFLATE=y
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set

 #
-# Hardware crypto devices
+# Compression
 #
+CONFIG_CRYPTO_DEFLATE=y
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y

 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.5.1

