From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 14 Apr 2015 13:27:10 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <20150414132709.GA1375@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de>
 <AEA6F5CA-D520-4F34-BE6B-EF2839501089@konsulko.com>
In-Reply-To: <AEA6F5CA-D520-4F34-BE6B-EF2839501089@konsulko.com>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pantelis,

thanks for your prompt reply. Unfortunately, I had to wait until I could
access the test system again.

> > +	struct property status_chg =3D { .name =3D "status", .length =3D 9, .=
value =3D "disabled" };
> > +	int ret;
> > +
>=20
> ^ The status_chg property is on the stack. You can=E2=80=99t do that, bec=
ause after you go out
> of scope the property is garbage. You should dynamically allocate.

My actual driver does that dynamically. For the test case, I considered
the stack to be enough to demonstrate my case.

> I bet that even after you fix that you=E2=80=99ll crash anyway.

Yes, it does.

> Note is that on many platforms the path of removing platform devices is b=
orken.
> I see that you=E2=80=99re using PM, that=E2=80=99s even more problematic.
>=20
> The good news is that we can probably fix it if you give us a detailed lo=
g and
> stack trace.

I'll attach the full boot log. I wonder what it contains what was not in
the previous log :)

Thanks,

   Wolfram

=3D=3D=3D

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.0-rc4-00009-gcb55587ebc4047 (ninja@katana)=
 (gcc version 4.9.2 (OSELAS.Toolchain-2014.12.0) ) #90 Tue Mar 31 17:04:52 =
CEST 2015
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=3D10c=
5347d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction ca=
che
[    0.000000] Machine model: Lager
[    0.000000] Ignoring memory block 0x140000000 - 0x200000000
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c03dd6c0, node_mem_map ee=
ff8000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 67584 pages, LIFO batch:15
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/kernel/devtree.c:144 arm_=
dt_init_cpu_maps+0xc0/0x130()
[    0.000000] DT /cpu 2 nodes greater than max cores 1, capping them
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.0.0-rc4-00009-gcb5=
5587ebc4047 #90
[    0.000000] Hardware name: Generic R8A7790 (Flattened Device Tree)
[    0.000000] Backtrace:=20
[    0.000000] [<c0011c80>] (dump_backtrace) from [<c0011e28>] (show_stack+=
0x18/0x1c)
[    0.000000]  r6:c02ee547 r5:00000009 r4:00000000 r3:00200000
[    0.000000] [<c0011e10>] (show_stack) from [<c0259f7c>] (dump_stack+0x20=
/0x28)
[    0.000000] [<c0259f5c>] (dump_stack) from [<c00208e0>] (warn_slowpath_c=
ommon+0x8c/0xb4)
[    0.000000] [<c0020854>] (warn_slowpath_common) from [<c0020974>] (warn_=
slowpath_fmt+0x38/0x40)
[    0.000000]  r8:eefcc690 r7:00000001 r6:00000000 r5:00000001 r4:eefcca98
[    0.000000] [<c0020940>] (warn_slowpath_fmt) from [<c0324a4c>] (arm_dt_i=
nit_cpu_maps+0xc0/0x130)
[    0.000000]  r3:00000002 r2:c02ee5d3
[    0.000000] [<c032498c>] (arm_dt_init_cpu_maps) from [<c03242f4>] (setup=
_arch+0x5f0/0x6c8)
[    0.000000]  r8:c02ee071 r7:c03cc630 r6:c03c7190 r5:c0340938 r4:ef7fcec0
[    0.000000] [<c0323d04>] (setup_arch) from [<c03219c4>] (start_kernel+0x=
88/0x394)
[    0.000000]  r10:00000000 r9:413fc0f2 r8:40004059 r7:c03c4040 r6:fffffff=
f r5:c03de2c0
[    0.000000]  r4:00000000
[    0.000000] [<c032193c>] (start_kernel) from [<40008070>] (0x40008070)
[    0.000000]  r9:413fc0f2 r8:40004059 r7:c03c72bc r6:c0341744 r5:c03c40b4=
 r4:c03de494
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260624
[    0.000000] Kernel command line: ignore_loglevel rw root=3D/dev/nfs ip=
=3Ddhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1027336K/1048576K available (2403K kernel code, 112K=
 rwdata, 764K rodata, 644K init, 8035K bss, 21240K reserved, 0K cma-reserve=
d, 270336K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0320f7c   (3172 kB)
[    0.000000]       .init : 0xc0321000 - 0xc03c2000   ( 644 kB)
[    0.000000]       .data : 0xc03c2000 - 0xc03de2c0   ( 113 kB)
[    0.000000]        .bss : 0xc03de2c0 - 0xc0bb7038   (8036 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000008] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every=
 3435973836800ns
[    0.000028] Switching to timer-based delay loop, resolution 100ns
[    0.001249] Console: colour dummy device 80x30
[    0.001288] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.001301] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001314] ... MAX_LOCK_DEPTH:          48
[    0.001327] ... MAX_LOCKDEP_KEYS:        8191
[    0.001339] ... CLASSHASH_SIZE:          4096
[    0.001352] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001365] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001378] ... CHAINHASH_SIZE:          32768
[    0.001391]  memory used by lock dependency info: 5167 kB
[    0.001404]  per task-struct memory footprint: 1152 bytes
[    0.001433] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 20.00 BogoMIPS (lpj=3D100000)
[    0.001455] pid_max: default: 32768 minimum: 301
[    0.001717] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001738] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.003465] CPU: Testing write buffer coherency: ok
[    0.004167] Setting up static identity map for 0x4025f558 - 0x4025f58c
[    0.007623] devtmpfs: initialized
[    0.007838] device: 'platform': device_add
[    0.008108] bus: 'platform': registered
[    0.008285] bus: 'cpu': registered
[    0.008309] device: 'cpu': device_add
[    0.008602] bus: 'container': registered
[    0.008627] device: 'container': device_add
[    0.009137] VFP support v0.3: implementor 41 architecture 4 part 30 vari=
ant f rev 0
[    0.009454] bus: 'workqueue': registered
[    0.009478] device: 'workqueue': device_add
[    0.010608] pinctrl core: initialized pinctrl subsystem
[    0.011039] device class 'regulator': registering
[    0.011251] Registering platform device 'reg-dummy'. Parent at platform
[    0.011268] device: 'reg-dummy': device_add
[    0.011322] bus: 'platform': add device reg-dummy
[    0.011549] bus: 'platform': add driver reg-dummy
[    0.011600] bus: 'platform': driver_probe_device: matched device reg-dum=
my with driver reg-dummy
[    0.011618] bus: 'platform': really_probe: probing driver reg-dummy with=
 device reg-dummy
