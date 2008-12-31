From: Steve.Glendinning@smsc.com
Date: Wed, 31 Dec 2008 14:13:23 +0000
Subject: SH7709 BUG on boot (partially bisected)
Message-Id: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

Using the current torvalds tree on SH7709, physmap is having a problem 
seeing my memory-mapped flash.  I've bisected this to somewhere between:

GOOD: [e9bf51e5ccc7703226c79888603e157066213700] sh: __udivdi3 -> do_div() 
in softfloat lib.
BAD: [3b041227f7ef7c7e97f205c68c6069c0c62e5204] sh: Add plain udivsi3 (not 
_i4*) for gcc-4.1 and lower.

All commits between these two fail to boot here (no console output at 
all), so I wasn't able to bisect further.

I have physmap configured for 0x01000000  of flash at 0x00000000, it's 
worked for me so far but am I referencing the wrong area?

GOOD boot log:
--
sh-sci: ttySC0 at MMIO 0xfffffe80 (irq = 25) is a sci  
sh-sci: ttySC1 at MMIO 0xa4000150 (irq = 59) is a scif  
console [ttySC1] enabled  
sh-sci: ttySC2 at MMIO 0xa4000140 (irq = 55) is a irda  
physmap platform flash device: 01000000 at 00000000  
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank  
 Intel/Sharp Extended Query Table at 0x0031  
Using buffer write method  
cfi_cmdset_0001: Erase suspend on write enabled  
3 cmdlinepart partitions found on MTD device physmap-flash.0  
Creating 3 MTD partitions on "physmap-flash.0":  
0x00000000-0x00100000 : "bootloader"  
0x00100000-0x00600000 : "Kernel"  
0x00600000-0x01000000 : "Filesystem"  
--


and the BAD boot log:
--
sh-sci: ttySC0 at MMIO 0xfffffe80 (irq = 25) is a sci  
sh-sci: ttySC1 at MMIO 0xa4000150 (irq = 59) is a scif  
console [ttySC1] enabled  
sh-sci: ttySC2 at MMIO 0xa4000140 (irq = 55) is a irda  
physmap platform flash device: 01000000 at 00000000  
------------[ cut here ]------------  
kernel BUG at include/linux/mtd/cfi.h:351!  
Kernel BUG: 003e [#1]  
Modules linked in:  
  
Pid : 1, Comm:          swapper  
CPU : 0                 Not tainted  (2.6.28-rc9 #25)  
  
PC is at cfi_qry_mode_on+0x88/0x610  
PR is at cfi_qry_mode_on+0x3a/0x610  
PC  : 8c10e388 SP  : 8f81bbfc SR  : 40000000 TEA : 00000000  
R0  : 00000000 R1  : 00000002 R2  : 00000001 R3  : 000000f0  
R4  : 00000000 R5  : 00000002 R6  : 00000001 R7  : 00000000  
R8  : 8f8f5c90 R9  : 00000002 R10 : 8f81bc7c R11 : 00000000  
R12 : 8c0d3c14 R13 : 00000000 R14 : 8f81bbfc  
MACH: 00000000 MACL: 00000000 GBR : 00000000 PR  : 8c10e33a  
  
Call trace:  
[<8c003e80>] do_IRQ+0x0/0x80  
[<8c10d7c8>] cfi_probe_chip+0x58/0x890  
[<8c01afd6>] vprintk+0x336/0x3b0  
[<8c01afbe>] vprintk+0x31e/0x3b0  
[<8c114674>] mtd_do_chip_probe+0x74/0x320  
[<8c10d590>] get_mtd_chip_driver+0x0/0x120  
[<8c17d6ca>] _spin_unlock+0x1a/0x50  
[<8c10e00c>] cfi_probe+0xc/0x20  
[<8c10d590>] get_mtd_chip_driver+0x0/0x120  
[<8c10d6ea>] do_map_probe+0x3a/0x70  
[<8c114aec>] physmap_flash_probe+0x11c/0x2d0  
[<8c10d6b0>] do_map_probe+0x0/0x70  
[<8c104262>] platform_drv_probe+0x12/0x20  
[<8c102c42>] driver_probe_device+0xb2/0x190  
[<8c102d2a>] __device_attach+0xa/0x20  
[<8c102d20>] __device_attach+0x0/0x20  
[<8c1796e0>] klist_next+0x0/0xe0  
[<8c101e54>] bus_for_each_drv+0x44/0x80  
[<8c102d8a>] device_attach+0x4a/0x80  
[<8c10210a>] bus_attach_device+0x2a/0x60  
[<8c100704>] device_add+0x414/0x590  
[<8c0ffcc0>] device_add_groups+0x0/0x90  
[<8c17d714>] _write_unlock+0x14/0x50  
[<8c103f4e>] platform_device_add+0xbe/0x170  
[<8c01fc70>] insert_resource+0x0/0x50  
[<8c104016>] platform_device_register+0x16/0x30  
[<8c224620>] physmap_init+0x0/0x40  
[<8c22463c>] physmap_init+0x1c/0x40  
[<8c0020a6>] do_one_initcall+0x56/0x180  
[<8c03a61c>] lock_acquire+0x4c/0x90  
[<8c03a61c>] lock_acquire+0x4c/0x90  
[<8c0d47a8>] get_from_free_list+0x18/0x50  
[<8c17d186>] _spin_lock_irqsave+0x46/0x70  
[<8c17d658>] _spin_unlock_irqrestore+0x18/0x70  
[<8c06b618>] kmem_cache_free+0x28/0xb0  
[<8c03a61c>] lock_acquire+0x4c/0x90  
[<8c0d5260>] ida_pre_get+0x0/0x60  
[<8c0a8082>] proc_register+0x102/0x1b0  
[<8c17d126>] _spin_lock+0x36/0x50  
[<8c17d6c4>] _spin_unlock+0x14/0x50  
[<8c0d5260>] ida_pre_get+0x0/0x60  
[<8c17d6ca>] _spin_unlock+0x1a/0x50  
[<8c17d6d0>] _spin_unlock+0x20/0x50  
[<8c0a80ba>] proc_register+0x13a/0x1b0  
[<8c0a832e>] create_proc_entry+0x5e/0xa0  
[<8c04ab14>] register_irq_proc+0x54/0xa0  
[<8c04abd2>] init_irq_proc+0x32/0x70  
[<8c21aa20>] kernel_init+0x70/0x100  
[<8c002050>] do_one_initcall+0x0/0x180  
[<8c003f24>] kernel_thread_helper+0x4/0x10  
[<8c21a9b0>] kernel_init+0x0/0x100  
[<8c003f20>] kernel_thread_helper+0x0/0x10  
  
INFO: lockdep is turned off.  
Code:  
  8c10e382:  cmp/eq    #4, r0  
  8c10e384:  bt.s      8c10e38c  
  8c10e386:  mov       r6, r1  
->8c10e388:  trapa     #62  
  8c10e38a:  mov       r6, r1  
  8c10e38c:  mov       #4, r2  
  8c10e38e:  shld      r2, r1  
  8c10e390:  mov.w     8c10e494 <cfi_qry_mode_on+0x194/0x610>, r0  ! 
000000f0 <>
  8c10e392:  shld      r1, r3  
  
Process: swapper (pid: 1, stack limit = 8f81a001) 
--

Thanks for all your help,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com


