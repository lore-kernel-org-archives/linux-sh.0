From: Luca Santini <luca.santini@spesonline.com>
Date: Wed, 23 Jul 2008 09:13:24 +0000
Subject: Re: problems opening console
Message-Id: <4886F634.4030301@spesonline.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080806030303000501070909"
List-Id: <linux-sh.vger.kernel.org>
References: <4885EC04.4060708@spesonline.com>
In-Reply-To: <4885EC04.4060708@spesonline.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------080806030303000501070909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

thanks for the help, i attach also the board-specific machvec 
initialization files i added.

Paul Mundt wrote:
> On Tue, Jul 22, 2008 at 04:17:40PM +0200, Luca Santini wrote:
>   
>> (in init/main.c ;  init_post(void) function)
>>
>> the rootfs seems correctly mounted and the devices /dev/console and 
>> /dev/ttySC2 are present in the filesystem.
>>
>> anybody can help me?
>>     
>
> Post the full boot log and your .config.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   

--------------080806030303000501070909
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.26-rc8
# Tue Jul 22 18:55:42 2008
#
CONFIG_SUPERH=y
CONFIG_SUPERH32=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_NO_VIRT_TO_BUS=y
CONFIG_ARCH_SUPPORTS_AOUT=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
# CONFIG_GROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
# CONFIG_NAMESPACES is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_SYSCTL_SYSCALL_CHECK=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_COMPAT_BRK=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_HAVE_KPROBES is not set
# CONFIG_HAVE_KRETPROBES is not set
# CONFIG_HAVE_DMA_ATTRS is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

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
CONFIG_CLASSIC_RCU=y

#
# System type
#
CONFIG_CPU_SH4=y
# CONFIG_CPU_SUBTYPE_SH7619 is not set
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
# CONFIG_CPU_SUBTYPE_SH7763 is not set
# CONFIG_CPU_SUBTYPE_SH7770 is not set
# CONFIG_CPU_SUBTYPE_SH7780 is not set
# CONFIG_CPU_SUBTYPE_SH7785 is not set
# CONFIG_CPU_SUBTYPE_SHX3 is not set
# CONFIG_CPU_SUBTYPE_SH7343 is not set
# CONFIG_CPU_SUBTYPE_SH7722 is not set
# CONFIG_CPU_SUBTYPE_SH7366 is not set
# CONFIG_CPU_SUBTYPE_SH5_101 is not set
# CONFIG_CPU_SUBTYPE_SH5_103 is not set

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
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_NR_QUICK=2

#
# Cache configuration
#
# CONFIG_SH_DIRECT_MAPPED is not set
CONFIG_CACHE_WRITEBACK=y
# CONFIG_CACHE_WRITETHROUGH is not set
# CONFIG_CACHE_OFF is not set

#
# Processor features
#
CONFIG_CPU_LITTLE_ENDIAN=y
# CONFIG_CPU_BIG_ENDIAN is not set
CONFIG_SH_FPU=y
# CONFIG_SH_STORE_QUEUES is not set
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
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# DMA support
#
# CONFIG_SH_DMA is not set
CONFIG_SH_DMABRG=y

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
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_GUSA=y
# CONFIG_GUSA_RB is not set

#
# Boot options
#
CONFIG_ZERO_PAGE_OFFSET=0x00001000
CONFIG_BOOT_LINK_OFFSET=0x02000000
# CONFIG_UBC_WAKEUP is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttySC2 root=/dev/ram init=/sbin/init"

#
# Bus options
#
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
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
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
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
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=3
CONFIG_MTD_CONCAT=y
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
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
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
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
CONFIG_MTD_PHYSMAP_START=0xA0000000
CONFIG_MTD_PHYSMAP_LEN=0x01000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
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
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=12000
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NET_ETHERNET is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_IWLWIFI_LEDS is not set
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
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SH_KEYSC=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_DEVKMEM=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C is not set
# CONFIG_SPI is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_THERMAL_HWMON is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set

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
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set
# CONFIG_HID_SUPPORT is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_RTC_CLASS is not set
# CONFIG_UIO is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_BIND34 is not set
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
# CONFIG_NLS_ASCII is not set
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
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
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
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
# CONFIG_SH_STANDARD_BIOS is not set
# CONFIG_EARLY_SCIF_CONSOLE is not set
# CONFIG_DEBUG_BOOTMEM is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_4KSTACKS is not set
# CONFIG_IRQSTACKS is not set
# CONFIG_SH_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_MANAGER is not set
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
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
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
# CONFIG_CRYPTO_DES is not set
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
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_HW is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_GENERIC_FIND_FIRST_BIT is not set
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y