[    0.011729] reg-dummy reg-dummy: no default pinctrl state
[    0.011879] device: 'regulator.0': device_add
[    0.012687] driver: 'reg-dummy': driver_bound: bound to device 'reg-dumm=
y'
[    0.012736] bus: 'platform': really_probe: bound device reg-dummy to dri=
ver reg-dummy
[    0.062593] NET: Registered protocol family 16
[    0.063094] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.063121] device class 'bdi': registering
[    0.063364] bus: 'platform': add driver renesas_irqc
[    0.063545] bus: 'platform': add driver sh-pfc
[    0.063702] bus: 'platform': add driver em_gio
[    0.063857] device class 'tty': registering
[    0.063948] device class 'vtconsole': registering
[    0.064050] device: 'vtcon0': device_add
[    0.064628] bus: 'i2c': registered
[    0.064673] bus: 'i2c': add driver dummy
[    0.064816] i2c-core: driver [dummy] registered
[    0.065398] device: 'f1001000.interrupt-controller': device_add
[    0.065460] bus: 'platform': add device f1001000.interrupt-controller
[    0.065601] platform f1001000.interrupt-controller: pm_clk_notify() 1
[    0.065969] device: 'e6050000.gpio': device_add
[    0.066029] bus: 'platform': add device e6050000.gpio
[    0.066140] platform e6050000.gpio: pm_clk_notify() 1
[    0.066508] device: 'e6051000.gpio': device_add
[    0.066579] bus: 'platform': add device e6051000.gpio
[    0.066690] platform e6051000.gpio: pm_clk_notify() 1
[    0.067055] device: 'e6052000.gpio': device_add
[    0.067116] bus: 'platform': add device e6052000.gpio
[    0.067227] platform e6052000.gpio: pm_clk_notify() 1
[    0.067594] device: 'e6053000.gpio': device_add
[    0.067657] bus: 'platform': add device e6053000.gpio
[    0.067768] platform e6053000.gpio: pm_clk_notify() 1
[    0.068156] device: 'e6054000.gpio': device_add
[    0.068216] bus: 'platform': add device e6054000.gpio
[    0.068327] platform e6054000.gpio: pm_clk_notify() 1
[    0.068711] device: 'e6055000.gpio': device_add
[    0.068772] bus: 'platform': add device e6055000.gpio
[    0.068883] platform e6055000.gpio: pm_clk_notify() 1
[    0.069287] device: 'e61f0000.thermal': device_add
[    0.069348] bus: 'platform': add device e61f0000.thermal
[    0.069460] platform e61f0000.thermal: pm_clk_notify() 1
[    0.069991] device: 'timer': device_add
[    0.070050] bus: 'platform': add device timer
[    0.070161] platform timer: pm_clk_notify() 1
[    0.070627] device: 'ffca0000.timer': device_add
[    0.070698] bus: 'platform': add device ffca0000.timer
[    0.070809] platform ffca0000.timer: pm_clk_notify() 1
[    0.071544] device: 'e61c0000.interrupt-controller': device_add
[    0.071606] bus: 'platform': add device e61c0000.interrupt-controller
[    0.071720] platform e61c0000.interrupt-controller: pm_clk_notify() 1
[    0.071810] bus: 'platform': driver_probe_device: matched device e61c000=
0.interrupt-controller with driver renesas_irqc
[    0.071828] bus: 'platform': really_probe: probing driver renesas_irqc w=
ith device e61c0000.interrupt-controller
[    0.071878] renesas_irqc e61c0000.interrupt-controller: no default pinct=
rl state
[    0.071914] renesas_irqc e61c0000.interrupt-controller: pm_clk_notify() 4
[    0.072314] renesas_irqc e61c0000.interrupt-controller: driving 4 irqs
[    0.072331] driver: 'renesas_irqc': driver_bound: bound to device 'e61c0=
000.interrupt-controller'
[    0.072360] renesas_irqc e61c0000.interrupt-controller: pm_clk_notify() 5
[    0.072378] bus: 'platform': really_probe: bound device e61c0000.interru=
pt-controller to driver renesas_irqc
[    0.074424] device: 'e6700000.dma-controller': device_add
[    0.074485] bus: 'platform': add device e6700000.dma-controller
[    0.074598] platform e6700000.dma-controller: pm_clk_notify() 1
[    0.076734] device: 'e6720000.dma-controller': device_add
[    0.076796] bus: 'platform': add device e6720000.dma-controller
[    0.076909] platform e6720000.dma-controller: pm_clk_notify() 1
[    0.078777] device: 'ec700000.dma-controller': device_add
[    0.078838] bus: 'platform': add device ec700000.dma-controller
[    0.078951] platform ec700000.dma-controller: pm_clk_notify() 1
[    0.080856] device: 'ec720000.dma-controller': device_add
[    0.080918] bus: 'platform': add device ec720000.dma-controller
[    0.081031] platform ec720000.dma-controller: pm_clk_notify() 1
[    0.081254] device: 'ec740000.dma-controller': device_add
[    0.081316] bus: 'platform': add device ec740000.dma-controller
[    0.081439] platform ec740000.dma-controller: pm_clk_notify() 1
[    0.081847] device: 'e6500000.i2c': device_add
[    0.081908] bus: 'platform': add device e6500000.i2c
[    0.082031] platform e6500000.i2c: pm_clk_notify() 1
[    0.082411] device: 'e6510000.i2c': device_add
[    0.082472] bus: 'platform': add device e6510000.i2c
[    0.082584] platform e6510000.i2c: pm_clk_notify() 1
[    0.082986] device: 'e60b0000.i2c': device_add
[    0.083047] bus: 'platform': add device e60b0000.i2c
[    0.083158] platform e60b0000.i2c: pm_clk_notify() 1
[    0.083540] device: 'ee220000.mmc': device_add
[    0.083601] bus: 'platform': add device ee220000.mmc
[    0.083713] platform ee220000.mmc: pm_clk_notify() 1
[    0.083939] device: 'e6060000.pfc': device_add
[    0.084000] bus: 'platform': add device e6060000.pfc
[    0.084112] platform e6060000.pfc: pm_clk_notify() 1
[    0.084203] bus: 'platform': driver_probe_device: matched device e606000=
0.pfc with driver sh-pfc
[    0.084220] bus: 'platform': really_probe: probing driver sh-pfc with de=
vice e6060000.pfc
[    0.084264] sh-pfc e6060000.pfc: no default pinctrl state
[    0.084297] sh-pfc e6060000.pfc: pm_clk_notify() 4
[    0.085304] sh-pfc e6060000.pfc: r8a77900_pfc support registered
[    0.085321] driver: 'sh-pfc': driver_bound: bound to device 'e6060000.pf=
c'
[    0.085348] sh-pfc e6060000.pfc: pm_clk_notify() 5
[    0.085365] bus: 'platform': really_probe: bound device e6060000.pfc to =
driver sh-pfc
[    0.085649] device: 'ee100000.sd': device_add
[    0.085710] bus: 'platform': add device ee100000.sd
[    0.085822] platform ee100000.sd: pm_clk_notify() 1
[    0.086190] device: 'ee140000.sd': device_add
[    0.086251] bus: 'platform': add device ee140000.sd
[    0.086374] platform ee140000.sd: pm_clk_notify() 1
[    0.086740] device: 'e6c40000.serial': device_add
[    0.086801] bus: 'platform': add device e6c40000.serial
[    0.086913] platform e6c40000.serial: pm_clk_notify() 1
[    0.087281] device: 'e6c50000.serial': device_add
[    0.087342] bus: 'platform': add device e6c50000.serial
[    0.087454] platform e6c50000.serial: pm_clk_notify() 1
[    0.087921] device: 'ee700000.ethernet': device_add
[    0.087983] bus: 'platform': add device ee700000.ethernet
[    0.088096] platform ee700000.ethernet: pm_clk_notify() 1
[    0.088471] device: 'ee500000.sata': device_add
[    0.088532] bus: 'platform': add device ee500000.sata
[    0.088644] platform ee500000.sata: pm_clk_notify() 1
[    0.089002] device: 'e6590000.usb': device_add
[    0.089063] bus: 'platform': add device e6590000.usb
[    0.089175] platform e6590000.usb: pm_clk_notify() 1
[    0.089399] device: 'e6590100.usb-phy': device_add
[    0.089460] bus: 'platform': add device e6590100.usb-phy
[    0.089573] platform e6590100.usb-phy: pm_clk_notify() 1
[    0.089969] device: 'e6ef1000.video': device_add
[    0.090030] bus: 'platform': add device e6ef1000.video
[    0.090153] platform e6ef1000.video: pm_clk_notify() 1
[    0.090531] device: 'fe920000.vsp1': device_add
[    0.090593] bus: 'platform': add device fe920000.vsp1
[    0.090705] platform fe920000.vsp1: pm_clk_notify() 1
[    0.091070] device: 'fe928000.vsp1': device_add
[    0.091133] bus: 'platform': add device fe928000.vsp1
[    0.091238] platform fe928000.vsp1: pm_clk_notify() 1
[    0.091593] device: 'fe930000.vsp1': device_add
[    0.091651] bus: 'platform': add device fe930000.vsp1
[    0.091757] platform fe930000.vsp1: pm_clk_notify() 1
[    0.092111] device: 'fe938000.vsp1': device_add
[    0.092168] bus: 'platform': add device fe938000.vsp1
[    0.092274] platform fe938000.vsp1: pm_clk_notify() 1
[    0.092968] device: 'feb00000.display': device_add
[    0.093026] bus: 'platform': add device feb00000.display
[    0.093132] platform feb00000.display: pm_clk_notify() 1
[    0.093496] device: 'e6b10000.spi': device_add
[    0.093554] bus: 'platform': add device e6b10000.spi
[    0.093660] platform e6b10000.spi: pm_clk_notify() 1
[    0.094082] device: 'e6e10000.spi': device_add
[    0.094139] bus: 'platform': add device e6e10000.spi
[    0.094257] platform e6e10000.spi: pm_clk_notify() 1
[    0.094649] device: 'ee000000.usb': device_add
[    0.094707] bus: 'platform': add device ee000000.usb
[    0.094813] platform ee000000.usb: pm_clk_notify() 1
[    0.095225] device: 'ee090000.pci': device_add
[    0.095283] bus: 'platform': add device ee090000.pci
[    0.095389] platform ee090000.pci: pm_clk_notify() 1
[    0.095801] device: 'ee0b0000.pci': device_add
[    0.095859] bus: 'platform': add device ee0b0000.pci
[    0.095965] platform ee0b0000.pci: pm_clk_notify() 1
[    0.096378] device: 'ee0d0000.pci': device_add
[    0.096435] bus: 'platform': add device ee0d0000.pci
[    0.096541] platform ee0d0000.pci: pm_clk_notify() 1
[    0.096921] device: 'ec500000.rcar_sound': device_add
[    0.096979] bus: 'platform': add device ec500000.rcar_sound
[    0.097086] platform ec500000.rcar_sound: pm_clk_notify() 1
[    0.097286] device: 'keyboard': device_add
[    0.097343] bus: 'platform': add device keyboard
[    0.097449] platform keyboard: pm_clk_notify() 1
[    0.097616] device: 'leds': device_add
[    0.097674] bus: 'platform': add device leds
[    0.097789] platform leds: pm_clk_notify() 1
[    0.097952] device: 'fixedregulator@0': device_add
[    0.098010] bus: 'platform': add device fixedregulator@0
[    0.098117] platform fixedregulator@0: pm_clk_notify() 1
[    0.098283] device: 'regulator@1': device_add
[    0.098341] bus: 'platform': add device regulator@1
[    0.098447] platform regulator@1: pm_clk_notify() 1
[    0.098612] device: 'regulator@2': device_add
[    0.098670] bus: 'platform': add device regulator@2
[    0.098776] platform regulator@2: pm_clk_notify() 1
[    0.098941] device: 'regulator@3': device_add
[    0.098998] bus: 'platform': add device regulator@3
[    0.099104] platform regulator@3: pm_clk_notify() 1
[    0.099270] device: 'regulator@4': device_add
[    0.099328] bus: 'platform': add device regulator@4
[    0.099434] platform regulator@4: pm_clk_notify() 1
[    0.099596] device: 'sound': device_add
[    0.099653] bus: 'platform': add device sound
[    0.099758] platform sound: pm_clk_notify() 1
[    0.099953] device: 'vga-encoder': device_add
[    0.100012] bus: 'platform': add device vga-encoder
[    0.100128] platform vga-encoder: pm_clk_notify() 1
[    0.100288] device: 'vga': device_add
[    0.100345] bus: 'platform': add device vga
[    0.100452] platform vga: pm_clk_notify() 1
[    0.100613] device: 'i2cbus@8': device_add
[    0.100682] bus: 'platform': add device i2cbus@8
[    0.100788] platform i2cbus@8: pm_clk_notify() 1
[    0.100920] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchp=
oint registers.
[    0.100935] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.101011] device class 'dma': registering
[    0.101258] device: 'cpu0': device_add
[    0.101316] bus: 'cpu': add device cpu0
[    0.148418] device: 'writeback': device_add
[    0.148483] bus: 'workqueue': add device writeback
[    0.148929] bus: 'platform': add driver reg-fixed-voltage
[    0.149254] bus: 'platform': driver_probe_device: matched device fixedre=
gulator@0 with driver reg-fixed-voltage
[    0.149272] bus: 'platform': really_probe: probing driver reg-fixed-volt=
age with device fixedregulator@0
[    0.149330] reg-fixed-voltage fixedregulator@0: pm_clk_notify() 4
[    0.149550] device: 'regulator.1': device_add
[    0.150192] driver: 'reg-fixed-voltage': driver_bound: bound to device '=
fixedregulator@0'
[    0.150221] reg-fixed-voltage fixedregulator@0: pm_clk_notify() 5
[    0.150239] bus: 'platform': really_probe: bound device fixedregulator@0=
 to driver reg-fixed-voltage
