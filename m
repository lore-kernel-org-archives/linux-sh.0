From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Nov 2013 05:35:34 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <20131114053534.GE22870@verge.net.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
List-Id: <linux-sh.vger.kernel.org>
References: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 12:29:13PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 13 November 2013 15:22:08 Simon Horman wrote:
> > On Wed, Nov 13, 2013 at 01:14:37PM +0900, Magnus Damm wrote:
> > > On Wed, Nov 13, 2013 at 9:54 AM, Simon Horman <horms@verge.net.au> wrote:
> > > > On Tue, Nov 12, 2013 at 02:24:34PM +0100, Laurent Pinchart wrote:
> > > >> On Tuesday 12 November 2013 14:08:40 Simon Horman wrote:
> > > >> > On Sat, Nov 09, 2013 at 01:18:01PM +0100, Laurent Pinchart wrote:
> > > >> > > The SENSE register bitfield position is incorrectly computed for
> > > >> > > SoCs that use 2-bit IRQ sense fields. Fix it.
> > > >> > > 
> > > >> > > Signed-off-by: Laurent Pinchart
> > > >> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > >> > 
> > > >> > Hi Laurent,
> > > >> > 
> > > >> > your change seems correct to me but I am wondering if it should
> > > >> > be considered as a bug-fix?
> > > >> 
> > > >> It's a bug fix, but given that the bug hasn't had any consequence so
> > > >> far, I'm not sure whether we really need to backport it to -stable.
> > > > 
> > > > Thanks. I think the best thing would be to
> > > > try and get it into v3.13 as a fix but not worry about -stable.
> > > > 
> > > > I will see about making it so.
> > > 
> > > Thanks. Can you work with Laurent to briefly extend the commit message
> > > with information about which SoCs this has been tested on and such? I
> > > don't have any R-Car Gen1 boards myself so you guys will have to fix
> > > that.
> > 
> > Yes of course.
> > 
> > Laurent, I have access to both a Marzen (H1) and Bockw (M1) board.
> > Please let me know if you would like me to do any testing.
> 
> I've tested the patch on a Marzen board, not a Lager board as erroneously 
> stated in my e-mail. It would be worth it testing it on Bockw to make sure we 
> were not in a situation where two wrongs made a right.

Hi Laurent,

I have booted a bockw board using its defconfig with this patch applied
on top of renesas-devel-v3.12-20131112. The boot was successful.

The attached boot log also includes the contents of /proc/interrupts
not long after boot for reference.

Is this test sufficient? Assuming so can I propose the following
updated changelog?


From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation

The SENSE register bitfield position is incorrectly computed for SoCs
that use 2-bit IRQ sense fields. Fix it.

This has been tested on the Marzen (H1) and Bockw (M1) boards.

This bug has been present since the renesas-intc-irqpin driver was
introduced by 443580486e3b9657 ("irqchip: Renesas INTC External IRQ pin
driver") in v3.10-rc1.

This bug does not have any known run-time effect.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Tested-by: Simon Horman <horms+renesas@verge.net.au>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.log"

Booting Linux on physical CPU 0x0
Linux version 3.12.0-00001-gd89cd30 (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian 4.7.2-4) ) #8 Thu Nov 14 14:26:15 JST 2013
CPU: ARMv7 Processor [412fc094] revision 4 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: bockw, model: bockw
debug: ignoring loglevel setting.
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c03c7da0, node_mem_map c053f000
  Normal zone: 512 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65536 pages, LIFO batch:15
DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
CPU: All CPU(s) started in SVC mode.
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs rw
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255800K/262144K available (2967K kernel code, 146K rwdata, 596K rodata, 127K init, 158K bss, 6344K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0382e24   (3564 kB)
      .init : 0xc0383000 - 0xc03a2e80   ( 128 kB)
      .data : 0xc03a4000 - 0xc03c8800   ( 146 kB)
       .bss : 0xc03c8800 - 0xc03f00a0   ( 159 kB)
NR_IRQS:16 nr_irqs:16 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 4194303999ms
Calibrating delay loop (skipped) preset value.. 532.00 BogoMIPS (lpj=260000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc02ec150 - 0xc02ec184
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_intc_irqpin renesas_intc_irqpin: driving 4 irqs
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c6, AUX_CTRL 0x42460000, Cache size: 1024 kB
sh-pfc pfc-r8a7778: r8a7778_pfc support registered
bio: create slab <bio-0> at 0
fixed-dummy: no parameters
fixed-3.3V: 3300 mV 
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
sh_tmu sh_tmu.0: used for clock events
sh_tmu sh_tmu.0: used for periodic clock events
sh_tmu sh_tmu.1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource sh_tmu.1
sh_tmu sh_tmu.0: used for oneshot clock events
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered (default)
SuperH (H)SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 102, base_baud = 0) is a scif
console [ttySC0] enabled
sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 103, base_baud = 0) is a scif
sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 104, base_baud = 0) is a scif
sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 105, base_baud = 0) is a scif
sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 106, base_baud = 0) is a scif
sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 107, base_baud = 0) is a scif
m25p80 spi0.0: unrecognized id s25fl008k
m25p80 spi0.0: found at26df081a, expected m25p80
m25p80 spi0.0: at26df081a (1024 Kbytes)
Creating 1 MTD partitions on "m25p80":
0x000000000000-0x000000100000 : "data(spi)"
smsc911x: Driver version 2008-10-21
smsc911x smsc911x (unregistered net_device): couldn't get clock -2
libphy: smsc911x-mdio: probed
smsc911x smsc911x eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=smsc911x-fffffff:01, irq=-1)
smsc911x smsc911x eth0: MAC Address: 2e:09:0a:00:2f:04
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-platform: OHCI generic platform driver
usbcore: registered new interface driver usb-storage
rtc-rx8581 0-0051: chip found, driver version 0.1
rtc-rx8581 0-0051: low voltage detected, date/time is not reliable.
rtc-rx8581 0-0051: rtc core: registered rtc-rx8581 as rtc0
i2c-rcar i2c-rcar.0: probed
i2c-rcar i2c-rcar.1: probed
i2c-rcar i2c-rcar.2: probed
i2c-rcar i2c-rcar.3: probed
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
ml86v7667 0-0041: chip found @ 0x41 (i2c-rcar)
soc-camera-pdrv soc-camera-pdrv.1: Probing soc-camera-pdrv.1
ml86v7667 0-0043: chip found @ 0x43 (i2c-rcar)
sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xffe4c000 clock rate 66 MHz
sh_mmcif sh_mmcif: driver version 2010-04-28
asoc-simple-card asoc-simple-card.0: ASoC: CPU DAI rsnd-dai.0 not registered
platform asoc-simple-card.0: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.1: ASoC: CPU DAI rsnd-dai.1 not registered
platform asoc-simple-card.1: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.2: ASoC: CPU DAI rsnd-dai.2 not registered
platform asoc-simple-card.2: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.3: ASoC: CPU DAI rsnd-dai.3 not registered
platform asoc-simple-card.3: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.4: ASoC: CPU DAI rsnd-dai.4 not registered
platform asoc-simple-card.4: Driver asoc-simple-card requests probe deferral
pinmux core: sh-pfc does not support function audio_clk
sh-pfc pfc-r8a7778: invalid function audio_clk in map table
pinmux core: sh-pfc does not support function audio_clk
sh-pfc pfc-r8a7778: invalid function audio_clk in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
pinmux core: sh-pfc does not support function ssi
sh-pfc pfc-r8a7778: invalid function ssi in map table
rcar_sound rcar_sound: probed
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
ehci-platform ehci-platform: EHCI Host Controller
ehci-platform ehci-platform: new USB bus registered, assigned bus number 1
ehci-platform ehci-platform: irq 76, io mem 0xffe70000
ehci-platform ehci-platform: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.12.0-00001-gd89cd30 ehci_hcd
usb usb1: SerialNumber: ehci-platform
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci-platform ohci-platform: Generic Platform OHCI controller
ohci-platform ohci-platform: new USB bus registered, assigned bus number 2
ohci-platform ohci-platform: irq 76, io mem 0xffe70400
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Generic Platform OHCI controller
usb usb2: Manufacturer: Linux 3.12.0-00001-gd89cd30 ohci_hcd
usb usb2: SerialNumber: ohci-platform
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
asoc-simple-card asoc-simple-card.0:  ak4642-hifi <-> rsnd-dai.0 mapping ok
asoc-simple-card asoc-simple-card.1:  ak4554-hifi <-> rsnd-dai.1 mapping ok
asoc-simple-card asoc-simple-card.2:  ak4554-hifi <-> rsnd-dai.2 mapping ok
asoc-simple-card asoc-simple-card.3:  ak4554-hifi <-> rsnd-dai.3 mapping ok
asoc-simple-card asoc-simple-card.4:  ak4554-hifi <-> rsnd-dai.4 mapping ok
rtc-rx8581 0-0051: low voltage detected, date/time is not reliable.
rtc-rx8581 0-0051: setting system clock to 2000-01-01 00:00:02 UTC (946684802)
smsc911x smsc911x eth0: SMSC911x/921x identified at 0xd0982000, IRQ: 2000
Sending DHCP requests ..., OK
IP-Config: Got DHCP answer from 10.3.3.254, my address is 10.3.3.156
IP-Config: Complete:
     device=eth0, hwaddr=2e:09:0a:00:2f:04, ipaddr=10.3.3.156, mask=255.255.255.0, gw=10.3.3.254
     host=10.3.3.156, domain=isobedori.kobe.vergenet.net kanocho.kobe.vergenet.net vergenet., nis-domain=(none)
     bootserver=10.3.3.135, rootserver=10.3.3.135, rootpath=/srv/nfs/bockw-armhf,rsize=1024,wsize=1024
     nameserver0=10.3.3.254
