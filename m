From: Luca Santini <luca.santini@spesonline.com>
Date: Mon, 04 May 2009 12:46:13 +0000
Subject: Re: 2.6.30-rc4-git: timer-related oops
Message-Id: <49FEE395.70304@spesonline.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090009070806010703000606"
List-Id: <linux-sh.vger.kernel.org>
References: <20090504091430.GA30660@linux-sh.org>
In-Reply-To: <20090504091430.GA30660@linux-sh.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------090009070806010703000606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

here everything seems fine.



Manuel Lauss ha scritto:
> Hi Paul,
> 
> On Mon, May 04, 2009 at 06:14:30PM +0900, Paul Mundt wrote:
>> On Mon, May 04, 2009 at 11:15:23AM +0200, Manuel Lauss wrote:
>>> Hello!
>>>
>>> Current -git (and a few revisions before that) oops when kernel tries to
>>> mount nfsroot.  Anyone else seeing this?  (system is SH7760; I disabled
>>> almost all of my platform code to rule out a screwup on my part. The code
>>> works on 2.6.29).
>>>
>>>
>> Can you post your .config?
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.30-rc4
> # Mon May  4 11:08:17 2009
> #
> CONFIG_SUPERH=y
> CONFIG_SUPERH32=y
> # CONFIG_SUPERH64 is not set
> CONFIG_ARCH_DEFCONFIG="arch/sh/configs/shx3_defconfig"
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_FIND_NEXT_BIT=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_I_WANT_MY_OWN_GPIO_HANDLER_BUT_STILL_USE_THE_NICE_SH_GPIO_FUNCTIONS=y
> # CONFIG_BUILD_GENGPIO is not set
> CONFIG_GENERIC_GPIO=y
> CONFIG_GENERIC_TIME=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> # CONFIG_ARCH_SUSPEND_POSSIBLE is not set
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_HAVE_LATENCYTOP_SUPPORT=y
> # CONFIG_ARCH_HAS_ILOG2_U32 is not set
> # CONFIG_ARCH_HAS_ILOG2_U64 is not set
> CONFIG_ARCH_NO_VIRT_TO_BUS=y
> CONFIG_ARCH_HAS_DEFAULT_IDLE=y
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> 
> #
> # General setup
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_LOCALVERSION="-exm7760"
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_AUDIT is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_CLASSIC_RCU=y
> # CONFIG_TREE_RCU is not set
> # CONFIG_PREEMPT_RCU is not set
> # CONFIG_TREE_RCU_TRACE is not set
> # CONFIG_PREEMPT_RCU_TRACE is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_LOG_BUF_SHIFT=17
> # CONFIG_GROUP_SCHED is not set
> # CONFIG_CGROUPS is not set
> # CONFIG_SYSFS_DEPRECATED_V2 is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> # CONFIG_BLK_DEV_INITRD is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_EMBEDDED=y
> # CONFIG_UID16 is not set
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_STRIP_ASM_SYMS=y
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> # CONFIG_ELF_CORE is not set
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> # CONFIG_VM_EVENT_COUNTERS is not set
> CONFIG_SLUB_DEBUG=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> # CONFIG_PROFILING is not set
> # CONFIG_MARKERS is not set
> CONFIG_HAVE_OPROFILE=y
> # CONFIG_KPROBES is not set
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_DMA_API_DEBUG=y
> # CONFIG_SLOW_WORK is not set
> CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> CONFIG_SLABINFO=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_BLOCK=y
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_BSG is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> # CONFIG_IOSCHED_AS is not set
> # CONFIG_IOSCHED_DEADLINE is not set
> # CONFIG_IOSCHED_CFQ is not set
> # CONFIG_DEFAULT_AS is not set
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> CONFIG_DEFAULT_NOOP=y
> CONFIG_DEFAULT_IOSCHED="noop"
> # CONFIG_FREEZER is not set
> 
> #
> # System type
> #
> CONFIG_CPU_SH4=y
> # CONFIG_CPU_SUBTYPE_SH7619 is not set
> # CONFIG_CPU_SUBTYPE_SH7201 is not set
> # CONFIG_CPU_SUBTYPE_SH7203 is not set
> # CONFIG_CPU_SUBTYPE_SH7206 is not set
> # CONFIG_CPU_SUBTYPE_SH7263 is not set
> # CONFIG_CPU_SUBTYPE_MXG is not set
> # CONFIG_CPU_SUBTYPE_SH7705 is not set
> # CONFIG_CPU_SUBTYPE_SH7706 is not set
> # CONFIG_CPU_SUBTYPE_SH7707 is not set
> # CONFIG_CPU_SUBTYPE_SH7708 is not set
> # CONFIG_CPU_SUBTYPE_SH7709 is not set
> # CONFIG_CPU_SUBTYPE_SH7710 is not set
> # CONFIG_CPU_SUBTYPE_SH7712 is not set
> # CONFIG_CPU_SUBTYPE_SH7720 is not set
> # CONFIG_CPU_SUBTYPE_SH7721 is not set
> # CONFIG_CPU_SUBTYPE_SH7750 is not set
> # CONFIG_CPU_SUBTYPE_SH7091 is not set
> # CONFIG_CPU_SUBTYPE_SH7750R is not set
> # CONFIG_CPU_SUBTYPE_SH7750S is not set
> # CONFIG_CPU_SUBTYPE_SH7751 is not set
> # CONFIG_CPU_SUBTYPE_SH7751R is not set
> CONFIG_CPU_SUBTYPE_SH7760=y
> # CONFIG_CPU_SUBTYPE_SH4_202 is not set
> # CONFIG_CPU_SUBTYPE_SH7723 is not set
> # CONFIG_CPU_SUBTYPE_SH7763 is not set
> # CONFIG_CPU_SUBTYPE_SH7770 is not set
> # CONFIG_CPU_SUBTYPE_SH7780 is not set
> # CONFIG_CPU_SUBTYPE_SH7785 is not set
> # CONFIG_CPU_SUBTYPE_SH7786 is not set
> # CONFIG_CPU_SUBTYPE_SHX3 is not set
> # CONFIG_CPU_SUBTYPE_SH7343 is not set
> # CONFIG_CPU_SUBTYPE_SH7722 is not set
> # CONFIG_CPU_SUBTYPE_SH7366 is not set
> 
> #
> # Memory management options
> #
> CONFIG_QUICKLIST=y
> CONFIG_MMU=y
> CONFIG_PAGE_OFFSET=0x80000000
> CONFIG_MEMORY_START=0x0C000000
> CONFIG_MEMORY_SIZE=0x04000000
> CONFIG_29BIT=y
> CONFIG_VSYSCALL=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_MAX_ACTIVE_REGIONS=1
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_PAGE_SIZE_4KB=y
> # CONFIG_PAGE_SIZE_8KB is not set
> # CONFIG_PAGE_SIZE_16KB is not set
> # CONFIG_PAGE_SIZE_64KB is not set
> CONFIG_ENTRY_OFFSET=0x00001000
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_STATIC=y
> # CONFIG_MEMORY_HOTPLUG is not set
> CONFIG_PAGEFLAGS_EXTENDED=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> # CONFIG_MIGRATION is not set
> # CONFIG_PHYS_ADDR_T_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=0
> CONFIG_NR_QUICK=2
> CONFIG_UNEVICTABLE_LRU=y
> CONFIG_HAVE_MLOCK=y
> CONFIG_HAVE_MLOCKED_PAGE_BIT=y
> 
> #
> # Cache configuration
> #
> CONFIG_CACHE_WRITEBACK=y
> # CONFIG_CACHE_WRITETHROUGH is not set
> # CONFIG_CACHE_OFF is not set
> 
> #
> # Processor features
> #
> CONFIG_CPU_LITTLE_ENDIAN=y
> # CONFIG_CPU_BIG_ENDIAN is not set
> CONFIG_SH_FPU=y
> # CONFIG_SH_STORE_QUEUES is not set
> CONFIG_CPU_HAS_INTEVT=y
> CONFIG_CPU_HAS_SR_RB=y
> CONFIG_CPU_HAS_PTEA=y
> CONFIG_CPU_HAS_FPU=y
> 
> #
> # Board support
> #
> # CONFIG_SH_EDOSK7760 is not set
> CONFIG_SH_EXM7760=y
> 
> #
> # MSC EXM32-SH7760 Configuration
> #
> # CONFIG_EXM_SKIP_GPIOCONF is not set
> 
> #
> # EXM32 Baseboards/Systems
> #
> CONFIG_EXM_DUMMYBB=y
> CONFIG_EXM_MSC_BASEBOARDS=y
> 
> #
> # EXM32 Extension Modules
> #
> CONFIG_EXM_MSC_EXTENSIONS=y
> 
> #
> # Timer and clock configuration
> #
> CONFIG_SH_TMU=y
> CONFIG_SH_TIMER_IRQ=16
> CONFIG_SH_PCLK_FREQ=33000000
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> # CONFIG_HIGH_RES_TIMERS is not set
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # DMA support
> #
> CONFIG_SH_DMA_API=y
> CONFIG_SH_DMA=y
> CONFIG_NR_ONCHIP_DMA_CHANNELS=8
> CONFIG_NR_DMA_CHANNELS_BOOL=y
> CONFIG_NR_DMA_CHANNELS=8
> CONFIG_SH_DMABRG=y
> 
> #
> # Companion Chips
> #
> 
> #
> # Additional SuperH Device Drivers
> #
> # CONFIG_HEARTBEAT is not set
> # CONFIG_PUSH_SWITCH is not set
> 
> #
> # Kernel features
> #
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> # CONFIG_SCHED_HRTICK is not set
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> # CONFIG_SECCOMP is not set
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_GUSA=y
> CONFIG_GUSA_RB=y
> 
> #
> # Boot options
> #
> CONFIG_ZERO_PAGE_OFFSET=0x00001000
> CONFIG_BOOT_LINK_OFFSET=0x00800000
> # CONFIG_UBC_WAKEUP is not set
> # CONFIG_CMDLINE_BOOL is not set
> 
> #
> # Bus options
> #
> # CONFIG_ARCH_SUPPORTS_MSI is not set
> CONFIG_PCCARD=y
> # CONFIG_PCMCIA_DEBUG is not set
> CONFIG_PCMCIA=y
> CONFIG_PCMCIA_LOAD_CIS=y
> # CONFIG_PCMCIA_IOCTL is not set
> 
> #
> # PC-card bridges
> #
> CONFIG_EXM7760_PCMCIA=y
> CONFIG_PCMCIA_PROBE=y
> CONFIG_PCCARD_IODYN=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_HAVE_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> 
> #
> # Power management options (EXPERIMENTAL)
> #
> # CONFIG_PM is not set
> # CONFIG_CPU_IDLE is not set
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=y
> CONFIG_IP_PNP=y
> # CONFIG_IP_PNP_DHCP is not set
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> # CONFIG_INET_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_BEET is not set
> # CONFIG_INET_LRO is not set
> # CONFIG_INET_DIAG is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_PHONET is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=y
> CONFIG_CAN_RAW=y
> CONFIG_CAN_BCM=y
> 
> #
> # CAN Device Drivers
> #
> # CONFIG_CAN_VCAN is not set
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # CONFIG_IRDA is not set
> CONFIG_BT=m
> CONFIG_BT_L2CAP=m
> CONFIG_BT_SCO=m
> CONFIG_BT_RFCOMM=m
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=m
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HIDP=m
> 
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_HCIBTUSB=m
> # CONFIG_BT_HCIBTSDIO is not set
> # CONFIG_BT_HCIUART is not set
> # CONFIG_BT_HCIBCM203X is not set
> # CONFIG_BT_HCIBPA10X is not set
> # CONFIG_BT_HCIBFUSB is not set
> # CONFIG_BT_HCIDTL1 is not set
> # CONFIG_BT_HCIBT3C is not set
> # CONFIG_BT_HCIBLUECARD is not set
> # CONFIG_BT_HCIBTUART is not set
> # CONFIG_BT_HCIVHCI is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_WIRELESS is not set
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_SYS_HYPERVISOR is not set
> # CONFIG_CONNECTOR is not set
> CONFIG_MTD=y
> # CONFIG_MTD_DEBUG is not set
> # CONFIG_MTD_CONCAT is not set
> CONFIG_MTD_PARTITIONS=y
> # CONFIG_MTD_TESTS is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> CONFIG_MTD_CMDLINE_PARTS=y
> # CONFIG_MTD_AR7_PARTS is not set
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_CHAR=y
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> # CONFIG_MTD_OOPS is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> CONFIG_MTD_CFI_INTELEXT=y
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> # CONFIG_MTD_PHYSMAP_COMPAT is not set
> # CONFIG_MTD_PLATRAM is not set
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_DATAFLASH is not set
> CONFIG_MTD_M25P80=y
> CONFIG_M25PXX_USE_FAST_READ=y
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOC2000 is not set
> # CONFIG_MTD_DOC2001 is not set
> # CONFIG_MTD_DOC2001PLUS is not set
> # CONFIG_MTD_NAND is not set
> # CONFIG_MTD_ONENAND is not set
> 
> #
> # LPDDR flash memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> 
> #
> # UBI - Unsorted block images
> #
> # CONFIG_MTD_UBI is not set
> # CONFIG_PARPORT is not set
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_COW_COMMON is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_UB=y
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_BLK_DEV_HD is not set
> # CONFIG_MISC_DEVICES is not set
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> # CONFIG_SCSI_TGT is not set
> # CONFIG_SCSI_NETLINK is not set
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> # CONFIG_CHR_DEV_SCH is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=y
> CONFIG_SCSI_WAIT_SCAN=m
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> # CONFIG_SCSI_LOWLEVEL is not set
> # CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
> # CONFIG_SCSI_DH is not set
> # CONFIG_SCSI_OSD_INITIATOR is not set
> CONFIG_ATA=y
> # CONFIG_ATA_NONSTANDARD is not set
> # CONFIG_SATA_PMP is not set
> CONFIG_ATA_SFF=y
> # CONFIG_SATA_MV is not set
> CONFIG_PATA_PCMCIA=y
> # CONFIG_PATA_PLATFORM is not set
> # CONFIG_MD is not set
> CONFIG_NETDEVICES=y
> CONFIG_COMPAT_NET_DEV_OPS=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_VETH is not set
> # CONFIG_PHYLIB is not set
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_AX88796 is not set
> # CONFIG_STNIC is not set
> CONFIG_SMC91X=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ETHOC is not set
> # CONFIG_SMC911X is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_DNET is not set
> # CONFIG_IBM_NEW_EMAC_ZMII is not set
> # CONFIG_IBM_NEW_EMAC_RGMII is not set
> # CONFIG_IBM_NEW_EMAC_TAH is not set
> # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
> # CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
> # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
> # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
> # CONFIG_B44 is not set
> # CONFIG_NETDEV_1000 is not set
> # CONFIG_NETDEV_10000 is not set
> 
> #
> # Wireless LAN
> #
> # CONFIG_WLAN_PRE80211 is not set
> # CONFIG_WLAN_80211 is not set
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> 
> #
> # USB Network Adapters
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> CONFIG_NET_PCMCIA=y
> # CONFIG_PCMCIA_3C589 is not set
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_FMVJ18X is not set
> CONFIG_PCMCIA_PCNET=m
> # CONFIG_PCMCIA_NMCLAN is not set
> # CONFIG_PCMCIA_SMC91C92 is not set
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_PCMCIA_AXNET is not set
> # CONFIG_WAN is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_ISDN is not set
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_POLLDEV is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ATKBD is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_SH_KEYSC is not set
> CONFIG_INPUT_MOUSE=y
> # CONFIG_MOUSE_PS2 is not set
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
> # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_ELO is not set
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_MK712 is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> CONFIG_TOUCHSCREEN_WM97XX=m
> CONFIG_TOUCHSCREEN_WM9705=y
> # CONFIG_TOUCHSCREEN_WM9712 is not set
> # CONFIG_TOUCHSCREEN_WM9713 is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_ATI_REMOTE is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> 
> #
> # Hardware I/O ports
> #
> # CONFIG_SERIO is not set
> # CONFIG_GAMEPORT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_DEVKMEM=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_CONSOLE is not set
> # CONFIG_SERIAL_8250_CS is not set
> CONFIG_SERIAL_8250_NR_UARTS=12
> CONFIG_SERIAL_8250_RUNTIME_UARTS=12
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> CONFIG_SERIAL_SH_SCI=y
> CONFIG_SERIAL_SH_SCI_NR_UARTS=3
> CONFIG_SERIAL_SH_SCI_CONSOLE=y
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_R3964 is not set
> 
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_CARDMAN_4000 is not set
> # CONFIG_CARDMAN_4040 is not set
> # CONFIG_IPWIRELESS is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_TCG_TPM is not set
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_CHARDEV=y
> # CONFIG_I2C_HELPER_AUTO is not set
> 
> #
> # I2C Algorithms
> #
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> # CONFIG_I2C_ALGOPCA is not set
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_SH7760=y
> # CONFIG_I2C_SH_MOBILE is not set
> # CONFIG_I2C_SIMTEC is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_I2C_STUB is not set
> 
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_DS1682 is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_PCF8575 is not set
> # CONFIG_SENSORS_PCA9539 is not set
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_BITBANG=m
> # CONFIG_SPI_GPIO is not set
> CONFIG_SPI_HSPI=m
> # CONFIG_SPI_SH_SCI is not set
> 
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=m
> # CONFIG_SPI_TLE62X0 is not set
> CONFIG_ARCH_REQUIRE_GPIOLIB=y
> CONFIG_GPIOLIB=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> 
> #
> # Memory mapped GPIO expanders:
> #
> 
> #
> # I2C GPIO expanders:
> #
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCF857X is not set
> 
> #
> # PCI GPIO expanders:
> #
> 
> #
> # SPI GPIO expanders:
> #
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MCP23S08 is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> # CONFIG_THERMAL is not set
> # CONFIG_THERMAL_HWMON is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> 
> #
> # Sonics Silicon Backplane
> #
> # CONFIG_SSB is not set
> 
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_CORE is not set
> CONFIG_MFD_SM501=y
> # CONFIG_MFD_SM501_GPIO is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_UCB1400_CORE is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_REGULATOR is not set
> 
> #
> # Multimedia devices
> #
> 
> #
> # Multimedia core support
> #
> # CONFIG_VIDEO_DEV is not set
> # CONFIG_DVB_CORE is not set
> # CONFIG_VIDEO_MEDIA is not set
> 
> #
> # Multimedia drivers
> #
> # CONFIG_DAB is not set
> 
> #
> # Graphics support
> #
> # CONFIG_VGASTATE is not set
> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> # CONFIG_FB_DDC is not set
> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> # CONFIG_FB_SYS_FILLRECT is not set
> # CONFIG_FB_SYS_COPYAREA is not set
> # CONFIG_FB_SYS_IMAGEBLIT is not set
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> # CONFIG_FB_SYS_FOPS is not set
> # CONFIG_FB_SVGALIB is not set
> # CONFIG_FB_MACMODES is not set
> # CONFIG_FB_BACKLIGHT is not set
> # CONFIG_FB_MODE_HELPERS is not set
> # CONFIG_FB_TILEBLITTING is not set
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_SH_MOBILE_LCDC is not set
> CONFIG_FB_SM501=y
> CONFIG_FB_SH7760=y
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> #
> # Display device support
> #
> # CONFIG_DISPLAY_SUPPORT is not set
> 
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> CONFIG_FONTS=y
> # CONFIG_FONT_8x8 is not set
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_10x18 is not set
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> # CONFIG_LOGO_SUPERH_MONO is not set
> # CONFIG_LOGO_SUPERH_VGA16 is not set
> CONFIG_LOGO_SUPERH_CLUT224=y
> CONFIG_SOUND=y
> # CONFIG_SOUND_OSS_CORE is not set
> CONFIG_SND=y
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_JACK=y
> # CONFIG_SND_SEQUENCER is not set
> # CONFIG_SND_MIXER_OSS is not set
> # CONFIG_SND_PCM_OSS is not set
> CONFIG_SND_DYNAMIC_MINORS=y
> # CONFIG_SND_SUPPORT_OLD_API is not set
> # CONFIG_SND_VERBOSE_PROCFS is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_VMASTER=y
> CONFIG_SND_AC97_CODEC=m
> # CONFIG_SND_DRIVERS is not set
> # CONFIG_SND_SPI is not set
> # CONFIG_SND_SUPERH is not set
> # CONFIG_SND_USB is not set
> # CONFIG_SND_PCMCIA is not set
> CONFIG_SND_SOC=m
> CONFIG_SND_SOC_AC97_BUS=y
> CONFIG_SND_SOC_PCM_SH7760=m
> CONFIG_SND_SOC_SH4_HAC=m
> CONFIG_SND_SOC_SH4_SSI=m
> # CONFIG_SND_SH7760_AC97 is not set
> CONFIG_SND_SOC_EXM32MSCBB=m
> CONFIG_SND_SOC_I2C_AND_SPI=m
> # CONFIG_SND_SOC_ALL_CODECS is not set
> CONFIG_SND_SOC_AC97_CODEC=m
> CONFIG_SND_SOC_CS4251X=m
> # CONFIG_SOUND_PRIME is not set
> CONFIG_AC97_BUS=m
> CONFIG_HID_SUPPORT=y
> CONFIG_HID=y
> # CONFIG_HID_DEBUG is not set
> CONFIG_HIDRAW=y
> 
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=y
> # CONFIG_HID_PID is not set
> CONFIG_USB_HIDDEV=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_BELKIN is not set
> # CONFIG_HID_CHERRY is not set
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_KENSINGTON is not set
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_NTRIG is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SONY is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_GREENASIA_FF is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> # CONFIG_USB_ARCH_HAS_EHCI is not set
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_DEVICE_CLASS is not set
> CONFIG_USB_DYNAMIC_MINORS=y
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> # CONFIG_USB_MON is not set
> # CONFIG_USB_WUSB is not set
> # CONFIG_USB_WUSB_CBAF is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=y
> CONFIG_USB_SH7760=y
> CONFIG_USB_SH7760_DMA=y
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_ISP1760_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
> # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HWA_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> # CONFIG_USB_LIBUSUAL is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_BERRY_CHARGE is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_VST is not set
> # CONFIG_USB_GADGET is not set
> 
> #
> # OTG and related infrastructure
> #
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_NOP_USB_XCEIV is not set
> CONFIG_MMC=y
> # CONFIG_MMC_DEBUG is not set
> # CONFIG_MMC_UNSAFE_RESUME is not set
> 
> #
> # MMC/SD/SDIO Card Drivers
> #
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_BOUNCE=y
> # CONFIG_SDIO_UART is not set
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_SDHCI is not set
> # CONFIG_MMC_SPI is not set
> CONFIG_MMC_SH7760=y
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS1307 is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> CONFIG_RTC_DRV_PCF8563=y
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_DS3234 is not set
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_SH is not set
> # CONFIG_DMADEVICES is not set
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_STAGING is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT2_FS_XIP is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
> CONFIG_FILE_LOCKING=y
> # CONFIG_XFS_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> # CONFIG_PROC_PAGE_MONITOR is not set
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_CONFIGFS_FS is not set
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=0
> CONFIG_JFFS2_FS_WRITEBUFFER=y
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> CONFIG_JFFS2_SUMMARY=y
> # CONFIG_JFFS2_FS_XATTR is not set
> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_LZO=y
> CONFIG_JFFS2_RTIME=y
> CONFIG_JFFS2_RUBIN=y
> # CONFIG_JFFS2_CMODE_NONE is not set
> # CONFIG_JFFS2_CMODE_PRIORITY is not set
> CONFIG_JFFS2_CMODE_SIZE=y
> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_SQUASHFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> # CONFIG_NFS_V4 is not set
> CONFIG_ROOT_NFS=y
> # CONFIG_NFSD is not set
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_ENABLE_WARN_DEPRECATED is not set
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_SHIRQ is not set
> # CONFIG_DETECT_SOFTLOCKUP is not set
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_SCHED_DEBUG is not set
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_TIMER_STATS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_WRITECOUNT is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> # CONFIG_PAGE_POISONING is not set
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_TRACING_SUPPORT=y
> 
> #
> # Tracers
> #
> # CONFIG_FUNCTION_TRACER is not set
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_CONTEXT_SWITCH_TRACER is not set
> # CONFIG_EVENT_TRACER is not set
> # CONFIG_BOOT_TRACER is not set
> # CONFIG_TRACE_BRANCH_PROFILING is not set
> # CONFIG_STACK_TRACER is not set
> # CONFIG_KMEMTRACE is not set
> # CONFIG_WORKQUEUE_TRACER is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> # CONFIG_SH_STANDARD_BIOS is not set
> CONFIG_EARLY_SCIF_CONSOLE=y
> CONFIG_EARLY_SCIF_CONSOLE_PORT=0xfe610000
> CONFIG_EARLY_PRINTK=y
> # CONFIG_DEBUG_BOOTMEM is not set
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_4KSTACKS=y
> CONFIG_IRQSTACKS=y
> CONFIG_DUMP_CODE=y
> # CONFIG_SH_NO_BSS_INIT is not set
> # CONFIG_MORE_COMPILE_OPTIONS is not set
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_DEBUG_PROC_KEYS=y
> # CONFIG_SECURITY is not set
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_FILE_CAPABILITIES=y
> # CONFIG_CRYPTO is not set
> # CONFIG_BINARY_PRINTF is not set
> 
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_FIND_LAST_BIT=y
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> CONFIG_CRC_T10DIF=y
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_DMA=y
> CONFIG_NLATTR=y
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
*Luca  Santini*
//Elettronica di Sistema//