[    0.150270] bus: 'platform': driver_probe_device: matched device regulat=
or@1 with driver reg-fixed-voltage
[    0.150288] bus: 'platform': really_probe: probing driver reg-fixed-volt=
age with device regulator@1
[    0.150338] reg-fixed-voltage regulator@1: pm_clk_notify() 4
[    0.150579] platform regulator@1: Driver reg-fixed-voltage requests prob=
e deferral
[    0.150601] platform regulator@1: Added to deferred list
[    0.150638] bus: 'platform': driver_probe_device: matched device regulat=
or@3 with driver reg-fixed-voltage
[    0.150656] bus: 'platform': really_probe: probing driver reg-fixed-volt=
age with device regulator@3
[    0.150707] reg-fixed-voltage regulator@3: pm_clk_notify() 4
[    0.150916] platform regulator@3: Driver reg-fixed-voltage requests prob=
e deferral
[    0.150937] platform regulator@3: Added to deferred list
[    0.151089] bus: 'platform': add driver da9063-regulators
[    0.151337] bus: 'platform': add driver gpio-regulator
[    0.151635] bus: 'platform': driver_probe_device: matched device regulat=
or@2 with driver gpio-regulator
[    0.151653] bus: 'platform': really_probe: probing driver gpio-regulator=
 with device regulator@2
[    0.151703] gpio-regulator regulator@2: pm_clk_notify() 4
[    0.151923] gpio-regulator regulator@2: Could not obtain regulator setti=
ng GPIOs: -517
[    0.151998] platform regulator@2: Driver gpio-regulator requests probe d=
eferral
[    0.152019] platform regulator@2: Added to deferred list
[    0.152055] bus: 'platform': driver_probe_device: matched device regulat=
or@4 with driver gpio-regulator
[    0.152073] bus: 'platform': really_probe: probing driver gpio-regulator=
 with device regulator@4
