From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Fri, 11 Sep 2009 04:18:41 +0000
Subject: Re: Problem with current kernel and old sh3 machines
Message-Id: <20090911041841.GA16844@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
In-Reply-To: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello,

On Thu, Jul 30, 2009 at 02:25:26PM +0900, Paul Mundt wrote:
> On Wed, Jul 29, 2009 at 10:11:45PM -0300, Rafael Ignacio Zurita wrote:
> > Node 0: start_pfn =3D 0xd000, low =3D 0xe000                           =
            =20
> > Zone PFN ranges:                                                       =
        =20
> >   Normal   0x0000d000 -> 0x0000e000                                    =
        =20
> > Movable zone start PFN for each node                                   =
        =20
> > early_node_map[1] active PFN ranges                                    =
        =20
> >     0: 0x0000d000 -> 0x0000e000                                        =
        =20
> > Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4=
064     =20
> > Kernel command line: mem=16M init=3D/bin/sh earlyprintk=3Dserial       =
            =20
> > NR_IRQS:256                                                            =
        =20
> > PID hash table entries: 64 (order: 6, 256 bytes)                       =
        =20
> > Console: colour dummy device 80x25                                     =
        =20
> > console handover: boot [sercon0] -> real [tty0]       =20
> >=20
> > and I guess that the system hangs.=20
> > Should I try other printks in other places? Suggestions?
> >=20
> earlyprintk=3Dserial,keep

Thanks, I get more output for debug.
Now I got the below kernel messages (sorry for the long output):

Linux version 2.6.31-rc4-hpc (rafa@nodo3) (gcc version 3.4.4) #15 PREEMPT F=
ri Se
p 11 00:42:31 ART 2009
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000100
... LOADER_TYPE       - 00000001
... INITRD_START      - 00400000
... INITRD_SIZE       - 00400000
console [sercon0] enabled
Booting machvec: hp6xx
Node 0: start_pfn =3D 0xd000, low =3D 0xe000
Zone PFN ranges:
  Normal   0x0000d000 -> 0x0000e000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000d000 -> 0x0000e000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: mem=16MB  earlyprintk=3Dserial,keep root=3D/dev/sda2 p=