*SPES. S.c.p.a*
Via  Lamberto Corsi, 43   
60044 Fabriano (AN)
tel. +39 0732 25291 diretto 0732 25451
fax +39 0732 2529441
luca.santini@spesonline.com <mailto:luca.santini@spesonline.com>
www.spesonline.com <http://www.spesonline.com>

--------------090009070806010703000606
Content-Type: text/plain;
 name="console_output.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="console_output.txt"

[    0.000000] Linux version 2.6.30-rc4_edosk7760-00101-g7c6bcc1-dirty (s@jeos) (gcc version 3.4.5 20060103 (3.4.5-10.1a))9
[    0.000000] Boot params:
[    0.000000] ... MOUNT_ROOT_RDONLY - 00000001
[    0.000000] ... RAMDISK_FLAGS     - 00000000
[    0.000000] ... ORIG_ROOT_DEV     - 00000200
[    0.000000] ... LOADER_TYPE       - 00000001
[    0.000000] ... INITRD_START      - 00000000
[    0.000000] ... INITRD_SIZE       - 00000000
[    0.000000] Booting machvec: EDOSK7760
[    0.000000] Node 0: start_pfn = 0xc000, low = 0x10000
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x0000c000 -> 0x00010000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x0000c000 -> 0x00010000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: mem=64M console=ttySC2,115200 root=/dev/nfs rw nfsroot=192.168.1.199:/temp/mlau ip=1929
[    0.000000] NR_IRQS:256
[    0.000000] intc: missing unique irq mask for irq 34 (vect 0x0640)
[    0.000000] intc: missing unique irq mask for irq 35 (vect 0x0660)
[    0.000000] intc: missing unique irq mask for irq 36 (vect 0x0680)
[    0.000000] intc: missing unique irq mask for irq 37 (vect 0x06a0)
[    0.000000] intc: missing unique irq mask for irq 44 (vect 0x0780)
[    0.000000] intc: missing unique irq mask for irq 45 (vect 0x07a0)
[    0.000000] intc: missing unique irq mask for irq 46 (vect 0x07c0)
[    0.000000] intc: missing unique irq mask for irq 47 (vect 0x07e0)
[    0.000000] intc: missing unique irq mask for irq 38 (vect 0x06c0)
[    0.000000] intc: missing unique irq mask for irq 18 (vect 0x0440)
[    0.000000] intc: missing unique irq mask for irq 19 (vect 0x0460)
[    0.000000] intc: missing unique irq mask for irq 28 (vect 0x0580)
[    0.000000] intc: missing unique irq mask for irq 29 (vect 0x05a0)
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[17179569.184000] Console: colour dummy device 80x25
[17179569.184000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[17179569.184000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[17179569.184000] Memory: 61224k/65536k available (1982k kernel code, 832k data, 100k init)
[17179569.184000] PVR=04050187 CVR=20480000 PRR=00000520
[17179569.184000] I-cache : n_ways=2 n_sets=256 way_incr=8192
[17179569.184000] I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
[17179569.184000] D-cache : n_ways=2 n_sets=512 way_incr=16384
[17179569.184000] D-cache : entry_mask=0x00003fe0 alias_mask=0x00003000 n_aliases=4
[17179569.184000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000063] Using tmu for system timer
[    0.000127] Calibrating delay loop (skipped)... 199.99 BogoMIPS PRESET (lpj=399999)
[    0.000469] Mount-cache hash table entries: 512
[    0.002085] CPU: SH7760
[    0.007827] net_namespace: 320 bytes
[    0.009985] NET: Registered protocol family 16
[    0.059861] bio: create slab <bio-0> at 0
[    0.066252] SCSI subsystem initialized
[    0.068998] usbcore: registered new interface driver usbfs
[    0.070764] usbcore: registered new interface driver hub
[    0.072464] usbcore: registered new device driver usb
[    0.073422] DMA: Registering DMA API.
[    0.073566] DMA: Registering sh_dmac handler (8 channels).
[    0.094405] NET: Registered protocol family 2
[    0.095659] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.099584] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.099939] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.100337] TCP: Hash tables configured (established 2048 bind 2048)
[    0.100402] TCP reno registered
[    0.101284] NET: Registered protocol family 1
[    0.103942] sq: Registering store queue API.
[    0.197536] JFFS2 version 2.2. (NAND) ��� 2001-2006 Red Hat, Inc.
[    0.202945] msgmni has been set to 119
[    0.208235] io scheduler noop registered
[    0.208297] io scheduler anticipatory registered
[    0.208342] io scheduler deadline registered
[    0.211430] io scheduler cfq registered (default)
[    1.079781] SuperH SCI(F) driver initialized
[    1.080451] sh-sci: ttySC0 at MMIO 0xfe600000 (irq = 55) is a scif
[    1.082481] sh-sci: ttySC1 at MMIO 0xfe610000 (irq = 75) is a scif
[    1.084796] sh-sci: ttySC2 at MMIO 0xfe620000 (irq = 79) is a scif
[    1.084906] console [ttySC2] enabled
[    1.488806] sh-sci sh-sci: Attempting to register port 4 when only 3 are available.
[    1.496650] sh-sci sh-sci: Consider bumping CONFIG_SERIAL_SH_SCI_NR_UARTS!
[    1.539730] brd: module loaded
[    1.543841] Driver 'sd' needs updating - please use bus_type methods
[    1.551965] smc91x: IOADDR a2000300 doesn't match configuration (600).
[    1.558671] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
[    1.570277] eth0: SMC91C94 (rev 9) at a2000300 IRQ 2 [nowait]
[    1.576410] eth0: Ethernet addr: 4a:5a:70:27:6e:2e
[    1.584064] physmap platform flash device: 02000000 at 00000000
[    1.590440] physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
[    1.597246]  Intel/Sharp Extended Query Table at 0x0031
[    1.602651] Using buffer write method
[    1.606454] cfi_cmdset_0001: Erase suspend on write enabled
[    1.613181] RedBoot partition parsing not available
[    1.618232] Using physmap partition information
[    1.622957] Creating 4 MTD partitions on "physmap-flash.0":
[    1.628700] 0x000000000000-0x000000040000 : "bootloader"
[    1.637403] mtd: Giving out device 0 to bootloader
[    1.645108] 0x000000040000-0x000000240000 : "kernel"
[    1.653629] mtd: Giving out device 1 to kernel
[    1.659911] 0x000000240000-0x000001d40000 : "fs"
[    1.667926] mtd: Giving out device 2 to fs
[    1.673969] 0x000001d40000-0x000002000000 : "other"
[    1.682350] mtd: Giving out device 3 to other
[    1.689657] usbmon: debugfs is not available
[    1.694120] Initializing USB Mass Storage driver...
[    1.700387] usbcore: registered new interface driver usb-storage
[    1.706650] USB Mass Storage support registered.
[    1.711405] i2c /dev entries driver
[    1.720272] sh7760-i2c sh7760-i2c.0: 400 kHz mmio fe140000 irq 62
[    1.729774] sh7760-i2c sh7760-i2c.1: 400 kHz mmio fe150000 irq 63
[    1.744591] TCP cubic registered
[    1.747868] NET: Registered protocol family 17
[    1.755306] RPC: Registered udp transport module.
[    1.760205] RPC: Registered tcp transport module.
[    2.273349] eth0: link up
[    3.280198] IP-Config: Guessing netmask 255.255.255.0
[    3.286080] IP-Config: Complete:
[    3.289258]      device=eth0, addr=192.168.1.59, mask=255.255.255.0, gw=255.255.255.255,
[    3.297535]      host=192.168.1.59, domain=, nis-domain=(none),
[    3.303601]      bootserver=255.255.255.255, rootserver=192.168.1.199, rootpath=
[    3.312251] Looking up port of RPC 100003/2 on 192.168.1.199
[    3.321718] Looking up port of RPC 100005/1 on 192.168.1.199
[    3.429787] VFS: Mounted root (nfs filesystem) on device 0:12.
[    3.436455] Freeing unused kernel memory: 100k freed