[    0.152123] gpio-regulator regulator@4: pm_clk_notify() 4
[    0.152340] gpio-regulator regulator@4: Could not obtain regulator setti=
ng GPIOs: -517
[    0.152414] platform regulator@4: Driver gpio-regulator requests probe d=
eferral
[    0.152435] platform regulator@4: Added to deferred list
[    0.152592] device class 'misc': registering
[    0.152713] device class 'mdio_bus': registering
[    0.152957] bus: 'mdio_bus': registered
[    0.152974] bus: 'mdio_bus': add driver Generic PHY
[    0.153109] bus: 'mdio_bus': add driver Generic 10G PHY
[    0.153433] bus: 'serio': registered
[    0.153456] device class 'input': registering
[    0.153588] bus: 'platform': add driver i2c-sh_mobile
[    0.153920] bus: 'platform': driver_probe_device: matched device e650000=
0.i2c with driver i2c-sh_mobile
[    0.153938] bus: 'platform': really_probe: probing driver i2c-sh_mobile =
with device e6500000.i2c
[    0.153989] i2c-sh_mobile e6500000.i2c: pm_clk_notify() 4
[    0.154164] i2c-sh_mobile e6500000.i2c: Runtime PM disabled, clock force=
d on.
[    0.154452] device: 'i2c-4': device_add
[    0.154596] bus: 'i2c': add device i2c-4
[    0.154773] i2c i2c-4: adapter [e6500000.i2c] registered
[    0.154841] i2c i2c-4: of_i2c: walking child nodes
[    0.154886] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 =
Hz
[    0.154903] driver: 'i2c-sh_mobile': driver_bound: bound to device 'e650=
0000.i2c'
[    0.154929] i2c-sh_mobile e6500000.i2c: pm_clk_notify() 5
[    0.154947] bus: 'platform': really_probe: bound device e6500000.i2c to =
driver i2c-sh_mobile
[    0.154993] bus: 'platform': driver_probe_device: matched device e651000=
0.i2c with driver i2c-sh_mobile
[    0.155011] bus: 'platform': really_probe: probing driver i2c-sh_mobile =
with device e6510000.i2c
[    0.155552] i2c-sh_mobile e6510000.i2c: pm_clk_notify() 4
[    0.155622] i2c-sh_mobile e6510000.i2c: Runtime PM disabled, clock force=
d on.
[    0.155876] device: 'i2c-5': device_add
[    0.156003] bus: 'i2c': add device i2c-5
[    0.156134] i2c i2c-5: adapter [e6510000.i2c] registered
[    0.156200] i2c i2c-5: of_i2c: walking child nodes
[    0.156232] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 =
Hz
[    0.156248] driver: 'i2c-sh_mobile': driver_bound: bound to device 'e651=
0000.i2c'
[    0.156275] i2c-sh_mobile e6510000.i2c: pm_clk_notify() 5
[    0.156293] bus: 'platform': really_probe: bound device e6510000.i2c to =
driver i2c-sh_mobile
[    0.156339] bus: 'platform': driver_probe_device: matched device e60b000=
0.i2c with driver i2c-sh_mobile
[    0.156356] bus: 'platform': really_probe: probing driver i2c-sh_mobile =
with device e60b0000.i2c
[    0.156848] i2c-sh_mobile e60b0000.i2c: pm_clk_notify() 4
[    0.156920] i2c-sh_mobile e60b0000.i2c: Runtime PM disabled, clock force=
d on.
[    0.157185] device: 'i2c-7': device_add
[    0.157312] bus: 'i2c': add device i2c-7
[    0.157443] i2c i2c-7: adapter [e60b0000.i2c] registered
[    0.157509] i2c i2c-7: of_i2c: walking child nodes
[    0.157533] i2c i2c-7: of_i2c: register /i2c@e60b0000/regulator@68
[    0.157574] device: '7-0068': device_add
[    0.157690] bus: 'i2c': add device 7-0068
[    0.157790] i2c 7-0068: uevent
[    0.157842] i2c i2c-7: client [da9210] registered with bus id 7-0068
[    0.157874] i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 =
Hz
[    0.157891] driver: 'i2c-sh_mobile': driver_bound: bound to device 'e60b=
0000.i2c'
[    0.157917] i2c-sh_mobile e60b0000.i2c: pm_clk_notify() 5
[    0.157935] bus: 'platform': really_probe: bound device e60b0000.i2c to =
driver i2c-sh_mobile
[    0.158508] media: Linux media interface: v0.10
[    0.158698] bus: 'media': registered
[    0.158721] Linux video capture interface: v2.00
[    0.158739] device class 'video4linux': registering
[    0.158832] device class 'watchdog': registering
[    0.158923] bus: 'platform': add driver sh_cmt
[    0.159086] bus: 'platform': driver_probe_device: matched device ffca000=
0.timer with driver sh_cmt
[    0.159103] bus: 'platform': really_probe: probing driver sh_cmt with de=
vice ffca0000.timer
[    0.159154] sh_cmt ffca0000.timer: pm_clk_notify() 4
[    0.159224] sh_cmt ffca0000.timer: Runtime PM disabled, clock forced on.
[    0.159476] sh_cmt ffca0000.timer: ch0: used for clock events
[    0.159502] sh_cmt ffca0000.timer: ch1: used as clock source
[    0.159529] driver: 'sh_cmt': driver_bound: bound to device 'ffca0000.ti=
mer'
[    0.159556] sh_cmt ffca0000.timer: pm_clk_notify() 5
[    0.159573] bus: 'platform': really_probe: bound device ffca0000.timer t=
o driver sh_cmt
[    0.160119] bus: 'platform': add driver sh_mtu2
[    0.160554] bus: 'platform': add driver em_sti
[    0.160984] device class 'sound': registering
[    0.161223] Advanced Linux Sound Architecture Driver Initialized.
[    0.161379] device class 'net': registering
[    0.161567] device: 'lo': device_add
[    0.163932] Switched to clocksource arch_sys_counter
[    0.164862] device class 'mem': registering
[    0.164944] device: 'mem': device_add
[    0.173284] device: 'kmem': device_add
[    0.173686] device: 'null': device_add
[    0.174114] device: 'zero': device_add
[    0.174513] device: 'full': device_add
[    0.174922] device: 'random': device_add
[    0.175381] device: 'urandom': device_add
[    0.175781] device: 'kmsg': device_add
[    0.176201] device: 'tty': device_add
[    0.177447] device: 'console': device_add
[    0.178264] device: 'tty0': device_add
[    0.178892] device class 'vc': registering
[    0.178982] device: 'vcs': device_add
[    0.179933] device: 'vcsa': device_add
[    0.180384] device: 'vcs1': device_add
[    0.180977] device: 'vcsa1': device_add
[    0.181812] device: 'tty1': device_add
[    0.182219] device: 'tty2': device_add
[    0.183009] device: 'tty3': device_add
[    0.183628] device: 'tty4': device_add
[    0.184064] device: 'tty5': device_add
[    0.184905] device: 'tty6': device_add
[    0.185314] device: 'tty7': device_add
[    0.185925] device: 'tty8': device_add
[    0.186716] device: 'tty9': device_add
[    0.187122] device: 'tty10': device_add
[    0.187924] device: 'tty11': device_add
[    0.188534] device: 'tty12': device_add
[    0.188991] device: 'tty13': device_add
[    0.189784] device: 'tty14': device_add
[    0.190192] device: 'tty15': device_add
[    0.190803] device: 'tty16': device_add
[    0.191595] device: 'tty17': device_add
[    0.192014] device: 'tty18': device_add
[    0.192808] device: 'tty19': device_add
[    0.193479] device: 'tty20': device_add
[    0.193888] device: 'tty21': device_add
[    0.194711] device: 'tty22': device_add
[    0.195120] device: 'tty23': device_add
[    0.195722] device: 'tty24': device_add
[    0.196525] device: 'tty25': device_add
[    0.196934] device: 'tty26': device_add
[    0.197775] device: 'tty27': device_add
[    0.198388] device: 'tty28': device_add
[    0.198796] device: 'tty29': device_add
[    0.199590] device: 'tty30': device_add
[    0.199999] device: 'tty31': device_add
[    0.200623] device: 'tty32': device_add
[    0.201416] device: 'tty33': device_add
[    0.201876] device: 'tty34': device_add
[    0.202670] device: 'tty35': device_add
[    0.203281] device: 'tty36': device_add
[    0.203690] device: 'tty37': device_add
[    0.204522] device: 'tty38': device_add
[    0.204943] device: 'tty39': device_add
[    0.205546] device: 'tty40': device_add
[    0.206389] device: 'tty41': device_add
[    0.206799] device: 'tty42': device_add
[    0.207594] device: 'tty43': device_add
[    0.208209] device: 'tty44': device_add
[    0.208630] device: 'tty45': device_add
[    0.209439] device: 'tty46': device_add
[    0.209849] device: 'tty47': device_add
[    0.210502] device: 'tty48': device_add
[    0.211297] device: 'tty49': device_add
[    0.211707] device: 'tty50': device_add
[    0.212502] device: 'tty51': device_add
[    0.213115] device: 'tty52': device_add
[    0.213536] device: 'tty53': device_add
[    0.214361] device: 'tty54': device_add
[    0.214822] device: 'tty55': device_add
[    0.215428] device: 'tty56': device_add
[    0.216234] device: 'tty57': device_add
[    0.216645] device: 'tty58': device_add
[    0.217461] device: 'tty59': device_add
[    0.218085] device: 'tty60': device_add
[    0.218497] device: 'tty61': device_add
[    0.219344] device: 'tty62': device_add
[    0.219756] device: 'tty63': device_add
[    0.220704] device class 'thermal': registering
[    0.221176] NET: Registered protocol family 2
[    0.222523] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.222975] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.229661] TCP: Hash tables configured (established 8192 bind 8192)
[    0.229786] TCP: reno registered
[    0.229820] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.230686] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.624817] bus: 'platform': add driver arm-pmu
[    0.626355] bus: 'clocksource': registered
[    0.626381] device: 'clocksource': device_add
[    0.626456] device: 'clocksource0': device_add
[    0.626516] bus: 'clocksource': add device clocksource0
[    0.626774] bus: 'platform': add driver alarmtimer
[    0.627027] Registering platform device 'alarmtimer'. Parent at platform
[    0.627043] device: 'alarmtimer': device_add
[    0.627105] bus: 'platform': add device alarmtimer
[    0.627223] platform alarmtimer: pm_clk_notify() 1
[    0.627307] bus: 'platform': driver_probe_device: matched device alarmti=
mer with driver alarmtimer
[    0.627324] bus: 'platform': really_probe: probing driver alarmtimer wit=
h device alarmtimer
[    0.627371] alarmtimer alarmtimer: pm_clk_notify() 4
[    0.627459] driver: 'alarmtimer': driver_bound: bound to device 'alarmti=
mer'
[    0.627486] alarmtimer alarmtimer: pm_clk_notify() 5
[    0.627503] bus: 'platform': really_probe: bound device alarmtimer to dr=
iver alarmtimer
[    0.627721] bus: 'clockevents': registered
[    0.627745] device: 'clockevents': device_add
[    0.627816] device: 'clockevent0': device_add
[    0.627876] bus: 'clockevents': add device clockevent0
[    0.628090] futex hash table entries: 256 (order: 1, 11264 bytes)
[    0.628710] bus: 'event_source': registered
[    0.628737] device: 'breakpoint': device_add
[    0.628803] bus: 'event_source': add device breakpoint
[    0.629042] device: 'software': device_add
[    0.629118] bus: 'event_source': add device software
[    0.634101] bus: 'platform': add driver gpio_rcar
[    0.634184] bus: 'platform': driver_probe_device: matched device e605000=
0.gpio with driver gpio_rcar
[    0.634202] bus: 'platform': really_probe: probing driver gpio_rcar with=
 device e6050000.gpio
