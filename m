From: Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>
Date: Tue, 23 Feb 2010 22:38:03 +0000
Subject: Re: Problem when testing current git on sh3 + hp6xx
Message-Id: <20100223223803.GA2815@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20100223025042.GA28763@rafazurita.homelinux.net>
In-Reply-To: <20100223025042.GA28763@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Tue, Feb 23, 2010 at 12:51:09PM +0900, Paul Mundt wrote:
> On Mon, Feb 22, 2010 at 11:50:42PM -0300, Rafael Ignacio Zurita wrote:
> > Hello, 
> >   I am testing current sh-2.6.git on SH7709 based hp6xx,
> > using earlyprintk as Paul suggested me.
> > 
> > When booting, kernel shows an
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > and then 
> > Kernel panic - not syncing: Fatal exception in interrupt
> > 
> > I built using arch/sh/configs/hp6xx_defconfig, and enabling
> > Verbose BUG() reporting and KALLSYMS_ALL as well.
> > 
> Can you boot this with ignore_loglevel on the command line also please,
> it would be helpful to see what the sparse IRQ mapping looks like.

Sure, below the log :

Linux version 2.6.33-rc8-00195-g16afc9f (rafa@nodo3) (gcc version 4.4.1 (Sourcery G++ Lite 4.4-45) ) #5 Tue Feb 23 19:21:44 ART 200
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000100
... LOADER_TYPE       - 00000001
... INITRD_START      - ffffffff
... INITRD_SIZE       - ffffffff
debug: ignoring loglevel setting.
bootconsole [early_ttySC1] enabled
Booting machvec: hp6xx
Node 0: start_pfn = 0xd000, low = 0xe000
Zone PFN ranges:
  Normal   0x0000d000 -> 0x0000e000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000d000 -> 0x0000e000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat 8d1e16c4, node_mem_map 8d20b000
  Normal zone: 32 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 4064 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: memM console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel
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
  alloc irq_desc for 16 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 17 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 18 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 19 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 20 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 21 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 22 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 23 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 24 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 25 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 26 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 27 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 28 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 29 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 48 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 49 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 50 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 51 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 60 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 56 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 57 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 58 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 59 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 40 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 41 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 52 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 53 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 54 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 55 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 36 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 37 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 32 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 33 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 34 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 35 on node 0
  alloc kstat_irqs on node 0