--------------080806030303000501070909
Content-Type: text/x-csrc;
 name="io.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io.c"

/* 
 * linux/arch/sh/edosk7760/io.c
 *
 * Copyright (C) 2001  Ian da Silva, Jeremy Siegel
 * Based largely on io_se.c.
 *
 * I/O routine for Hitachi EDOSK7760.
 *
 */

#include <linux/kernel.h>
#include <linux/types.h>
#include <asm/io.h>
#include <asm/addrspace.h>
#include <linux/pci.h>

#define SMC_IOADDR	0xA2000300

#define maybebadio24(name,port) \
  printk("bad PC-like io %s for port 0x%lx at 0x%08x\n", \
	 #name, (port), (__u32) __builtin_return_address(0))

static inline void delay(void)
{
	ctrl_inw(0xa0000000);
}

/* Map the Ethernet addresses as if it is at 0x300 - 0x320 */
static inline unsigned long __port2addr(unsigned long port)
{
     if (port >= 0x300 && port < 0x320)
     {
	  /* SMC91C96 registers are 4 byte aligned rather than the
	   * usual 2 byte!
	   */
	  return SMC_IOADDR + ( (port - 0x300) * 2);
     }
     
     maybebadio24(__port2addr, port);
     return port;
}

unsigned short sh_edosk7760_inw(unsigned long port)
{
    return *(volatile unsigned short *)__port2addr(port);
}


void sh_edosk7760_outw(unsigned short value, unsigned long port)
{
	*(volatile unsigned short *)__port2addr(port) = value;
}

unsigned char sh_edosk7760_inb(unsigned long port)
{
	if (port >= 0x300 && port < 0x320 && port & 0x01) {
		return (volatile unsigned char)(sh_edosk7760_inw(port -1) >> 8);
	}
	return *(volatile unsigned char *)__port2addr(port);
}

unsigned char sh_edosk7760_inb_p(unsigned long port)
{
	unsigned char v;

 	v = *(volatile unsigned char *)__port2addr(port);
        return v;
}

unsigned int sh_edosk7760_inl(unsigned long port)
{
    return *(volatile unsigned long *)port;
}

void sh_edosk7760_outb(unsigned char value, unsigned long port)
{
	if (port >= 0x300 && port < 0x320 && port & 0x01) {
		sh_edosk7760_outw(((unsigned short)value << 8), port -1);
		return;
	}
	*(volatile unsigned char *)__port2addr(port) = value;
}

void sh_edosk7760_outb_p(unsigned char value, unsigned long port)
{
	*(volatile unsigned char *)__port2addr(port) = value;
}


void sh_edosk7760_outl(unsigned int value, unsigned long port)
{
	*(volatile unsigned long *)port = value;
}

void sh_edosk7760_insb(unsigned long port, void *addr, unsigned long count)
{
	unsigned char *p = addr;
	while (count--) *p++ = sh_edosk7760_inb(port);
}

void sh_edosk7760_insw(unsigned long port, void *addr, unsigned long count)
{
	unsigned short *p = (unsigned short*)addr;
	while (count--) *p++ = sh_edosk7760_inw(port);
}

void sh_edosk7760_insl(unsigned long port, void *addr, unsigned long count)
{
	unsigned long *p = (unsigned long*)addr;
	while (count--) *p++ = sh_edosk7760_inl(port);
}

void sh_edosk7760_outsb(unsigned long port, const void *addr, unsigned long count)
{
	unsigned char *p = (unsigned char*)addr;
	while (count--) sh_edosk7760_outb(*p++, port);
}

void sh_edosk7760_outsw(unsigned long port, const void *addr, unsigned long count)
{
	unsigned short *p = (unsigned short*)addr;
	while (count--) sh_edosk7760_outw(*p++, port);
}

void sh_edosk7760_outsl(unsigned long port, const void *addr, unsigned long count)
{
	unsigned long *p = (unsigned long*)addr;
	while (count--) sh_edosk7760_outl(*p++, port);
}

/* For read/write calls, just copy generic (pass-thru); PCIMBR is  */
/* already set up.  For a larger memory space, these would need to */
/* reset PCIMBR as needed on a per-call basis...                   */

unsigned char sh_edosk7760_readb(unsigned long addr)
{
	return *(volatile unsigned char*)addr;
}

unsigned short sh_edosk7760_readw(unsigned long addr)
{
	return *(volatile unsigned short*)addr;
}

unsigned int sh_edosk7760_readl(unsigned long addr)
{
	return *(volatile unsigned long*)addr;
}

void sh_edosk7760_writeb(unsigned char b, unsigned long addr)
{
	*(volatile unsigned char*)addr = b;
}

void sh_edosk7760_writew(unsigned short b, unsigned long addr)
{
	*(volatile unsigned short*)addr = b;
}

void sh_edosk7760_writel(unsigned int b, unsigned long addr)
{
        *(volatile unsigned long*)addr = b;
}


unsigned long
sh_edosk7760_isa_port2addr(unsigned long offset)
{
	return __port2addr(offset);
}


--------------080806030303000501070909
Content-Type: text/x-csrc;
 name="irq_intc2.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="irq_intc2.c"

/*
 * linux/arch/sh/kernel/irq_intc2.c
 *
 * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
 *
 * May be copied or modified under the terms of the GNU General Public
 * License.  See linux/COPYING for more information.                            
 *
 * Interrupt handling for INTC2-based IRQ.
 *
 * These are the "new Hitachi style" interrupts, as present on the 
 * Hitachi 7751 and the STM ST40 STB1.
 *
 * This module has been extended to support the SH7760
 *
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <asm/edosk7760.h> //SPES

#include <asm/system.h>
#include <asm/io.h>
#include <asm/machvec.h>


struct sh7760_intc2_data {
	unsigned int addr;	/* Address of Interrupt Priority Register */
	int mask; /*Mask to apply */
	int mask_offset;	/* Mask register offset */
};


