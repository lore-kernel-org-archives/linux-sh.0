From: Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>
Date: Tue, 23 Feb 2010 02:50:42 +0000
Subject: Problem when testing current git on sh3 + hp6xx
Message-Id: <20100223025042.GA28763@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, 
  I am testing current sh-2.6.git on SH7709 based hp6xx,
using earlyprintk as Paul suggested me.

When booting, kernel shows an
Unable to handle kernel NULL pointer dereference at virtual address 00000000
and then 
Kernel panic - not syncing: Fatal exception in interrupt

I built using arch/sh/configs/hp6xx_defconfig, and enabling
Verbose BUG() reporting and KALLSYMS_ALL as well.

This is the log :

Linux version 2.6.33-rc8-00195-g16afc9f (rafa@nodo3) (gcc version 4.4.1 (Sourcery G++ Lite 4.4-450
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000100
... LOADER_TYPE       - 00000001
... INITRD_START      - ffffffff
... INITRD_SIZE       - ffffffff
bootconsole [early_ttySC1] enabled
Booting machvec: hp6xx
Node 0: start_pfn = 0xd000, low = 0xe000
Zone PFN ranges:
  Normal   0x0000d000 -> 0x0000e000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000d000 -> 0x0000e000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: memM console=ttySC1,115200 earlyprintk=sh-sci.1,115200
PID hash table entries: 64 (order: -4, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
I-cache : n_ways=4 n_sets%6 way_incr@96
I-cache : entry_mask=0x00000ff0 alias_mask=0x00000000 n_aliases=0
D-cache : n_ways=4 n_sets%6 way_incr@96
D-cache : entry_mask=0x00000ff0 alias_mask=0x00000000 n_aliases=0
Memory: 14144k/16384k available (1440k kernel code, 482k data, 84k init)
virtual kernel memory layout:
    fixmap  : 0xdfff7000 - 0xdffff000   (  32 kB)
    vmalloc : 0xc0000000 - 0xdfff5000   ( 511 MB)
    lowmem  : 0x8d000000 - 0x8e000000   (  16 MB) (cached)
            : 0x8e000000 - 0xae000000   ( 512 MB) (uncached)
      .init : 0x8d1e2000 - 0x8d1f7000   (  84 kB)
      .data : 0x8d16920c - 0x8d1e1d20   ( 482 kB)
      .text : 0x8d001000 - 0x8d16920c   (1440 kB)
Hierarchical RCU implementation.
NR_IRQS:256 nr_irqs:86
Console: colour dummy device 80x25
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc = 00000000
*pde = 00000000
Oops: 0000 [#1]
last sysfs file: 

Pid : 0, Comm:          swapper
CPU : 0                 Not tainted  (2.6.33-rc8-00195-g16afc9f #3)

PC is at 0x0
PR is at sh_tmu_interrupt+0x20/0x50
PC  : 00000000 SP  : 8d1c7ebc SR  : 400001f0 TEA : 00000000
R0  : 00000000 R1  : 00000000 R2  : 00000020 R3  : 00000100
R4  : 8dc06e9c R5  : 8dc06e60 R6  : 00000000 R7  : 00000010
R8  : 8dc06e68 R9  : 00000000 R10 : 00000000 R11 : 00000010
R12 : 8d003c80 R13 : 000000f0 R14 : 8d003cb0
MACH: 09127064 MACL: 00000ea0 GBR : 8c009800 PR  : 8d162ab0

Call trace:
 [<8d03cbb2>] handle_IRQ_event+0x42/0x150
 [<8d03ea14>] handle_level_irq+0x44/0xd0
 [<8d003cb0>] __raw_local_save_flags+0x0/0x10
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d0039f0>] do_IRQ+0x30/0x60
 [<8d0080ec>] ret_from_exception+0x0/0xc
 [<8d0039c0>] do_IRQ+0x0/0x60
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d003cb0>] __raw_local_save_flags+0x0/0x10
 [<8d003c92>] raw_local_irq_restore+0x12/0x30
 [<8d03d45a>] __setup_irq+0xea/0x350
 [<8d1656ba>] sh_tmu_probe+0x24a/0x330
 [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
 [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
 [<8d1e27a2>] start_kernel+0x28a/0x468
 [<8d0e6540>] strlen+0x0/0x58
 [<8d165960>] printk+0x0/0x30
 [<8d002024>] _stext+0x24/0x30

Code:
  fffffffa:  add       #-84, r3
  fffffffc:  .word 0x0000
  fffffffe:  .word 0x0000
 (Bad address in pc)

Process: swapper (pid: 0, stack limit = 8d1c6001)
Stack: (0x8d1c7ebc to 0x8d1c8000)
7ea0:                                                                8d03cbb2 
7ec0: 8d1b7988 00000010 8d03ea14 ffffffda 8d003cb0 00000000 8d003c80 00000010 
7ee0: 00000010 8dc070c0 8d0039f0 00000000 8d1dbfa4 00000010 8d0080ec 00000010 
7f00: 8d0039c0 400081f1 00000000 00000000 40000100 00000000 00000000 00006c8c 
7f20: 00000002 00000040 8dc070c0 8dc06e68 00000010 8d003c80 00000000 8d003cb0 
7f40: ffffffda 8d1c7f64 8d003c92 8d03d45a 40000100 8c009800 09127064 00000ea0 
7f60: ffffffff 8d1656ba 00000000 8d1cc5a8 8d1ee11c 8d1a5568 000000c8 8dc06e9c 
7f80: 8dc06e60 8d1ee11c 8d1a528c 00000088 ffffff78 8d1f2af8 8d1cc234 8d1f4b1c 
7fa0: 8d1f2b00 00000000 00000001 00000002 00000000 00000002 00000000 8d1e27a2 
7fc0: 8d0e6540 8d1f7068 8d1f705c 8d1f1bee 8d1f1954 8d165960 000000f0 8d1f1bb4 
7fe0: 8d002024 00000000 6cef10a6 00000000 56125511 64123128 6103d30e 2019e1e0 
---[ end trace 4eaa2a86a8e2da22 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Stack: (0x8d1c7d58 to 0x8d1c8000)
7d40:                                                       8d165874 8d1a53b4 
7d60: 8d0efc80 8d1a62fc 8d1c7d88 8d0066f8 8d1a62fc 8d165960 00000000 8d0efc80 
7d80: 8d003c80 8d1c7e60 00001bb9 ffffffff 8d206560 8d00e21a 8d1ff348 8d165960 
7da0: 8d1c7ea0 00000000 8d1c7e60 00000000 00000000 00000000 00000000 00000000 
7dc0: 00000000 00000000 00000000 00000000 8d1c7e20 00000000 00000000 00000000 
7de0: 8d1c7e30 8d1c7e34 8d1c7e38 00000037 00000025 00000023 00000000 8d0ed7cc 
7e00: ffffffff 00000000 00000001 8d04d55c 8d003c80 00000000 8d04b970 8d1c7e6c 
7e20: 8d1e16e4 00000001 00000019 00000000 8d0ed7cc ffffffff 8d1fcd30 00000002 
7e40: 8d0080ec 8d003cb0 000000f0 8d003c80 00000010 8d0080ec 8d0080ec 00000000 
7e60: 00000000 00000000 00000020 00000100 8dc06e9c 8dc06e60 00000000 00000010 
7e80: 8dc06e68 00000000 00000000 00000010 8d003c80 000000f0 8d003cb0 8d1c7ebc 
7ea0: 00000000 8d162ab0 400001f0 8c009800 09127064 00000ea0 ffffffff 8d03cbb2 
7ec0: 8d1b7988 00000010 8d03ea14 ffffffda 8d003cb0 00000000 8d003c80 00000010 
7ee0: 00000010 8dc070c0 8d0039f0 00000000 8d1dbfa4 00000010 8d0080ec 00000010 
7f00: 8d0039c0 400081f1 00000000 00000000 40000100 00000000 00000000 00006c8c 
7f20: 00000002 00000040 8dc070c0 8dc06e68 00000010 8d003c80 00000000 8d003cb0 
7f40: ffffffda 8d1c7f64 8d003c92 8d03d45a 40000100 8c009800 09127064 00000ea0 
7f60: ffffffff 8d1656ba 00000000 8d1cc5a8 8d1ee11c 8d1a5568 000000c8 8dc06e9c 
7f80: 8dc06e60 8d1ee11c 8d1a528c 00000088 ffffff78 8d1f2af8 8d1cc234 8d1f4b1c 
7fa0: 8d1f2b00 00000000 00000001 00000002 00000000 00000002 00000000 8d1e27a2 
7fc0: 8d0e6540 8d1f7068 8d1f705c 8d1f1bee 8d1f1954 8d165960 000000f0 8d1f1bb4 
7fe0: 8d002024 00000000 6cef10a6 00000000 56125511 64123128 6103d30e 2019e1e0 

Call trace:
 [<8d0efc80>] bust_spinlocks+0x0/0x50
 [<8d0efc80>] bust_spinlocks+0x0/0x50
 [<8d0066f8>] die+0xf8/0x170
 [<8d165960>] printk+0x0/0x30
 [<8d0efc80>] bust_spinlocks+0x0/0x50
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d00e21a>] do_page_fault+0x27a/0x3c0
 [<8d165960>] printk+0x0/0x30
 [<8d0ed7cc>] number+0x2cc/0x2f0
 [<8d04d55c>] get_page_from_freelist+0x1ac/0x460
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d04b970>] __rmqueue+0x0/0x2f0
 [<8d0ed7cc>] number+0x2cc/0x2f0
 [<8d0080ec>] ret_from_exception+0x0/0xc
 [<8d003cb0>] __raw_local_save_flags+0x0/0x10
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d0080ec>] ret_from_exception+0x0/0xc
 [<8d0080ec>] ret_from_exception+0x0/0xc
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d003cb0>] __raw_local_save_flags+0x0/0x10
 [<8d162ab0>] sh_tmu_interrupt+0x20/0x50
 [<8d03cbb2>] handle_IRQ_event+0x42/0x150
 [<8d03ea14>] handle_level_irq+0x44/0xd0
 [<8d003cb0>] __raw_local_save_flags+0x0/0x10
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d0039f0>] do_IRQ+0x30/0x60
 [<8d0080ec>] ret_from_exception+0x0/0xc
 [<8d0039c0>] do_IRQ+0x0/0x60
 [<8d003c80>] raw_local_irq_restore+0x0/0x30
 [<8d003cb0>] __raw_local_save_flags+0x0/0x10
 [<8d003c92>] raw_local_irq_restore+0x12/0x30
 [<8d03d45a>] __setup_irq+0xea/0x350
 [<8d1656ba>] sh_tmu_probe+0x24a/0x330
 [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
 [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
 [<8d1e27a2>] start_kernel+0x28a/0x468
 [<8d0e6540>] strlen+0x0/0x58
 [<8d165960>] printk+0x0/0x30
 [<8d002024>] _stext+0x24/0x30


Is there some .config option that I can use to go further?

By the way, I have built the kernel using a new toolchain for me,
(from Sourcery G++). Could it be the problem? 

My old gcc-3.4.4-glibc-2.3.5 toolchain was always good for
kernel building, but I get compilation errors with current sh-2.6.git tree
(the compilation of linus git with the 3.4.4 gcc toolchain goes
well though).

Thanks in advance.

Rafael Ignacio Zurita