Console: colour dummy device 80x25
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc = 00000000
*pde = 00000000
Oops: 0000 [#1]
last sysfs file: 

Pid : 0, Comm:          swapper
CPU : 0                 Not tainted  (2.6.33-rc8-00195-g16afc9f #5)

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
7fc0: 8d0e6540 8d1f7068 8d1f705c 8d1f1bfe 8d1f1954 8d165960 000000f0 8d1f1bb4 
7fe0: 8d002024 00000000 4cf3d1d6 00000000 56125511 64123128 6103d30e 2019e1e0 
---[ end trace 4eaa2a86a8e2da22 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Stack: (0x8d1c7d58 to 0x8d1c8000)
7d40:                                                       8d165874 8d1a53b4 
7d60: 8d0efc80 8d1a62fc 8d1c7d88 8d0066f8 8d1a62fc 8d165960 00000000 8d0efc80 
7d80: 8d003c80 8d1c7e60 00001bee ffffffff 8d206560 8d00e21a 8d1ff348 8d165960 
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
7fc0: 8d0e6540 8d1f7068 8d1f705c 8d1f1bfe 8d1f1954 8d165960 000000f0 8d1f1bb4 
7fe0: 8d002024 00000000 4cf3d1d6 00000000 56125511 64123128 6103d30e 2019e1e0 

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


> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [snip]
> > PR is at sh_tmu_interrupt+0x20/0x50
> > PC  : 00000000 SP  : 8d1c7ebc SR  : 400001f0 TEA : 00000000
> > R0  : 00000000 R1  : 00000000 R2  : 00000020 R3  : 00000100
> > R4  : 8dc06e9c R5  : 8dc06e60 R6  : 00000000 R7  : 00000010
> > R8  : 8dc06e68 R9  : 00000000 R10 : 00000000 R11 : 00000010
> > R12 : 8d003c80 R13 : 000000f0 R14 : 8d003cb0
> > MACH: 09127064 MACL: 00000ea0 GBR : 8c009800 PR  : 8d162ab0
> > 
> > Call trace:
> >  [<8d03cbb2>] handle_IRQ_event+0x42/0x150
> >  [<8d03ea14>] handle_level_irq+0x44/0xd0
> >  [<8d003cb0>] __raw_local_save_flags+0x0/0x10
> >  [<8d003c80>] raw_local_irq_restore+0x0/0x30
> >  [<8d0039f0>] do_IRQ+0x30/0x60
> >  [<8d0080ec>] ret_from_exception+0x0/0xc
> >  [<8d0039c0>] do_IRQ+0x0/0x60
> >  [<8d003c80>] raw_local_irq_restore+0x0/0x30
> >  [<8d003cb0>] __raw_local_save_flags+0x0/0x10
> >  [<8d003c92>] raw_local_irq_restore+0x12/0x30
> >  [<8d03d45a>] __setup_irq+0xea/0x350
> >  [<8d1656ba>] sh_tmu_probe+0x24a/0x330
> >  [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
> >  [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
> > 
> Based on this it would seem that you are entering the kernel with pending
> timer IRQs and are racing against the clockevent setup, as no one has set
> up the event handler yet. Try this:
> 
> ---
> 
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 93c2322..961f5b5 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -323,15 +323,15 @@ static void sh_tmu_register_clockevent(struct sh_tmu_priv *p,
>  	ced->set_next_event = sh_tmu_clock_event_next;
>  	ced->set_mode = sh_tmu_clock_event_mode;
>  
> +	pr_info("sh_tmu: %s used for clock events\n", ced->name);
> +	clockevents_register_device(ced);
> +
>  	ret = setup_irq(p->irqaction.irq, &p->irqaction);
>  	if (ret) {
>  		pr_err("sh_tmu: failed to request irq %d\n",
>  		       p->irqaction.irq);
>  		return;
>  	}
> -
> -	pr_info("sh_tmu: %s used for clock events\n", ced->name);
> -	clockevents_register_device(ced);
>  }
>  
>  static int sh_tmu_register(struct sh_tmu_priv *p, char *name,

After to apply your patch it looks a lot better. The log :

Linux version 2.6.33-rc8-00195-g16afc9f-dirty (rafa@nodo3) (gcc version 4.4.1 (Sourcery G++ Lite 4.4-45) ) #4 Tue Feb 23 19:02:17 A0
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
Kernel command line: memM console=ttySC1,115200 earlyprintk=sh-sci.1,115200 root=/dev/sda2
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
      .data : 0x8d16921c - 0x8d1e1d20   ( 482 kB)
      .text : 0x8d001000 - 0x8d16921c   (1440 kB)
Hierarchical RCU implementation.
NR_IRQS:256 nr_irqs:86
Console: colour dummy device 80x25
sh_tmu: TMU0 used for clock events
sh_tmu: TMU0 used for periodic clock events
sh_tmu: TMU1 used as clock source
Calibrating delay loop (skipped)... 22.11 BogoMIPS PRESET (lpjD220)
Mount-cache hash table entries: 512
CPU: SH7729
bio: create slab <bio-0> at 0
SCSI subsystem initialized
DMA: Registering sh_dmac handler (6 channels).
DMA: Registering DMA API.
Switching to clocksource TMU1
HD64461 configured at 0xb0000000 on irq 36(mapped into 64 to 79)
HD64461: enabling PCMCIA devices
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 80x30
fb0: Hitachi HD64461 frame buffer device
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xfffffe80 (irq = 23) is a sci
sh-sci.1: ttySC1 at MMIO 0xa4000150 (irq = 56) is a scif
console [ttySC1] enabled, bootconsole disabled
console [ttySC1] enabled, bootconsole disabled
sh-sci.2: ttySC2 at MMIO 0xa4000140 (irq = 52) is a irda
scsi0 : pata_platform
ata1: PATA max PIO0 mmio cmd 0x150001f0 ctl 0x150001fe irq 77
input: HP Jornada 680 keyboard as /class/input/input0
input: HP Jornada touchscreen as /class/input/input1
sh-rtc sh-rtc: rtc core: registered sh as rtc0
sh_tmu: TMU0 kept as earlytimer
sh_tmu: TMU1 kept as earlytimer
sh-rtc sh-rtc: setting system clock to 1999-01-01 00:04:02 UTC (915149042)
ata1.00: CFA: TOSHIBA THNCF1G02QG, 3.00, max PIO4
ata1.00: 2000880 sectors, multi 1: LBA 
ata1.00: configured for PIO
ata1.00: configured for PIO
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNCF1G0 3.00 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2000880 512-byte logical blocks: (1.02 GB/976 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI removable disk
VFS: Mounted root (ext2 filesystem) on device 8:2.
Freeing unused kernel memory: 84k freed
INIT: version 2.86 booting


If your patch is applied then I need to check why X does not run, 
but that is another story.
If your patch is not going to mainline, then please, let me know
what should be done to continue fixing the original issue.

Thanks.

Rafael Ignacio Zurita
