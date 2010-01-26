From: Yusuke Goda <goda.yusuke@renesas.com>
Date: Tue, 26 Jan 2010 08:33:18 +0000
Subject: Re: USB boot problems submission
Message-Id: <4B5EA8CE.9050100@renesas.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary_(ID_Gyoc7NUELYLR7kiWRm1K7Q)"
List-Id: <linux-sh.vger.kernel.org>
References: <4B5D3019.9080900@renesas.com>
In-Reply-To: <4B5D3019.9080900@renesas.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Gyoc7NUELYLR7kiWRm1K7Q)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Hi Paul-san

> You should rebuild your kernel with verbose BUG reporting and all of the
> kallsyms bits turned on, which will give you a meaningful oops. That
I attach log(CONFIG_KALLSYMS=y).

> should at least give us an idea of where things are going wrong,
> otherwise we go back to bisecting.
This problem seems to occur with the following commit.
 commit 2277ab4a1df50e05bc732fe9488d4e902bb8399a
  sh: Migrate from PG_mapped to PG_dcache_dirty.

Sorry, I cannot identify it to number of lines.
/Goda

--Boundary_(ID_Gyoc7NUELYLR7kiWRm1K7Q)
Content-type: text/plain; name=ecovec-usbboot-kallsyms.log
Content-transfer-encoding: 8BIT
Content-disposition: inline; filename=ecovec-usbboot-kallsyms.log

## Starting application at 0x89000000 ...
Linux version 2.6.33-rc4 (root@gohda) (gcc version 4.3.4 (Debian 4.3.4-1) ) #37 PREEMPT Tue Jan 26 08:02:53 UTC 2010
Boot params:
... MOUNT_ROOT_RDONLY - 00080004
... RAMDISK_FLAGS     - 00004000
... ORIG_ROOT_DEV     - 80180008
... LOADER_TYPE       - 00004000
... INITRD_START      - 00100000
... INITRD_SIZE       - 00008000
Booting machvec: R0P7724 (EcoVec)
Node 0: start_pfn = 0x8000, low = 0xf800
Zone PFN ranges:
  Normal   0x00008000 -> 0x0000f800
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00008000 -> 0x0000f800
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 30480
Kernel command line: console=tty0, console=ttySC0,115200 root=/dev/sda2 rootdelay=10 mem=120M memchunk.vpu=4m
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)102         ������������������                                       Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
PVR=10300b00 CVR=7144040d PRR=00002200
I-cache : n_ways=4 n_sets=256 way_incr=8192
I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
D-cache : n_ways=4 n_sets=256 way_incr=8192
D-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
S-cache : n_ways=4 n_sets=2048 way_incr=65536
S-cache : entry_mask=0x0000ffe0 alias_mask=0x0000f000 n_aliases=16
Memory: 118244k/122880k available (2247k kernel code, 953k data, 96k init)
virtual kernel memory layout:
    fixmap  : 0xdffd6000 - 0xdffff000   ( 164 kB)
    vmalloc : 0xc0000000 - 0xdffd4000   ( 511 MB)
    lowmem  : 0x88000000 - 0x8f800000   ( 120 MB) (cached)
            : 0xa8000000 - 0xc8000000   ( 512 MB) (uncached)
      .init : 0x88322000 - 0x8833a000   (  96 kB)
      .data : 0x88232efc - 0x883216c0   ( 953 kB)
      .text : 0x88001000 - 0x88232efc   (2247 kB)
