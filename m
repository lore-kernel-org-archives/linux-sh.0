From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 23 Oct 2015 10:28:13 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <36149610.Eic43bQLgJ@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart16071886.cADEmOvcnA"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de> <2048622.tkxROUAu7P@avalon> <20151023094500.GD13380@katana>
In-Reply-To: <20151023094500.GD13380@katana>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This is a multi-part message in MIME format.

--nextPart16071886.cADEmOvcnA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Friday 23 October 2015 11:45:00 Wolfram Sang wrote:
> > I had CONFIG_DRM_FBDEV_EMULATION disabled. I've then enabled it but also
> > merged git://people.freedesktop.org/~airlied/linux next in my branch,
> > which probably fixes the problem.
> 
> So, your tree is not strictly renesas-drivers-2015-10-13-v4.3-rc5?

I've tested it on renesas-drivers-2015-10-13-v4.3-rc5 without 
CONFIG_DRM_FBDEV_EMULATION, explaining why it compiled properly for me.

> >> I fixed it locally and will see if I see ADV7511 problems. I cannot
> >> fully test HDMI probably, because it seems that this HDMI->DVI chain I
> >> have does not work.
> > 
> > It's supposed to be supported, so that might be something we need to fix.
> > More work for me \o/ :-)
>
> :/ Let me know if I can send you debug output.

What's the exact issue ?

> >> Okay, so before any 'modetest' activity. Which kernelconfig?
> >> shmobile_defconfig?
> > 
> > .config attached.
> 
> That one also probes for me... I only disabled DHCP and added my initramfs.
> I patched the fbdev build error out and changed Lager dts to use i2c-rcar
> (instead of i2c-sh_mobile).
> 
> Can you enable CONFIG_I2C_DEBUG_CORE in the config, apply this patch,
> and send me the trace output and bootlog?

Please find both attached to this e-mail.

-- 
Regards,

Laurent Pinchart