static struct sh7760_intc2_data intc2_data[NR_INTC2_IRQS];

static void sh7760_enable_intc2_irq(unsigned int irq);
static void sh7760_disable_intc2_irq(unsigned int irq);

/* shutdown is same as "disable" */
#define sh7760_shutdown_intc2_irq sh7760_disable_intc2_irq

static void sh7760_mask_and_ack_intc2(unsigned int);
static void sh7760_end_intc2_irq(unsigned int irq);

static unsigned int sh7760_startup_intc2_irq(unsigned int irq)
{ 
	sh7760_enable_intc2_irq(irq);
	return 0; /* never anything pending */
}

static struct hw_interrupt_type intc2_irq_type = {
	"INTC2-IRQ",
	sh7760_startup_intc2_irq,
	sh7760_shutdown_intc2_irq,
	sh7760_enable_intc2_irq,
	sh7760_disable_intc2_irq,
	sh7760_mask_and_ack_intc2,
	sh7760_end_intc2_irq
};

static void sh7760_disable_intc2_irq(unsigned int irq)
{
	unsigned addr;
	int offset=irq-INTC2_FIRST_IRQ;
	unsigned val,flags;

	//SPES: sostituzione della save_flags() e cli() che nel kernel 2.6 non ci sono pi������
	DEFINE_SPINLOCK(driver_lock); //SPES
	
	
	// Sanity check
	if(offset<0 || offset>=NR_INTC2_IRQS) return;

	addr=intc2_data[offset].addr + intc2_data[offset].mask_offset;

	//save_and_cli(flags); //SPES
	spin_lock_irqsave(&driver_lock, flags); //SPES
	
	val=ctrl_inl(addr);
	val|=intc2_data[offset].mask;
	ctrl_outl(val,addr);

	//restore_flags(flags); //SPES
	spin_unlock_irqrestore(&driver_lock, flags); //SPES
}