Mounting /proc
Mounting /dev/pts

Please press Enter to activate this console. 


--------------090009070806010703000606
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.30-rc4
# Mon May  4 12:15:22 2009
#
CONFIG_SUPERH=y
CONFIG_SUPERH32=y
# CONFIG_SUPERH64 is not set
CONFIG_ARCH_DEFCONFIG="arch/sh/configs/shx3_defconfig"
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
CONFIG_GENERIC_IRQ_PROBE=y
# CONFIG_GENERIC_GPIO is not set
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
# CONFIG_ARCH_SUSPEND_POSSIBLE is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_NO_VIRT_TO_BUS=y
CONFIG_ARCH_HAS_DEFAULT_IDLE=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION="_edosk7760"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set

#
# RCU Subsystem
#
CONFIG_CLASSIC_RCU=y
# CONFIG_TREE_RCU is not set
# CONFIG_PREEMPT_RCU is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_PREEMPT_RCU_TRACE is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_GROUP_SCHED is not set
# CONFIG_CGROUPS is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
# CONFIG_NAMESPACES is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_EMBEDDED=y
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
# CONFIG_SLOW_WORK is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
# CONFIG_FREEZER is not set

#
# System type
#
CONFIG_CPU_SH4=y
# CONFIG_CPU_SUBTYPE_SH7619 is not set
# CONFIG_CPU_SUBTYPE_SH7201 is not set
# CONFIG_CPU_SUBTYPE_SH7203 is not set
# CONFIG_CPU_SUBTYPE_SH7206 is not set
# CONFIG_CPU_SUBTYPE_SH7263 is not set
# CONFIG_CPU_SUBTYPE_MXG is not set
# CONFIG_CPU_SUBTYPE_SH7705 is not set
# CONFIG_CPU_SUBTYPE_SH7706 is not set
# CONFIG_CPU_SUBTYPE_SH7707 is not set
# CONFIG_CPU_SUBTYPE_SH7708 is not set
# CONFIG_CPU_SUBTYPE_SH7709 is not set
# CONFIG_CPU_SUBTYPE_SH7710 is not set
# CONFIG_CPU_SUBTYPE_SH7712 is not set
# CONFIG_CPU_SUBTYPE_SH7720 is not set
# CONFIG_CPU_SUBTYPE_SH7721 is not set
# CONFIG_CPU_SUBTYPE_SH7750 is not set
# CONFIG_CPU_SUBTYPE_SH7091 is not set
# CONFIG_CPU_SUBTYPE_SH7750R is not set
# CONFIG_CPU_SUBTYPE_SH7750S is not set
# CONFIG_CPU_SUBTYPE_SH7751 is not set
# CONFIG_CPU_SUBTYPE_SH7751R is not set
CONFIG_CPU_SUBTYPE_SH7760=y
# CONFIG_CPU_SUBTYPE_SH4_202 is not set
# CONFIG_CPU_SUBTYPE_SH7723 is not set
# CONFIG_CPU_SUBTYPE_SH7724 is not set
# CONFIG_CPU_SUBTYPE_SH7763 is not set
# CONFIG_CPU_SUBTYPE_SH7770 is not set
# CONFIG_CPU_SUBTYPE_SH7780 is not set
# CONFIG_CPU_SUBTYPE_SH7785 is not set
# CONFIG_CPU_SUBTYPE_SH7786 is not set
# CONFIG_CPU_SUBTYPE_SHX3 is not set
# CONFIG_CPU_SUBTYPE_SH7343 is not set
# CONFIG_CPU_SUBTYPE_SH7722 is not set
# CONFIG_CPU_SUBTYPE_SH7366 is not set