--nextPart16071886.cADEmOvcnA
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="dmesg.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.3.0-rc5-04061-gb9653e9c000d-dirty (laurent@avalon) (gcc version 4.7.3 20130205 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - Linaro GCC 2013.02) ) #89 SMP Fri Oct 23 13:16:05 EEST 2015
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Koelsch
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 256 MiB at 0x0000000070000000
[    0.000000] cma: Reserved 64 MiB at 0x000000006c000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c0678ec0, node_mem_map e7fd8000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 327680 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @e7f90000 s17920 r8192 d23040 u49152
[    0.000000] pcpu-alloc: s17920 r8192 d23040 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1742976K/2097152K available (4276K kernel code, 304K rwdata, 1652K rodata, 392K init, 2183K bss, 26496K reserved, 327680K cma-reserved, 1048576K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05d3034   (5933 kB)
[    0.000000]       .init : 0xc05d4000 - 0xc0636000   ( 392 kB)
[    0.000000]       .data : 0xc0636000 - 0xc0682364   ( 305 kB)
[    0.000000]        .bss : 0xc0685000 - 0xc08a6c9c   (2184 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] 
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** trace_printk() being used. Allocating extra memory.  **
[    0.000000] **                                                      **
[    0.000000] ** This means that this is a DEBUG kernel and it is     **
[    0.000000] ** unsafe for production use.                           **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your vendor!  **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000004] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.000013] Switching to timer-based delay loop, resolution 100ns
[    0.000577] Console: colour dummy device 80x30
[    0.001368] console [tty0] enabled
[    0.001393] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.001428] pid_max: default: 32768 minimum: 301
[    0.001555] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001579] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002056] CPU: Testing write buffer coherency: ok
[    0.002101] ftrace: allocating 17139 entries in 51 pages
[    0.023381] CPU0: update cpu_capacity 1024
[    0.023406] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.023514] Setting up static identity map for 0x40009000 - 0x40009058
[    0.026491] CPU1: update cpu_capacity 1024
[    0.026497] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.026587] Brought up 2 CPUs
[    0.026634] SMP: Total of 2 processors activated (40.00 BogoMIPS).
[    0.026649] CPU: All CPU(s) started in SVC mode.
[    0.027063] devtmpfs: initialized
[    0.037663] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.038068] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.043595] pinctrl core: initialized pinctrl subsystem
[    0.044658] NET: Registered protocol family 16
[    0.045575] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.046309] i2c-core: driver [dummy] registered
[    0.073298] cpuidle: using governor ladder
[    0.103278] cpuidle: using governor menu
[    0.106195] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    0.109271] sh-pfc e6060000.pfc: r8a77910_pfc support registered
[    0.114337] No ATAGs?
[    0.144424] i2c-core: driver [pcf857x] registered
[    0.145185] gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
[    0.145287] gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
[    0.145382] gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
[    0.145845] i2c-core: driver [as3711] registered
[    0.146152] usbcore: registered new interface driver usbfs
[    0.146233] usbcore: registered new interface driver hub
[    0.146301] usbcore: registered new device driver usb
[    0.146389] i2c-core: driver [tca6416-keypad] registered
[    0.146984] i2c i2c-6: adapter [e60b0000.i2c] registered
[    0.147035] i2c i2c-6: of_i2c: walking child nodes
[    0.147054] i2c i2c-6: of_i2c: register /i2c@e60b0000/pmic@58
[    0.147153] i2c 6-0058: uevent
[    0.147192] i2c i2c-6: client [da9063] registered with bus id 6-0058
[    0.147213] i2c i2c-6: of_i2c: register /i2c@e60b0000/regulator@68
[    0.147314] i2c 6-0068: uevent
[    0.147351] i2c i2c-6: client [da9210] registered with bus id 6-0068
[    0.147376] i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
[    0.147571] media: Linux media interface: v0.10
[    0.147638] Linux video capture interface: v2.00
[    0.147887] sh_cmt ffca0000.timer: ch0: used for clock events
[    0.147913] sh_cmt ffca0000.timer: ch1: used as clock source
[    0.147933] clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
[    0.149128] clocksource: Switched to clocksource arch_sys_counter
[    0.177262] NET: Registered protocol family 2
[    0.177677] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.177747] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.177859] TCP: Hash tables configured (established 8192 bind 8192)
[    0.177912] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.177946] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.178101] NET: Registered protocol family 1
[    0.178380] RPC: Registered named UNIX socket transport module.
[    0.178399] RPC: Registered udp transport module.
[    0.178412] RPC: Registered tcp transport module.
[    0.178426] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.178457] PCI: CLS 0 bytes, default 64
[    0.179469] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.180889] bounce: pool size: 64 pages
[    0.180916] io scheduler noop registered (default)
[    0.181683] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    0.182136] gpio_rcar e6051000.gpio: driving 32 GPIOs
[    0.182570] gpio_rcar e6052000.gpio: driving 32 GPIOs
[    0.182993] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    0.183417] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    0.183851] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    0.184276] gpio_rcar e6055400.gpio: driving 32 GPIOs
[    0.184667] gpio_rcar e6055800.gpio: driving 26 GPIOs
[    0.185205] pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
[    0.185393] pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
[    0.185415] pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
[    0.185434] pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
[    0.185452] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.185503] pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
[    0.185537] pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
[    0.185559] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.185799] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    0.185840] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.185911] pci 0000:00:01.0: supports D1 D2
[    0.185928] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    0.186175] pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.186214] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.186284] pci 0000:00:02.0: supports D1 D2
[    0.186300] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    0.186549] PCI: bus0: Fast back to back transfers disabled
[    0.186570] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.186659] pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
[    0.186682] pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
[    0.186734] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    0.186786] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    0.187008] pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
[    0.187192] pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
[    0.187212] pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
[    0.187230] pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
[    0.187248] pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
[    0.187289] pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
[    0.187319] pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
[    0.187341] pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.187567] pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
[    0.187607] pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.187677] pci 0001:01:01.0: supports D1 D2
[    0.187692] pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
[    0.187929] pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.187968] pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.188038] pci 0001:01:02.0: supports D1 D2
[    0.188053] pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
[    0.188308] PCI: bus1: Fast back to back transfers disabled
[    0.188328] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    0.188457] pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
[    0.188481] pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
[    0.188521] pci 0001:01:01.0: enabling device (0140 -> 0142)
[    0.188567] pci 0001:01:02.0: enabling device (0140 -> 0142)
[    0.188913] da9210 6-0068: probe
[    0.189013] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.189477] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.189981] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.189999] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.190693] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.190713] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.191300] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.191318] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.191910] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.191927] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.192650] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.192668] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.193250] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.193715] i2c-core: driver [da9210] registered
[    0.193966] SuperH (H)SCI(F) driver initialized
[    0.194409] e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 109, base_baud = 0) is a scif
[    1.359745] console [ttySC0] enabled
[    1.363984] e6e68000.serial: ttySC1 at MMIO 0xe6e68000 (irq = 110, base_baud = 0) is a scif
[    1.373087] [drm] Initialized drm 1.1.0 20060810
[    1.379679] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.386449] [drm] No driver support for vblank timestamp query.
[    1.392887] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.400570] i2c-core: driver [adv7511] registered
[    1.406828] libphy: sh_mii: probed
[    1.411580] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:3d:cf, IRQ 111.
[    1.421232] i2c-core: driver [st1232-ts] registered
[    1.426264] i2c-core: driver [tsc2007] registered
[    1.431689] i2c i2c-2: adapter [e6530000.i2c] registered
[    1.437151] i2c i2c-2: of_i2c: walking child nodes
[    1.442063] i2c i2c-2: of_i2c: register /i2c@e6530000/codec@12
[    1.448109] i2c 2-0012: uevent
[    1.451276] i2c i2c-2: client [ak4643] registered with bus id 2-0012
[    1.457772] i2c i2c-2: of_i2c: register /i2c@e6530000/composite-in@20
[    1.464444] i2c 2-0020: uevent
[    1.467595] i2c i2c-2: client [adv7180] registered with bus id 2-0020
[    1.474192] i2c i2c-2: of_i2c: register /i2c@e6530000/hdmi@39
[    1.480147] i2c 2-0039: uevent
[    1.483340] adv7511 2-0039: probe
[    1.486902] i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
[    1.492434] i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
[    1.498600] i2c i2c-2: client [adv7511w] registered with bus id 2-0039
[    1.505330] i2c i2c-2: of_i2c: register /i2c@e6530000/eeprom@50
[    1.511482] i2c 2-0050: uevent
[    1.514634] i2c i2c-2: client [24c02] registered with bus id 2-0050
[    1.521059] i2c-rcar e6530000.i2c: probed
[    1.537018] usbcore: registered new interface driver usbhid
[    1.542752] usbhid: USB HID core driver
[    1.546862] NET: Registered protocol family 17
[    1.551497] Registering SWP/SWPB emulation handler
[    1.560158] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.566926] [drm] No driver support for vblank timestamp query.
[    1.573481] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.582699] input: keyboard as /devices/platform/keyboard/input/input0
[    1.589873] hctosys: unable to open rtc device (rtc0)
[    1.599600] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.606392] [drm] No driver support for vblank timestamp query.
[    1.612857] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.680906] sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 379) to driver Micrel KSZ8041RNLI
[    1.709097] Sending DHCP requests ..
[    4.588282] sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[    9.129088] ., OK
[    9.179093] IP-Config: Got DHCP answer from 192.168.1.47, my address is 192.168.1.254
[    9.187195] IP-Config: Complete:
[    9.190522]      device=eth0, hwaddr=2e:09:0a:00:3d:cf, ipaddr=192.168.1.254, mask=255.255.255.0, gw=255.255.255.255
[    9.201292]      host=192.168.1.254, domain=, nis-domain=(none)
[    9.207342]      bootserver=192.168.1.47, rootserver=192.168.1.47, rootpath=/home/laurent/src/iob/netboot/renesas
[    9.217661]      nameserver0=192.168.1.47
[    9.221998] SDHI0 Vcc: disabling
[    9.225299] SDHI1 Vcc: disabling
[    9.228600] SDHI2 Vcc: disabling
[    9.231915] SDHI0 VccQ: disabling
[    9.235304] SDHI1 VccQ: disabling
[    9.238692] SDHI2 VccQ: disabling
[    9.242601] sh-sci e6e60000.serial: dma_request_slave_channel_compat failed
[    9.249752] sh-sci e6e60000.serial: dma_request_slave_channel_compat failed
[    9.263442] VFS: Mounted root (nfs filesystem) on device 0:14.
[    9.271700] devtmpfs: mounted
[    9.274933] Freeing unused kernel memory: 392K (c05d4000 - c0636000)
[    9.784147] udevd[540]: starting version 1.9
[    9.819179] random: udevd urandom read with 34 bits of entropy available
[    9.838134] udevd[540]: specified group 'input' unknown
[    9.847353] i2c 6-0058: uevent
[    9.850737] da9210 6-0068: uevent
[    9.854513] i2c 2-0012: uevent
[    9.857732] i2c 2-0020: uevent
[    9.861119] i2c 2-0039: uevent
[    9.864402] i2c 2-0050: uevent
[    9.918259] rcar_thermal e61f0000.thermal: 1 sensor probed
[    9.925377] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.932228] [drm] No driver support for vblank timestamp query.
[    9.934784] i2c 2-0012: uevent
[    9.935000] i2c 2-0012: uevent
[    9.935467] i2c 2-0020: uevent
[    9.935654] i2c 2-0020: uevent
[    9.936118] i2c 2-0039: uevent
[    9.936306] i2c 2-0039: uevent
[    9.936523] i2c 2-0039: uevent
[    9.936915] i2c 2-0050: uevent
[    9.937079] i2c 2-0050: uevent
[    9.937276] i2c 2-0050: uevent
[    9.970858] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    9.985833] adv7180 2-0020: probe
[    9.989288] adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
[    9.993695] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.993697] [drm] No driver support for vblank timestamp query.
[    9.994068] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.013234] i2c 6-0058: uevent
[   10.013586] i2c 6-0058: uevent
[   10.016053] i2c 6-0058: uevent
[   10.016644] da9210 6-0068: uevent
[   10.017016] da9210 6-0068: uevent
[   10.017682] da9210 6-0068: uevent
[   10.034530] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.040711] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.046619] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.052697] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.058688] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.064613] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.071319] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.077226] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.083995] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.089904] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.095793] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.108766] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.109152] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.121200] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.121536] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.121877] i2c i2c-2: master_xfer[0] W, addr=0x20, len=1
[   10.121882] i2c i2c-2: master_xfer[1] R, addr=0x20, len=1
[   10.144069] [drm] No driver support for vblank timestamp query.
[   10.144187] i2c-core: driver [adv7180] registered
[   10.144456] adv7180 2-0020: uevent
[   10.158827] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.166987] soc_scale_crop: module license 'unspecified' taints kernel.
[   10.173806] Disabling lock debugging due to kernel taint
[   10.184764] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.191608] [drm] No driver support for vblank timestamp query.
[   10.198023] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.219838] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.227292] [drm] No driver support for vblank timestamp query.
[   10.233764] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.260349] sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
[   10.270544] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
[   10.276866] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
[   10.286988] renesas_usbhs e6590000.usb: Error applying setting, reverse things back
[   10.295099] renesas_usbhs e6590000.usb: host probed
[   10.300109] renesas_usbhs e6590000.usb: transceiver found
[   10.305828] renesas_usbhs e6590000.usb: gadget probed
[   10.311198] renesas_usbhs e6590000.usb: probed
[   10.316356] renesas_spi e6b10000.spi: DMA available
[   10.322901] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.329550] renesas_spi e6b10000.spi: probed
[   10.330576] spi_sh_msiof e6e20000.spi: DMA available
[   10.339205] [drm] No driver support for vblank timestamp query.
[   10.345645] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.356791] soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
[   10.371092] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.377887] [drm] No driver support for vblank timestamp query.
[   10.384430] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.431738] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.438533] [drm] No driver support for vblank timestamp query.
[   10.445044] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.454211] ak4642-codec 2-0012: probe
[   10.458243] i2c-core: driver [ak4642-codec] registered
[   10.472513] ak4642-codec 2-0012: uevent
[   10.501637] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.508436] [drm] No driver support for vblank timestamp query.
[   10.514980] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.547788] SCSI subsystem initialized
[   10.566325] rcar_sound ec500000.sound: probed
[   10.572360] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.579182] [drm] No driver support for vblank timestamp query.
[   10.585657] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.612025] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[   10.617085] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[   10.680053] libata version 3.00 loaded.
[   10.801036] sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
[   10.811758] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.818534] [drm] No driver support for vblank timestamp query.
[   10.825089] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.834103] scsi host0: sata_rcar
[   10.838015] ata1: SATA max UDMA/133 irq 112
[   10.843779] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[   10.848837] sh_mobile_sdhi ee140000.sd: Got WP GPIO
[   10.849927] random: nonblocking pool is initialized
[   10.861249] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.868030] [drm] No driver support for vblank timestamp query.
[   10.874590] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.039851] sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
[   11.048053] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[   11.065516] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.072353] [drm] No driver support for vblank timestamp query.
[   11.078856] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.241222] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
[   11.251466] rcar_jpu fe980000.jpeg-codec: encoder device registered as /dev/video26
[   11.259363] rcar_jpu fe980000.jpeg-codec: decoder device registered as /dev/video27
[   11.267486] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.267962] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.267968] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.268599] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.268604] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.269307] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.269312] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.269889] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.269894] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.270992] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.270997] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.271717] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.271722] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.279166] ata1: link resume succeeded after 1 retries
[   11.290833] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   11.291224] i2c i2c-2: master_xfer[0] W, addr=0x20, len=1
[   11.291229] i2c i2c-2: master_xfer[1] R, addr=0x20, len=1
[   11.291963] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   11.368145] [drm] No driver support for vblank timestamp query.
[   11.374668] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.382004] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[   11.389420] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.394942] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.400618] ata1: SATA link down (SStatus 0 SControl 300)
[   11.403216] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.403218] [drm] No driver support for vblank timestamp query.
[   11.403585] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.426074] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.431641] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.437765] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.443328] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.449417] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.454940] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.461035] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.466556] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.472703] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.478227] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.492072] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.498845] [drm] No driver support for vblank timestamp query.
[   11.505330] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)