static void sh7760_enable_intc2_irq(unsigned int irq)
{
	unsigned addr;
	int offset=irq-INTC2_FIRST_IRQ;

	// Sanity check
	if(offset<0 || offset>=NR_INTC2_IRQS) return;

	addr = intc2_data[offset].addr+ intc2_data[offset].mask_offset + 0x20;
	ctrl_outl(intc2_data[offset].mask, addr);

}

static void sh7760_mask_and_ack_intc2(unsigned int irq)
{
	sh7760_disable_intc2_irq(irq);
}

static void sh7760_end_intc2_irq(unsigned int irq)
{
	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
		sh7760_enable_intc2_irq(irq);
}

void sh7760_make_intc2_irq(unsigned int irq, unsigned int addr, 
		    unsigned int group,int pos, int priority, int mask_offset,
			int pri_offset)
{
	int offset=irq-INTC2_FIRST_IRQ;
	unsigned flags,val;
	
	//SPES: sostituzione della save_flags() e cli() che nel kernel 2.6 non ci sono pi������
	DEFINE_SPINLOCK(driver_lock); //SPES
	
	if(offset<0 || offset>=NR_INTC2_IRQS) {
		return;
	}

	disable_irq_nosync(irq);
	/* Fill the the data we need */
	intc2_data[offset].addr=addr;
	intc2_data[offset].mask=1<<pos;
	intc2_data[offset].mask_offset = mask_offset;
		
	/* Set the priority level */
	//save_and_cli(flags); //SPES
	spin_lock_irqsave(&driver_lock, flags); //SPES
	
	val=ctrl_inl(addr+pri_offset);
	val|=(priority)<< (group*4);
	ctrl_outl(val,addr+pri_offset);
	
	//restore_flags(flags); //SPES
	spin_unlock_irqrestore(&driver_lock, flags); //SPES
	
	
	//irq_desc[irq].handler=&intc2_irq_type; //SPES
	irq_desc[irq].handle_irq=&intc2_irq_type; //SPES

	sh7760_disable_intc2_irq(irq);
}





--------------080806030303000501070909
Content-Type: text/x-csrc;
 name="mach.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mach.c"

/*
 * linux/arch/sh/systemh/mach.c
 *
 * Minor tweak of mach_se.c file to reference EDOSK7760.
 *
 * May be copied or modified under the terms of the GNU General Public
 * License.  See linux/COPYING for more information.
 *
 * Machine vector for the Renesas EDOSK7760 board.
 */

#include <linux/init.h>
#include <asm/machvec.h>
#include <asm/edosk7760.h>

extern void heartbeat_edosk7760(void);
extern void setup_edosk7760(void);
extern void init_edosk7760(void);

/*
 * The Machine Vector
 */

/// SPES vedi include/asm-sh/machvec.h 
struct sh_machine_vector mv_edosk7760 __initmv = {
	
//	mv_setup:		//(char **cmdline_p);
	mv_name:		"EDOSK7760",
	mv_nr_irqs:		128,

	mv_inb:			sh_edosk7760_inb,
	mv_inw:			sh_edosk7760_inw,
	mv_inl:			sh_edosk7760_inl,
	mv_outb:		sh_edosk7760_outb,
	mv_outw:		sh_edosk7760_outw,
	mv_outl:		sh_edosk7760_outl,

	mv_inb_p:		sh_edosk7760_inb_p,
	mv_inw_p:		sh_edosk7760_inw,
	mv_inl_p:		sh_edosk7760_inl,
	mv_outb_p:		sh_edosk7760_outb_p,
	mv_outw_p:		sh_edosk7760_outw,
	mv_outl_p:		sh_edosk7760_outl,

	mv_insb:		sh_edosk7760_insb,
	mv_insw:		sh_edosk7760_insw,
	mv_insl:		sh_edosk7760_insl,
	mv_outsb:		sh_edosk7760_outsb,
	mv_outsw:		sh_edosk7760_outsw,
	mv_outsl:		sh_edosk7760_outsl,

