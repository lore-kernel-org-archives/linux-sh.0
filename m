From: Simon Horman <horms@verge.net.au>
Date: Fri, 02 May 2014 01:40:16 +0000
Subject: Re: [PATCH v4 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <20140502014015.GE2265@verge.net.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
List-Id: <linux-sh.vger.kernel.org>
References: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 01, 2014 at 06:51:55PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 24 April 2014 09:21:40 Simon Horman wrote:
> > On Wed, Apr 23, 2014 at 01:09:22PM +0200, Laurent Pinchart wrote:
> > > On Wednesday 23 April 2014 11:06:32 Simon Horman wrote:
> > > > On Tue, Apr 22, 2014 at 12:50:41PM +0200, Laurent Pinchart wrote:
> > > > > Hello,
> > > > > 
> > > > > This patch set switches all Renesas platforms to the new style CMT,
> > > > > MTU2 and TMU device platform data. All patches have been previously
> > > > > posted as part of the "[PATCH v3 00/52] Renesas CMT and TMU cleanups"
> > > > > and "[PATCH 00/22] SH MTU2 DT support" patch series.
> > > > > 
> > > > > This new version just rebases the patches on top of the clockevents
> > > > > branch that contains the latest driver cleanups, found at
> > > > > 
> > > > > 	git://git.linaro.org/people/daniel.lezcano/linux.git
> > > > > 	clockevents/cmt-mtu2-tmu-cleanups>
> > > > > 
> > > > > Simon, could you please pull that branch in your tree and apply this
> > > > > series on top of it ? Furthermore, as I have other pending patches for
> > > > > the driver side, could you do so in a separate topic branch that
> > > > > Daniel could merge into his tree ?
> > > > 
> > > > With this series applied Bock-W fails to boot both using Legacy-C and
> > > > DT-reference, and mackerel fails to boot (using Legacy-C).
> > > > In each case the boot hangs and I gave up after waiting two minutes.
> > > > 
> > > > I have supplied boot logs below.
> > > > I have used the defconfig for each board, tweaking
> > > > the result to allow booting DT-reference as appropriate.
> > > 
> > > I've debugged the issue on Mackerel, I had "just" used evt2irq instead of
> > > intcs_evt2irq for the TMU resources :-/ I'll resubmit this series with the
> > > problem fixed.
> > > 
> > > I've also found another issue in the sh_cmt driver that would break
> > > bisection and have submitted a fix for that separately.
> > > 
> > > I don't have access to a Bock-W board, could you assist me debugging the
> > > issue there ? In particular I'd like to first make sure that the patch
> > > that breaks the kernel is "ARM: shmobile: r8a7778: Switch to new style
> > > TMU device". If that's correct I'll ask you to please test a debugging
> > > patch. Another option would be to give me remote access to a Bock-W board
> > > if that's possible.
> >
> > Of course I am happy to help.
> > 
> > I reverted "ARM: shmobile: r8a7778: Switch to new style TMU device" and
> > the Bock-W once again boots, both using legacy-C and DT-reference.
> > 
> > With regards to debugging, I think that if this becomes a drawn-out process
> > then it will be easiest for both of us if I give you remote-access. But
> > as that requires some re-arrangement of things on my side perhaps it would
> > be easiest if you sent me a debug patch for now.
> 
> I've attached a debugging patch to this e-mail. Could you please boot the 
> BockW board with that patch applied before (working) and after (broken) 
> applying "ARM: shmobile: r8a7778: Switch to new style TMU device" and provide 
> me with the two boot logs ?

Sure, please see the attached logs.

In both cases I used the bockw_defconfig (and booted using Legacy-C).

In the case of the log bad.txt, the boot hung (I waited for 120sec)
at the point where the log ends.

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="good.txt"

$ bootp;bootm
smc911x: detected LAN89218 controller
smc911x: phy initialized
smc911x: MAC 2e:09:0a:00:2f:04
BOOTP broadcast 1
BOOTP broadcast 2
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
DHCP client bound to address 10.3.3.156
Using smc911x-0 device
TFTP from server 10.3.3.135; our IP address is 10.3.3.156
Filename 'bockw/uImage'.
Load address: 0x60007fc0
Loading: #################################################################
         #################################################################
         #################################################################
         #####
done
Bytes transferred = 1597418 (185fea hex)
## Booting kernel from Legacy Image at 60007fc0 ...
   Image Name:   'Linux-3.15.0-rc1-00072-gef52e65
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1597354 Bytes = 1.5 MiB
   Load Address: 60008000
   Entry Point:  60008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.15.0-rc1-00072-gef52e65-dirty (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian 4.7.2-4) ) #1893 Fri May 2 10:25:22 JST 2014
