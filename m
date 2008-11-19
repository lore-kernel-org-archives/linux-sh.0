From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 19 Nov 2008 23:15:24 +0000
Subject: HP Jornada 600-series bisected
Message-Id: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__20_Nov_2008_01_16_00_+0100_bOj4=sy6Gu06aY1o"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Thu__20_Nov_2008_01_16_00_+0100_bOj4=sy6Gu06aY1o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

I've started bisecting it after finding v2.6.26(-hpc)=20
working nicely. However after bisecting awhile I ran
into a problem where the serial would startup then
panic and finally reboot (cold reboot).
It's not the exact problem I have in v2.6.27(-hpc)
but most likely related.

I cannot paste the entire log since it's 109 pages (!)
but here's the start of it:

Linux version 2.6.27-rc3-hpc (kristoffer@BoTux) (gcc version 3.4.5) #4 PREE=
MPT Thu Nov 20 00:58:23 CET 2008
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - ffffffff
... ORIG_ROOT_DEV     - ffffffff
... LOADER_TYPE       - 00000001
... INITRD_START      - ffffffff
... INITRD_SIZE       - ffffffff
Booting machvec: hp6xx
Node 0: start_pfn =3D 0xd000, low =3D 0xe000
Zone PFN ranges:
  Normal   0x0000d000 -> 0x0000e000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000d000 -> 0x0000e000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: mem=3D16M console=3DttySC1,115200
PID hash table entries: 64 (order: 6, 256 bytes)
Using tmu for system timer
Using 5.528 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13316k/16384k available (2177k kernel code, 541k data, 92k init)
Calibrating delay loop... 64.25 BogoMIPS (lpj=3D128512)
Mount-cache hash table entries: 512
CPU: SH7729
net_namespace: 288 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
DMA: Registering DMA API.
DMA: Registering sh_dmac handler (4 channels).
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
HD64461 configured at 0xb0000000 on irq 36(mapped into 64 to 79)
HD64461: enabling PCMCIA devices
msgmni has been set to 26
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 80x30
fb0: Hitachi HD64461 frame buffer device
SuperH SCI(F) driver initialized
sh-sci: ttySC0 at MMIO 0xfffffe80 (irq =3D 25) is a sci
sh-sci: ttySC1 at MMIO 0xa4000150 (irq =3D 59) is a scif
console [ttySC1] enabled
sh-sci: ttySC2 at MMIO 0xa4000140 (irq =3D 55) is a irda
loop: module loaded
Driver 'sd' needs updating - please use bus_type methods
scsi0 : pata_platform
ata1: PATA max PIO0 mmio cmd 0x150001f0 ctl 0x150001fe irq 77
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc =3D 00000000
*pde =3D 00000000
Oops: 0000 [#1]
Modules linked in:

Pid : 0, Comm:              swapper
PC is at 0x0
PC  : 00000000 SP  : 8d291f54 SR  : 400001f1 TEA : 00000000    Not tainted
R0  : 0000004d R1  : 00000000 R2  : 8d2c1a98 R3  : 0000000f
R4  : 0000004d R5  : 8d29970c R6  : 00000019 R7  : ffffffff
R8  : 8d2cec0c R9  : 00000000 R10 : 00000034 R11 : 8d2c009c
R12 : 8d21bb80 R13 : 8d2c005c R14 : 8d013cc0
MACH: 000071c6 MACL: 000010d8 GBR : 8c009800 PR  : 8d0036c4

Call trace:=20
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d066130>] quicklist_trim+0x0/0x120
[<8d003690>] do_IRQ+0x0/0x60
[<8d003730>] default_idle+0x0/0xd0
[<8d066130>] quicklist_trim+0x0/0x120
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d013cc0>] printk+0x0/0x20
[<8d003782>] default_idle+0x52/0xd0
[<8d003854>] cpu_idle+0x54/0xb0
[<8d2a994e>] start_kernel+0x4ee/0x560
[<8d2ae4f0>] __alloc_bootmem+0x0/0x10
[<8d0e7810>] strlen+0x0/0x60
[<8d002024>] _stext+0x24/0x30