	mv_readb:		sh_edosk7760_readb,
	mv_readw:		sh_edosk7760_readw,
	mv_readl:		sh_edosk7760_readl,
	mv_writeb:		sh_edosk7760_writeb,
	mv_writew:		sh_edosk7760_writew,
	mv_writel:		sh_edosk7760_writel,

//	mv_irq_demux:  	//(int irq);
	mv_init_irq:	init_edosk7760,
//	mv_init_pci:	//(void);
//	mv_heartbeat:	//(void);

//	mv_ioport_map: 	//(unsigned long port, unsigned int size);
//	mv_ioport_unmap: //(void __iomem *);

};


--------------080806030303000501070909
Content-Type: text/x-csrc;
 name="setup.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup.c"

/* 
 * linux/arch/sh/edosk7760/setup.c
 *
 * Copyright (C) 2000  Kazumoto Kojima
 *
 *
 * Modified for EDOSK7760 by
 * Richard Bister
 * 
 * SPES port to 2.6 by
 * Luca Santini
 */


#include <linux/init.h>
#include <linux/types.h>
#include <linux/platform_device.h>
#include <linux/ata_platform.h>
#include <asm/machvec.h>
#include <asm/edosk7760.h> //SPES
#include <asm/heartbeat.h>
#include <asm/io.h>
#include <asm/addrspace.h>
#include <asm/delay.h>
#include <linux/hdreg.h>
#include <linux/ide.h>

//#include <linux/spes.h> //SPES DEBUG
#define SpesPrint printk //SPES DEBUG


/*
 * Initialize the board
 */
void __init setup_edosk7760(void)
{
	SpesPrint("SPES  setup_edosk7760\n");
	/* Setup CS4 area for access to Epson graphics card */
	ctrl_outl(0x424A0400, BSC_CS4BCR);
	ctrl_outl(0x00040981, BSC_CS4WCR);

	// TODO: Add any setup code here
	SpesPrint("SPES  setup_edosk7760 fatto\n");
}

void __init init_edosk7760(void)
{
	SpesPrint("\tSPES  init_edosk7760\n");
	
	/* This is the Ethernet interrupt */
	make_imask_irq(0x09);

	/* This is the IntelStrata Flash interrupt */
	make_imask_irq(0x0A);
	
	SpesPrint("\t\tSPES  init_edosk7760 -> setup scif2 irq\n");
	/* Setup scif2 interrupts */
	sh7760_make_intc2_irq(SCIF2_ERI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
	 	SCIF2_ERI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
		SCIF2_INTPRI_OFFSET);
	
	sh7760_make_intc2_irq(SCIF2_RXI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
	 	SCIF2_RXI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
		SCIF2_INTPRI_OFFSET);
		
	sh7760_make_intc2_irq(SCIF2_BRI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
	 	SCIF2_BRI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
		SCIF2_INTPRI_OFFSET);	
		
	sh7760_make_intc2_irq(SCIF2_TXI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
	 	SCIF2_TXI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
		SCIF2_INTPRI_OFFSET);	

	SpesPrint("\t\tSPES  init_edosk7760 -> setup usbhi irq\n");

	sh7760_make_intc2_irq(USBHI_IRQ, INTC2_BASE0, 
			      USBHI_INTPRI_GROUP,
			      USBHI_INTMSK_POS, USBHI_PRIORITY, 
			      USBHI_INTMSK_OFFSET,
			      USBHI_INTPRI_OFFSET);	

	/* Setup dmabrg interrupts */
	SpesPrint("\t\tSPES  init_edosk7760 -> setup dmabrg irq\n");
	sh7760_make_intc2_irq(DMABRGI0_IRQ, INTC2_BASE0, DMABRG_INTPRI_GROUP,
	 	DMABRGI0_INTMSK_POS, DMA_PRIORITY, DMABRG_INTMSK_OFFSET,
		DMABRG_INTPRI_OFFSET);

	sh7760_make_intc2_irq(DMABRGI1_IRQ, INTC2_BASE0, DMABRG_INTPRI_GROUP,
	 	DMABRGI1_INTMSK_POS, DMA_PRIORITY, DMABRG_INTMSK_OFFSET,
		DMABRG_INTPRI_OFFSET);
		
		
	SpesPrint("\tSPES  init_edosk7760 uscita\n");
		
}