[    0.634257] gpio_rcar e6050000.gpio: pm_clk_notify() 4
[    0.634361] gpio_rcar e6050000.gpio: Runtime PM disabled, clock forced o=
n.
[    0.635763] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    0.635780] driver: 'gpio_rcar': driver_bound: bound to device 'e6050000=
=2Egpio'
[    0.635807] gpio_rcar e6050000.gpio: pm_clk_notify() 5
[    0.635825] bus: 'platform': really_probe: bound device e6050000.gpio to=
 driver gpio_rcar
[    0.635865] bus: 'platform': driver_probe_device: matched device e605100=
0.gpio with driver gpio_rcar
[    0.635882] bus: 'platform': really_probe: probing driver gpio_rcar with=
 device e6051000.gpio
[    0.635934] gpio_rcar e6051000.gpio: pm_clk_notify() 4
[    0.636005] gpio_rcar e6051000.gpio: Runtime PM disabled, clock forced o=
n.
[    0.637302] gpio_rcar e6051000.gpio: driving 32 GPIOs
[    0.637318] driver: 'gpio_rcar': driver_bound: bound to device 'e6051000=
=2Egpio'
[    0.637345] gpio_rcar e6051000.gpio: pm_clk_notify() 5
[    0.637362] bus: 'platform': really_probe: bound device e6051000.gpio to=
 driver gpio_rcar
[    0.637401] bus: 'platform': driver_probe_device: matched device e605200=
0.gpio with driver gpio_rcar
[    0.637419] bus: 'platform': really_probe: probing driver gpio_rcar with=
 device e6052000.gpio
[    0.637470] gpio_rcar e6052000.gpio: pm_clk_notify() 4
[    0.637539] gpio_rcar e6052000.gpio: Runtime PM disabled, clock forced o=
n.
[    0.638843] gpio_rcar e6052000.gpio: driving 32 GPIOs
[    0.638859] driver: 'gpio_rcar': driver_bound: bound to device 'e6052000=
=2Egpio'
[    0.638886] gpio_rcar e6052000.gpio: pm_clk_notify() 5
[    0.638903] bus: 'platform': really_probe: bound device e6052000.gpio to=
 driver gpio_rcar
[    0.638943] bus: 'platform': driver_probe_device: matched device e605300=
0.gpio with driver gpio_rcar
[    0.638960] bus: 'platform': really_probe: probing driver gpio_rcar with=
 device e6053000.gpio
[    0.639011] gpio_rcar e6053000.gpio: pm_clk_notify() 4
[    0.639081] gpio_rcar e6053000.gpio: Runtime PM disabled, clock forced o=
n.
[    0.640415] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    0.640431] driver: 'gpio_rcar': driver_bound: bound to device 'e6053000=
=2Egpio'
[    0.640457] gpio_rcar e6053000.gpio: pm_clk_notify() 5
[    0.640475] bus: 'platform': really_probe: bound device e6053000.gpio to=
 driver gpio_rcar
[    0.640514] bus: 'platform': driver_probe_device: matched device e605400=
0.gpio with driver gpio_rcar
[    0.640532] bus: 'platform': really_probe: probing driver gpio_rcar with=
 device e6054000.gpio
[    0.640584] gpio_rcar e6054000.gpio: pm_clk_notify() 4
[    0.640653] gpio_rcar e6054000.gpio: Runtime PM disabled, clock forced o=
n.
[    0.641992] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    0.642008] driver: 'gpio_rcar': driver_bound: bound to device 'e6054000=
=2Egpio'
[    0.642034] gpio_rcar e6054000.gpio: pm_clk_notify() 5
[    0.642052] bus: 'platform': really_probe: bound device e6054000.gpio to=
 driver gpio_rcar
[    0.642091] bus: 'platform': driver_probe_device: matched device e605500=
0.gpio with driver gpio_rcar
[    0.642109] bus: 'platform': really_probe: probing driver gpio_rcar with=
 device e6055000.gpio
[    0.642161] gpio_rcar e6055000.gpio: pm_clk_notify() 4
[    0.642230] gpio_rcar e6055000.gpio: Runtime PM disabled, clock forced o=
n.
[    0.643566] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    0.643581] driver: 'gpio_rcar': driver_bound: bound to device 'e6055000=
=2Egpio'
[    0.643608] gpio_rcar e6055000.gpio: pm_clk_notify() 5
[    0.643625] bus: 'platform': really_probe: bound device e6055000.gpio to=
 driver gpio_rcar
