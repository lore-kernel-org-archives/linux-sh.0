From: "goda.yusuke" <goda.yusuke@renesas.com>
Date: Thu, 28 Feb 2008 03:53:23 +0000
Subject: [PATCH] sh: se7780 defconfig
Message-Id: <47C63033.3080708@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch updates se7780_defconfig

Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
---
 arch/sh/configs/se7780_defconfig |  646 +++++++++++++++-----------------------
 1 files changed, 255 insertions(+), 391 deletions(-)

diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index f68743d..30f5ee4 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -1,9 +1,10 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc3
-# Thu Mar 15 14:06:20 2007
+# Linux kernel version: 2.6.25-rc3
+# Thu Feb 28 10:18:04 2008
 #
 CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -11,38 +12,44 @@ CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-# CONFIG_GENERIC_TIME is not set
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_SYS_SUPPORTS_PCI=y
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
 # CONFIG_EXPERIMENTAL is not set
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT2
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT
+# CONFIG_CGROUPS is not set
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
@@ -52,31 +59,36 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 # CONFIG_EPOLL is not set
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set

 #
@@ -91,68 +103,27 @@ CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
+CONFIG_CLASSIC_RCU=y
+# CONFIG_PREEMPT_RCU is not set

 #
 # System type
 #
-CONFIG_SOLUTION_ENGINE=y
-# CONFIG_SH_SOLUTION_ENGINE is not set
-# CONFIG_SH_7751_SOLUTION_ENGINE is not set
-CONFIG_SH_7780_SOLUTION_ENGINE=y
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
-# CONFIG_SH_UNKNOWN is not set
-
-#
-# Processor selection
-#
 CONFIG_CPU_SH4=y
 CONFIG_CPU_SH4A=y
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
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7706 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
 # CONFIG_CPU_SUBTYPE_SH7708 is not set
 # CONFIG_CPU_SUBTYPE_SH7709 is not set
 # CONFIG_CPU_SUBTYPE_SH7710 is not set
-
-#
-# SH-4 Processor Support
-#
+# CONFIG_CPU_SUBTYPE_SH7712 is not set
+# CONFIG_CPU_SUBTYPE_SH7720 is not set
+# CONFIG_CPU_SUBTYPE_SH7721 is not set
 # CONFIG_CPU_SUBTYPE_SH7750 is not set
 # CONFIG_CPU_SUBTYPE_SH7091 is not set
 # CONFIG_CPU_SUBTYPE_SH7750R is not set
@@ -161,52 +132,58 @@ CONFIG_CPU_SH4A=y
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
+# CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 CONFIG_CPU_SUBTYPE_SH7780=y
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
 CONFIG_MEMORY_START=0x08000000
 CONFIG_MEMORY_SIZE=0x08000000
-CONFIG_32BIT=y
+CONFIG_29BIT=y
+# CONFIG_PMB is not set
 CONFIG_VSYSCALL=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+CONFIG_MAX_ACTIVE_REGIONS=1
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_ARCH_SELECT_MEMORY_MODEL=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+# CONFIG_FLATMEM_MANUAL is not set
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_SPARSEMEM=y
+CONFIG_HAVE_MEMORY_PRESENT=y
+CONFIG_SPARSEMEM_STATIC=y
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
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
+CONFIG_CACHE_WRITEBACK=y
+# CONFIG_CACHE_WRITETHROUGH is not set
+# CONFIG_CACHE_OFF is not set

 #
 # Processor features
@@ -214,20 +191,29 @@ CONFIG_ZONE_DMA_FLAG=0
 CONFIG_CPU_LITTLE_ENDIAN=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_SH_FPU=y
-# CONFIG_SH_DSP is not set
 # CONFIG_SH_STORE_QUEUES is not set
 CONFIG_CPU_HAS_INTEVT=y
-CONFIG_CPU_HAS_INTC2_IRQ=y
-CONFIG_CPU_HAS_INTC_IRQ=y
 CONFIG_CPU_HAS_SR_RB=y
