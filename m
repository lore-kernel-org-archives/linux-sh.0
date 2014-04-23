From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 23 Apr 2014 11:09:22 +0000
Subject: Re: [PATCH v4 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <19695574.xjNIjvhPcl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 23 April 2014 11:06:32 Simon Horman wrote:
> On Tue, Apr 22, 2014 at 12:50:41PM +0200, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set switches all Renesas platforms to the new style CMT, MTU2
> > and TMU device platform data. All patches have been previously posted as
> > part of the "[PATCH v3 00/52] Renesas CMT and TMU cleanups" and "[PATCH
> > 00/22] SH MTU2 DT support" patch series.
> > 
> > This new version just rebases the patches on top of the clockevents branch
> > that contains the latest driver cleanups, found at
> > 
> > 	git://git.linaro.org/people/daniel.lezcano/linux.git
> > 	clockevents/cmt-mtu2-tmu-cleanups> 
> > Simon, could you please pull that branch in your tree and apply this
> > series on top of it ? Furthermore, as I have other pending patches for
> > the driver side, could you do so in a separate topic branch that Daniel
> > could merge into his tree ?
> 
> With this series applied Bock-W fails to boot both using Legacy-C and DT-
> reference, and mackerel fails to boot (using Legacy-C).
> In each case the boot hangs and I gave up after waiting two minutes.
> 
> I have supplied boot logs below.
> I have used the defconfig for each board, tweaking
> the result to allow booting DT-reference as appropriate.

I've debugged the issue on Mackerel, I had "just" used evt2irq instead of 
intcs_evt2irq for the TMU resources :-/ I'll resubmit this series with the 
problem fixed.

I've also found another issue in the sh_cmt driver that would break bisection 
and have submitted a fix for that separately.

I don't have access to a Bock-W board, could you assist me debugging the issue 
there ? In particular I'd like to first make sure that the patch that breaks 
the kernel is "ARM: shmobile: r8a7778: Switch to new style TMU device". If 
that's correct I'll ask you to please test a debugging patch. Another option 
would be to give me remote access to a Bock-W board if that's possible.

> I have not tested the SH boards and indeed I have no means to test most of
> them. It does seem to me, given my results from testing on the ARM side,
> that there is scope for regression on the SH side. I wonder if we can avoid
> updating support for legacy boards which we can't verify.

Not if we want to move forward with the driver and implement DT support I'm 
afraid. arch/sh/ is unmaintained and untestable, I thus don't think it 
qualifies as a platform that should prevent us moving forward. We should of 
course be as careful as possible not to break it, but at the end of the day, 
we can't stall ARM development because of SH.