#
# Memory management options
#
CONFIG_QUICKLIST=y
CONFIG_MMU=y
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_MEMORY_START=0x0c000000
CONFIG_MEMORY_SIZE=0x04000000
CONFIG_29BIT=y
CONFIG_VSYSCALL=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_MAX_ACTIVE_REGIONS=1
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_8KB is not set
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_ENTRY_OFFSET=0x00001000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_NR_QUICK=2
CONFIG_UNEVICTABLE_LRU=y
CONFIG_HAVE_MLOCK=y
CONFIG_HAVE_MLOCKED_PAGE_BIT=y

#
# Cache configuration
#
CONFIG_CACHE_WRITEBACK=y
# CONFIG_CACHE_WRITETHROUGH is not set
# CONFIG_CACHE_OFF is not set

#
# Processor features
#
CONFIG_CPU_LITTLE_ENDIAN=y
# CONFIG_CPU_BIG_ENDIAN is not set
CONFIG_SH_FPU=y
CONFIG_SH_STORE_QUEUES=y
CONFIG_CPU_HAS_INTEVT=y
CONFIG_CPU_HAS_SR_RB=y
CONFIG_CPU_HAS_PTEA=y
CONFIG_CPU_HAS_FPU=y

#
# Board support
#
CONFIG_SH_EDOSK7760=y