Process: swapper (pid: 0, stack limit =3D 8d290001)
Stack: (0x8d291f54 to 0x8d292000)
1f40:                                              8d0070e8 8d066130 8d0036=
90=20
1f60: ffffffff 00000000 00000000 10000000 50000100 8d2c9fa8 00000000 000000=
19=20
1f80: ffffffff 8d003730 ffffffff 8d066130 8d2c009c 8d21bb80 8d2c005c 8d013c=
c0=20
1fa0: 8d291fc4 8d003782 8d003854 50000101 8c009800 000071c6 00000000 ffffff=
ff=20
1fc0: ffffffff 8d2a994e 8d2c006c 8d2ae4f0 8d0e7810 8d2b93d4 8d293dd3 8d2b95=
98=20
1fe0: 8d002024 00000000 eeed8cbe 00000000 56125511 64123128 6103d30e 2019e1=
e0=20
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc =3D 00000000
*pde =3D 00000000
Oops: 0000 [#2]
Modules linked in:

Pid : 0, Comm:              swapper
PC is at 0x0
PC  : 00000000 SP  : 8d291dc0 SR  : 400001f1 TEA : 00000000    Tainted: G  =
    D =20
R0  : 0000004d R1  : 00000000 R2  : 8d2c1a98 R3  : 0000000f
R4  : 0000004d R5  : 8d29970c R6  : ffffffff R7  : 00000020
R8  : 8d2cec0c R9  : 8d291f64 R10 : 00000034 R11 : 8d255cec
R12 : 8d0efca0 R13 : 8d291f34 R14 : 8d013cc0
MACH: 000071c6 MACL: 000010d8 GBR : 8c009800 PR  : 8d0036c4

Call trace:=20
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d003690>] do_IRQ+0x0/0x60
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d005cd6>] die+0xa6/0x180
[<8d005cca>] die+0x9a/0x180
[<8d00b08c>] do_page_fault+0x1ac/0x390
[<8d013cc0>] printk+0x0/0x20
[<8d00c3f2>] place_entity+0x82/0xf0
[<8d00c690>] enqueue_task_fair+0xa0/0xf0
[<8d00cff2>] enqueue_task+0x12/0x20
[<8d00cff2>] enqueue_task+0x12/0x20
[<8d00d100>] activate_task+0x20/0x40
[<8d00d646>] try_to_wake_up+0xc6/0x100
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d013cc0>] printk+0x0/0x20
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d013cc0>] printk+0x0/0x20
[<8d0036c4>] do_IRQ+0x34/0x60
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d066130>] quicklist_trim+0x0/0x120
[<8d003690>] do_IRQ+0x0/0x60
[<8d003730>] default_idle+0x0/0xd0
[<8d066130>] quicklist_trim+0x0/0x120
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d013cc0>] printk+0x0/0x20
[<8d003782>] default_idle+0x52/0xd0
[<8d003854>] cpu_idle+0x54/0xb0
[<8d2a994e>] start_kernel+0x4ee/0x560
[<8d2ae4f0>] __alloc_bootmem+0x0/0x10
[<8d0e7810>] strlen+0x0/0x60
[<8d002024>] _stext+0x24/0x30