Hierarchical RCU implementation.
NR_IRQS:256 nr_irqs:256
Console: colour dummy device 80x25
console [tty0] enabled
sh_tmu: TMU0 used for clock events
sh_tmu: TMU0 used for periodic clock events
sh_tmu: TMU1 used as clock source
Calibrating delay loop (skipped)... 499.99 BogoMIPS PRESET (lpj=999999)
Mount-cache hash table entries: 512
CPU: SH7724
NET: Registered protocol family 16
vpu: forcing memory chunk size to 0x00400000
sh pinmux: sh7724_pfc handling gpio 0 -> 486
Performance Events: SH-4A support registered
HW Breakpoints: SH-4A UBC support registered
USB1 function is selected
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource TMU1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 231
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 100x30
graphics fb0: registered sh_mobile_lcdc_fb/mainlcd as 800x480 16bpp.
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xffe00000 (irq = 80) is a scif
console [ttySC0] enabled
sh-sci.1: ttySC1 at MMIO 0xffe10000 (irq = 81) is a scif
sh-sci.2: ttySC2 at MMIO 0xffe20000 (irq = 82) is a scif
sh-sci.3: ttySC3 at MMIO 0xa4e30000 (irq = 56) is a scifa
sh-sci.4: ttySC4 at MMIO 0xa4e40000 (irq = 88) is a scifa
sh-sci.5: ttySC5 at MMIO 0xa4e50000 (irq = 109) is a scifa
brd: module loaded
physmap platform flash device: 04000000 at 00000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
RedBoot partition parsing not available
Using physmap partition information
Creating 2 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000500000 : "boot loader"
0x000000500000-0x000004000000 : "free-area"
sh_mii: probed
Base address at 0xa4600000, 00:00:87:6B:BC:B0, IRQ 91.
r8a66597_hcd: driver r8a66597_hcd, 2009-05-26
r8a66597_hcd r8a66597_hcd.0: USB Host Controller
r8a66597_hcd r8a66597_hcd.0: new USB bus registered, assigned bus number 1
r8a66597_hcd r8a66597_hcd.0: irq 65, io base 0xa4d80000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
input: sh_keysc as /class/input/input0
i2c /dev entries driver
Linux video capture interface: v2.00
camera 0-0: Probing 0-0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 0
camera: probe of 0-0 failed with error -12
camera 1-0: Probing 1-0
sh_mobile_ceu sh_mobile_ceu.1: SuperH Mobile CEU driver attached to camera 0
sh_mobile_ceu sh_mobile_ceu.1: SuperH Mobile CEU driver detached from camera 0
camera: probe of 1-0 failed with error -12
camera 1-1: Probing 1-1
sh_mobile_ceu sh_mobile_ceu.1: SuperH Mobile CEU driver attached to camera 1
sh_mobile_ceu sh_mobile_ceu.1: SuperH Mobile CEU driver detached from camera 1
camera: probe of 1-1 failed with error -12
sh_tmu: TMU0 kept as earlytimer
sh_tmu: TMU1 kept as earlytimer
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
heartbeat: version 0.1.2 loaded
TCP cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting 10sec before mounting root device...
usb 1-1: new high speed USB device using r8a66597_hcd and address 2
scsi0 : usb-storage 1-1:1.0
scsi 0:0:0:0: Direct-Access     I-O DATA USB Flash Disk   3A   PQ: 0 ANSI: 2
sd 0:0:0:0: [sda] 4014080 512-byte logical blocks: (2.05 GB/1.91 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Attached SCSI removable disk
EXT3-fs (sda2): recovery required on readonly filesystem
EXT3-fs (sda2): write access will be enabled during recovery
EXT3-fs (sda2): recovery complete
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
Freeing unused kernel memory: 96k freed
Fixing up unaligned userspace access in "init" pid=1 pc=0x2955f50e ins=0x5174
Fixing up unaligned userspace access in "init" pid=1 pc=0x2955f50e ins=0x5174
Sending SIGBUS to "init" due to unaligned access (PC 2955f50e PR 29556f30)
Kernel panic - not syncing: Attempted to kill init!
Stack: (0x8f01de3c to 0x8f01e000)
de20:                                                                8822f428 
de40: 8811a94c 88295f58 8f01de68 8801926e 8f1a2560 8f01fd60 8f01def0 8f01acc0 
de60: 8f01acc0 883002f0 8f01acb8 00000000 8f01de4c 00000007 00000001 00000000 
de80: 8f01de80 8f01de80 88019858 000000fc 8f1a2560 8f01fd60 8f01def0 00000006 
dea0: 00000007 8f01fd60 88022ba6 00000006 8f1a25dc 8f01dfa4 8f01df70 880050de 
dec0: 7baefe94 8f01dfa4 a214a41a 29556000 8800704c 880070ec a214a41a 00000002 
dee0: 8f01aef0 00000000 88006bf2 29587d6a 00000007 00000000 00030002 29587d6a 
df00: 00000000 00000000 00000071 00000100 29587d6a 00000000 00000000 00000071 
df20: 00000100 88003c06 00000000 00000000 00000000 00000000 00000000 00000000 
df40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
df60: 00000000 7baefee0 29556900 00000000 00008000 00000000 000008b7 7ebdf5b0 
df80: 0000004c 8800713c 7baefe94 2958328c a214a41a 29556000 8800704c 880070ec 
dfa0: 8f01c000 2955f598 00000000 29556848 000085d0 295832c8 2956b9a0 7baefebc 
dfc0: 29587d5a 295832c8 2958344c 29583050 29556000 a214a41a 2958328c 7baefe94 
dfe0: 7baefe88 2955f50e 29556f30 00008000 00000000 000000d8 0000006c ffffffff 

Call trace:
 [<8811a94c>] bust_spinlocks+0x0/0x44
 [<8801926e>] do_exit+0x3e/0x5b4
 [<88019858>] do_group_exit+0x74/0xb4
 [<88022ba6>] get_signal_to_deliver+0x35a/0x3d8
 [<880050de>] do_notify_resume+0x8a/0x6cc
 [<8800704c>] address_error_load+0x0/0x4
 [<880070ec>] ret_from_exception+0x0/0x8
 [<88006bf2>] do_address_error+0xea/0x1b8
 [<88003c06>] sys_execve+0x0/0x5e
 [<8800713c>] resume_userspace+0x0/0x10
 [<8800704c>] address_error_load+0x0/0x4
 [<880070ec>] ret_from_exception+0x0/0x8


--Boundary_(ID_Gyoc7NUELYLR7kiWRm1K7Q)--