#
# Timer and clock configuration
#
CONFIG_SH_TMU=y
CONFIG_SH_TIMER_IRQ=16
CONFIG_SH_PCLK_FREQ=33333333
CONFIG_TICK_ONESHOT=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# DMA support
#
CONFIG_SH_DMA_API=y
CONFIG_SH_DMA=y
CONFIG_NR_ONCHIP_DMA_CHANNELS=8
# CONFIG_NR_DMA_CHANNELS_BOOL is not set
# CONFIG_SH_DMABRG is not set

#
# Companion Chips
#

#
# Additional SuperH Device Drivers
#
# CONFIG_HEARTBEAT is not set
# CONFIG_PUSH_SWITCH is not set

#
# Kernel features
#
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_SECCOMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_GUSA=y
# CONFIG_GUSA_RB is not set

#
# Boot options
#
CONFIG_ZERO_PAGE_OFFSET=0x00001000
CONFIG_BOOT_LINK_OFFSET=0x02000000
# CONFIG_UBC_WAKEUP is not set
CONFIG_CMDLINE_BOOL=y

#CONFIG_CMDLINE="mem=64M console=ttySC2,115200 root=/dev/mtdblock2 ro"
CONFIG_CMDLINE="mem=64M console=ttySC2,115200 root=/dev/nfs rw nfsroot=192.168.1.199:/temp/mlau ip=192.168.1.59"