+CONFIG_CPU_HAS_FPU=y
+
+#
+# Board support
+#
+CONFIG_SOLUTION_ENGINE=y
+CONFIG_SH_7780_SOLUTION_ENGINE=y
+# CONFIG_SH_SDK7780 is not set
+# CONFIG_SH_HIGHLANDER is not set

 #
 # Timer and clock configuration
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ(
-# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SH_PCLK_FREQ3333333
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y

 #
 # CPU Frequency scaling
@@ -242,7 +228,6 @@ CONFIG_SH_PCLK_FREQ3333333
 #
 # Companion Chips
 #
-# CONFIG_HD6446X_SERIES is not set

 #
 # Additional SuperH Device Drivers
@@ -258,40 +243,36 @@ CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ%0
-# CONFIG_SMP is not set
+# CONFIG_SCHED_HRTICK is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_RCU_TRACE=y
+CONFIG_GUSA=y

 #
 # Boot options
 #
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00810000
-# CONFIG_UBC_WAKEUP is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttySC0.115200 root=/dev/sda1"

 #
 # Bus options
 #
+# CONFIG_CF_ENABLER is not set
 CONFIG_PCI=y
 CONFIG_SH_PCIDMA_NONCOHERENT=y
 CONFIG_PCI_AUTO=y
 CONFIG_PCI_AUTO_UPDATE_RESOURCES=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-
-#
-# PCI Hotplug Support
-#
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y

 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_FLAT is not set
 # CONFIG_BINFMT_MISC is not set

 #
@@ -302,7 +283,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -329,6 +309,7 @@ CONFIG_IP_PNP=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -349,16 +330,13 @@ CONFIG_IPV6=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
+# CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set

 #
@@ -366,9 +344,18 @@ CONFIG_IPV6=y
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set

 #
 # Device Drivers
@@ -380,15 +367,7 @@ CONFIG_IPV6=y
 CONFIG_STANDALONE=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
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
 # CONFIG_MTD_CONCAT is not set
@@ -407,6 +386,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set

 #
 # RAM/ROM/Flash chip drivers
@@ -437,13 +417,13 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 CONFIG_MTD_ROM=y
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set

 #
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set

 #
@@ -461,31 +441,15 @@ CONFIG_MTD_ROM=y
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
-# CONFIG_BLK_CPQ_DA is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -497,15 +461,12 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set

 #
@@ -513,6 +474,7 @@ CONFIG_BLK_DEV_LOOP=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y

@@ -533,6 +495,7 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m

 #
 # SCSI Transports
@@ -540,12 +503,9 @@ CONFIG_CHR_DEV_SG=y
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
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
 # CONFIG_SCSI_3W_9XXX is not set
@@ -555,7 +515,6 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC94XX is not set
-# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
@@ -566,6 +525,7 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_MVSAS is not set
 # CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
@@ -577,10 +537,6 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_SCSI_SRP is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
@@ -597,62 +553,48 @@ CONFIG_SATA_SIL=y
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
 # CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_EFAR is not set
 # CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
 # CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
 # CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
 # CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SERVERWORKS is not set
 # CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
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
 #
-# CONFIG_IEEE1394 is not set

 #
-# I2O device support
+# An alternative FireWire stack is available with EXPERIMENTAL=y
 #
+# CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
 CONFIG_PHYLIB=y

 #
@@ -666,85 +608,59 @@ CONFIG_PHYLIB=y
 # CONFIG_VITESSE_PHY is not set
 CONFIG_SMSC_PHY=y
 # CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
 CONFIG_SMC91X=y
-
-#
-# Tulip family network device support
-#
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
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
 # CONFIG_8139TOO is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-# CONFIG_QLA3XXX is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-# CONFIG_CHELSIO_T3 is not set
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-# CONFIG_NETXEN_NIC is not set
-
-#
-# Token Ring devices
-#
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set

 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set

 #
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
@@ -752,15 +668,7 @@ CONFIG_NET_PCI=y
 # CONFIG_NET_FC is not set
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
@@ -768,6 +676,7 @@ CONFIG_NET_PCI=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set

 #
 # Userland interfaces
@@ -777,7 +686,6 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X24
 CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set

@@ -787,6 +695,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set

@@ -821,31 +730,12 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
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
 # CONFIG_HW_RANDOM is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set

 #
@@ -853,18 +743,27 @@ CONFIG_UNIX98_PTYS=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+CONFIG_THERMAL=y
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set

 #
 # Multifunction device drivers
@@ -875,23 +774,27 @@ CONFIG_HWMON=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set

 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -899,14 +802,13 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_TILEBLITTING is not set

 #
-# Frambuffer hardware drivers
+# Frame buffer hardware drivers
 #
 # CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_CYBER2000 is not set
 # CONFIG_FB_ASILIANT is not set
 # CONFIG_FB_IMSTT is not set
-# CONFIG_FB_EPSON1355 is not set
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_NVIDIA is not set
 # CONFIG_FB_RIVA is not set
@@ -920,22 +822,27 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_KYRO is not set
 # CONFIG_FB_3DFX is not set
 # CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
 # CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set

 #
 # Console display driver support
 #
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
@@ -958,39 +865,38 @@ CONFIG_SOUND=y
 # Open Sound System
 #
 CONFIG_SOUND_PRIME=y
-# CONFIG_OBSOLETE_OSS is not set
-# CONFIG_SOUND_BT878 is not set
-# CONFIG_SOUND_ICH is not set
 # CONFIG_SOUND_TRIDENT is not set
 # CONFIG_SOUND_MSNDCLAS is not set
 # CONFIG_SOUND_MSNDPIN is not set
-# CONFIG_SOUND_VIA82CXXX is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set

 #
-# USB support
+# USB Input Devices
 #
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HIDDEV is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
-CONFIG_USB_DEBUG=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

 #
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set

 #
 # USB Host Controller Drivers
 #
 CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_BIG_ENDIAN_MMIO is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
@@ -998,6 +904,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set

 #
 # USB Device Class drivers
@@ -1015,49 +922,20 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set

 #
-# USB Input Devices
-#
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_USB_HIDDEV is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MICROTEK is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_USBNET_MII is not set
-# CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y

 #
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set

 #
@@ -1078,67 +956,17 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
-
-#
-# USB DSL modem support
-#
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
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
 # CONFIG_INFINIBAND is not set
+# CONFIG_RTC_CLASS is not set

 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
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
+# Userspace I/O
 #
+# CONFIG_UIO is not set

 #
 # File systems
@@ -1151,12 +979,11 @@ CONFIG_EXT2_FS=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-# CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -1181,14 +1008,14 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
-# CONFIG_SYSFS is not set
+CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set

 #
 # Miscellaneous filesystems
@@ -1197,14 +1024,13 @@ CONFIG_RAMFS=y
 # CONFIG_JFFS2_FS is not set
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
@@ -1225,10 +1051,6 @@ CONFIG_SUNRPC=y
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
@@ -1275,13 +1097,15 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_EARLY_SCIF_CONSOLE is not set
 # CONFIG_SH_KGDB is not set
@@ -1290,11 +1114,48 @@ CONFIG_LOG_BUF_SHIFT
 # Security options
 #
 # CONFIG_KEYS is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set
+# CONFIG_SECURITY is not set
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_SEQIV is not set
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_PCBC is not set
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
@@ -1302,9 +1163,12 @@ CONFIG_LOG_BUF_SHIFT
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 


