From: =?UTF-8?B?7KGw7LC97ZmY?= <charlescho64@gmail.com>
Date: Mon, 23 Nov 2015 01:11:51 +0000
Subject: Re: [Lager-Board][Don't bring up all CPU]
Message-Id: <CANi_qo2zVnNtj8KF1TegN4R7wzTZ27=XDKb4uhrPDnwi4By+gA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

 Hello,

 I tried to bring up Lager Board.

 With Linux kernel mainline 4.3 and shmobile_defconfig, I brought lager board
 to get shell of rootfs. But all cpu didn't be bring up. Only 4 of 8 CPU's
 are alive.

 Below is log message.
 .......................................................................................................
sh_eth Waiting for PHY auto negotiation to complete.. done
sh_eth: 100Base/Full
Using sh_eth device
TFTP from server 192.168.0.228; our IP address is 192.168.0.91
Filename 'zImage-native'.
Load address: 0x40007fc0
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###########################
         1.4 MiB/s
done
Bytes transferred = 4462992 (441990 hex)
sh_eth:1 is connected to sh_eth.  Reconnecting to sh_eth
sh_eth Waiting for PHY auto negotiation to complete.. done
sh_eth: 100Base/Full
Using sh_eth device
TFTP from server 192.168.0.228; our IP address is 192.168.0.91
Filename 'lager-native.dtb'.
Load address: 0x4f000000
Loading: #########
         1.3 MiB/s
done
Bytes transferred = 43694 (aaae hex)
## Flattened Device Tree blob at 4f000000
   Booting using the fdt blob at 0x4f000000
   Loading Device Tree to 40ef2000, end 40effaad ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 4.3.0 (charles@charles-desktop) (gcc version 4.9.3
20150113 (prerelease) (Linaro GCC 4.9-2015.01-3) ) #8 SMP Tue Nov 17
09:59:52 KST5
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Lager
Ignoring memory block 0x140000000 - 0x200000000
Memory policy: Data cache writealloc
PERCPU: Embedded 10 pages/cpu @eef84000 s17984 r0 d22976 u40960
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC0,38400 root=/dev/ram0 rw
earlyprintk rdinit=/sbin/init
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030868K/1048576K available (4956K kernel code, 188K rwdata,
1444K rodata, 1360K init, 205K bss, 17708K reserved, 0K cma-reserved,
270336K)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0649044   (6405 kB)
      .init : 0xc064a000 - 0xc079e000   (1360 kB)
      .data : 0xc079e000 - 0xc07cd0c0   ( 189 kB)
       .bss : 0xc07d0000 - 0xc080346c   ( 206 kB)
Hierarchical RCU implementation.
        Build-time adjustment of leaf fanout to 32.
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
0x24e6a1710, max_idle_ns: 440795202120 ns
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
Switching to timer-based delay loop, resolution 100ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer
frequency.. 20.00 BogoMIPS (lpj0000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1535
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40009000 - 0x40009058
CPU1: update cpu_capacity 1535
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU2: update cpu_capacity 1535
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
CPU3: update cpu_capacity 1535
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
CPU4: failed to boot: -22
CPU5: failed to boot: -22
CPU6: failed to boot: -22
CPU7: failed to boot: -22
Brought up 4 CPUs
SMP: Total of 4 processors activated (80.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 4 irqs
sh-pfc e6060000.pfc: r8a77900_pfc support registered
No ATAGs?
hw-breakpoint: Failed to enable monitor mode on CPU 1.
gpio-regulator regulator@2: Could not obtain regulator setting GPIOs: -517
gpio-regulator regulator@4: Could not obtain regulator setting GPIOs: -517
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 Hz
media: Linux media interface: v0.10
Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1911260446275000000 ns
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 2048 (order: 5, 131072 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
gpio_rcar e6050000.gpio: driving 32 GPIOs
gpio_rcar e6051000.gpio: driving 32 GPIOs
gpio_rcar e6052000.gpio: driving 32 GPIOs
gpio_rcar e6053000.gpio: driving 32 GPIOs
gpio_rcar e6054000.gpio: driving 32 GPIOs
gpio_rcar e6055000.gpio: driving 32 GPIOs
pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
pci 0000:00:01.0: enabling device (0140 -> 0142)
pci 0000:00:02.0: enabling device (0140 -> 0142)
pci-rcar-gen2 ee0b0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0b0000.pci: PCI host bridge to bus 0001:01
pci_bus 0001:01: root bus resource [io  0xee0a0000-0xee0a10ff]
pci_bus 0001:01: root bus resource [mem 0xee0a0000-0xee0a10ff]
pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
PCI: bus1: Fast back to back transfers disabled
pci 0001:01:01.0: BAR 0: assigned [mem 0xee0a0000-0xee0a0fff]
pci 0001:01:02.0: BAR 0: assigned [mem 0xee0a1000-0xee0a10ff]
pci 0001:01:01.0: enabling device (0140 -> 0142)
pci 0001:01:02.0: enabling device (0140 -> 0142)
pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0002:02
pci_bus 0002:02: root bus resource [io  0xee0c0000-0xee0c10ff]
pci_bus 0002:02: root bus resource [mem 0xee0c0000-0xee0c10ff]
pci_bus 0002:02: No busn resource found for root bus, will use [bus 02-ff]
PCI: bus2: Fast back to back transfers disabled
pci 0002:02:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
pci 0002:02:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
pci 0002:02:01.0: enabling device (0140 -> 0142)
pci 0002:02:02.0: enabling device (0140 -> 0142)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e6c40000.serial: ttySC0 at MMIO 0xe6c40000 (irq = 103, base_baud = 0) is a scifa
console [ttySC0] enabled
e6c50000.serial: ttySC1 at MMIO 0xe6c50000 (irq = 104, base_baud = 0) is a scifa
[drm] Initialized drm 1.1.0 20060810
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
rcar-du feb00000.display: failed to initialize encoder
/i2c@e6520000/hdmi@39 (-38), skipping
rcar-du feb00000.display: fb0:  frame buffer device
[drm] Initialized rcar-du 1.0.0 20130110 on minor 0
brd: module loaded
da9063 7-0058: Device detected (chip-ID: 0x61, var-ID: 0x50)
scsi host0: sata_rcar
ata1: SATA max UDMA/133 irq 106
renesas_spi e6b10000.spi: DMA available
m25p80 spi0.0: s25fl512s (65536 Kbytes)
3 ofpart partitions found on MTD device spi0.0
Creating 3 MTD partitions on "spi0.0":
0x000000000000-0x000000040000 : "loader"
0x000000040000-0x000000440000 : "user"
0x000000440000-0x000004000000 : "flash"
renesas_spi e6b10000.spi: probed
spi_sh_msiof e6e10000.spi: DMA available
libphy: sh_mii: probed
sh-eth ee700000.ethernet eth0: Base address at 0xee700000,
00:40:5c:26:0a:5c, IRQ 105.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:02.0: EHCI Host Controller
ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.0: irq 120, io mem 0xee081000
ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-pci 0001:01:02.0: EHCI Host Controller
ehci-pci 0001:01:02.0: new USB bus registered, assigned bus number 2
ehci-pci 0001:01:02.0: irq 121, io mem 0xee0a1000
ehci-pci 0001:01:02.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ehci-pci 0002:02:02.0: EHCI Host Controller
ehci-pci 0002:02:02.0: new USB bus registered, assigned bus number 3
ehci-pci 0002:02:02.0: irq 122, io mem 0xee0c1000
ehci-pci 0002:02:02.0: USB 2.0 started, EHCI 1.00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
ata1: link resume succeeded after 1 retries
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:01.0: OHCI PCI host controller
ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 4
ohci-pci 0000:00:01.0: irq 120, io mem 0xee080000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
ohci-pci 0001:01:01.0: OHCI PCI host controller
ohci-pci 0001:01:01.0: new USB bus registered, assigned bus number 5
ohci-pci 0001:01:01.0: irq 121, io mem 0xee0a0000
ata1: SATA link down (SStatus 0 SControl 300)
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
ohci-pci 0002:02:01.0: OHCI PCI host controller
ohci-pci 0002:02:01.0: new USB bus registered, assigned bus number 6
ohci-pci 0002:02:01.0: irq 122, io mem 0xee0c0000
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 1 port detected
sh-pfc e6060000.pfc: pin GP_5_19 already requested by ee090000.pci;
cannot claim for e6590000.usb
sh-pfc e6060000.pfc: pin-179 (e6590000.usb) status -22
sh-pfc e6060000.pfc: could not request pin 179 (GP_5_19) from group
usb0_ovc_vbus  on device sh-pfc
renesas_usbhs e6590000.usb: Error applying setting, reverse things back
renesas_usbhs e6590000.usb: transceiver found
renesas_usbhs e6590000.usb: gadget probed
renesas_usbhs e6590000.usb: USB function not selected (GPIO 850)
renesas_usbhs e6590000.usb: probe failed
renesas_usbhs: probe of e6590000.usb failed with error -524
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
adv7180 6-0020: chip found @ 0x20 (e6520000.i2c)
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
rcar_thermal e61f0000.thermal: 1 sensor probed
sh_mobile_sdhi ee100000.sd: Got CD GPIO
sh_mobile_sdhi ee140000.sd: Got CD GPIO
sh_mmcif ee220000.mmc: No vqmmc regulator found
sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
sh_mmcif ee220000.mmc:  CRC error: state 1, wait 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
rcar_sound ec500000.sound: probed
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
bridge: automatic filtering via arp/ip/ip6tables has been deprecated.
Update your scripts to load br_netfilter if you need this.
mmc0: MAN_BKOPS_EN bit is not set
mmc0: new high speed MMC card at address 0001
mmcblk0: mmc0:0001 eMMC   7.28 GiB
mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
 mmcblk0: p1
Key type dns_resolver registered
Registering SWP/SWPB emulation handler
sh_mobile_sdhi ee100000.sd: Got CD GPIO
sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 clock rate 97 MHz
sh_mobile_sdhi ee140000.sd: Got CD GPIO
sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 clock rate 97 MHz
asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
input: keyboard as /devices/platform/keyboard/input/input0
hctosys: unable to open rtc device (rtc0)
SDHI0 Vcc: disabling
SDHI2 Vcc: disabling
SDHI0 VccQ: disabling
SDHI2 VccQ: disabling
ALSA device list:
  #0: rsnd-dai.0-ak4642-hifi
Freeing unused kernel memory: 1360K (c064a000 - c079e000)

Please press Enter to activate this console.
#
 .......................................................................................................

 I hope you let me change anything in linux kernel 4.3 mainline.

 --
 Happy Virus....
 Chang Hwan, Cho
