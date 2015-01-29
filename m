From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 Jan 2015 00:49:19 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150129004919.GF18731@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150128124645.21199.99590.sendpatchset@little-apple>
In-Reply-To: <20150128124645.21199.99590.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 29, 2015 at 09:35:43AM +0900, Simon Horman wrote:
> On Wed, Jan 28, 2015 at 02:34:43PM +0100, Geert Uytterhoeven wrote:
> > Hi Magnus,
> > 
> > On Wed, Jan 28, 2015 at 1:46 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > > From: Magnus Damm <damm+renesas@opensource.se>
> > >
> > > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> > > domain."), the APE6EVM legacy board support is known to be broken.
> > >
> > > The IRQ numbers of the GIC are now virtual, and no longer match the
> > > hardcoded hardware IRQ numbers in the legacy platform board code.
> > >
> > > To fix this issue specific to non-muliplatform r8a73a4 and APE6EVM:
> > >  1) Instantiate the GIC from platform board code and also
> > >  2) Skip over the DT arch timer as well as
> > >  3) Force delay setup based on DT CPU frequency
> > >
> > > With these 3 fixes in place interrupts on APE6EVM are now unbroken.
> > >
> > > Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
> > > him for the initial work.
> > >
> > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Thanks!
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, I have queued this up as a fix for v3.19.

Actually, perhaps I spoke a little soon there.

Although things seem a bit better booting ape6evm_defconfig still
doesn't make it to userspace.

The bootlog is for renesas-next-20150126-v3.19-rc1 with your patch applied.
A similar result seems to occur using v3.19-rc6 with your patch applied.


Starting kernel ...

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpu
Linux version 3.19.0-rc1 (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #627 SMP Thu Jan 29 09:40:01 JST 2015
CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), crc5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: APE6EVM
Ignoring memory block 0x200000000 - 0x240000000
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0521800, node_mem_map eeffa000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 8 pages/cpu @eefe5000 s11520 r0 d21248 u32768
pcpu-alloc: s11520 r0 d21248 u32768 alloc=8*4096
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034044K/1048576K available (3773K kernel code, 220K rwdata, 980K rodata, 256K init, 188K bss, 14532K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc04ad59c   (4758 kB)
      .init : 0xc04ae000 - 0xc04ee000   ( 256 kB)
      .data : 0xc04ee000 - 0xc0525358   ( 221 kB)
       .bss : 0xc0525358 - 0xc055457c   ( 189 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped) preset value.. 1500.40 BogoMIPS (lpjX59375)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40393df8 - 0x40393e50
Brought up 1 CPUs
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc pfc-r8a73a4: r8a73a4_pfc handling gpio 0 -> 329
sh-pfc pfc-r8a73a4: r8a73a4_pfc support registered
renesas_irqc renesas_irqc.0: driving 32 irqs
renesas_irqc renesas_irqc.1: driving 26 irqs
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
sh_cmt sh-cmt-48-gen2.1: ch0: used for clock events
sh_cmt sh-cmt-48-gen2.1: ch0: used for periodic clock events
sh_cmt sh-cmt-48-gen2.1: ch1: used as clock source
Switched to clocksource sh-cmt-48-gen2.1
sh_cmt sh-cmt-48-gen2.1: ch0: used for oneshot clock events
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
futex hash table entries: 256 (order: 2, 16384 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
SuperH (H)SCI(F) driver initialized
sh-sci sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 176, base_baud = 0) is a scifa
console [ttySC0] enabled
sh-sci sh-sci.1: ttySC1 at MMIO 0xe6c50000 (irq = 177, base_baud = 0) is a scifa
sh-sci sh-sci.2: ttySC2 at MMIO 0xe6c20000 (irq = 180, base_baud = 0) is a scifb
sh-sci sh-sci.3: ttySC3 at MMIO 0xe6c30000 (irq = 181, base_baud = 0) is a scifb
sh-sci sh-sci.4: ttySC4 at MMIO 0xe6ce0000 (irq = 182, base_baud = 0) is a scifb
sh-sci sh-sci.5: ttySC5 at MMIO 0xe6cf0000 (irq = 183, base_baud = 0) is a scifb
libphy: smsc911x-mdio: probed
smsc911x smsc911x eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=smsc911x-fffffff:01, irq=-1)
smsc911x smsc911x eth0: MAC Address: 00:08:f7:00:02:4b
rcar_thermal rcar_thermal: 3 sensor probed
Driver 'mmcblk' needs updating - please use bus_type methods
sh_mobile_sdhi sh_mobile_sdhi.0: No vqmmc regulator found