[    0.644282] bus: 'platform': add driver shdma-of
[    0.644724] bus: 'platform': add driver sh-dma-engine
[    0.645234] bus: 'platform': remove driver sh-dma-engine
[    0.645296] driver: 'sh-dma-engine': driver_release
[    0.645327] bus: 'i2c': add driver da9210
[    0.645389] bus: 'i2c': driver_probe_device: matched device 7-0068 with =
driver da9210
[    0.645406] bus: 'i2c': really_probe: probing driver da9210 with device =
7-0068
[    0.645517] da9210 7-0068: probe
[    0.645938] i2c i2c-7: master_xfer[0] W, addr=3D0x68, len=3D2
[    0.647496] i2c i2c-7: master_xfer[0] W, addr=3D0x68, len=3D2
[    0.647978] device: 'regulator.2': device_add
[    0.648282] i2c i2c-7: master_xfer[0] W, addr=3D0x68, len=3D1
[    0.648304] i2c i2c-7: master_xfer[1] R, addr=3D0x68, len=3D1
[    0.649311] i2c i2c-7: master_xfer[0] W, addr=3D0x68, len=3D1
[    0.649333] i2c i2c-7: master_xfer[1] R, addr=3D0x68, len=3D1
[    0.649986] i2c i2c-7: master_xfer[0] W, addr=3D0x68, len=3D1
[    0.650008] i2c i2c-7: master_xfer[1] R, addr=3D0x68, len=3D1
[    0.650665] i2c i2c-7: master_xfer[0] W, addr=3D0x68, len=3D1
[    0.650687] i2c i2c-7: master_xfer[1] R, addr=3D0x68, len=3D1
[    0.651496] driver: 'da9210': driver_bound: bound to device '7-0068'
[    0.651518] bus: 'i2c': really_probe: bound device 7-0068 to driver da92=
10
[    0.651628] i2c-core: driver [da9210] registered
[    0.651718] device: 'ptmx': device_add
[    0.652144] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.652236] Registering platform device 'serial8250'. Parent at platform
[    0.652253] device: 'serial8250': device_add
[    0.652311] bus: 'platform': add device serial8250
[    0.652418] platform serial8250: pm_clk_notify() 1
[    0.652634] device: 'ttyS0': device_add
[    0.653818] device: 'ttyS1': device_add
[    0.654661] device: 'ttyS2': device_add
[    0.655472] device: 'ttyS3': device_add
[    0.656893] bus: 'platform': add driver serial8250
[    0.657054] bus: 'platform': driver_probe_device: matched device serial8=
250 with driver serial8250
[    0.657071] bus: 'platform': really_probe: probing driver serial8250 wit=
h device serial8250
[    0.657115] serial8250 serial8250: pm_clk_notify() 4
[    0.657199] driver: 'serial8250': driver_bound: bound to device 'serial8=
250'
[    0.657226] serial8250 serial8250: pm_clk_notify() 5
[    0.657243] bus: 'platform': really_probe: bound device serial8250 to dr=
iver serial8250
[    0.657369] bus: 'platform': add driver serial8250-em
[    0.657804] SuperH (H)SCI(F) driver initialized
[    0.658040] bus: 'platform': add driver sh-sci
[    0.658337] bus: 'platform': driver_probe_device: matched device e6c4000=
0.serial with driver sh-sci
[    0.658354] bus: 'platform': really_probe: probing driver sh-sci with de=
vice e6c40000.serial
[    0.659023] sh-sci e6c40000.serial: pm_clk_notify() 4
[    0.659097] sh-sci e6c40000.serial: Runtime PM disabled, clock forced on.
[    0.659456] e6c40000.serial: ttySC0 at MMIO 0xe6c40000 (irq =3D 100, bas=
e_baud =3D 0) is a scifa
[    3.939664] console [ttySC0] enabled
[    3.943250] device: 'ttySC0': device_add
[    3.949740] driver: 'sh-sci': driver_bound: bound to device 'e6c40000.se=
rial'
[    3.956855] sh-sci e6c40000.serial: pm_clk_notify() 5
[    3.961875] bus: 'platform': really_probe: bound device e6c40000.serial =
to driver sh-sci
[    3.969945] bus: 'platform': driver_probe_device: matched device e6c5000=
0.serial with driver sh-sci
[    3.978943] bus: 'platform': really_probe: probing driver sh-sci with de=
vice e6c50000.serial
[    3.987979] sh-sci e6c50000.serial: pm_clk_notify() 4
[    3.993053] sh-sci e6c50000.serial: Runtime PM disabled, clock forced on.
[    4.000116] e6c50000.serial: ttySC1 at MMIO 0xe6c50000 (irq =3D 101, bas=
e_baud =3D 0) is a scifa
[    4.008560] device: 'ttySC1': device_add
[    4.013505] driver: 'sh-sci': driver_bound: bound to device 'e6c50000.se=
rial'
[    4.020617] sh-sci e6c50000.serial: pm_clk_notify() 5
[    4.025652] bus: 'platform': really_probe: bound device e6c50000.serial =
to driver sh-sci
[    4.034237] bus: 'i2c': add driver at24
[    4.038173] i2c-core: driver [at24] registered
[    4.042613] bus: 'i2c': add driver da9063
[    4.046738] i2c-core: driver [da9063] registered
[    4.051379] bus: 'platform': add driver sh-eth
[    4.056297] bus: 'platform': driver_probe_device: matched device ee70000=
0.ethernet with driver sh-eth
[    4.065468] bus: 'platform': really_probe: probing driver sh-eth with de=
vice ee700000.ethernet
[    4.075389] sh-eth ee700000.ethernet: pm_clk_notify() 4
[    4.080636] sh-eth ee700000.ethernet: Runtime PM disabled, clock forced =
on.
[    4.087790] device: 'ee700000.etherne': device_add
[    4.092867] libphy: sh_mii: probed
[    4.096972] device: 'ee700000.etherne:01': device_add
[    4.102040] bus: 'mdio_bus': add device ee700000.etherne:01
[    4.107851] device: 'eth0': device_add
[    4.113709] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2=
e:09:0a:00:6e:2e, IRQ 102.
[    4.122622] driver: 'sh-eth': driver_bound: bound to device 'ee700000.et=
hernet'
[    4.129907] sh-eth ee700000.ethernet: pm_clk_notify() 5
[    4.135113] bus: 'platform': really_probe: bound device ee700000.etherne=
t to driver sh-eth
[    4.143972] device: 'mice': device_add
[    4.150713] mousedev: PS/2 mouse device common for all mice
[    4.156276] bus: 'serio': add driver atkbd
[    4.160607] bus: 'i2c': add driver st1232-ts
[    4.164994] i2c-core: driver [st1232-ts] registered
[    4.169866] bus: 'platform': add driver i2c-riic
[    4.174894] bus: 'platform': add driver i2c-rcar
[    4.180397] bus: 'platform': add driver i2c-demux-pinctrl
[    4.186082] bus: 'platform': driver_probe_device: matched device i2cbus@=
8 with driver i2c-demux-pinctrl
[    4.195425] bus: 'platform': really_probe: probing driver i2c-demux-pinc=
trl with device i2cbus@8
[    4.204200] i2c-demux-pinctrl i2cbus@8: pm_clk_notify() 4
[    4.209674] of_changeset: applying...
[    4.213317] of/cset<eeb4e840> UPDATE_PROPERTY /i2c@e6520000/status
[    4.219622] of_changeset: applied, emitting notifiers.
[    4.224744] of/notify UPDATE_PROPERTY /i2c@e6520000:status
[    4.230707] device: 'e6520000.i2c': device_add
[    4.235244] bus: 'platform': add device e6520000.i2c
[    4.240309] platform e6520000.i2c: pm_clk_notify() 1
[    4.245445] bus: 'platform': driver_probe_device: matched device e652000=
0.i2c with driver i2c-sh_mobile
[    4.254788] bus: 'platform': really_probe: probing driver i2c-sh_mobile =
with device e6520000.i2c
[    4.263719] i2c-sh_mobile e6520000.i2c: pm_clk_notify() 4
[    4.269174] i2c-sh_mobile e6520000.i2c: Runtime PM disabled, clock force=
d on.
[    4.276660] device: 'i2c-6': device_add
[    4.280607] bus: 'i2c': add device i2c-6
[    4.284690] i2c i2c-6: adapter [e6520000.i2c] registered
[    4.290029] i2c i2c-6: of_i2c: walking child nodes
[    4.294839] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 =
Hz
[    4.301668] driver: 'i2c-sh_mobile': driver_bound: bound to device 'e652=
0000.i2c'
[    4.309131] i2c-sh_mobile e6520000.i2c: pm_clk_notify() 5
[    4.314511] bus: 'platform': really_probe: bound device e6520000.i2c to =
driver i2c-sh_mobile
[    4.322934] of_changeset: notifiers sent.
[    4.327483] device: 'i2c-8': device_add
[    4.331408] bus: 'i2c': add device i2c-8
[    4.335441] i2c i2c-8: adapter [i2c-6-mux (chan_id 0)] registered
[    4.341545] i2c i2c-8: of_i2c: walking child nodes
[    4.346328] i2c i2c-8: of_i2c: register /i2cbus@8/i2c8@0/sound-codec@12
[    4.352929] device: '8-0012': device_add
[    4.356932] bus: 'i2c': add device 8-0012
[    4.361011] i2c 8-0012: uevent
[    4.364115] i2c i2c-8: client [ak4643] registered with bus id 8-0012
[    4.370435] i2c i2c-8: of_i2c: register /i2cbus@8/i2c8@0/composite-in@20
[    4.377134] device: '8-0020': device_add
[    4.381124] bus: 'i2c': add device 8-0020
[    4.385204] i2c 8-0020: uevent
[    4.388292] i2c i2c-8: client [adv7180] registered with bus id 8-0020
[    4.394777] i2c i2c-6: Added multiplexed i2c bus 8
[    4.399561] driver: 'i2c-demux-pinctrl': driver_bound: bound to device '=
i2cbus@8'
[    4.407018] i2c-demux-pinctrl i2cbus@8: pm_clk_notify() 5
[    4.412383] bus: 'platform': really_probe: bound device i2cbus@8 to driv=
er i2c-demux-pinctrl
[    4.420897] bus: 'platform': add driver i2c-mux-gpio
[    4.426261] bus: 'i2c': add driver i2c-slave-eeprom
[    4.431252] i2c-core: driver [i2c-slave-eeprom] registered
[    4.436747] bus: 'i2c': add driver adv7180
[    4.440869] bus: 'i2c': driver_probe_device: matched device 8-0020 with =
driver adv7180
[    4.448746] bus: 'i2c': really_probe: probing driver adv7180 with device=
 8-0020
[    4.456108] adv7180 8-0020: probe
[    4.459412] adv7180 8-0020: chip found @ 0x20 (i2c-6-mux (chan_id 0))
[    4.466015] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.475297] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.481033] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.486776] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.492509] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.498256] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.503983] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.509714] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.515457] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.521194] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.526937] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.543983] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.549710] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.555449] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D2
[    4.561176] i2c i2c-8: master_xfer[0] W, addr=3D0x20, len=3D1
[    4.566560] i2c i2c-8: master_xfer[1] R, addr=3D0x20, len=3D1
[    4.572477] driver: 'adv7180': driver_bound: bound to device '8-0020'
[    4.578895] bus: 'i2c': really_probe: bound device 8-0020 to driver adv7=
180
[    4.585921] i2c-core: driver [adv7180] registered
[    4.590631] bus: 'platform': add driver rcar_thermal
[    4.595664] bus: 'platform': driver_probe_device: matched device e61f000=
0.thermal with driver rcar_thermal
[    4.605266] bus: 'platform': really_probe: probing driver rcar_thermal w=
ith device e61f0000.thermal
[    4.614301] rcar_thermal e61f0000.thermal: pm_clk_notify() 4
[    4.619982] rcar_thermal e61f0000.thermal: Runtime PM disabled, clock fo=
rced on.
[    4.628174] device: 'thermal_zone0': device_add
[    4.633221] rcar_thermal e61f0000.thermal: 1 sensor probed
[    4.638685] driver: 'rcar_thermal': driver_bound: bound to device 'e61f0=
000.thermal'
[    4.646400] rcar_thermal e61f0000.thermal: pm_clk_notify() 5
[    4.652024] bus: 'platform': really_probe: bound device e61f0000.thermal=
 to driver rcar_thermal
