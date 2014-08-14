From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Aug 2014 06:16:20 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()
Message-Id: <20140814061617.GD26709@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407930300-10988-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1407930300-10988-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 13, 2014 at 01:45:00PM +0200, Geert Uytterhoeven wrote:
> Add the missing call to shmobile_init_late() to r8a7778_init_late().
> This should make sure Suspend-to-RAM and CPUIdle are setup as expected
> on bockw.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested

Hi Geert,

while this may be part of the puzzle my light testing shows
that suspend-to-ram does not appear to work with this patch applied.

My procedure is as followw.

1. Apply this patch on top of renesas-devel-v3.16-20140811
2. make bockw_defconfig
3. Select CONFIG_SUSPEND
4. Update r8a7778-bockw.dts to include no_console_suspend in bootargs
4. Boot and then:

   i. echo enabled > /sys/devices/platform/sh-sci.0/tty/ttySC0/power/wakeup
   ii. echo mem > /sys/power/wakeup_count

The boot log and then the panic that occurred on suspend follow:



Booting Linux on physical CPU 0x0
Linux version 3.16.0-00001-g535da58-dirty (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #44 Thu Aug 14 15:08:35 JST 2014
CPU: ARMv7 Processor [412fc094] revision 4 (ARMv7), crc53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: bockw
debug: ignoring loglevel setting.
Memory policy: Data cache writeback
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c0407f08, node_mem_map cfdfa000
  Normal zone: 512 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65536 pages, LIFO batch:15
DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
CPU: All CPU(s) started in SVC mode.
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs rw no_console_suspend
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255532K/262144K available (3179K kernel code, 146K rwdata, 636K rodata, 134K init, 165K bss, 6612K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc03c1e14   (3816 kB)
      .init : 0xc03c2000 - 0xc03e3908   ( 135 kB)
      .data : 0xc03e4000 - 0xc04089e0   ( 147 kB)
       .bss : 0xc04089e0 - 0xc0432128   ( 166 kB)
NR_IRQS:16 nr_irqs:16 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 2097152000000000ns
Calibrating delay loop (skipped) preset value.. 532.00 BogoMIPS (lpj&0000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x60320958 - 0x603209b0
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_intc_irqpin renesas_intc_irqpin: driving 4 irqs
L2C: DT/platform modifies aux control register: 0x02000000 -> 0x02400000
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 64 kB
L2C-310: CACHE_ID 0x410000c6, AUX_CTRL 0x46400001
sh-pfc pfc-r8a7778: r8a7778_pfc support registered
fixed-dummy: no parameters
fixed-3.3V: at 3300 mV 
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
sh_tmu sh-tmu.0: ch0: used for clock events
sh_tmu sh-tmu.0: ch0: used for periodic clock events
sh_tmu sh-tmu.0: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource sh-tmu.0
sh_tmu sh-tmu.0: ch0: used for oneshot clock events
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
sh_mobile_sdhi sh_mobile_sdhi.0: No vmmc regulator found
sh_mobile_sdhi sh_mobile_sdhi.0: No vqmmc regulator found
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
usb usb1: New USB device found, idVendor6b, idProduct 02
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.16.0-00001-g535da58-dirty ehci_hcd
usb usb1: SerialNumber: ehci-platform
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci-platform ohci-platform: Generic Platform OHCI controller
ohci-platform ohci-platform: new USB bus registered, assigned bus number 2
ohci-platform ohci-platform: irq 76, io mem 0xffe70400
usb usb2: New USB device found, idVendor6b, idProduct 01
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Generic Platform OHCI controller
usb usb2: Manufacturer: Linux 3.16.0-00001-g535da58-dirty ohci_hcd
usb usb2: SerialNumber: ohci-platform
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
asoc-simple-card asoc-simple-card.0: ak4642-hifi <-> rsnd-dai.0 mapping ok
asoc-simple-card asoc-simple-card.1: ak4554-hifi <-> rsnd-dai.1 mapping ok
asoc-simple-card asoc-simple-card.2: ak4554-hifi <-> rsnd-dai.2 mapping ok
asoc-simple-card asoc-simple-card.3: ak4554-hifi <-> rsnd-dai.3 mapping ok
asoc-simple-card asoc-simple-card.4: ak4554-hifi <-> rsnd-dai.4 mapping ok
rtc-rx8581 0-0051: low voltage detected, date/time is not reliable.
rtc-rx8581 0-0051: setting system clock to 2000-01-01 00:00:06 UTC (946684806)
smsc911x smsc911x eth0: SMSC911x/921x identified at 0xd0980000, IRQ: 2000
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.3.3.254, my address is 10.3.3.156
IP-Config: Complete:
     device=eth0, hwaddr.:09:0a:00:2f:04, ipaddr.3.3.156, mask%5.255.255.0, gw.3.3.254
     host.3.3.156, domain=isobedori.kobe.vergenet.net kanocho.kobe.vergenet.net vergenet., nis-domain=(none)
     bootserver.3.3.135, rootserver.3.3.135, rootpath=/srv/nfs/bockw-armhf,rsize24,wsize24
     nameserver0.3.3.254, nameserver1.4.3.254, nameserver2=8.8.8.8
ALSA device list:
  #0: SSI56-AK4643
  #1: SSI3-AK4554(playback)
  #2: SSI4-AK4554(capture)
  #3: SSI7-AK4554(playback)
  #4: SSI8-AK4554(capture)
VFS: Mounted root (nfs filesystem) on device 0:11.
devtmpfs: mounted
Freeing unused kernel memory: 132K (c03c2000 - c03e3000)
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevdudevd[419]: starting version 175
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
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from 10.3.3.254
RTNETLINK answers: File exists
bound to 10.3.3.156 -- renewal in 279 seconds.
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
---
Testing QSPI performance. Expect 1MB/s or more
dd: opening `/dev/mtd0': No such file or directory
da39a3ee5e6b4b0d3255bfef95601890afd80709  -
---
Testing CPU freq. Expect two or three different frequencies
/etc/rc.local: 22: /etc/rc.local: cannot create /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor: Directory nonexistent
startpar: service(s) returned failure: rc.local ... failed!

Debian GNU/Linux wheezy/sid debian ttySC0

debian login: root
Password: 
Last login: Sat Jan  1 00:00:34 UTC 2000 on ttySC0
Linux debian 3.16.0-00001-g535da58-dirty #44 Thu Aug 14 15:08:35 JST 2014 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@debian:~# dmesg | grep console
Kernel command line: console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs rw no_console_suspend
console [ttySC0] enabled
root@debian:~# echo enabled > /sys/devices/platform/sh-sci.0/tty/ttySC0/power/wakeup
root@debian:~# cat !$
cat /sys/devices/platform/sh-sci.0/tty/ttySC0/power/wakeup
enabled
root@debian:~# echo mem > /sys/power/wakeup_count 
-bash: echo: write error: Invalid argument
INIT: Id "2" respawning too fast: disabled for 5 minutes
INIT: Id "1" respawning too fast: disabled for 5 minutes
ate 
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.002 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
rtc-rx8581 0-0051: low voltage detected, date/time is not reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000620
pgd = cfbec000
[00000620] *pgdobd1831, *pte 000000, *ppte 000000
Internal error: Oops: 17 [#1] ARM
CPU: 0 PID: 1591 Comm: bash Not tainted 3.16.0-00001-g535da58-dirty #44
task: cfaa54c0 ti: cfaa8000 task.ti: cfaa8000
PC is at smsc911x_suspend+0x18/0x3c
LR is at dpm_run_callback.isra.11+0x24/0x50
pc : [<c01d588c>]    lr : [<c019c004>]    psr: a0000093
sp : cfaa9d98  ip : cfaa9db0  fp : cfaa9dac
r10: 00000000  r9 : c03fbe78  r8 : 00000000
r7 : cfa24474  r6 : c0426b7c  r5 : c01d5874  r4 : a0000013
r3 : 00000000  r2 : 00000000  r1 : cfa24440  r0 : 00000000
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 6fbec059  DAC: 00000015
Process bash (pid: 1591, stack limit = 0xcfaa8238)
Stack: (0xcfaa9d98 to 0xcfaaa000)
9d80:                                                       00000000 cfa24440
9da0: cfaa9dcc cfaa9db0 c019c004 c01d5880 cfa451fc cfa24440 cfa24440 00000002
9dc0: cfaa9e04 cfaa9dd0 c019d528 c019bfec cf99fc8c cf99fcc0 c0426b7c 003fbe64
9de0: cfa24498 cfa24498 c0426b7c c03fbe64 cfa24440 c03f38c4 cfaa9e4c cfaa9e08
9e00: c019d708 c019d40c 205772c7 0000001d c019bf78 00000002 205772c7 0000001d
9e20: 00000000 00000002 00000000 00000000 c040b358 c03f3970 c0391830 00000004
9e40: cfaa9e64 cfaa9e50 c019d924 c019d6bc c0017820 00000003 cfaa9ea4 cfaa9e68
9e60: c00416e0 c019d8d0 00000000 cfaa9e84 cfaa9ea4 cfaa9e90 c0041460 c031ca8c
9e80: 00000003 00000000 00000003 00000003 c03f3970 00000004 cfaa9ebc cfaa9ea8
9ea0: c00419f0 c004169c cf835200 c03f3968 cfaa9eec cfaa9ec0 c0040d00 c0041988
9ec0: 00000004 cf837678 cf835200 cf835f80 cf835200 cfaa9f78 00000000 cf835f8c
9ee0: cfaa9efc cfaa9ef0 c0155204 c0040c94 cfaa9f14 cfaa9f00 c00e33c4 c01551f4
9f00: 00000000 00000000 cfaa9f44 cfaa9f18 c00e2a30 c00e3384 00000000 00000000
9f20: cf9ec100 00000004 000b2c08 cfaa9f78 00000000 00000000 cfaa9f74 cfaa9f48
9f40: c0091348 c00e2970 c00a9110 c00a867c cf9ec100 cf9ec100 00000004 000b2c08
9f60: 00000000 00000000 cfaa9fa4 cfaa9f78 c0091508 c009129c 00000000 00000000
9f80: b6eb55e0 00000004 000b2c08 00000004 c000e484 cfaa8000 00000000 cfaa9fa8
9fa0: c000e300 c00914cc b6eb55e0 00000004 00000001 000b2c08 00000004 00000000
9fc0: b6eb55e0 00000004 000b2c08 00000004 bef6fa94 000ad094 00000000 000b5398
9fe0: 00000004 bef6fa18 b6e2496d b6e5cb9c 40000010 00000001 00000000 00000000
Backtrace: 
[<c01d5874>] (smsc911x_suspend) from [<c019c004>] (dpm_run_callback.isra.11+0x24/0x50)
 r4:cfa24440 r3:00000000
[<c019bfe0>] (dpm_run_callback.isra.11) from [<c019d528>] (__device_suspend+0x128/0x2b0)
 r5:00000002 r4:cfa24440
[<c019d400>] (__device_suspend) from [<c019d708>] (dpm_suspend+0x58/0x214)
 r8:c03f38c4 r7:cfa24440 r6:c03fbe64 r5:c0426b7c r4:cfa24498
[<c019d6b0>] (dpm_suspend) from [<c019d924>] (dpm_suspend_start+0x60/0x68)
 r10:00000004 r9:c0391830 r8:c03f3970 r7:c040b358 r6:00000000 r5:00000000
 r4:00000002
[<c019d8c4>] (dpm_suspend_start) from [<c00416e0>] (suspend_devices_and_enter+0x50/0x2ec)
 r4:00000003 r3:c0017820
[<c0041690>] (suspend_devices_and_enter) from [<c00419f0>] (pm_suspend+0x74/0x200)
 r10:00000004 r8:c03f3970 r7:00000003 r6:00000003 r5:00000000 r4:00000003
[<c004197c>] (pm_suspend) from [<c0040d00>] (state_store+0x78/0xdc)
 r5:c03f3968 r4:cf835200
[<c0040c88>] (state_store) from [<c0155204>] (kobj_attr_store+0x1c/0x28)
 r10:cf835f8c r9:00000000 r8:cfaa9f78 r7:cf835200 r6:cf835f80 r5:cf835200
 r4:cf837678 r3:00000004
[<c01551e8>] (kobj_attr_store) from [<c00e33c4>] (sysfs_kf_write+0x4c/0x50)
[<c00e3378>] (sysfs_kf_write) from [<c00e2a30>] (kernfs_fop_write+0xcc/0x18c)
 r5:00000000 r4:00000000
[<c00e2964>] (kernfs_fop_write) from [<c0091348>] (vfs_write+0xb8/0x1a8)
 r10:00000000 r8:00000000 r7:cfaa9f78 r6:000b2c08 r5:00000004 r4:cf9ec100
[<c0091290>] (vfs_write) from [<c0091508>] (SyS_write+0x48/0x88)
 r10:00000000 r8:00000000 r7:000b2c08 r6:00000004 r5:cf9ec100 r4:cf9ec100
[<c00914c0>] (SyS_write) from [<c000e300>] (ret_fast_syscall+0x0/0x30)
 r9:cfaa8000 r8:c000e484 r7:00000004 r6:000b2c08 r5:00000004 r4:b6eb55e0
Code: e24cb004 e590004c e10f4000 f10c0080 (e5903620) 
---[ end trace 4fd4e37d8aa32295 ]---