//static void edosk7760_dummy_IRQ(int irq, void * dev_id,  struct pt_regs * regs)
static irqreturn_t edosk7760_dummy_IRQ(int irq, void * dev_id) //SPES
{
	/* The edosk7760 board has the IntelStrata flash STS
	   interrupt on 0x0A. We don't need this so ignore it here */
	SpesPrint("SPES  edosk7760_dummy_IRQ\n");
  	udelay(1000); 
  	return IRQ_HANDLED;
}

//static void init_edosk7760_flash(void) //SPES
static int __init init_edosk7760_flash(void) //SPES
{
	SpesPrint("SPES  init_edosk7760_flash\n");
	request_irq(0x0A, edosk7760_dummy_IRQ, SA_INTERRUPT, "flash", NULL); //SPES COMMENTO
	SpesPrint("SPES  init_edosk7760_flash fatto DUMMY\n");

	return 0;

}

static void exit_edosk7760_flash(void)
{
	SpesPrint("SPES  exit_edosk7760_flash\n");
	free_irq(0x0A, NULL);	
}

module_init(init_edosk7760_flash);
module_exit(exit_edosk7760_flash);


--------------080806030303000501070909
Content-Type: text/x-chdr;
 name="edosk7760.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="edosk7760.h"

#ifndef ASM_SH_EDOSK7760
#define  ASM_SH_EDOSK7760

#include <asm/addrspace.h>

#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */ //SPES: da signal.h del 2.4 
#define SCIF_BASE 0xFE620000 /* Used for low-level debug output */

#define SCSMR  (volatile unsigned short *)(SCIF_BASE + 0x00)
#define SCBRR  (SCIF_BASE + 0x04)
#define SCSCR  (volatile unsigned short *)(SCIF_BASE + 0x08)
#define SC_TDR (volatile unsigned char *)(SCIF_BASE + 0x0C)
#define SC_SR  (volatile unsigned short *)(SCIF_BASE + 0x10)
#define SC_RDR (SCIF_BASE + 0x14)
#define SCTFDR (SCIF_BASE + 0x1C)
#define SCRFDR (SCIF_BASE + 0x20)
#define SCSPTR (SCIF_BASE + 0x24)
#define SCLSR  (SCIF_BASE + 0x28)
#define SCI_TD_E  0x0020
#define SCI_TDRE_CLEAR		0x00df

/* Bus state controller registers for CS4 area */
#define BSC_CS4BCR    0xA4FD0010
#define BSC_CS4WCR    0xA4FD0030 


#define __IO_PREFIX sh_edosk7760
#define u8  unsigned char
#define u16 unsigned short
#define u32 unsigned long

#include <linux/autoconf.h>
#include <asm/io_generic.h>

#define INTC_IPRA	0xffd00004UL
#define INTC_IPRB	0xffd00008UL
#define INTC_IPRC	0xffd0000cUL

#define TIMER_IRQ	16
#define TIMER_IPR_ADDR	INTC_IPRA
#define TIMER_IPR_POS	 3
#define TIMER_PRIORITY	 2

#define RTC_IRQ		22
#define RTC_IPR_ADDR	INTC_IPRA
#define RTC_IPR_POS	 0
#define RTC_PRIORITY	TIMER_PRIORITY

#define DMTE0_IRQ	34
#define DMTE1_IRQ	35
#define DMTE2_IRQ	36
#define DMTE3_IRQ	37
#define DMAE_IRQ	38
#define DMA_IPR_ADDR	INTC_IPRC
#define DMA_IPR_POS	2
#define DMA_PRIORITY	7

#  define ONCHIP_NR_IRQS 128

#  define PINT_NR_IRQS 0
#  define OFFCHIP_NR_IRQS 0

# define ACTUAL_NR_IRQS NR_IRQS


#define SCIF2_ERI_IRQ 76
#define SCIF2_RXI_IRQ 77
#define SCIF2_BRI_IRQ 78
#define SCIF2_TXI_IRQ 79

#define SCIF2_INTPRI_OFFSET INTC2_INTPRI08_OFFSET
#define SCIF2_INTPRI_GROUP 2
#define SCIF2_INTMSK_OFFSET INTC2_INTMSK00_OFFSET
#define SCIF2_ERI_INTMSK_POS 3
#define SCIF2_RXI_INTMSK_POS 2
#define SCIF2_BRI_INTMSK_POS 1
#define SCIF2_TXI_INTMSK_POS 0
#define SCIF2_PRIORITY 3