[    4.661037] bus: 'platform': add driver da9063-watchdog
[    4.666653] bus: 'hid': registered
[    4.670192] device: 'timer': device_add
[    4.676483] Registering platform device 'snd-soc-dummy'. Parent at platf=
orm
[    4.683398] device: 'snd-soc-dummy': device_add
[    4.687959] bus: 'platform': add device snd-soc-dummy
[    4.693071] platform snd-soc-dummy: pm_clk_notify() 1
[    4.698201] bus: 'platform': add driver snd-soc-dummy
[    4.703368] bus: 'platform': driver_probe_device: matched device snd-soc=
-dummy with driver snd-soc-dummy
[    4.712797] bus: 'platform': really_probe: probing driver snd-soc-dummy =
with device snd-soc-dummy
[    4.721650] snd-soc-dummy snd-soc-dummy: pm_clk_notify() 4
[    4.727268] driver: 'snd-soc-dummy': driver_bound: bound to device 'snd-=
soc-dummy'
[    4.734812] snd-soc-dummy snd-soc-dummy: pm_clk_notify() 5
[    4.740264] bus: 'platform': really_probe: bound device snd-soc-dummy to=
 driver snd-soc-dummy
[    4.748842] bus: 'platform': add driver soc-audio
[    4.753761] bus: 'i2c': add driver ak4642-codec
[    4.758339] bus: 'i2c': driver_probe_device: matched device 8-0012 with =
driver ak4642-codec
[    4.766648] bus: 'i2c': really_probe: probing driver ak4642-codec with d=
evice 8-0012
[    4.774442] ak4642-codec 8-0012: probe
[    4.778407] driver: 'ak4642-codec': driver_bound: bound to device '8-001=
2'
[    4.785256] bus: 'i2c': really_probe: bound device 8-0012 to driver ak46=
42-codec
[    4.792702] i2c-core: driver [ak4642-codec] registered
[    4.798235] TCP: cubic registered
[    4.801853] device: 'cpu_dma_latency': device_add
[    4.808670] device: 'network_latency': device_add
[    4.814014] device: 'network_throughput': device_add
[    4.819618] device: 'memory_bandwidth': device_add
[    4.825776] platform regulator@1: Retrying from deferred list
[    4.831523] bus: 'platform': driver_probe_device: matched device regulat=
or@1 with driver reg-fixed-voltage
[    4.841126] bus: 'platform': really_probe: probing driver reg-fixed-volt=
age with device regulator@1
[    4.850188] reg-fixed-voltage regulator@1: pm_clk_notify() 4
[    4.856132] device: 'regulator.3': device_add
[    4.861632] driver: 'reg-fixed-voltage': driver_bound: bound to device '=
regulator@1'
[    4.869382] reg-fixed-voltage regulator@1: pm_clk_notify() 5
[    4.875020] bus: 'platform': really_probe: bound device regulator@1 to d=
river reg-fixed-voltage
[    4.883688] platform regulator@3: Retrying from deferred list
[    4.889441] bus: 'platform': driver_probe_device: matched device regulat=
or@3 with driver reg-fixed-voltage
[    4.899043] bus: 'platform': really_probe: probing driver reg-fixed-volt=
age with device regulator@3
[    4.908084] reg-fixed-voltage regulator@3: pm_clk_notify() 4
[    4.913927] device: 'regulator.4': device_add
[    4.919012] driver: 'reg-fixed-voltage': driver_bound: bound to device '=
regulator@3'
[    4.926734] reg-fixed-voltage regulator@3: pm_clk_notify() 5
[    4.932359] bus: 'platform': really_probe: bound device regulator@3 to d=
river reg-fixed-voltage
[    4.941030] platform regulator@2: Retrying from deferred list
[    4.946791] bus: 'platform': driver_probe_device: matched device regulat=
or@2 with driver gpio-regulator
[    4.956134] bus: 'platform': really_probe: probing driver gpio-regulator=
 with device regulator@2
[    4.964915] gpio-regulator regulator@2: pm_clk_notify() 4
[    4.970654] device: 'regulator.5': device_add
[    4.975809] driver: 'gpio-regulator': driver_bound: bound to device 'reg=
ulator@2'
[    4.983259] gpio-regulator regulator@2: pm_clk_notify() 5
[    4.988638] bus: 'platform': really_probe: bound device regulator@2 to d=
river gpio-regulator
[    4.997051] platform regulator@4: Retrying from deferred list
[    5.002798] bus: 'platform': driver_probe_device: matched device regulat=
or@4 with driver gpio-regulator
[    5.012142] bus: 'platform': really_probe: probing driver gpio-regulator=
 with device regulator@4
[    5.020924] gpio-regulator regulator@4: pm_clk_notify() 4
[    5.026651] device: 'regulator.6': device_add
[    5.031687] driver: 'gpio-regulator': driver_bound: bound to device 'reg=
ulator@4'
[    5.039151] gpio-regulator regulator@4: pm_clk_notify() 5
[    5.044530] bus: 'platform': really_probe: bound device regulator@4 to d=
river gpio-regulator
[    5.054379] bus: 'platform': add driver gpio-keys
[    5.059318] bus: 'platform': driver_probe_device: matched device keyboar=
d with driver gpio-keys
[    5.067972] bus: 'platform': really_probe: probing driver gpio-keys with=
 device keyboard