--nextPart16071886.cADEmOvcnA
Content-Disposition: attachment; filename="trace.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="trace.log"

# tracer: nop
#
# entries-in-buffer/entries-written: 155/155   #P:2
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [000] d.h1     1.498063: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.498075: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.498266: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1     1.498348: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1     1.498465: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1     1.498475: rcar_i2c_irq: msr 59595959
           udevd-540   [000] d.h.    10.040209: rcar_i2c_irq: msr 09090909
           udevd-540   [000] d.h.    10.040220: rcar_i2c_irq: msr 08080808
           udevd-540   [000] dnH6    10.040315: rcar_i2c_irq: msr 0c0c0c0c
         syslogd-528   [000] d.H3    10.040409: rcar_i2c_irq: msr 14141414
    kworker/0:1H-516   [000] d.H3    10.046376: rcar_i2c_irq: msr 09090909
    kworker/0:1H-516   [000] d.H3    10.046396: rcar_i2c_irq: msr 08080808
    kworker/0:1H-516   [000] d.H2    10.046473: rcar_i2c_irq: msr 0c0c0c0c
    kworker/0:1H-516   [000] d.h1    10.046575: rcar_i2c_irq: msr 14141414
           udevd-546   [000] dnh.    10.052316: rcar_i2c_irq: msr 09090909
           udevd-546   [000] dnh.    10.052326: rcar_i2c_irq: msr 08080808
    kworker/0:1H-516   [000] d.h1    10.052413: rcar_i2c_irq: msr 0c0c0c0c
           udevd-545   [000] dnH3    10.052520: rcar_i2c_irq: msr 14141414
           udevd-548   [000] d.h.    10.058353: rcar_i2c_irq: msr 09090909
           udevd-548   [000] d.h.    10.058362: rcar_i2c_irq: msr 08080808
           udevd-540   [000] d.h.    10.058451: rcar_i2c_irq: msr 0c0c0c0c
           udevd-540   [000] dnH6    10.058552: rcar_i2c_irq: msr 14141414
           udevd-540   [000] d.h.    10.064373: rcar_i2c_irq: msr 09090909
           udevd-540   [000] d.h.    10.064383: rcar_i2c_irq: msr 08080808
           udevd-540   [000] dnH6    10.064470: rcar_i2c_irq: msr 0c0c0c0c
         syslogd-528   [000] d.H1    10.064572: rcar_i2c_irq: msr 14141414
      S20urandom-542   [000] d.h1    10.070298: rcar_i2c_irq: msr 09090909
      S20urandom-542   [000] d.h1    10.070306: rcar_i2c_irq: msr 08080808
      S20urandom-542   [000] d.h1    10.070395: rcar_i2c_irq: msr 0c0c0c0c
           udevd-545   [000] d.h1    10.070497: rcar_i2c_irq: msr 14141414
           udevd-540   [000] d.H1    10.076989: rcar_i2c_irq: msr 09090909
           udevd-540   [000] d.H1    10.076999: rcar_i2c_irq: msr 08080808
     kworker/0:1-193   [000] d.H.    10.077095: rcar_i2c_irq: msr 0c0c0c0c
           udevd-550   [000] d.h.    10.077189: rcar_i2c_irq: msr 14141414
           udevd-540   [000] d.h.    10.082912: rcar_i2c_irq: msr 09090909
           udevd-540   [000] d.h.    10.082920: rcar_i2c_irq: msr 08080808
           udevd-540   [000] d.h.    10.083008: rcar_i2c_irq: msr 0c0c0c0c
    kworker/0:1H-516   [000] d.H2    10.083112: rcar_i2c_irq: msr 14141414
           udevd-540   [000] dnH6    10.089670: rcar_i2c_irq: msr 09090909
           udevd-540   [000] dnH6    10.089678: rcar_i2c_irq: msr 08080808
           udevd-550   [000] d.H3    10.089766: rcar_i2c_irq: msr 0c0c0c0c
    kworker/0:1H-516   [000] d.h.    10.089868: rcar_i2c_irq: msr 14141414
    kworker/0:1H-516   [000] d.h.    10.095556: rcar_i2c_irq: msr 09090909
    kworker/0:1H-516   [000] d.H.    10.095575: rcar_i2c_irq: msr 08080808
           udevd-550   [000] d.h1    10.095652: rcar_i2c_irq: msr 0c0c0c0c
           udevd-550   [000] d.h2    10.095756: rcar_i2c_irq: msr 14141414
           udevd-540   [000] d.H3    10.101466: rcar_i2c_irq: msr 09090909
           udevd-540   [000] d.H3    10.101474: rcar_i2c_irq: msr 08080808
     kworker/0:1-193   [000] d.h2    10.101565: rcar_i2c_irq: msr 0c0c0c0c
           udevd-540   [000] d.h.    10.101654: rcar_i2c_irq: msr 44444444
           udevd-540   [000] d.h.    10.101662: rcar_i2c_irq: msr 54545454
    kworker/u4:0-6     [000] dnH1    10.115580: rcar_i2c_irq: msr 09090909
    kworker/u4:0-6     [000] dnH1    10.115589: rcar_i2c_irq: msr 08080808
    kworker/u4:0-6     [000] dnH1    10.121135: rcar_i2c_irq: msr 0c0c0c0c
    kworker/u4:0-6     [000] dnH3    10.121156: rcar_i2c_irq: msr 14141414
    kworker/u4:0-6     [000] dnH1    10.121310: rcar_i2c_irq: msr 09090909
    kworker/u4:0-6     [000] dnH1    10.121316: rcar_i2c_irq: msr 08080808
    kworker/u4:0-6     [000] dnH3    10.121403: rcar_i2c_irq: msr 0c0c0c0c
    kworker/u4:0-6     [000] dnH5    10.121506: rcar_i2c_irq: msr 14141414
    kworker/u4:0-6     [000] dnH4    10.121646: rcar_i2c_irq: msr 09090909
    kworker/u4:0-6     [000] dnH4    10.121651: rcar_i2c_irq: msr 08080808
    kworker/u4:0-6     [000] dnH1    10.121739: rcar_i2c_irq: msr 0c0c0c0c
    kworker/u4:0-6     [000] dnH7    10.121841: rcar_i2c_irq: msr 14141414
    kworker/u4:0-6     [000] dnh1    10.127459: rcar_i2c_irq: msr 09090909
    kworker/u4:0-6     [000] dnh1    10.127465: rcar_i2c_irq: msr 08080808
    kworker/u4:0-6     [000] dnH1    10.133000: rcar_i2c_irq: msr 07070707
    kworker/u4:0-6     [000] dnh1    10.138520: rcar_i2c_irq: msr 06060606
    kworker/u4:0-6     [000] dnH1    10.144051: rcar_i2c_irq: msr 59595959
    kworker/u4:0-6     [000] dnH1    10.144055: rcar_i2c_irq: msr 59595959
           udevd-550   [000] d.h.    11.268106: rcar_i2c_irq: msr 09090909
           udevd-550   [000] d.h.    11.268119: rcar_i2c_irq: msr 08080808
           udevd-550   [000] d.h.    11.268313: rcar_i2c_irq: msr 07070707
          v4l_id-706   [000] d.h2    11.268400: rcar_i2c_irq: msr 06060606
          v4l_id-706   [000] d.h2    11.268519: rcar_i2c_irq: msr 49494949
          v4l_id-706   [000] d.h2    11.268530: rcar_i2c_irq: msr 59595959
          v4l_id-706   [000] d.h2    11.268714: rcar_i2c_irq: msr 09090909
          v4l_id-706   [000] d.h2    11.268720: rcar_i2c_irq: msr 08080808
          v4l_id-706   [000] d.h2    11.268916: rcar_i2c_irq: msr 07070707
          v4l_id-706   [000] d.h2    11.268998: rcar_i2c_irq: msr 06060606
          v4l_id-706   [000] dnh.    11.269116: rcar_i2c_irq: msr 49494949
          v4l_id-706   [000] dnh.    11.269126: rcar_i2c_irq: msr 59595959
           udevd-553   [000] d.h.    11.269423: rcar_i2c_irq: msr 09090909
           udevd-553   [000] d.h.    11.269429: rcar_i2c_irq: msr 08080808
          v4l_id-706   [000] d.h.    11.269625: rcar_i2c_irq: msr 07070707
          v4l_id-706   [000] d.h.    11.269709: rcar_i2c_irq: msr 06060606
           udevd-553   [000] d.h.    11.269829: rcar_i2c_irq: msr 49494949
           udevd-553   [000] d.h.    11.269838: rcar_i2c_irq: msr 59595959
           udevd-553   [000] d.h.    11.270003: rcar_i2c_irq: msr 09090909
           udevd-553   [000] d.h.    11.270010: rcar_i2c_irq: msr 08080808
          v4l_id-706   [000] d.h.    11.270205: rcar_i2c_irq: msr 07070707
          v4l_id-706   [000] d.h1    11.270287: rcar_i2c_irq: msr 06060606
          v4l_id-706   [000] d.h.    11.270406: rcar_i2c_irq: msr 49494949
          v4l_id-706   [000] d.h.    11.270416: rcar_i2c_irq: msr 59595959
          <idle>-0     [000] d.h1    11.271110: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    11.271118: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    11.271311: rcar_i2c_irq: msr 07070707
          v4l_id-706   [000] d.h1    11.271394: rcar_i2c_irq: msr 06060606
          v4l_id-706   [000] d.h2    11.271514: rcar_i2c_irq: msr 49494949
          v4l_id-706   [000] d.h.    11.271523: rcar_i2c_irq: msr 59595959
          <idle>-0     [000] d.h1    11.271833: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    11.271840: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    11.272033: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    11.272114: rcar_i2c_irq: msr 06060606
          v4l_id-706   [000] d.h1    11.272233: rcar_i2c_irq: msr 49494949
          v4l_id-706   [000] d.h.    11.272242: rcar_i2c_irq: msr 59595959
           udevd-545   [000] d.h.    11.290960: rcar_i2c_irq: msr 09090909
           udevd-545   [000] d.h.    11.290970: rcar_i2c_irq: msr 08080808
           udevd-545   [000] d.h.    11.291057: rcar_i2c_irq: msr 0c0c0c0c
           udevd-545   [000] d.h.    11.291159: rcar_i2c_irq: msr 14141414
           udevd-544   [000] d.h.    11.291340: rcar_i2c_irq: msr 09090909
           udevd-544   [000] d.h.    11.291347: rcar_i2c_irq: msr 08080808
           udevd-544   [000] d.h.    11.291542: rcar_i2c_irq: msr 07070707
           udevd-540   [000] d.h.    11.291625: rcar_i2c_irq: msr 06060606
           udevd-545   [000] d.h.    11.291744: rcar_i2c_irq: msr 49494949
           udevd-545   [000] d.h.    11.291753: rcar_i2c_irq: msr 59595959
           udevd-545   [000] d.h.    11.292086: rcar_i2c_irq: msr 09090909
           udevd-545   [000] d.h.    11.292093: rcar_i2c_irq: msr 08080808
           udevd-545   [000] d.h.    11.292181: rcar_i2c_irq: msr 0c0c0c0c
           udevd-540   [000] d.h.    11.292283: rcar_i2c_irq: msr 14141414
       scsi_eh_0-661   [000] d.h1    11.406150: rcar_i2c_irq: msr 09090909
       scsi_eh_0-661   [000] d.h1    11.406162: rcar_i2c_irq: msr 08080808
       scsi_eh_0-661   [000] d.H1    11.412943: rcar_i2c_irq: msr 07070707
       scsi_eh_0-661   [000] d.h1    11.419026: rcar_i2c_irq: msr 06060606
       scsi_eh_0-661   [000] d.H1    11.425975: rcar_i2c_irq: msr 59595959
       scsi_eh_0-661   [000] d.H1    11.425979: rcar_i2c_irq: msr 59595959
          <idle>-0     [000] d.h1    11.437273: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    11.437282: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    11.437474: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    11.437555: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    11.437672: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1    11.437683: rcar_i2c_irq: msr 59595959
     ksoftirqd/0-3     [000] d.H.    11.448954: rcar_i2c_irq: msr 09090909
     ksoftirqd/0-3     [000] d.H.    11.448960: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h2    11.449157: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    11.449239: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    11.449356: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1    11.449367: rcar_i2c_irq: msr 59595959
           klogd-531   [000] d.h.    11.460590: rcar_i2c_irq: msr 09090909
           klogd-531   [000] d.h.    11.460596: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    11.460791: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    11.460872: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    11.460989: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1    11.461000: rcar_i2c_irq: msr 59595959
          <idle>-0     [000] d.h1    11.472205: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    11.472211: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    11.472404: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    11.472485: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    11.472602: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1    11.472613: rcar_i2c_irq: msr 59595959
          <idle>-0     [000] d.h1    11.483890: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    11.483897: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    11.484090: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    11.484171: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    11.484288: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1    11.484299: rcar_i2c_irq: msr 59595959

--nextPart16071886.cADEmOvcnA--

