From: Simon Horman <horms@verge.net.au>
Date: Fri, 18 Jul 2014 08:57:21 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup SD2CKCR register address
Message-Id: <20140718085719.GA29036@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 17, 2014 at 10:28:39PM -0700, Kuninori Morimoto wrote:
> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Hi Geert, Simon
> 
> Can you please test this patch ?
> I don't have M2 board

Hi Morimoto-san,

I have tested that both with and without this patch I can read
data from mmc2 on a koelsch board.

The main difference I have noticed with this patch is:
sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 12 MHz

Whereas without I see:
sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz

Is there anything else I should test at this time?

For reference dmesg output follows:

With this patch:

Booting Linux on physical CPU 0x0
Linux version 3.16.0-rc5-00001-g4478ae8 (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #558 SMP Fri Jul 18 17:55:26 JST 2014
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc5347d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Ignoring memory at 0x200000000 outside 32-bit physical address space
Machine model: Koelsch
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c05b3640, node_mem_map eeff9000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 528 pages used for memmap
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 5 pages/cpu @eefce000 s7488 r0 d12992 u32768
pcpu-alloc: s7488 r0 d12992 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033376K/1048576K available (4319K kernel code, 227K rwdata, 1012K rodata, 243K init, 197K bss, 15200K reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc053dfc4   (5336 kB)
      .init : 0xc053e000 - 0xc057ad40   ( 244 kB)
      .data : 0xc057c000 - 0xc05b4dc0   ( 228 kB)
       .bss : 0xc05b4dc8 - 0xc05e61fc   ( 198 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 3435973836800ns
Switching to timer-based delay loop
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj0000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x4043e668 - 0x4043e6c0
Unable to boot CPU1 when MD21 is set
CPU1: failed to boot: -524
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
sh-pfc e6060000.pfc: r8a77910_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
platform regulator@0: Driver reg-fixed-voltage requests probe deferral
platform regulator@2: Driver reg-fixed-voltage requests probe deferral
platform regulator@4: Driver reg-fixed-voltage requests probe deferral
gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
platform regulator@1: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
platform regulator@3: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
platform regulator@5: Driver gpio-regulator requests probe deferral
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pinmux core: sh-pfc does not support function i2c6
sh-pfc e6060000.pfc: invalid function i2c6 in map table
i2c-sh_mobile e60b0000.i2c: I2C adapter 6 with bus speed 100000 Hz (L/H=0x19/0x16)
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 512 (order: 3, 32768 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
msgmni has been set to 1490
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
gpio_rcar e6050000.gpio: driving 32 GPIOs
gpio_rcar e6051000.gpio: driving 32 GPIOs
gpio_rcar e6052000.gpio: driving 32 GPIOs
gpio_rcar e6053000.gpio: driving 32 GPIOs
gpio_rcar e6054000.gpio: driving 32 GPIOs
gpio_rcar e6055000.gpio: driving 32 GPIOs
gpio_rcar e6055400.gpio: driving 32 GPIOs
gpio_rcar e6055800.gpio: driving 26 GPIOs
pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:00:01.0: supports D1 D2
pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus0: Fast back to back transfers disabled
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:00:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:00:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0xee0c0000-0xee0c10ff]
pci_bus 0000:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
pci_bus 0000:01: No busn resource found for root bus, will use [bus 01-ff]
pci 0000:01:00.0: [1033:0000] type 00 class 0x060000
pci 0000:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
pci 0000:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:01:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:01:01.0: supports D1 D2
pci 0000:01:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:01:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:01:02.0: supports D1 D2
pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:01:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:01:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:01:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
pci 0000:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
rcar-pcie fe000000.pcie: PCIe link down
DA9210: 1000 mV at 4600 mA 
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e6e60000.serial: ttySC6 at MMIO 0xe6e60000 (irq = 184, base_baud = 0) is a scif
console [ttySC6] enabled
e6e68000.serial: ttySC7 at MMIO 0xe6e68000 (irq = 185, base_baud = 0) is a scif
[drm] Initialized drm 1.1.0 20060810
rcar-du rcar-du-r8a7791: fb0:  frame buffer device
rcar-du rcar-du-r8a7791: registered panic notifier
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
[drm] Initialized rcar-du 1.0.0 20130110 on minor 0
scsi0 : sata_rcar
ata1: SATA max UDMA/133 irq 137
renesas_spi e6b10000.spi: probed
libphy: sh_mii: probed
sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:6d:00, IRQ 194.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:00:02.0: EHCI Host Controller
ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.0: irq 140, io mem 0xee081000
ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-pci 0000:01:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:01:02.0: EHCI Host Controller
ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 2
ehci-pci 0000:01:02.0: irq 145, io mem 0xee0c1000
ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:00:01.0: OHCI PCI host controller
ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:00:01.0: irq 140, io mem 0xee080000
ohci-pci 0000:00:01.0: init err (00002edf 0000)
ohci-pci 0000:00:01.0: can't start
ohci-pci 0000:00:01.0: startup error -75
ohci-pci 0000:00:01.0: USB bus 3 deregistered
ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
ohci-pci: probe of 0000:00:01.0 failed with error -75
ohci-pci 0000:01:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:01:01.0: OHCI PCI host controller
ohci-pci 0000:01:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:01:01.0: irq 145, io mem 0xee0c0000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
mousedev: PS/2 mouse device common for all mice
at24 2-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
i2c-rcar e6530000.i2c: probed
rcar_thermal e61f0000.thermal: 1 sensor probed
sh_mobile_sdhi ee100000.sd: Got CD GPIO #806.
sh_mobile_sdhi ee100000.sd: Got WP GPIO #807.
platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
sh_mobile_sdhi ee140000.sd: Got CD GPIO #814.
sh_mobile_sdhi ee140000.sd: Got WP GPIO #815.
platform ee140000.sd: Driver sh_mobile_sdhi requests probe deferral
sh_mobile_sdhi ee160000.sd: Got CD GPIO #822.
platform ee160000.sd: Driver sh_mobile_sdhi requests probe deferral
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 1300000 KHz
cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency changed to: 1312500 KHz
ata1: link resume succeeded after 1 retries
SDHI0 Vcc: 3300 mV 
SDHI1 Vcc: 3300 mV 
SDHI2 Vcc: 3300 mV 
SDHI0 VccQ: 1800 <--> 3300 mV at 3300 mV 
SDHI1 VccQ: 1800 <--> 3300 mV at 3300 mV 
SDHI2 VccQ: 1800 <--> 3300 mV at 3300 mV 
sh_mobile_sdhi ee100000.sd: Got CD GPIO #806.
sh_mobile_sdhi ee100000.sd: Got WP GPIO #807.
of_dma_request_slave_channel: dma-names property of node '/sd@ee100000' missing or empty
ata1: SATA link down (SStatus 0 SControl 300)
sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
sh_mobile_sdhi ee140000.sd: Got CD GPIO #814.
sh_mobile_sdhi ee140000.sd: Got WP GPIO #815.
of_dma_request_slave_channel: dma-names property of node '/sd@ee140000' missing or empty
sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
sh_mobile_sdhi ee160000.sd: Got CD GPIO #822.
of_dma_request_slave_channel: dma-names property of node '/sd@ee160000' missing or empty
sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
input: gpio-keys as /devices/gpio-keys/input/input0
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 416) to driver Micrel KSZ8041RNLI
Sending DHCP requests .
mmc2: new high speed SDHC card at address b368
mmcblk0: mmc2:b368 SD08G 7.41 GiB 
 mmcblk0: p1
.
sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
., OK
IP-Config: Got DHCP answer from 10.3.3.254, my address is 10.3.3.159
IP-Config: Complete:
     device=eth0, hwaddr.:09:0a:00:6d:00, ipaddr.3.3.159, mask%5.255.255.0, gw.3.3.254
     host.3.3.159, domain=isobedori.kobe.vergenet.net kanocho.kobe.vergenet.net vergenet., nis-domain=(none)
     bootserver.3.3.135, rootserver.3.3.135, rootpath=/srv/nfs/koelsch-armhf,rsize24,wsize24
     nameserver0.3.3.254
SDHI1 VccQ: disabling
SDHI0 VccQ: disabling
SDHI1 Vcc: disabling
SDHI0 Vcc: disabling
ALSA device list:
  No soundcards found.
VFS: Mounted root (nfs filesystem) on device 0:13.
devtmpfs: mounted
Freeing unused kernel memory: 240K (c053e000 - c057a000)
udevd[604]: starting version 175
random: nonblocking pool is initialized


Without this patch:

Booting Linux on physical CPU 0x0
Linux version 3.16.0-rc5 (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #557 SMP Fri Jul 18 17:49:42 JST 2014
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc5347d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Ignoring memory at 0x200000000 outside 32-bit physical address space
Machine model: Koelsch
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c05b3640, node_mem_map eeff9000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 528 pages used for memmap
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 5 pages/cpu @eefce000 s7488 r0 d12992 u32768
pcpu-alloc: s7488 r0 d12992 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033376K/1048576K available (4319K kernel code, 227K rwdata, 1012K rodata, 243K init, 197K bss, 15200K reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc053dfc4   (5336 kB)
      .init : 0xc053e000 - 0xc057ad40   ( 244 kB)
      .data : 0xc057c000 - 0xc05b4dc0   ( 228 kB)
       .bss : 0xc05b4dc8 - 0xc05e61fc   ( 198 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 3435973836800ns
Switching to timer-based delay loop
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj0000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x4043e668 - 0x4043e6c0
Unable to boot CPU1 when MD21 is set
CPU1: failed to boot: -524
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
sh-pfc e6060000.pfc: r8a77910_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
platform regulator@0: Driver reg-fixed-voltage requests probe deferral
platform regulator@2: Driver reg-fixed-voltage requests probe deferral
platform regulator@4: Driver reg-fixed-voltage requests probe deferral
gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
platform regulator@1: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
platform regulator@3: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
platform regulator@5: Driver gpio-regulator requests probe deferral
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pinmux core: sh-pfc does not support function i2c6
sh-pfc e6060000.pfc: invalid function i2c6 in map table
i2c-sh_mobile e60b0000.i2c: I2C adapter 6 with bus speed 100000 Hz (L/H=0x19/0x16)
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 512 (order: 3, 32768 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
msgmni has been set to 1490
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
gpio_rcar e6050000.gpio: driving 32 GPIOs
gpio_rcar e6051000.gpio: driving 32 GPIOs
gpio_rcar e6052000.gpio: driving 32 GPIOs
gpio_rcar e6053000.gpio: driving 32 GPIOs
gpio_rcar e6054000.gpio: driving 32 GPIOs
gpio_rcar e6055000.gpio: driving 32 GPIOs
gpio_rcar e6055400.gpio: driving 32 GPIOs
gpio_rcar e6055800.gpio: driving 26 GPIOs
pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:00:01.0: supports D1 D2
pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus0: Fast back to back transfers disabled
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:00:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:00:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0xee0c0000-0xee0c10ff]
pci_bus 0000:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
pci_bus 0000:01: No busn resource found for root bus, will use [bus 01-ff]
pci 0000:01:00.0: [1033:0000] type 00 class 0x060000
pci 0000:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
pci 0000:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:01:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:01:01.0: supports D1 D2
pci 0000:01:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:01:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:01:02.0: supports D1 D2
pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:01:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:01:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:01:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
pci 0000:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
rcar-pcie fe000000.pcie: PCIe link down
DA9210: 1000 mV at 4600 mA 
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e6e60000.serial: ttySC6 at MMIO 0xe6e60000 (irq = 184, base_baud = 0) is a scif
console [ttySC6] enabled
e6e68000.serial: ttySC7 at MMIO 0xe6e68000 (irq = 185, base_baud = 0) is a scif
[drm] Initialized drm 1.1.0 20060810
rcar-du rcar-du-r8a7791: fb0:  frame buffer device
rcar-du rcar-du-r8a7791: registered panic notifier
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
[drm] Initialized rcar-du 1.0.0 20130110 on minor 0
scsi0 : sata_rcar
ata1: SATA max UDMA/133 irq 137
renesas_spi e6b10000.spi: probed
libphy: sh_mii: probed
sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:6d:00, IRQ 194.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:00:02.0: EHCI Host Controller
ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.0: irq 140, io mem 0xee081000
ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-pci 0000:01:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:01:02.0: EHCI Host Controller
ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 2
ehci-pci 0000:01:02.0: irq 145, io mem 0xee0c1000
ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:00:01.0: OHCI PCI host controller
ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:00:01.0: irq 140, io mem 0xee080000
ohci-pci 0000:00:01.0: init err (00002edf 0000)
ohci-pci 0000:00:01.0: can't start
ohci-pci 0000:00:01.0: startup error -75
ohci-pci 0000:00:01.0: USB bus 3 deregistered
ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
ohci-pci: probe of 0000:00:01.0 failed with error -75
ohci-pci 0000:01:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:01:01.0: OHCI PCI host controller
ohci-pci 0000:01:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:01:01.0: irq 145, io mem 0xee0c0000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
mousedev: PS/2 mouse device common for all mice
at24 2-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
i2c-rcar e6530000.i2c: probed
rcar_thermal e61f0000.thermal: 1 sensor probed
sh_mobile_sdhi ee100000.sd: Got CD GPIO #806.
sh_mobile_sdhi ee100000.sd: Got WP GPIO #807.
platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
sh_mobile_sdhi ee140000.sd: Got CD GPIO #814.
sh_mobile_sdhi ee140000.sd: Got WP GPIO #815.
platform ee140000.sd: Driver sh_mobile_sdhi requests probe deferral
sh_mobile_sdhi ee160000.sd: Got CD GPIO #822.
platform ee160000.sd: Driver sh_mobile_sdhi requests probe deferral
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 1300000 KHz
cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency changed to: 1312500 KHz
ata1: link resume succeeded after 1 retries
SDHI0 Vcc: 3300 mV 
SDHI1 Vcc: 3300 mV 
SDHI2 Vcc: 3300 mV 
SDHI0 VccQ: 1800 <--> 3300 mV at 3300 mV 
SDHI1 VccQ: 1800 <--> 3300 mV at 3300 mV 
SDHI2 VccQ: 1800 <--> 3300 mV at 3300 mV 
sh_mobile_sdhi ee100000.sd: Got CD GPIO #806.
sh_mobile_sdhi ee100000.sd: Got WP GPIO #807.
of_dma_request_slave_channel: dma-names property of node '/sd@ee100000' missing or empty
ata1: SATA link down (SStatus 0 SControl 300)
sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
sh_mobile_sdhi ee140000.sd: Got CD GPIO #814.
sh_mobile_sdhi ee140000.sd: Got WP GPIO #815.
of_dma_request_slave_channel: dma-names property of node '/sd@ee140000' missing or empty
sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
sh_mobile_sdhi ee160000.sd: Got CD GPIO #822.
of_dma_request_slave_channel: dma-names property of node '/sd@ee160000' missing or empty
sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 12 MHz
input: gpio-keys as /devices/gpio-keys/input/input0
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 416) to driver Micrel KSZ8041RNLI
Sending DHCP requests .
mmc2: new high speed SDHC card at address b368
mmcblk0: mmc2:b368 SD08G 7.41 GiB 
 mmcblk0: p1
.
sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
., OK
IP-Config: Got DHCP answer from 10.3.3.254, my address is 10.3.3.159
IP-Config: Complete:
     device=eth0, hwaddr.:09:0a:00:6d:00, ipaddr.3.3.159, mask%5.255.255.0, gw.3.3.254
     host.3.3.159, domain=isobedori.kobe.vergenet.net kanocho.kobe.vergenet.net vergenet., nis-domain=(none)
     bootserver.3.3.135, rootserver.3.3.135, rootpath=/srv/nfs/koelsch-armhf,rsize24,wsize24
     nameserver0.3.3.254
SDHI1 VccQ: disabling
SDHI0 VccQ: disabling
SDHI1 Vcc: disabling
SDHI0 Vcc: disabling
ALSA device list:
  No soundcards found.
VFS: Mounted root (nfs filesystem) on device 0:13.
devtmpfs: mounted
Freeing unused kernel memory: 240K (c053e000 - c057a000)
udevd[604]: starting version 175
random: nonblocking pool is initialized