[    5.076056] gpio-keys keyboard: pm_clk_notify() 4
[    5.081623] device: 'input0': device_add
[    5.086295] input: keyboard as /devices/platform/keyboard/input/input0
[    5.092953] driver: 'gpio-keys': driver_bound: bound to device 'keyboard'
[    5.099729] gpio-keys keyboard: pm_clk_notify() 5
[    5.104419] bus: 'platform': really_probe: bound device keyboard to driv=
er gpio-keys
[    5.112285] of_changeset: applying...
[    5.115941] of/cset<ee940440> UPDATE_PROPERTY /i2c@e60b0000/status
[    5.122157] of_changeset: applied, emitting notifiers.
[    5.127278] of/notify UPDATE_PROPERTY /i2c@e60b0000:status
[    5.132779] i2c-sh_mobile e60b0000.i2c: pm_clk_notify() 2
[    5.138469] bus: 'platform': remove device e60b0000.i2c
[    5.143728] i2c-sh_mobile e60b0000.i2c: pm_clk_notify() 6
[    5.149197] device: '7-0068': device_unregister
[    5.153977] bus: 'i2c': remove device 7-0068
[    5.158660] device: 'regulator.2': device_unregister
[    5.165811] i2c 7-0068: uevent
[    5.168980] i2c i2c-7: adapter [e60b0000.i2c] unregistered
[    5.174446] device: 'i2c-7': device_unregister
[    5.179041] bus: 'i2c': remove device i2c-7
[    5.183555] platform e60b0000.i2c: pm_clk_notify() 7
[    5.188581] platform e60b0000.i2c: Runtime PM disabled, clock forced off.
[    5.195353] platform e60b0000.i2c: pm_clk_notify() 3
[    5.200414] Unable to handle kernel NULL pointer dereference at virtual =
address 00000018
[    5.208461] pgd =3D c0004000
[    5.211151] [00000018] *pgd=3D00000000
[    5.214732] Internal error: Oops: 5 [#1] ARM
[    5.218983] CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.0.0-=
rc4-00009-gcb55587ebc4047 #90
[    5.228136] Hardware name: Generic R8A7790 (Flattened Device Tree)
[    5.234275] task: ee84d340 ti: ee84e000 task.ti: ee84e000
[    5.239643] PC is at release_resource+0x20/0x68
[    5.244157] LR is at _raw_write_lock+0x3c/0x44
[    5.248577] pc : [<c002417c>]    lr : [<c025f0e0>]    psr: a0000113
[    5.248577] sp : ee84fcd8  ip : ee84fcb0  fp : ee84fcec
[    5.259975] r10: 00000000  r9 : c03de2c0  r8 : c03d5694
[    5.265166] r7 : ee84fdf4  r6 : 0000001c  r5 : 00000000  r4 : ee8efd00
[    5.271650] r3 : 00000000  r2 : 00000018  r1 : 00000009  r0 : c03c7cd8
[    5.278136] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[    5.285395] Control: 10c5347d  Table: 40004059  DAC: 00000015
[    5.291102] Process swapper (pid: 1, stack limit =3D 0xee84e208)
[    5.296896] Stack: (0xee84fcd8 to 0xee850000)
[    5.301228] fcc0:                                                       =
00000000 ee8f3e00
[    5.309359] fce0: ee84fd0c ee84fcf0 c01604fc c0024168 c03d39a0 ee8f3e00 =
00000000 00000005
[    5.317491] fd00: ee84fd24 ee84fd10 c016054c c0160494 c03d39a0 ee8f3e10 =
ee84fd3c ee84fd28
[    5.325624] fd20: c01aad54 c0160544 ee8f3e34 ee8f3e00 ee84fd64 ee84fd40 =
c01ab3f8 c01aad08
[    5.333755] fd40: 00000000 00000000 c0b9ba86 ffffffff 00000000 00000005 =
ee84fd8c ee84fd68
[    5.341887] fd60: c00389b0 c01ab338 ffffffff c03d7b98 c03d7ba4 ffffffff =
ee84fdf4 00000005
[    5.350018] fd80: ee84fdbc ee84fd90 c0038c78 c0038974 00000000 c004eed4 =
c0311ab7 ee84fdf4
[    5.358150] fda0: 00000005 ee84fe88 c0340d2c c0340d2c ee84fdd4 ee84fdc0 =
c0038cb0 c0038c38
[    5.366282] fdc0: 00000000 c0259a44 ee84fdec ee84fdd8 c01ab868 c0038c9c =
ee940440 ee84fe88
[    5.374414] fde0: ee84fe0c ee84fdf0 c01aba70 c01ab7ec 00000001 eefd18b8 =
ee84fe90 eefd1b1c
[    5.382546] fe00: ee84fe4c ee84fe10 c01abafc c01aba38 ee84fe3c ee84fe20 =
c025d420 c0046dc0
[    5.390678] fe20: 00000000 ee84fe88 ee84fe88 c0340d2c ee84fe4c ee84fe40 =
c025d454 ee940440
[    5.398810] fe40: ee84fe84 ee84fe50 c01ac408 c01aba84 ee84fe84 ee84fe60 =
c01ac5b4 eefd18b8
[    5.406941] fe60: c03356c0 00000000 c0340d2c eefd18b8 c03356c0 00000000 =
ee84fee4 ee84fe88
[    5.415073] fe80: c0335744 c01ac370 ee940440 ee940440 c02fc41b 00000009 =
c0300520 eefd1b5c
[    5.423203] fea0: 00000000 00000000 c02fc41b 00000124 c0baab34 00000000 =
00000000 00000009
[    5.431334] fec0: 00000000 c01a848c 00000000 00000000 00000000 ee940440 =
ee84ff5c ee84fee8
[    5.439466] fee0: c0321dd8 c03356cc ee84ff0c ee84fef8 c025ed5c c0046dc0 =
ee84ff00 ee84ff08
[    5.447599] ff00: c0321604 c010ae7c ef7fcce4 ef7fcce1 ee84ff5c ee84ff20 =
c0037790 c03215f4
[    5.455728] ff20: 00000043 00000007 00000007 00000044 ee84ff5c 00000007 =
00000007 00000044
[    5.463860] ff40: c034155c c034789c c03de2c0 c03de2c0 ee84ff94 ee84ff60 =
c0321f88 c0321cdc
[    5.471990] ff60: 00000007 00000007 c03215e8 00000000 c03de2c0 c0257c94 =
00000000 00000000
[    5.480121] ff80: 00000000 00000000 ee84ffac ee84ff98 c0257ca8 c0321e98 =
00000000 00000000
[    5.488251] ffa0: 00000000 ee84ffb0 c000e8f0 c0257ca0 00000000 00000000 =
00000000 00000000
[    5.496381] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    5.504512] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
0bbb5628 10468c41
[    5.512628] Backtrace:=20
[    5.515081] [<c002415c>] (release_resource) from [<c01604fc>] (platform_=
device_del+0x74/0x84)
[    5.523543]  r4:ee8f3e00 r3:00000000
[    5.527129] [<c0160488>] (platform_device_del) from [<c016054c>] (platfo=
rm_device_unregister+0x14/0x20)
[    5.536453]  r6:00000005 r5:00000000 r4:ee8f3e00 r3:c03d39a0
[    5.542138] [<c0160538>] (platform_device_unregister) from [<c01aad54>] =
(of_platform_device_destroy+0x58/0xa8)
[    5.552066]  r4:ee8f3e10 r3:c03d39a0
[    5.555652] [<c01aacfc>] (of_platform_device_destroy) from [<c01ab3f8>] =
(of_platform_notify+0xcc/0xe8)
[    5.564891]  r4:ee8f3e00 r3:ee8f3e34
[    5.568479] [<c01ab32c>] (of_platform_notify) from [<c00389b0>] (notifie=
r_call_chain+0x48/0x70)
[    5.577114]  r6:00000005 r5:00000000 r4:ffffffff
[    5.581746] [<c0038968>] (notifier_call_chain) from [<c0038c78>] (__bloc=
king_notifier_call_chain+0x4c/0x64)
[    5.591416]  r8:00000005 r7:ee84fdf4 r6:ffffffff r5:c03d7ba4 r4:c03d7b98=
 r3:ffffffff
[    5.599180] [<c0038c2c>] (__blocking_notifier_call_chain) from [<c0038cb=
0>] (blocking_notifier_call_chain+0x20/0x28)
[    5.609625]  r8:c0340d2c r7:c0340d2c r6:ee84fe88 r5:00000005 r4:ee84fdf4
[    5.616352] [<c0038c90>] (blocking_notifier_call_chain) from [<c01ab868>=
] (of_reconfig_notify+0x88/0xa8)
[    5.625776] [<c01ab7e0>] (of_reconfig_notify) from [<c01aba70>] (of_prop=
erty_notify+0x44/0x4c)
[    5.634325]  r5:ee84fe88 r4:ee940440
[    5.637912] [<c01aba2c>] (of_property_notify) from [<c01abafc>] (__of_ch=
angeset_entry_notify+0x84/0xc4)
[    5.647251] [<c01aba78>] (__of_changeset_entry_notify) from [<c01ac408>]=
 (of_changeset_apply+0xa4/0xe4)
[    5.656575]  r4:ee940440
[    5.659114] [<c01ac364>] (of_changeset_apply) from [<c0335744>] (test_in=
it+0x84/0xa8)
[    5.666887]  r6:00000000 r5:c03356c0 r4:eefd18b8
[    5.671520] [<c03356c0>] (test_init) from [<c0321dd8>] (do_one_initcall+=
0x108/0x1bc)
[    5.679208]  r4:ee940440
[    5.681746] [<c0321cd0>] (do_one_initcall) from [<c0321f88>] (kernel_ini=
t_freeable+0xfc/0x1bc)
[    5.690296]  r9:c03de2c0 r8:c03de2c0 r7:c034789c r6:c034155c r5:00000044=
 r4:00000007
[    5.698060] [<c0321e8c>] (kernel_init_freeable) from [<c0257ca8>] (kerne=
l_init+0x14/0xec)
[    5.706178]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0257c94=
 r4:c03de2c0
[    5.713942] [<c0257c94>] (kernel_init) from [<c000e8f0>] (ret_from_fork+=
0x14/0x24)
[    5.721457]  r4:00000000 r3:00000000
[    5.725040] Code: e59f004c eb08ebcb e5943010 e2832018 (e5933018)=20
[    5.731118] ---[ end trace cb88537fdc8fa202 ]---
[    5.735735] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[    5.735735]=20
[    5.744812] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x0000000b
[    5.744812]=20

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLRWtAAoJEBQN5MwUoCm2b0AP+gJ7kg0pBqCvY2UYsLXZNEaE
1NpWwWZwFg6SirdAhTBsGa38qlfvs9LYr88VVai80ugWVSvuMZ3gq0706Wao/3qy
I+t5XFQGg8QRLW0EDmMP25OrXDAY8I26efM7P2dYwGRNAqPenyyRSbXOo+Bx8KdQ
LQfKVRsfC2WZd/le8Inu3aLtMcZTvb4RLrVmetKfVjCQE9MppaXXTeg4mLxv0p9D
1vJ+GhBW34Q8iZ39X0z1b56cP4xuMJZA3IChqk8lATzj0Hq3yrdQiPUl0ctM6Acr
n/rRltf5jMSNSEubfcoiGgiVTOz9lg7LFQZz1NPBehxt4rleRHQTUB9dEKBOX9iv
aTdm81eiskK5M/qB+w03dOBYL+XVtZQLIQ9VOZJ35Drm/qc8kReDAN608d+X6Q2i
oKPAEj1bMAQtG9qppmE6BVOL/wnO7zmsTN2XFIbMvwKDgyHK2p1xPKQ1ZNk39CPH
g9n6WtpTQGXu5NCicrWMD6t6c/uDDcIjX1aufVE44GsknSkSX2D0xVYF6WvGNYF4
hSysEiZhVm7VUCzkOwlhTR5E5nby+QBeDzwQ3blBDJ2Gbdsr8kPKy/u5hiMXEAn7
XtYtwyhaUPAtjVYB6dHsI76qxJx9BgsZ8MmO78hBQX+MgHU6VdPBtnx56se5owjh
KutfCzKjjS0bSGNsjGi6
=WFOC
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