ALSA device list:
  #0: SSI56-AK4643
  #1: SSI3-AK4554(playback)
  #2: SSI4-AK4554(capture)
  #3: SSI7-AK4554(playback)
  #4: SSI8-AK4554(capture)
VFS: Mounted root (nfs filesystem) on device 0:9.
Freeing unused kernel memory: 124K (c0383000 - c03a2000)
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...done.
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux 2.20.1
done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Cleaning up ifupdown....
Setting up networking....
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/2e:09:0a:00:2f:04
Sending on   LPF/eth0/2e:09:0a:00:2f:04
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPOFFER from 10.3.3.254
DHCPACK from 10.3.3.254
RTNETLINK answers: File exists
bound to 10.3.3.156 -- renewal in 252 seconds.
done.
Cleaning up temporary files....
Setting up ALSA...done.
Setting kernel variables ...done.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting enhanced syslogd: rsyslogd.
Starting periodic command scheduler: cron.
Starting system message bus: dbus.
Starting OpenBSD Secure Shell server: sshd.

Debian GNU/Linux wheezy/sid debian ttySC0

debian login: 
Debian GNU/Linux wheezy/sid debian ttySC0

debian login: root
Password: 
Last login: Thu Jan  1 00:01:42 UTC 1970 on ttySC0
Linux debian 3.12.0-00001-gd89cd30 #8 Thu Nov 14 14:26:15 JST 2013 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@debian:~# cat /proc/interrupts 
            CPU0       
  59:      11804       GIC   59  renesas_intc_irqpin
  60:          0       GIC   60  renesas_intc_irqpin
  61:          0       GIC   61  renesas_intc_irqpin
  62:          0       GIC   62  renesas_intc_irqpin
  64:      21164       GIC   64  sh_tmu.0
  76:          1       GIC   76  ehci_hcd:usb1, ohci_hcd:usb2
  90:          0       GIC   90  r8a7778-vin.0, r8a7778-vin.1
  93:        280       GIC   93  sh_mmcif
  99:        350       GIC   99  i2c-rcar.0
 102:        339       GIC  102  sh-sci.0:mux
 108:          0       GIC  108  i2c-rcar.2
 109:          0       GIC  109  i2c-rcar.3
 110:          0       GIC  110  i2c-rcar.1
 119:         52       GIC  119  sh_mobile_sdhi.0
 126:          0       GIC  126  hpb-dma.0, hpb-dma.1
 133:          0       GIC  133  rcar_sound, rcar_sound
 134:          0       GIC  134  rcar_sound, rcar_sound, rcar_sound, rcar_sound
2000:      11804  renesas_intc_irqpin    0  eth0
 Err:          0

--k1lZvvs/B4yU6o8G--