splash=FA
lse
PID hash table entries: 64 (order: 6, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 7536k/16384k available (1145k kernel code, 356k data, 84k init)
NR_IRQS:256
BUG: scheduling while atomic: swapper/0/0x00000002
2 locks held by swapper/0:
 #0:  (clock_list_sem){......}, at: [<8d009928>] clk_register+0x58/0xf0
 #1:  (clock_list_sem){......}, at: [<8d009c6c>] clk_get_sys+0x1c/0xd0
Stack: (0x8d15fec0 to 0x8d160000)
fec0: 8d006d6e 8d15fed0 00000000 8d161000 8d00f6e6 8d15fed8 8d11b13e 8d15fe=
e8=20
fee0: 8d165f30 000000f0 00000001 00000000 8d16118c 8d11befc 8d15ff14 8d1610=
00=20
ff00: 000000f0 ffffffff ffffff0f 8d165a30 000000f0 8d165a50 8d165a50 8d1610=
00=20
ff20: 8d15ff14 8d165a50 8d009c6c 8d15ff48 8d0098d0 8d17ccb0 00000000 000000=
00=20
ff40: 8d149608 00000000 8d009d3e 8d15ff60 00000000 8d165744 00000000 8d1496=
08=20
ff60: 8d009012 8d15ff74 8d165744 00000000 8d165744 8d009994 8d15ff80 8d1657=
44=20
ff80: 8d17cf0e 8d15ff90 00000003 8d165744 8d17cf4a 8d15ffb0 8d18e05c 8d180b=
10=20
ffa0: 8d0daf80 8d18e068 8d188c04 8d194530 8d17d242 8d15ffb8 8d17ca98 8d15ff=
d0=20
ffc0: 8d0daf80 8d18e068 8d188c04 8d194530 8d17966c 8d15ffdc ffffffff 8d188f=
d4=20
ffe0: 8d002024 ac000750 acea98a6 00000000 56125511 64123128 6103d30e 2019e1=
e0=20

Call trace:
[<8d006d6e>] dump_stack+0xe/0x2a0
[<8d00f6e6>] __schedule_bug+0x56/0x80
[<8d11b13e>] schedule+0x3de/0x500
[<8d11befc>] mutex_lock_nested+0x13c/0x320
[<8d009c6c>] clk_get_sys+0x1c/0xd0
[<8d0098d0>] clk_register+0x0/0xf0
[<8d17ccb0>] arch_init_clk_ops+0x0/0x30
[<8d009d3e>] clk_get+0x1e/0x100
[<8d009012>] set_bus_parent+0x12/0x30
[<8d009994>] clk_register+0xc4/0xf0
[<8d17cf0e>] cpg_clk_init+0x3e/0x70
[<8d17cf4a>] arch_clk_init+0xa/0x20
[<8d180b10>] __alloc_bootmem+0x0/0x20
[<8d0daf80>] strlen+0x0/0x58
[<8d17d242>] clk_init+0x12/0xc0
[<8d17ca98>] time_init+0x18/0xc0
[<8d0daf80>] strlen+0x0/0x58
[<8d17966c>] start_kernel+0x15c/0x570
[<8d002024>] _stext+0x24/0x30

2 locks held by swapper/0:
 #0:  (clock_list_sem){......}, at: [<8d009928>] clk_register+0x58/0xf0
 #1:  (clock_list_sem){......}, at: [<8d009c6c>] clk_get_sys+0x1c/0xd0
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pc =3D 8d00c65c
*pde =3D 00000000
Oops: 0000 [#1]

Pid : 0, Comm:          swapper
CPU : 0                 Not tainted  (2.6.31-rc4-hpc #15)

PC is at set_next_entity+0xc/0x70
PR is at pick_next_task_fair+0x3e/0xb0
PC  : 8d00c65c SP  : 8d15fec4 SR  : 400000f1 TEA : 0000001c
R0  : 00000000 R1  : 8d00c650 R2  : ffffffff R3  : 8d165f70
R4  : 8d165f80 R5  : 00000000 R6  : fff00000 R7  : ffffffff
R8  : 00000000 R9  : 8d165f80 R10 : 8d165f30 R11 : ffffffff
R12 : 8d165f30 R13 : 8d161000 R14 : 8d15fed4
MACH: 00000000 MACL: 00000007 GBR : 8c009800 PR  : 8d00cd9e

Call trace:
[<8d00cd9e>] pick_next_task_fair+0x3e/0xb0
[<8d11aeb2>] schedule+0x152/0x500
[<8d11befc>] mutex_lock_nested+0x13c/0x320
[<8d009c6c>] clk_get_sys+0x1c/0xd0
[<8d0098d0>] clk_register+0x0/0xf0
[<8d17ccb0>] arch_init_clk_ops+0x0/0x30
[<8d009d3e>] clk_get+0x1e/0x100
[<8d009012>] set_bus_parent+0x12/0x30
[<8d009994>] clk_register+0xc4/0xf0
[<8d17cf0e>] cpg_clk_init+0x3e/0x70
[<8d17cf4a>] arch_clk_init+0xa/0x20
[<8d180b10>] __alloc_bootmem+0x0/0x20
[<8d0daf80>] strlen+0x0/0x58
[<8d17d242>] clk_init+0x12/0xc0
[<8d17ca98>] time_init+0x18/0xc0
[<8d0daf80>] strlen+0x0/0x58
[<8d17966c>] start_kernel+0x15c/0x570
[<8d002024>] _stext+0x24/0x30

INFO: lockdep is turned off.
Process: swapper (pid: 0, stack limit =3D 8d15e001)
Stack: (0x8d15fec4 to 0x8d160000)
fec0:          8d00cd9e 8d15fed4 8d165f80 00000000 8d11aeb2 8d15fee8 8d1610=
00=20
fee0: 8d165f30 8d16632c 00000001 00000000 8d161188 8d11befc 8d15ff14 8d1610=
00=20
ff00: 000000f0 ffffffff ffffff0f 8d165a30 000000f0 8d165a50 8d165a50 8d1610=
00=20
ff20: 8d15ff14 8d165a50 8d009c6c 8d15ff48 8d0098d0 8d17ccb0 00000000 000000=
00=20
ff40: 8d149608 00000000 8d009d3e 8d15ff60 00000000 8d165744 00000000 8d1496=
08=20
ff60: 8d009012 8d15ff74 8d165744 00000000 8d165744 8d009994 8d15ff80 8d1657=
44=20
ff80: 8d17cf0e 8d15ff90 00000003 8d165744 8d17cf4a 8d15ffb0 8d18e05c 8d180b=
10=20
ffa0: 8d0daf80 8d18e068 8d188c04 8d194530 8d17d242 8d15ffb8 8d17ca98 8d15ff=
d0=20
ffc0: 8d0daf80 8d18e068 8d188c04 8d194530 8d17966c 8d15ffdc ffffffff 8d188f=
d4=20
ffe0: 8d002024 ac000750 acea98a6 00000000 56125511 64123128 6103d30e 2019e1=
e0=20
---[ end trace 4eaa2a86a8e2da22 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Stack: (0x8d15fd28 to 0x8d160000)
fd20:                   8d006d6e 8d15fd38 8d18f260 8d0153c0 8d013fe8 8d15fd=
40=20
fd40: 8d017068 8d15fd6c 8d15fe68 8d0e3f40 00000000 0000000b 8d161000 ffffff=
ff=20
fd60: 00000001 8d014dfc 00000000 8d0e3f40 00000000 8d149970 8d15fe68 8d0061=
bc=20
fd80: 8d15fd9c 8d15fe68 8d0e3f40 00000000 8d149970 8d15fe68 8d0153c0 8d00af=
9c=20
fda0: 8d15fdb8 8d161000 8d15fea8 0000001c 8d0153c0 00000000 00000023 8d0149=
90=20
fdc0: 8d161000 8d193783 8d0150c8 8d15fdd0 8d161000 8d193765 8d0150c8 8d15fd=
e0=20
fde0: 8d014dfc 8d15fdf0 8d014eb6 8d15fdf0 8d015116 8d15fe10 00000004 8d0149=
90=20
fe00: 8d0153c0 8d193761 8d0150c8 8d15fe10 8d15fe14 8d014dfc 8d15fe24 8d014e=
b6=20
fe20: 00000004 000000f0 8d15fe44 00000004 8d0153d4 8d15fe50 00000000 000300=
01=20
fe40: 8d161000 00000002 8d0070e4 8d15fed4 8d161000 8d165f30 ffffffff 8d0070=
e4=20
fe60: 0000001c 00000000 00000000 8d00c650 ffffffff 8d165f70 8d165f80 000000=
00=20
fe80: fff00000 ffffffff 00000000 8d165f80 8d165f30 ffffffff 8d165f30 8d1610=
00=20
fea0: 8d15fed4 8d15fec4 8d00c65c 8d00cd9e 400000f1 8c009800 00000000 000000=
07=20
fec0: ffffffff 8d00cd9e 8d15fed4 8d165f80 00000000 8d11aeb2 8d15fee8 8d1610=
00=20
fee0: 8d165f30 8d16632c 00000001 00000000 8d161188 8d11befc 8d15ff14 8d1610=
00=20
ff00: 000000f0 ffffffff ffffff0f 8d165a30 000000f0 8d165a50 8d165a50 8d1610=
00=20
ff20: 8d15ff14 8d165a50 8d009c6c 8d15ff48 8d0098d0 8d17ccb0 00000000 000000=
00=20
ff40: 8d149608 00000000 8d009d3e 8d15ff60 00000000 8d165744 00000000 8d1496=
08=20
ff60: 8d009012 8d15ff74 8d165744 00000000 8d165744 8d009994 8d15ff80 8d1657=
44=20
ff80: 8d17cf0e 8d15ff90 00000003 8d165744 8d17cf4a 8d15ffb0 8d18e05c 8d180b=
10=20
ffa0: 8d0daf80 8d18e068 8d188c04 8d194530 8d17d242 8d15ffb8 8d17ca98 8d15ff=
d0=20
ffc0: 8d0daf80 8d18e068 8d188c04 8d194530 8d17966c 8d15ffdc ffffffff 8d188f=
d4=20
ffe0: 8d002024 ac000750 acea98a6 00000000 56125511 64123128 6103d30e 2019e1=
e0=20

Call trace:
[<8d006d6e>] dump_stack+0xe/0x2a0
[<8d0153c0>] printk+0x0/0x30
[<8d013fe8>] panic+0x48/0x140
[<8d017068>] do_exit+0x448/0x660
[<8d0e3f40>] bust_spinlocks+0x0/0x60
[<8d014dfc>] release_console_sem+0xdc/0x240
[<8d0e3f40>] bust_spinlocks+0x0/0x60
[<8d0061bc>] die+0xfc/0x160
[<8d0e3f40>] bust_spinlocks+0x0/0x60
[<8d0153c0>] printk+0x0/0x30
[<8d00af9c>] do_page_fault+0x22c/0x3d0
[<8d0153c0>] printk+0x0/0x30
[<8d014990>] emit_log_char+0x0/0x70
[<8d0150c8>] vprintk+0x118/0x410
[<8d0150c8>] vprintk+0x118/0x410
[<8d014dfc>] release_console_sem+0xdc/0x240
[<8d014eb6>] release_console_sem+0x196/0x240
[<8d015116>] vprintk+0x166/0x410
[<8d014990>] emit_log_char+0x0/0x70
[<8d0153c0>] printk+0x0/0x30
[<8d0150c8>] vprintk+0x118/0x410
[<8d014dfc>] release_console_sem+0xdc/0x240
[<8d014eb6>] release_console_sem+0x196/0x240
[<8d0153d4>] printk+0x14/0x30
[<8d0070e4>] ret_from_exception+0x0/0x8
[<8d0070e4>] ret_from_exception+0x0/0x8
[<8d00c650>] set_next_entity+0x0/0x70
[<8d00c65c>] set_next_entity+0xc/0x70
[<8d00cd9e>] pick_next_task_fair+0x3e/0xb0
[<8d00cd9e>] pick_next_task_fair+0x3e/0xb0
[<8d11aeb2>] schedule+0x152/0x500
[<8d11befc>] mutex_lock_nested+0x13c/0x320
[<8d009c6c>] clk_get_sys+0x1c/0xd0
[<8d0098d0>] clk_register+0x0/0xf0
[<8d17ccb0>] arch_init_clk_ops+0x0/0x30
[<8d009d3e>] clk_get+0x1e/0x100
[<8d009012>] set_bus_parent+0x12/0x30
[<8d009994>] clk_register+0xc4/0xf0
[<8d17cf0e>] cpg_clk_init+0x3e/0x70
[<8d17cf4a>] arch_clk_init+0xa/0x20
[<8d180b10>] __alloc_bootmem+0x0/0x20
[<8d0daf80>] strlen+0x0/0x58
[<8d17d242>] clk_init+0x12/0xc0
[<8d17ca98>] time_init+0x18/0xc0
[<8d0daf80>] strlen+0x0/0x58
[<8d17966c>] start_kernel+0x15c/0x570
[<8d002024>] _stext+0x24/0x30

INFO: lockdep is turned off.


The important message (I guess) is :

2 locks held by swapper/0:
 #0:  (clock_list_sem){......}, at: [<8d009928>] clk_register+0x58/0xf0
 #1:  (clock_list_sem){......}, at: [<8d009c6c>] clk_get_sys+0x1c/0xd0
Unable to handle kernel NULL pointer dereference at virtual address 0000001c


So I read for a while arch/sh/kernel/cpu/clock.c
trying to understand if I see some problem. Both, int clk_register(struct c=
lk *clk)
and struct clk *clk_get_sys(const char *dev_id, const char *con_id)
do mutex_lock(&clock_list_sem) and mutex_unlock(&clock_list_sem).

Then, I did this crazy change below:

diff -upr linux-2.6.orig/arch/sh/kernel/cpu/clock.c linux-2.6.new/arch/sh/k=
ernel/cpu/clock.c
--- linux-2.6.orig/arch/sh/kernel/cpu/clock.c	2009-09-11 01:09:35.000000000=
 -0300
+++ linux-2.6.new/arch/sh/kernel/cpu/clock.c	2009-09-11 01:12:01.000000000 =
-0300
@@ -266,7 +266,7 @@ int clk_register(struct clk *clk)
 	if (clk->node.next || clk->node.prev)
 		return 0;
=20
-	mutex_lock(&clock_list_sem);
+	/* mutex_lock(&clock_list_sem); */
=20
 	INIT_LIST_HEAD(&clk->children);
 	clk->usecount =3D 0;
@@ -279,7 +279,7 @@ int clk_register(struct clk *clk)
 	list_add(&clk->node, &clock_list);
 	if (clk->ops && clk->ops->init)
 		clk->ops->init(clk);
-	mutex_unlock(&clock_list_sem);
+	/* mutex_unlock(&clock_list_sem); */
=20
 	return 0;
 }


and after building the kernel boots and goes further:

Linux version 2.6.31-rc4-hpc (rafa@nodo3) (gcc version 3.4.4) #16 PREEMPT F=
ri Sep 9
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000100
... LOADER_TYPE       - 00000001
... INITRD_START      - 00400000
... INITRD_SIZE       - 00400000
console [sercon0] enabled
Booting machvec: hp6xx
Node 0: start_pfn =3D 0xd000, low =3D 0xe000
Zone PFN ranges:
  Normal   0x0000d000 -> 0x0000e000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000d000 -> 0x0000e000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: mem=16MB  earlyprintk=3Dserial,keep root=3D/dev/sda2 p=
splash=FAlse
PID hash table entries: 64 (order: 6, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 7536k/16384k available (1145k kernel code, 356k data, 84k init)
NR_IRQS:256
sh_tmu: TMU0 used for clock events
sh_tmu: TMU0 used for periodic clock events
sh_tmu: TMU1 used as clock source
Console: colour dummy device 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3487 kB
 per task-struct memory footprint: 1152 bytes
Calibrating delay loop (skipped)... 0.00 BogoMIPS PRESET (lpj=3D0)
Mount-cache hash table entries: 512
CPU: SH7729
bio: create slab <bio-0> at 0
sh_tmu: TMU0 used for oneshot clock events
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
BUG: Bad page state in process swapper  pfn:0d562
page:8d88bc40 flags:00080000 count:0 mapcount:0 mapping:(null) index:0
Stack: (0x8dc1fc40 to 0x8dc20000)
fc40: 8d006d6e 8dc1fc50 8d55c99c 8d88bc40 8d044d76 8dc1fc58 8d047456 8d0474=
16=20
fc60: 8dc1fc78 00000000 8d178150 8d800000 ffffff0f 8d88bc40 8d0475cc 8dc1fc=
98=20
fc80: 80000000 ffe60000 8d400000 8d800000 ffffff0f 8d562000 8d04761c 8dc1fc=
a0=20
fca0: 8d04768e 8dc1fca8 8d00a44e 8dc1fcb0 8d17be7e 8dc1fcd0 8dc4b000 ffffff=
ff=20
fcc0: 8d1489a8 8dc4b000 8d18e094 8d18e098 8d17c034 8dc1fce0 00000000 000000=
00=20
fce0: 8dc1fd04 8d0aea34 00000001 00000004 000241ed 00000000 00000000 000000=
00=20
fd00: 00001000 00000000 4a723e40 00000000 4a723e40 00000000 386d4380 11e443=
cf=20
fd20: 00000000 00000000 00000000 8d00208c 8dc1fd4c 00000000 00000000 8dc1ff=
2c=20
fd40: 8d18b6f0 8d002050 8d18b5bc 8d157e00 8d157e1c 00000002 00000010 000000=
02=20
fd60: fffffffa 0000000a 00000001 ffffffff 00000010 00000002 ffffffff 000000=
0a=20
fd80: ffffffff ffffffff 00000001 00000000 00000000 00000000 00000000 000003=
7c=20
fda0: ffffffab ffffffff 8d1679d8 00000000 00000000 8dc1d020 00000000 8d165f=
40=20
fdc0: 00000000 00000000 8dc1d020 00000000 8d167a10 8d03849c 8dc1fe04 8d193c=
b0=20
fde0: 00000000 00000000 8dc1d020 00000000 8d165f80 8d03849c 8d170b90 000000=
00=20
fe00: 00000000 8dc1d020 00000000 0000037c 8d03849c 8dc1fe40 00000102 000000=
20=20
fe20: 8d166578 8d063858 8d063858 8dc1fe48 00000102 00000020 8dc21bd0 8d1723=
98=20
fe40: 00000000 8d172398 00000000 00000000 8dc1d020 00000001 8dc1fe84 8d0384=
9c=20
fe60: 8dc1fe8c 8d172378 00000032 8dc13524 00000000 0000037c 000000f0 000000=
01=20
fe80: 00000001 00000000 8d0dbc78 8d11d7c4 8d11dc18 8dc1feac 8d063858 8dc1fe=
b8=20
fea0: 8d172378 8d17236c 00000000 00000000 8dc1d020 00000000 8d0dca50 8d0384=
9c=20
fec0: 8dc1feec 8dc3d230 8dc3d1b0 8d0dc8b0 00000000 0000037c 00000000 000000=
01=20
fee0: 00000000 00000000 8d0a907a 8d11d764 8d11dca4 8dc1ff0c 8dc3d1b0 8d0dc8=
b0=20
ff00: 8d11dcaa 8dc1ff0c 8d17235c 8d0a90b2 8dc1ff18 00000000 00000032 8d0a93=
b2=20
ff20: 8dc1ff3c 00000000 00000000 8d03eab0 0000003c 8d55c948 8dc3d1b0 8dc3d2=
30=20
ff40: 8d03eb1a 8dc1ff4c 8d16a318 00003036 00000000 8d170000 8d03ebfe 8d17be=
c0=20
ff60: 00000001 8d179b00 8dc1ff84 00000000 00000000 8d18b538 8d18b6f0 8d0020=
50=20
ff80: 8d18b5bc 8d003a38 8dc1ff9c 00000000 00000000 00000000 00000000 000000=
00=20
ffa0: 00000000 00000000 00000000 00000000 00000000 00000000 8d179a80 000000=
00=20
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00=20
ffe0: 8dc1ffa4 8d003a30 00000000 40000000 00000000 00000000 00000000 000000=
00=20

Call trace:
[<8d006d6e>] dump_stack+0xe/0x2a0
[<8d044d76>] bad_page+0x76/0x140
[<8d047456>] free_hot_cold_page+0x196/0x290
[<8d047416>] free_hot_cold_page+0x156/0x290
[<8d0475cc>] free_hot_page+0xc/0x20
[<8d04761c>] __free_pages+0x3c/0x70
[<8d04768e>] free_pages+0x3e/0x60
[<8d00a44e>] free_initrd_mem+0x8e/0x100
[<8d17be7e>] free_initrd+0x1e/0x60
[<8d17c034>] populate_rootfs+0x174/0x280
[<8d0aea34>] sysfs_add_file_mode+0x44/0xc0
[<8d00208c>] do_one_initcall+0x3c/0x200
[<8d002050>] do_one_initcall+0x0/0x200
[<8d03849c>] lock_acquire+0x4c/0x90
[<8d03849c>] lock_acquire+0x4c/0x90
[<8d03849c>] lock_acquire+0x4c/0x90
[<8d063858>] kmem_cache_free+0x28/0xa0
[<8d063858>] kmem_cache_free+0x28/0xa0
[<8d03849c>] lock_acquire+0x4c/0x90
[<8d0dbc78>] get_from_free_list+0x18/0x50
[<8d11d7c4>] _spin_lock_irqsave+0x44/0x60
[<8d11dc18>] _spin_unlock_irqrestore+0x18/0x90
[<8d063858>] kmem_cache_free+0x28/0xa0
[<8d0dca50>] ida_get_new_above+0x140/0x200
[<8d03849c>] lock_acquire+0x4c/0x90
[<8d0dc8b0>] ida_pre_get+0x0/0x60
[<8d0a907a>] proc_register+0x8a/0x1d0
[<8d11d764>] _spin_lock+0x34/0x50
[<8d11dca4>] _spin_unlock+0x14/0x60
[<8d0dc8b0>] ida_pre_get+0x0/0x60
[<8d11dcaa>] _spin_unlock+0x1a/0x60
[<8d0a90b2>] proc_register+0xc2/0x1d0
[<8d0a93b2>] create_proc_entry+0x42/0xb0
[<8d03eab0>] register_irq_proc+0x0/0xb0
[<8d03eb1a>] register_irq_proc+0x6a/0xb0
[<8d03ebfe>] init_irq_proc+0x4e/0x90
[<8d17bec0>] populate_rootfs+0x0/0x280
[<8d179b00>] kernel_init+0x80/0x140
[<8d002050>] do_one_initcall+0x0/0x200
[<8d003a38>] kernel_thread_helper+0x8/0x20
[<8d179a80>] kernel_init+0x0/0x140
[<8d003a30>] kernel_thread_helper+0x0/0x20

no locks held by swapper/1.
Disabling lock debugging due to kernel taint
Freeing initrd memory: 4096k freed
HD64461 configured at 0xb0000000 on irq 36(mapped into 64 to 79)
msgmni has been set to 22
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
SuperH SCI(F) driver initialized
sh-sci: ttySC0 at MMIO 0xfffffe80 (irq =3D 23) is a sci
sh-sci: ttySC1 at MMIO 0xa4000150 (irq =3D 56) is a scif
sh-sci: ttySC2 at MMIO 0xa4000140 (irq =3D 52) is a irda
brd: module loaded
sh_tmu: TMU0 kept as earlytimer
sh_tmu: TMU1 kept as earlytimer
RAMDISK: Couldn't find valid RAM disk image starting at 0.
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=3D" boot option; here are the available parti=
tions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0=
,0)
Stack: (0x8dc1fed4 to 0x8dc20000)
fec0:                                              8d006d6e 8dc1fee4 8d18f2=
60=20
fee0: 8d015390 8d013fb8 8dc1feec 8d179dfe 8dc1ff18 00000000 00008000 000002=
bc=20
ff00: 8dc3a000 8d015390 8dc3a000 8dc1ff18 8d11a0a2 00000000 6e6b6e75 2d6e77=
6f=20
ff20: 636f6c62 2c30286b 00002930 8dc3a000 8dc3a000 8d072be6 8d148468 8d17a1=
24=20
ff40: 8dc1ff5c 00000000 00000000 8d002390 8d18b6f0 8d148468 00000000 8d17a2=
c2=20
ff60: 8dc1ff6c 8d002050 8d18e07c 8d179b4a 8dc1ff84 8d18b538 8d18b6f0 8d0020=
50=20
ff80: 8d18e070 8d003a38 8dc1ff9c 00000000 00000000 00000000 00000000 000000=
00=20
ffa0: 00000000 00000000 00000000 00000000 00000000 00000000 8d179a80 000000=
00=20
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00=20
ffe0: 8dc1ffa4 8d003a30 00000000 40000000 00000000 00000000 00000000 000000=
00=20

Call trace:
[<8d006d6e>] dump_stack+0xe/0x2a0
[<8d015390>] printk+0x0/0x30
[<8d013fb8>] panic+0x48/0x140
[<8d179dfe>] mount_block_root+0xde/0x2e0
[<8d015390>] printk+0x0/0x30
[<8d11a0a2>] klist_next+0x62/0xd0
[<8d072be6>] sys_mknod+0x16/0x30
[<8d17a124>] mount_root+0x44/0x70
[<8d002390>] name_to_dev_t+0x0/0xc70
[<8d17a2c2>] prepare_namespace+0x172/0x230
[<8d002050>] do_one_initcall+0x0/0x200
[<8d179b4a>] kernel_init+0xca/0x140
[<8d002050>] do_one_initcall+0x0/0x200
[<8d003a38>] kernel_thread_helper+0x8/0x20
[<8d179a80>] kernel_init+0x0/0x140
[<8d003a30>] kernel_thread_helper+0x0/0x20

INFO: lockdep is turned off.


Now, I don't know how to continue fixing properly the problem. Suggestions?
=20
Rafael