#define USBHI_IRQ        64
#define USBHI_INTPRI_OFFSET INTC2_INTPRI08_OFFSET
#define USBHI_INTPRI_GROUP 7
#define USBHI_INTMSK_OFFSET INTC2_INTMSK00_OFFSET
#define USBHI_INTMSK_POS 17
#define USBHI_PRIORITY   3 

#define DMABRGI0_IRQ    68
#define DMABRGI1_IRQ    69
#define DMABRG_INTPRI_OFFSET INTC2_INTPRI08_OFFSET
#define DMABRG_INTPRI_GROUP 5
#define DMABRG_INTMSK_OFFSET INTC2_INTMSK00_OFFSET
#define DMABRGI0_INTMSK_POS 14
#define DMABRGI1_INTMSK_POS 13

#define INTC2_FIRST_IRQ 48
#define NR_INTC2_IRQS 64

#define INTC2_BASE0 0xfe080000

#define INTC2_INTPRI00_OFFSET	0x00
#define INTC2_INTPRI04_OFFSET	0x04
#define INTC2_INTPRI08_OFFSET	0x08
#define INTC2_INTPRI0C_OFFSET	0x0C
#define INTC2_INTREQ00_OFFSET	0x20
#define INTC2_INTREQ04_OFFSET	0x24
#define INTC2_INTMSK00_OFFSET	0x40
#define INTC2_INTMSK04_OFFSET	0x44
#define INTC2_INTMSKCLR00_OFFSET	0x60
#define INTC2_INTMSKCLR04_OFFSET	0x64

extern void sh7760_make_intc2_irq(unsigned int irq,unsigned int addr,
                           unsigned int group,int pos,int priority,
						   int mask_offset, int pri_offset);
			

extern void disable_irq(unsigned int);
extern void disable_irq_nosync(unsigned int);
extern void enable_irq(unsigned int);

/*
 * Simple Mask Register Support
 */
extern void make_maskreg_irq(unsigned int irq);
extern unsigned short *irq_mask_register;

/*
 * Function for "on chip support modules".
 */
extern void make_ipr_irq(unsigned int irq, unsigned int addr,
			 int pos,  int priority);
extern void make_imask_irq(unsigned int irq);

#endif //ASM_SH_EDOSK7760


--------------080806030303000501070909
Content-Type: text/plain;
 name="bootlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootlog"

EDOSK7760 is in LITTLE ENDIAN mode.



Press 'SPACE Bar' key or wait for 5 seconds to enter TFTP Boot Loader.

Press any other key to start ETS.


Starting TFTP Boot Loader...
Renesas EDOSK7760 (little endian)
SH TFTP Bootloader Version 1.9
   Copyright (C) 2000 Free Software Foundation, Inc.
   Copyright (C) 2004 Renesas Technology Europe Limited
This software comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it under
under the terms of the GNU Lesser General Public License version 2.1
or later.

MAC Address = 00:00:D6:87:C6:AC
Press Space or wait 5 seconds to boot from network, any other key for menu