#
# Bus options
#
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Power management options (EXPERIMENTAL)
#
# CONFIG_PM is not set
# CONFIG_CPU_IDLE is not set
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_OLD_REGULATORY is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_LIB80211 is not set
# CONFIG_MAC80211 is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=0
CONFIG_MTD_CONCAT=y
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_MTD_OOPS is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
CONFIG_MTD_MAP_BANK_WIDTH_32=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR flash memory drivers
#
# CONFIG_MTD_LPDDR is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=26000
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_NETDEVICES=y
CONFIG_COMPAT_NET_DEV_OPS=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_AX88796 is not set
# CONFIG_STNIC is not set
CONFIG_SMC91X=y
# CONFIG_ETHOC is not set
# CONFIG_SMC911X is not set
# CONFIG_SMSC911X is not set
# CONFIG_DNET is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_B44 is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=3
CONFIG_SERIAL_SH_SCI_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_SH7760=y
# CONFIG_I2C_SH_MOBILE is not set
# CONFIG_I2C_SIMTEC is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_STUB is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_PCF8575 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y
# CONFIG_SPI is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_THERMAL_HWMON is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_REGULATOR is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_SH_MOBILE_LCDC is not set
# CONFIG_FB_SH7760 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
# CONFIG_FB_BROADSHEET is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# CONFIG_LOGO_SUPERH_MONO is not set
# CONFIG_LOGO_SUPERH_VGA16 is not set
CONFIG_LOGO_SUPERH_CLUT224=y
# CONFIG_SOUND is not set
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_MON=y
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_VST is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_STAGING is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT2_FS_XIP=y
CONFIG_EXT3_FS=y
# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4_FS is not set
CONFIG_FS_XIP=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_FILE_LOCKING=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_GENERIC_ACL=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=y
# CONFIG_PAGE_POISONING is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_SUPPORT=y

#
# Tracers
#
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_CONTEXT_SWITCH_TRACER is not set
# CONFIG_EVENT_TRACER is not set
# CONFIG_BOOT_TRACER is not set
# CONFIG_TRACE_BRANCH_PROFILING is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_KMEMTRACE is not set
# CONFIG_WORKQUEUE_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_SH_STANDARD_BIOS is not set
CONFIG_EARLY_SCIF_CONSOLE=y
CONFIG_EARLY_SCIF_CONSOLE_PORT=0xffe80000
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_BOOTMEM is not set
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_4KSTACKS is not set
# CONFIG_IRQSTACKS is not set
CONFIG_DUMP_CODE=y
# CONFIG_SH_NO_BSS_INIT is not set
# CONFIG_MORE_COMPILE_OPTIONS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_MANAGER2 is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_HW=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_LAST_BIT=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y

--------------090009070806010703000606--
