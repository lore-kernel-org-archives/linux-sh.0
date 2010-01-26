From: Yusuke Goda <goda.yusuke@renesas.com>
Date: Tue, 26 Jan 2010 09:42:23 +0000
Subject: Re: USB boot problems submission
Message-Id: <4B5EB8FF.20807@renesas.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030102080602040706080607"
List-Id: <linux-sh.vger.kernel.org>
References: <4B5D3019.9080900@renesas.com>
In-Reply-To: <4B5D3019.9080900@renesas.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------030102080602040706080607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Paul Mundt wrote:
> On Tue, Jan 26, 2010 at 06:24:21PM +0900, Yusuke Goda wrote:
>> Paul Mundt wrote:
>>> On Tue, Jan 26, 2010 at 05:33:18PM +0900, Yusuke Goda wrote:
>>>> Hi Paul-san
>>>>
>>>>> You should rebuild your kernel with verbose BUG reporting and all of the
>>>>> kallsyms bits turned on, which will give you a meaningful oops. That
>>>> I attach log(CONFIG_KALLSYMS=y).
>>>>
>>>>> should at least give us an idea of where things are going wrong,
>>>>> otherwise we go back to bisecting.
>>>> This problem seems to occur with the following commit.
>>>>  commit 2277ab4a1df50e05bc732fe9488d4e902bb8399a
>>>>   sh: Migrate from PG_mapped to PG_dcache_dirty.
>>>>
>>>> Sorry, I cannot identify it to number of lines.
>>> Thanks. Can you try this again with the dwarf unwinder enabled?
>> OK. I attach it.
>>
> .. while keeping verbose bug reporting and kallsyms enabled :-)
Oh sorry. I attach it.

Goda

--------------030102080602040706080607
Content-Type: text/plain;
 name="ecovec-usbboot-dwarf_unwinder2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ecovec-usbboot-dwarf_unwinder2.log"

## Starting application at 0x89000000 ...
Linux version 2.6.33-rc4 (root@gohda) (gcc version 4.3.4 (Debian 4.3.4-1) ) #39 PREEMPT Tue Jan 26 09:39:26 UTC 2010
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000000
... LOADER_TYPE       - 00000000
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
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
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
PVR=10300b00 CVR=7144040d PRR=00002200
I-cache : n_ways=4 n_sets=256 way_incr=8192
I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
D-cache : n_ways=4 n_sets=256 way_incr=8192
D-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
S-cache : n_ways=4 n_sets=2048 way_incr=65536
S-cache : entry_mask=0x0000ffe0 alias_mask=0x0000f000 n_aliases=16
Memory: 117560k/122880k available (2346k kernel code, 951k data, 104k init)
virtual kernel memory layout:
    fixmap  : 0xdffd6000 - 0xdffff000   ( 164 kB)
    vmalloc : 0xc0000000 - 0xdffd4000   ( 511 MB)
    lowmem  : 0x88000000 - 0x8f800000   ( 120 MB) (cached)
            : 0xa8000000 - 0xc8000000   ( 512 MB) (uncached)
      .init : 0x883c4000 - 0x883de000   ( 104 kB)
      .data : 0x8824b9dc - 0x883396e0   ( 951 kB)
      .text : 0x88001000 - 0x8824b9dc   (2346 kB)
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
DWARF unwinder initialised: read 2 CIEs, 12566 FDEs
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
msgmni has been set to 229
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
EXT3-fs (sda2): warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda2): using internal journal
EXT3-fs (sda2): recovery complete
EXT3-fs (sda2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 8:2.
Freeing unused kernel memory: 104k freed
Kernel panic - not syncing: Attempted to kill init!
Stack: (0x8f01de1c to 0x8f01e000)
de00:                                                                88247d06 
de20: 8f01de2c 8812837c 882ae1e4 88247d64 8f01de34 8f01de58 8801ba98 8f01de64 
de40: 8d66a580 8f01fd60 8f01def0 8f01acc0 8f01acc0 88318314 8f01acb8 00000000 
de60: 8f01de3c 8f01de64 00000001 0000000b 8f01dfa4 8f01de74 8f01de74 8801c08c 
de80: 8f01de9c 8d66a580 8f01fd60 8f01def0 0000000a 0000000b 8f01fd60 88025c38 
dea0: 8f01deac 0000000a 8d66a64c 8f01dfa4 8f01df70 8800549c 8f01ded4 8f01dfa4 
dec0: 29583004 00000001 880080f0 880080f0 29583004 0000000a 00000002 8f01aef0 
dee0: 8f01defc 8d674d40 8d674d74 8f01dfa4 0000000b 00000000 00030001 00000004 
df00: 8d675f3c 29746000 29746000 8805f1d4 00000004 8d675f3c 29746000 29746000 
df20: 8805f1d4 8f01df28 00002410 00000508 00000000 00000000 00000000 00000000 
df40: 29746000 8d674d40 08100073 00000002 8f01df54 8802ef7a 8f01df74 8f01df80 
df60: 8f01df44 29746000 8f01df6c 880115f0 8f01df8c 000001bc 29583004 00000000 
df80: 29566de0 88008140 8f01dfa4 000001bc 29583004 00000001 880080f0 880080f0 
dfa0: 8f01c000 00000040 00000000 00000020 29582e14 29574c18 29574dd0 00000000 
dfc0: 29574c18 29574c58 295832c8 00000001 00000001 29583004 000001bc 7babec7c 
dfe0: 7babec7c 295610de 29559810 00008100 2974a450 01f014c6 a13383fe ffffffff 

Call trace:
 [<8800eff6>] dwarf_unwinder_dump+0x22/0x68
 [<88007292>] unwind_stack+0x9a/0xf0
 [<8800329e>] show_trace+0x3e/0x78
 [<880066da>] show_stack+0x3a/0x58
 [<88247d06>] dump_stack+0xe/0x1c
 [<88247d64>] panic+0x50/0x114
 [<8801ba98>] do_exit+0x40/0x5bc
 [<8801c08c>] do_group_exit+0x78/0xb8
 [<88025c38>] get_signal_to_deliver+0x360/0x3e4
 [<8800549c>] do_notify_resume+0x8c/0x6ec
 [<88008140>] resume_userspace+0x0/0x10
 [<295610de>] 0x295610de



--------------030102080602040706080607--