CPU: ARMv7 Processor [412fc094] revision 4 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: bockw
debug: ignoring loglevel setting.
Memory policy: Data cache writeback
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c03f3f00, node_mem_map cfdfb000
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
Memory: 255616K/262144K available (3107K kernel code, 146K rwdata, 628K rodata, 131K init, 165K bss, 6528K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc03ade04   (3736 kB)
      .init : 0xc03ae000 - 0xc03cecf8   ( 132 kB)
      .data : 0xc03d0000 - 0xc03f49a0   ( 147 kB)
       .bss : 0xc03f49a0 - 0xc041e088   ( 166 kB)
NR_IRQS:16 nr_irqs:16 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 2097152000000000ns
Calibrating delay loop (skipped) preset value.. 532.00 BogoMIPS (lpj=260000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x6030f278 - 0x6030f2ac
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_intc_irqpin renesas_intc_irqpin: driving 4 irqs
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c6, AUX_CTRL 0x42460000, Cache size: 1024 kB
sh-pfc pfc-r8a7778: r8a7778_pfc support registered
fixed-dummy: no parameters
fixed-3.3V: at 3300 mV 
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
sh_tmu sh_tmu.0: MSTP clock 16 @ffc80030
sh_tmu sh_tmu.0: phys base 0xffd80008 virt base d0964008 size 12
sh_tmu sh_tmu.0: ch0: base d0964008
sh_tmu sh_tmu.0: ch0: used for clock events
sh_tmu sh_tmu.0: ch0: used for periodic clock events
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: clock rate is 16666666
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh_tmu.0: ch0: requesting IRQ 64 for clock event device
sh_tmu sh_tmu.1: MSTP clock 15 @ffc80030
sh_tmu sh_tmu.1: phys base 0xffd80014 virt base d0966014 size 12
sh_tmu sh_tmu.1: ch1: base d0966014
sh_tmu sh_tmu.1: ch1: failed to get irq
Advanced Linux Sound Architecture Driver Initialized.
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
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
futex hash table entries: 256 (order: -1, 3072 bytes)
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
m25p80 spi0.0: found at26df081a, expected s25fl008k
m25p80 spi0.0: at26df081a (1024 Kbytes)
Creating 1 MTD partitions on "m25p80":
0x000000000000-0x000000100000 : "data(spi)"
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
sh_mobile_sdhi.0 supply vmmc not found, using dummy regulator
sh_mobile_sdhi sh_mobile_sdhi.0: Failed getting OCR mask: -22
sh_mobile_sdhi sh_mobile_sdhi.0: could not set regulator OCR (-22)
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
usb usb1: Manufacturer: Linux 3.15.0-rc1-00072-gef52e65-dirty ehci_hcd
usb usb1: SerialNumber: ehci-platform
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci-platform ohci-platform: Generic Platform OHCI controller
ohci-platform ohci-platform: new USB bus registered, assigned bus number 2
ohci-platform ohci-platform: irq 76, io mem 0xffe70400
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Generic Platform OHCI controller
usb usb2: Manufacturer: Linux 3.15.0-rc1-00072-gef52e65-dirty ohci_hcd
usb usb2: SerialNumber: ohci-platform
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
asoc-simple-card asoc-simple-card.0: ak4642-hifi <-> rsnd-dai.0 mapping ok
asoc-simple-card asoc-simple-card.1: ak4554-hifi <-> rsnd-dai.1 mapping ok
asoc-simple-card asoc-simple-card.2: ak4554-hifi <-> rsnd-dai.2 mapping ok
asoc-simple-card asoc-simple-card.3: ak4554-hifi <-> rsnd-dai.3 mapping ok
asoc-simple-card asoc-simple-card.4: ak4554-hifi <-> rsnd-dai.4 mapping ok
rtc-rx8581 0-0051: low voltage detected, date/time is not reliable.
rtc-rx8581 0-0051: setting system clock to 2000-01-01 00:00:22 UTC (946684822)
smsc911x smsc911x eth0: SMSC911x/921x identified at 0xd0982000, IRQ: 2000
Sending DHCP requests .
sh_mobile_sdhi sh_mobile_sdhi.0: could not set regulator OCR (-22)
sh_mobile_sdhi sh_mobile_sdhi.0: could not set regulator OCR (-22)
sh_mobile_sdhi sh_mobile_sdhi.0: could not set regulator OCR (-22)
., OK
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
VFS: Mounted root (nfs filesystem) on device 0:10.
devtmpfs: mounted
Freeing unused kernel memory: 128K (c03ae000 - c03ce000)
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevdudevd[424]: starting version 175
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...done.
random: nonblocking pool is initialized
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
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPOFFER from 10.3.3.254
DHCPACK from 10.3.3.254
RTNETLINK answers: File exists
bound to 10.3.3.156 -- renewal in 285 seconds.
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

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bad.txt"

$ bootp;bootm
smc911x: detected LAN89218 controller
smc911x: phy initialized
smc911x: MAC 2e:09:0a:00:2f:04
BOOTP broadcast 1
BOOTP broadcast 2
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
DHCP client bound to address 10.3.3.156
Using smc911x-0 device
TFTP from server 10.3.3.135; our IP address is 10.3.3.156
Filename 'bockw/uImage'.
Load address: 0x60007fc0
Loading: #################################################################
         #################################################################
         #################################################################
         #####
done
Bytes transferred = 1597418 (185fea hex)
## Booting kernel from Legacy Image at 60007fc0 ...
   Image Name:   'Linux-3.15.0-rc1-00071-ga253bb5
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1597354 Bytes = 1.5 MiB
   Load Address: 60008000
   Entry Point:  60008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.15.0-rc1-00071-ga253bb5-dirty (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian 4.7.2-4) ) #1894 Fri May 2 10:32:44 JST 2014
CPU: ARMv7 Processor [412fc094] revision 4 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: bockw
debug: ignoring loglevel setting.
Memory policy: Data cache writeback
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c03f3f80, node_mem_map cfdfb000
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
Memory: 255616K/262144K available (3107K kernel code, 146K rwdata, 628K rodata, 131K init, 165K bss, 6528K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc03ade04   (3736 kB)
      .init : 0xc03ae000 - 0xc03cec18   ( 132 kB)
      .data : 0xc03d0000 - 0xc03f4a20   ( 147 kB)
       .bss : 0xc03f4a20 - 0xc041e108   ( 166 kB)
NR_IRQS:16 nr_irqs:16 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 2097152000000000ns
Calibrating delay loop (skipped) preset value.. 532.00 BogoMIPS (lpj=260000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x6030f278 - 0x6030f2ac
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_intc_irqpin renesas_intc_irqpin: driving 4 irqs
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c6, AUX_CTRL 0x42460000, Cache size: 1024 kB
sh-pfc pfc-r8a7778: r8a7778_pfc support registered
fixed-dummy: no parameters
fixed-3.3V: at 3300 mV 
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
sh_tmu sh-tmu.0: MSTP clock 16 @ffc80030
sh_tmu sh-tmu.0: phys base 0xffd80000 virt base d0964000 size 48
sh_tmu sh-tmu.0: ch0: base d0964008
sh_tmu sh-tmu.0: ch0: used for clock events
sh_tmu sh-tmu.0: ch0: used for periodic clock events
sh_tmu sh-tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh-tmu.0: ch0: writing TSTR @d0964004
sh_tmu sh-tmu.0: ch0: clock rate is 16666666
sh_tmu sh-tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh-tmu.0: ch0: writing TSTR @d0964004
sh_tmu sh-tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh-tmu.0: ch0: writing TSTR @d0964004
sh_tmu sh-tmu.0: ch0: reading TSTR @d0964004
sh_tmu sh-tmu.0: ch0: writing TSTR @d0964004
sh_tmu sh-tmu.0: ch0: requesting IRQ 96 for clock event device
sh_tmu sh-tmu.0: ch1: base d0964014
sh_tmu sh-tmu.0: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
sh_tmu sh-tmu.0: ch1: reading TSTR @d0964004
sh_tmu sh-tmu.0: ch1: writing TSTR @d0964004
sh_tmu sh-tmu.0: ch1: clock rate is 16666666
sh_tmu sh-tmu.0: ch1: reading TSTR @d0964004
sh_tmu sh-tmu.0: ch1: writing TSTR @d0964004
Switched to clocksource sh-tmu.0
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
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
futex hash table entries: 256 (order: -1, 3072 bytes)
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
m25p80 spi0.0: found at26df081a, expected s25fl008k
m25p80 spi0.0: at26df081a (1024 Kbytes)
Creating 1 MTD partitions on "m25p80":
0x000000000000-0x000000100000 : "data(spi)"
libphy: smsc911x-mdio: probed

--x+6KMIRAuhnl3hBn--