Process: swapper (pid: 0, stack limit =3D 8d290001)
Stack: (0x8d291dc0 to 0x8d292000)
1dc0: 8d0070e8 00000000 8d003690 ffffffff 00000000 00000000 40000100 000000=
f0=20
1de0: 00000080 00001140 ffffffff 00000020 8d013cc0 8d291ef4 00000000 8d255c=
ec=20
1e00: 8d0efca0 8d291f34 8d013cc0 8d291e30 8d005cd6 8d005cca 40000100 8c0098=
00=20
1e20: 000071c6 00000000 ffffffff ffffffff 8d00b08c 8d291ef4 8d293000 000000=
00=20
1e40: 8d013cc0 00000000 00000000 00000000 00000000 8d291e54 8d00c3f2 8d291e=
70=20
1e60: 8d315a7c 8d2c1fb4 00000000 8d00c690 8d291e8c 8d2c1f84 8d2c1fb4 8d315a=
50=20
1e80: 00000000 8d315a7c 8d2c1fe0 00000001 8d00cff2 8d291eb0 00000003 8d00cf=
f2=20
1ea0: 8d291eb0 8d2c1f84 8d315a50 8d315a90 8d00d100 8d291ebc 8d00d646 8d291e=
c8=20
1ec0: 8d315a50 8d2c2340 00000000 00030001 8d291ee4 8d0070e0 8d013cc0 8d2c00=
5c=20
1ee0: 8d21bb80 8d2c009c 8d0070e0 00000000 00000000 0000004d 00000000 8d2c1a=
98=20
1f00: 0000000f 0000004d 8d29970c 00000019 ffffffff 8d2cec0c 00000000 000000=
34=20
1f20: 8d2c009c 8d21bb80 8d2c005c 8d013cc0 8d291f54 00000000 8d0036c4 400001=
f1=20
1f40: 8c009800 000071c6 000010d8 ffffffff 00000040 8d0070e8 8d066130 8d0036=
90=20
1f60: ffffffff 00000000 00000000 10000000 50000100 8d2c9fa8 00000000 000000=
19=20
1f80: ffffffff 8d003730 ffffffff 8d066130 8d2c009c 8d21bb80 8d2c005c 8d013c=
c0=20
1fa0: 8d291fc4 8d003782 8d003854 50000101 8c009800 000071c6 00000000 ffffff=
ff=20
1fc0: ffffffff 8d2a994e 8d2c006c 8d2ae4f0 8d0e7810 8d2b93d4 8d293dd3 8d2b95=
98=20
1fe0: 8d002024 00000000 eeed8cbe 00000000 56125511 64123128 6103d30e 2019e1=
e0=20
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc =3D 00000000
*pde =3D 00000000
Oops: 0000 [#3]
Modules linked in:

Pid : 0, Comm:              swapper
PC is at 0x0
PC  : 00000000 SP  : 8d291c2c SR  : 400001f1 TEA : 00000000    Tainted: G  =
    D =20
R0  : 0000004d R1  : 00000000 R2  : 8d2c1a98 R3  : 0000000f
R4  : 0000004d R5  : 8d29970c R6  : ffffffff R7  : 00000020
R8  : 8d2cec0c R9  : 8d291dd0 R10 : 00000034 R11 : 8d255cec
R12 : 8d0efca0 R13 : 8d291da0 R14 : 8d013cc0
MACH: 000071c6 MACL: 000010d8 GBR : 8c009800 PR  : 8d0036c4

Call trace:=20
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d003690>] do_IRQ+0x0/0x60
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d005cd6>] die+0xa6/0x180
[<8d005cca>] die+0x9a/0x180
[<8d00b08c>] do_page_fault+0x1ac/0x390
[<8d013cc0>] printk+0x0/0x20
[<8d013cd0>] printk+0x10/0x20
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d03a2b8>] __print_symbol+0x18/0x30
[<8d0132c4>] __call_console_drivers+0x54/0x70
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d0036c4>] do_IRQ+0x34/0x60
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d003690>] do_IRQ+0x0/0x60
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d005cd6>] die+0xa6/0x180
[<8d005cca>] die+0x9a/0x180
[<8d00b08c>] do_page_fault+0x1ac/0x390
[<8d013cc0>] printk+0x0/0x20
[<8d00c3f2>] place_entity+0x82/0xf0
[<8d00c690>] enqueue_task_fair+0xa0/0xf0
[<8d00cff2>] enqueue_task+0x12/0x20
[<8d00cff2>] enqueue_task+0x12/0x20
[<8d00d100>] activate_task+0x20/0x40
[<8d00d646>] try_to_wake_up+0xc6/0x100
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d013cc0>] printk+0x0/0x20
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d013cc0>] printk+0x0/0x20
[<8d0036c4>] do_IRQ+0x34/0x60
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d066130>] quicklist_trim+0x0/0x120
[<8d003690>] do_IRQ+0x0/0x60
[<8d003730>] default_idle+0x0/0xd0
[<8d066130>] quicklist_trim+0x0/0x120
[<8d21bb80>] __sched_text_start+0x0/0x4b0
[<8d013cc0>] printk+0x0/0x20
[<8d003782>] default_idle+0x52/0xd0
[<8d003854>] cpu_idle+0x54/0xb0
[<8d2a994e>] start_kernel+0x4ee/0x560
[<8d2ae4f0>] __alloc_bootmem+0x0/0x10
[<8d0e7810>] strlen+0x0/0x60
[<8d002024>] _stext+0x24/0x30