> *** Bock-W Legacy-C ***
> Booting Linux on physical CPU 0x0
> Linux version 3.15.0-rc2-00070-gca099ba
> (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian
> 4.7.2-4) ) #1788 Wed Apr 23 10:42:02 JST 2014 CPU: ARMv7 Processor
> [412fc094] revision 4 (ARMv7), crc53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: bockw
> debug: ignoring loglevel setting.
> Memory policy: Data cache writeback
> On node 0 totalpages: 65536
> free_area_init_node: node 0, pgdat c03f3f80, node_mem_map cfdfb000
>   Normal zone: 512 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 65536 pages, LIFO batch:15
> DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
> CPU: All CPU(s) started in SVC mode.
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> pcpu-alloc: [0] 0
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: console=ttySC0,115200 ignore_loglevel ip=dhcp
> root=/dev/nfs rw PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 255616K/262144K available (3107K kernel code, 146K rwdata, 628K
> rodata, 131K init, 165K bss, 6528K reserved, 0K highmem) Virtual kernel
> memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>       .text : 0xc0008000 - 0xc03ade04   (3736 kB)
>       .init : 0xc03ae000 - 0xc03ced18   ( 132 kB)
>       .data : 0xc03d0000 - 0xc03f4a20   ( 147 kB)
>        .bss : 0xc03f4a20 - 0xc041e108   ( 166 kB)
> NR_IRQS:16 nr_irqs:16 16
> GIC CPU mask not found - kernel will fail to boot.
> GIC CPU mask not found - kernel will fail to boot.
> sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every
> 2097152000000000ns Calibrating delay loop (skipped) preset value.. 532.00
> BogoMIPS (lpj&0000) pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0x6030f168 - 0x6030f19c
> devtmpfs: initialized
> VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> renesas_intc_irqpin renesas_intc_irqpin: driving 4 irqs
> L310 cache controller enabled
> l2x0: 16 ways, CACHE_ID 0x410000c6, AUX_CTRL 0x42460000, Cache size: 1024 kB
> sh-pfc pfc-r8a7778: r8a7778_pfc support registered
> fixed-dummy: no parameters
> fixed-3.3V: at 3300 mV
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Linux video capture interface: v2.00
> sh_tmu sh-tmu.0: ch0: used for clock events
> sh_tmu sh-tmu.0: ch0: used for periodic clock events
> sh_tmu sh-tmu.0: ch1: used as clock source
> Advanced Linux Sound Architecture Driver Initialized.
> Switched to clocksource sh-tmu.0
> NET: Registered protocol family 2
> TCP established hash table entries: 2048 (order: 1, 8192 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP: reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> futex hash table entries: 256 (order: -1, 3072 bytes)
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered
> io scheduler deadline registered (default)
> SuperH (H)SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 102, base_baud = 0) is a scif
> console [ttySC0] enabled
> sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 103, base_baud = 0) is a scif
> sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 104, base_baud = 0) is a scif
> sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 105, base_baud = 0) is a scif
> sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 106, base_baud = 0) is a scif
> sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 107, base_baud = 0) is a scif
> m25p80 spi0.0: found at26df081a, expected s25fl008k
> m25p80 spi0.0: at26df081a (1024 Kbytes)
> Creating 1 MTD partitions on "m25p80":
> 0x000000000000-0x000000100000 : "data(spi)"
> libphy: smsc911x-mdio: probed
> [hang!]
> 
> *** Bock-W DT-Reference ***
> 
> Booting Linux on physical CPU 0x0
> Linux version 3.15.0-rc2-00070-gca099ba
> (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian
> 4.7.2-4) ) #1789 Wed Apr 23 10:46:01 JST 2014 CPU: ARMv7 Processor
> [412fc094] revision 4 (ARMv7), crc53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: bockw
> debug: ignoring loglevel setting.
> Memory policy: Data cache writeback
> On node 0 totalpages: 65536
> free_area_init_node: node 0, pgdat c03f3c00, node_mem_map cfdfb000
>   Normal zone: 512 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 65536 pages, LIFO batch:15
> DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
> CPU: All CPU(s) started in SVC mode.
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> pcpu-alloc: [0] 0
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: console=ttySC0,115200 ignore_loglevel root=/dev/nfs
> ip=dhcp rw PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 255616K/262144K available (3107K kernel code, 145K rwdata, 628K
> rodata, 129K init, 165K bss, 6528K reserved, 0K highmem) Virtual kernel
> memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>       .text : 0xc0008000 - 0xc03ade04   (3736 kB)
>       .init : 0xc03ae000 - 0xc03ce5d8   ( 130 kB)
>       .data : 0xc03d0000 - 0xc03f46a0   ( 146 kB)
>        .bss : 0xc03f46a0 - 0xc041dd88   ( 166 kB)
> NR_IRQS:16 nr_irqs:16 16
> GIC CPU mask not found - kernel will fail to boot.
> GIC CPU mask not found - kernel will fail to boot.
> sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every
> 2097152000000000ns Calibrating delay loop (skipped) preset value.. 532.00
> BogoMIPS (lpj&0000) pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0x6030efe8 - 0x6030f01c
> devtmpfs: initialized
> VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> L310 cache controller enabled
> l2x0: 16 ways, CACHE_ID 0x410000c6, AUX_CTRL 0x42460000, Cache size: 1024 kB
> renesas_intc_irqpin fe78001c.irqpin: driving 4 irqs
> sh-pfc fffc0000.pfc: r8a7778_pfc support registered
> fixed-3.3V: 3300 mV
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Linux video capture interface: v2.00
> sh_tmu sh-tmu.0: ch0: used for clock events
> sh_tmu sh-tmu.0: ch0: used for periodic clock events
> sh_tmu sh-tmu.0: ch1: used as clock source
> Advanced Linux Sound Architecture Driver Initialized.
> Switched to clocksource sh-tmu.0
> NET: Registered protocol family 2
> TCP established hash table entries: 2048 (order: 1, 8192 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP: reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> futex hash table entries: 256 (order: -1, 3072 bytes)
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered
> io scheduler deadline registered (default)
> SuperH (H)SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 102, base_baud = 0) is a scif
> console [ttySC0] enabled
> sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 103, base_baud = 0) is a scif
> sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 104, base_baud = 0) is a scif
> sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 105, base_baud = 0) is a scif
> sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 106, base_baud = 0) is a scif
> sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 107, base_baud = 0) is a scif
> m25p80 spi0.0: found at26df081a, expected s25fl008k
> m25p80 spi0.0: at26df081a (1024 Kbytes)
> 1 ofpart partitions found on MTD device spi0.0
> Creating 1 MTD partitions on "spi0.0":
> 0x000000000000-0x000000100000 : "data(spi)"
> libphy: smsc911x-mdio: probed
> [hang!]
> 
> *** Mackerel (Legacy-C) ***
> Booting Linux on physical CPU 0x0
> Linux version 3.15.0-rc2-00070-gca099ba
> (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian
> 4.7.2-4) ) #1790 Wed Apr 23 10:49:28 JST 2014 CPU: ARMv7 Processor
> [413fc081] revision 1 (ARMv7), crc53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: Mackerel (AP4 EVM 2nd)
> Memory policy: Data cache writeback
> CPU: All CPU(s) started in SVC mode.
> bootconsole [early_ttySC0] enabled
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 60960
> Kernel command line: console=tty0, console=ttySC0,115200
> earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp mem$0m
> rw PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 238352K/245760K available (3471K kernel code, 198K rwdata, 1084K
> rodata, 148K init, 176K bss, 7408K reserved) Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xcf800000 - 0xff000000   ( 760 MB)
>     lowmem  : 0xc0000000 - 0xcf000000   ( 240 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0xc0008000 - 0xc047bf4c   (4560 kB)
>       .init : 0xc047c000 - 0xc04a11b8   ( 149 kB)
>       .data : 0xc04a2000 - 0xc04d39c0   ( 199 kB)
>        .bss : 0xc04d39c0 - 0xc04ffc90   ( 177 kB)
> NR_IRQS:16 nr_irqs:16 16
> intc: Registered controller 'sh7372-intca' with 108 IRQs
> intc: Registered controller 'sh7372-intca-irq-lo' with 16 IRQs
> intc: Registered controller 'sh7372-intca-irq-hi' with 16 IRQs
> intc: Registered controller 'sh7372-intcs' with 61 IRQs
> sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every
> 16777216000000000ns Console: colour dummy device 80x30
> console [tty0] enabled
>  sh-tmu.0: ch0: used for clock events
>  sh-tmu.0: ch0: used for periodic clock events
>  sh-tmu.0: ch1: used as clock source
>  sh-cmt-32-fast.2: ch0: used for clock events
>  sh-cmt-32-fast.2: ch0: used as clock source
> Calibrating delay loop...
> [hang!]

-- 
Regards,

Laurent Pinchart

