From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sun, 20 Jan 2008 00:30:09 +0000
Subject: [PCMCIA/HD64461 - DEBUG] : Normal Socket behaviour?
Message-Id: <20080120013027.1293678c.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Greetings,

Added some printk code to atmel wifi driver to see if it ever reached there=
, didn't get any output, so I assume the driver never gets loaded.
Added heavier debug printk's inside pcmcia driver and this is what came out=
. I can of course add more but looks weird, could anyone give me some feedb=
ack. I hope the printk's are self-explanatory. Search for hd64461.

Im somewhat suprised that set_mem_map is being called so heavily.

Best wishes
Kristoffer

Bootlog:
Linux version 2.6.24-rc7-dirty (kristoffer@NightCrawler) (gcc version 3.4.5=
) #15 Sun Jan 20 01:03:08 PST 2008
Using mem=3D to increase the size of kernel memory is not allowed.
  Recompile the kernel with the correct value for CONFIG_MEMORY_SIZE.
Booting machvec: HP Jornada 6xx
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
Memory: 12116k/15360k available (2225k kernel code, 665k data, 76k init)
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
hd64461: enabling pcmcia slot 1 (type : storage)
hd64461: enabling pcmcia slot 0 (type : storage/io)
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
ata1.00: CFA: Hitachi XX.V.3.5.0.0, Rev 0.00, max PIO4
ata1.00: 2002896 sectors, multi 0: LBA=20
ata1.00: configured for PIO
ata1.00: configured for PIO
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      Hitachi XX.V.3.5 Rev  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2002896 512-byte hardware sectors (1025 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
sd 0:0:0:0: [sda] 2002896 512-byte hardware sectors (1025 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI removable disk
hd64461_ss_init: pcmcia driver for hd64461 chipset started
hd64461_interrupt: Passing Interrupt to CARD_DRIVER
hd64461_ss_init: setting socket device
hd64461_set_voltage: 0 Vcc, 0 Vpp
hd64461_init: setting 0 Vcc, 0 Vpp
hd64461: entering hd64461_set_socket
hd64461_set_socket: SS_DETECT and state changed
hd64461_set_socket: We've passed the routine successfully
hd64461_ss_init: return value 0 from pcmcia_register_socket
input: HP Jornada 680 keyboard as /devices/platform/jornada680_kbd/input/in=
put0
hd64461 : getting status from slot, ff
hd64461: setting status to SS_DETECT
hd64461: IC_memory =3D 1
hd64461: setting status to SS_READY
hd64461: setting status to SS_WRPROT
hd64461: setting no status at all
hd64461: will return status =3D c1
hd64461 : getting status from slot, ff
hd64461: setting status to SS_DETECT
hd64461: IC_memory =3D 1
hd64461: setting status to SS_READY
hd64461: setting status to SS_WRPROT
hd64461: setting no status at all
hd64461: will return status =3D c1
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
sh-rtc sh-rtc: setting system clock to 1999-01-01 00:01:23 UTC (915148883)
hd64461 : getting status from slot, ff
hd64461: setting status to SS_DETECT
hd64461: IC_memory =3D 1
hd64461: setting status to SS_READY
hd64461: setting status to SS_WRPROT
hd64461: setting no status at all
hd64461: will return status =3D c1
hd64461: entering hd64461_set_socket
hd64461_set_voltage: 50 Vcc, 50 Vpp
hd64461_set_socket: We've passed the routine successfully
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 76k freed
hd64461 : getting status from slot, ff
hd64461: setting status to SS_DETECT
hd64461: IC_memory =3D 1
hd64461: setting status to SS_READY
hd64461: setting status to SS_WRPROT
hd64461: setting no status at all
hd64461: setting status to SS_POWERON
hd64461: will return status =3D 1c1
hd64461: entering hd64461_set_socket
hd64461_set_socket: SS_RESET and state changed
hd64461_set_socket: SS_OUTPUT_ENA and state changed
hd64461_set_socket: We've passed the routine successfully
hd64461: entering hd64461_set_socket
hd64461_set_socket: SS_RESET and state changed
hd64461_set_socket: We've passed the routine successfully
hd64461 : getting status from slot, ff
hd64461: setting status to SS_DETECT
hd64461: IC_memory =3D 1
hd64461: setting status to SS_READY
hd64461: setting status to SS_WRPROT
hd64461: setting no status at all
hd64461: setting status to SS_POWERON
hd64461: will return status =3D 1c1
pccard: PCMCIA card inserted into slot 0
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
hd64461: entering hd64461_set_mem_map
hd64461: settings pointers smem to 8d2fc5cc and saddr to b8000000
hd64461: mem->static_start =3D saddr (b8000000)
/bin/sh: can't access tty; job control turned off
/ $ hd64461_interrupt: Passing Interrupt to SLOT_DRIVER (card inserted here)
hd64461_interrupt: Passing SS_DETECT to events
hd64461_interrupt: we are pushing changed events! events=128
hd64461 : getting status from slot, a3
hd64461: will return status =3D 0
pccard: card ejected from slot 0
hd64461_set_voltage: 0 Vcc, 0 Vpp
hd64461_init: setting 0 Vcc, 0 Vpp
hd64461: entering hd64461_set_socket
hd64461_set_socket: SS_OUTPUT_ENA and state changed
hd64461_set_socket: We've passed the routine successfully
hd64461 : getting status from slot, a3
hd64461: will return status =3D 0
iwconfig
/ $ iwconfig
/ $ ifconfig
ifconfig: Warning: cannot open /proc/net/dev. Limited output.: No such file=
 or directory
/ $ moutn =08 =08=08 =08=08 =08nt /p=08=08
/ $ mount /proc/=1B[J -t procfs
/ $=20
/ $ mount /proc/ -t procfs=1B[J
/ $ ifconfig=1B[J
/ $ iwconfig=1B[J
lo        no wireless extensions.

dummy0    no wireless extensions.

/ $

--=20
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