Timeout - booting...
Starting network boot
Board IP address : 10.193.101.98
Server IP address: 10.193.101.100
Downloading zImage to 8C210000
<sleep>
<sleep>
Downloaded 1368288 bytes, crc 1421265193
Downloading disk.img.gz to 8C360000
Downloaded 3937279 bytes, crc 2804333182
Starting program at 8C210000
[    0.000000] Linux version 2.6.26-rc8-00210-g35534ad-dirty (s@s-laptop) (gcc version 3.4.5 20060103 (3.4.5-10.1a)) #298 8
[    0.000000] Boot params:
[    0.000000] ... MOUNT_ROOT_RDONLY - 00000001
[    0.000000] ... RAMDISK_FLAGS     - 00000000
[    0.000000] ... ORIG_ROOT_DEV     - 00000200
[    0.000000] ... LOADER_TYPE       - 00000001
[    0.000000] ... INITRD_START      - 00360000
[    0.000000] ... INITRD_SIZE       - 003c13ff
[    0.000000] Booting machvec: EDOSK7760
[    0.000000] Node 0: start_pfn = 0xc000, low = 0x10000
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal      49152 ->    65536
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:    49152 ->    65536
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: console=ttySC2 root=/dev/ram init=/sbin/init
[    0.000000]  SPES  init_edosk7760
[    0.000000]          SPES  init_edosk7760 -> setup scif2 irq
[    0.000000]          SPES  init_edosk7760 -> setup usbhi irq
[    0.000000]          SPES  init_edosk7760 -> setup dmabrg irq
[    0.000000]  SPES  init_edosk7760 uscita
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] Using tmu for system timer
[    0.000078] Using 8.333 MHz high precision timer.
[    0.000354] Console: colour dummy device 80x25
[    0.000844] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.001626] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.012491] Memory: 58312k/65536k available (2013k kernel code, 510k data, 116k init)
[    0.012557] PVR=04050187 CVR=20480000 PRR=00000510
[    0.012594] I-cache : n_ways=2 n_sets=256 way_incr=8192
[    0.012634] I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
[    0.012681] D-cache : n_ways=2 n_sets=512 way_incr=16384
[    0.012721] D-cache : entry_mask=0x00003fe0 alias_mask=0x00003000 n_aliases=4
[    0.013228] SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.100691] Mount-cache hash table entries: 512
[    0.105310] CPU: SH7760
[    0.117711] net_namespace: 192 bytes
[    0.120559] NET: Registered protocol family 16
[    0.216239] NET: Registered protocol family 2
[    0.251442] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.254269] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.254713] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.254922] TCP: Hash tables configured (established 2048 bind 2048)
[    0.254963] TCP reno registered
[    0.267804] NET: Registered protocol family 1
[    0.279187] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[    3.035611] Freeing initrd memory: 3844k freed
[    3.042064] SPES  init_edosk7760_flash
[    3.042179] SPES  init_edosk7760_flash fatto DUMMY
[    3.298107] msgmni has been set to 121
[    3.298451] io scheduler noop registered
[    3.298488] io scheduler anticipatory registered
[    3.298523] io scheduler deadline registered
[    3.304141] io scheduler cfq registered (default)
[    4.878016] SuperH SCI(F) driver initialized
[    4.878405] sh-sci: ttySC0 at MMIO 0xfe600000 (irq = 55) is a scif
[    4.881943] sh-sci: ttySC1 at MMIO 0xfe610000 (irq = 75) is a scif
[    4.885179] sh-sci: ttySC2 at MMIO 0xfe620000 (irq = 79) is a scif
[    4.885275] console [ttySC2] enabled
[    5.188222] sh-sci sh-sci: Attempting to register port 4 when only 3 are available.
[    5.192480] sh-sci sh-sci: Consider bumping CONFIG_SERIAL_SH_SCI_NR_UARTS!
[    5.285663] brd: module loaded
[    5.294944] physmap platform flash device: 01000000 at a0000000
[    5.295274] physmap-flash.0: Found 1 x32 devices at 0x0 in 16-bit bank
[    5.302219]  Intel/Sharp Extended Query Table at 0x0031
[    5.306936] Using buffer write method
[    5.310520] cfi_cmdset_0001: Erase suspend on write enabled
[    5.318009] cmdlinepart partition parsing not available
[    5.323077] RedBoot partition parsing not available
[    5.326114] mtd: Giving out device 0 to physmap-flash.0
[    5.348805] mice: PS/2 mouse device common for all mice
[    5.360576] TCP cubic registered
[    5.360657] NET: Registered protocol family 17
[    5.374778] RPC: Registered udp transport module.
[    5.374875] RPC: Registered tcp transport module.
[    5.388992] RAMDISK: Compressed image found at block 0
[    9.487745] kjournald starting.  Commit interval 5 seconds
[    9.487968] EXT3-fs: mounted filesystem with ordered data mode.
[    9.494474] VFS: Mounted root (ext3 filesystem) readonly.
[    9.500366] Freeing unused kernel memory: 116k freed
[    9.503781] SPES trying to do  sys_open((const char __user *) "/dev/console"         , O_RDWR, 0) ...


--------------080806030303000501070909--