Process: swapper (pid: 0, stack limit =3D 8d290001)
Stack: (0x8d291c2c to 0x8d292000)
1c20:                            8d0070e8 00000000 8d003690 ffffffff 000000=
00=20
1c40: 00000000 40000100 000000f0 00000080 00001ef2 ffffffff 00000020 8d013c=
c0=20
1c60: 8d291d60 00000000 8d255cec 8d0efca0 8d291da0 8d013cc0 8d291c9c 8d005c=
d6=20
1c80: 8d005cca 40000100 8c009800 000071c6 00000000 ffffffff ffffffff 8d00b0=
8c=20
1ca0: 8d291d60 8d293000 00000000 8d013cc0 00000000 00000000 00000000 000000=
00=20
1cc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00=20
1ce0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
10=20
1d00: 00000004 000000f0 8d013cd0 8d013cc0 8d291f34 8d0efca0 8d255cec 8d291f=
34=20
1d20: 8d013cc0 8d255254 8d03a2b8 8d291d38 00000000 00000000 00030001 8d0132=
c4=20
1d40: 8d0070e0 8d013cc0 8d291f34 8d0efca0 8d255cec 8d0070e0 00000000 000000=
00=20
1d60: 0000004d 00000000 8d2c1a98 0000000f 0000004d 8d29970c ffffffff 000000=
20=20
1d80: 8d2cec0c 8d291f64 00000034 8d255cec 8d0efca0 8d291f34 8d013cc0 8d291d=
c0=20
1da0: 00000000 8d0036c4 400001f1 8c009800 000071c6 000010d8 ffffffff 000000=
40=20
1dc0: 8d0070e8 00000000 8d003690 ffffffff 00000000 00000000 40000100 000000=
f0=20
1de0: 00000080 00001140 ffffffff 00000020 8d013cc0 8d291ef4 00000000 8d255c=
ec=20
1e00: 8d0efca0 8d291f34 8d013cc0 8d291e30 8d005cd6 8d005cca 40000100 8c0098=
00=20
1e20: 000071c6 00000000 ffffffff ffffffff 8d00b08c 8d291ef4 8d293000 000000=
00=20
1e40: 8d013cc0 00000000 00000000 00000000 00000000 8d291e54 8d00c3f2 8d291e=
70=20
1e60: 8d315a7c 8d2c1fb4 00000000 8d00c690 8d291e8c 8d2c1f84 8d2c1fb4 8d315a=
50=20
1e80: 00000000 8d315a7c 8d2c1fe0 00000001 8d00cff2 8d291eb0 00000003 8d00cf=
f2=20
1ea0: 8d291eb0 8d2c1f84 8d315a50 8d315a90 8d00d100 8d291ebc 8d00d646 8d291e=
c8=20
1ec0: 8d315a50 8d2c2340 00000000 00030001 8d291ee4 8d0070e0 8d013cc0 8d2c00=
5c=20
1ee0: 8d21bb80 8d2c009c 8d0070e0 00000000 00000000 0000004d 00000000 8d2c1a=
98=20
1f00: 0000000f 0000004d 8d29970c 00000019 ffffffff 8d2cec0c 00000000 000000=
34=20
1f20: 8d2c009c 8d21bb80 8d2c005c 8d013cc0 8d291f54 00000000 8d0036c4 400001=
f1=20
1f40: 8c009800 000071c6 000010d8 ffffffff 00000040 8d0070e8 8d066130 8d0036=
90=20
1f60: ffffffff 00000000 00000000 10000000 50000100 8d2c9fa8 00000000 000000=
19=20
1f80: ffffffff 8d003730 ffffffff 8d066130 8d2c009c 8d21bb80 8d2c005c 8d013c=
c0=20
1fa0: 8d291fc4 8d003782 8d003854 50000101 8c009800 000071c6 00000000 ffffff=
ff=20
1fc0: ffffffff 8d2a994e 8d2c006c 8d2ae4f0 8d0e7810 8d2b93d4 8d293dd3 8d2b95=
98=20
1fe0: 8d002024 00000000 eeed8cbe 00000000 56125511 64123128 6103d30e 2019e1=
e0=20
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc =3D 00000000
*pde =3D 00000000
Oops: 0000 [#4]
Modules linked in:

Pid : 0, Comm:              swapper
PC is at 0x0
PC  : 00000000 SP  : 8d291a98 SR  : 400001f1 TEA : 00000000    Tainted: G  =
    D =20
R0  : 0000004d R1  : 00000000 R2  : 8d2c1a98 R3  : 0000000f
R4  : 0000004d R5  : 8d29970c R6  : ffffffff R7  : 00000020
R8  : 8d2cec0c R9  : 8d291c3c R10 : 00000034 R11 : 8d255cec
R12 : 8d0efca0 R13 : 8d291c0c R14 : 8d013cc0
MACH: 000071c6 MACL: 000010d8 GBR : 8c009800 PR  : 8d0036c4

Call trace:=20
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d003690>] do_IRQ+0x0/0x60
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d005cd6>] die+0xa6/0x180
[<8d005cca>] die+0x9a/0x180
[<8d00b08c>] do_page_fault+0x1ac/0x390
[<8d013cc0>] printk+0x0/0x20
[<8d0ee1d2>] vsnprintf+0x3e2/0x640
[<8d013cd0>] printk+0x10/0x20
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d03a2b8>] __print_symbol+0x18/0x30
[<8d0132c4>] __call_console_drivers+0x54/0x70
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d0036c4>] do_IRQ+0x34/0x60
[<8d0070e8>] ret_from_irq+0x0/0x10
[<8d003690>] do_IRQ+0x0/0x60
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d005cd6>] die+0xa6/0x180
[<8d005cca>] die+0x9a/0x180
[<8d00b08c>] do_page_fault+0x1ac/0x390
[<8d013cc0>] printk+0x0/0x20
[<8d013cd0>] printk+0x10/0x20
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d03a2b8>] __print_symbol+0x18/0x30
[<8d0132c4>] __call_console_drivers+0x54/0x70
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d013cc0>] printk+0x0/0x20
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d0070e0>] ret_from_exception+0x0/0x8
[<8d0efca0>] bust_spinlocks+0x0/0x50
[<8d013cc0>] printk+0x0/0x20
[<8d0036c4>] do_IRQ+0x34/0x60
[<8d0070e8>] ret_from_irq+0x0/0x10
...........................




--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__20_Nov_2008_01_16_00_+0100_bOj4=sy6Gu06aY1o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkkrEAACgkQPQls10ERAGfQPgCeNRdVY74m5LJDyhUHMJ2BDbVu
KFsAn3zbeeGXsVyr+n3xHLZ8Yht8LUyK
=z3Q8
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Nov_2008_01_16_00_+0100_bOj4=sy6Gu06aY1o--
