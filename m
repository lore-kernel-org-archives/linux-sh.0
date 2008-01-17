From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 17 Jan 2008 23:32:02 +0000
Subject: [PATA_PLATFORM] :
Message-Id: <20080118003118.3a1d6ccf.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Greetings,

Paul, this is against latest linux-sh git tree. I suspect It will affect ot=
her platforms also.

Money lines are :
Driver 'sd' needs updating - please use bus_type methods
scsi0 : pata_platform
ata1: PATA max PIO0 mmio cmd 0x150001f0 ctl 0x150001fe irq 77
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x1)
ata1: failed to recover some devices, retrying in 5 secs

Best wishes
Kristoffer


--------------------
Linux version 2.6.24-rc7-gd54ca5fc-dirty (kristoffer@NightCrawler) (gcc ver=
sion 3.4.5) #1 Fri Jan 18 00:03:19 PST 2008
Using mem=3D to increase the size of kernel memory is not allowed.
  Recompile the kernel with the correct value for CONFIG_MEMORY_SIZE.

Booting machvec: hp6xx
Node 0: start_pfn =3D 0xd000, low =3D 0xdf00
Zone PFN ranges:
  Normal      53248 ->    57088
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:    53248 ->    57088
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 3810
Kernel command line: mem2M root=3D/dev/sda2 console=3DttySC1,115200 init=3D=
/bin/sh psplash=FAlse
PID hash table entries: 64 (order: 6, 256 bytes)
Using tmu for system timer
Using 5.528 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 11876k/15360k available (2406k kernel code, 713k data, 84k init)
Mount-cache hash table entries: 512
CPU: SH7729
net_namespace: 64 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb

DMA: Registering DMA API.
DMA: Registering sh_dmac handler (4 channels).
Time: SuperH clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
hd6446x chipset configured at 0xb0000000 on irq 36(mapped into 64 to 79)
hd6446x: enabling pcmcia slot 1 (type : storage)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
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
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x1)
ata1: failed to recover some devices, retrying in 5 secs
input: HP Jornada 680 keyboard as /devices/platform/jornada680_kbd/input/in=
put0
input: HP Jornada touchscreen as /devices/virtual/input/input1
sh-rtc sh-rtc: rtc core: registered sh as rtc0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.=
com>
sh-rtc sh-rtc: setting system clock to 1999-01-01 00:07:56 UTC (915149276)
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=3D" boot option; here are the available parti=
tions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0=
,0)

--=20
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
