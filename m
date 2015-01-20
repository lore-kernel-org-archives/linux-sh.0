From: Simon Horman <horms@verge.net.au>
Date: Tue, 20 Jan 2015 23:50:39 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150120235033.GA338@verge.net.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
To: linux-sh@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 20, 2015 at 08:38:00PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> domain."), the APE6EVM legacy board support is know to be broken.
> 
> The IRQ numbers of the GIC are now virtual, and no longer match the
> hardcoded hardware IRQ numbers in the platform board code.
> 
> To fix this, instantiate the GIC from platform board code when compiling
> a legacy kernel, like is done for the sh73a0, r8a7740, r8a7778 and r8a7779
> legacy code.
> 
> Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
> thanks to him for the initial work.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written on top of renesas-devel-20150119-v3.19-rc5
> 
>  Untested due to lack of working hardware, testing needed.

Hi Magnus,

thanks for your help with this. I have tested this and have
both good and bad news.

The bad news is that it does not appear to work :(
The good news is that this means my setup is at least working (or not)
consistently as I had brewed up the same change myself a few weeks ago
and that also did not work :^)

My naïve guess is that the GIC setup for the r8a73a4 is somehow
more complex or than calling gic_init() and that this is reflected
in its DT - which seems more complex than for the r8a77{40,98,99} which
we have been fixed in a manner very close to the patch you propose here.

Please find attached two boot logs which may or may not be of any help.

* renesas-devel-20150119-v3.19-rc5.txt: This is a boot of
  renesas-devel-20150119-v3.19-rc5 using the ape6evm_defconfig.
  It features the problem your patch tries to solve.

* renesas-devel-20150119-v3.19-rc5+patched+earlyprintk: This is
  a boot of renesas-devel-20150119-v3.19-rc5 with your patch applied,
  and earlyprintk specified on the command line and
  CONFIG_DEBUG_RCAR_GEN2_SCIF0 enabled in its config. Without the latter
  two enhancements there is no console output at all.

I'm not sure what the best way is to move forwards on this but
I am quite happy to offer any assistance you need.

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="renesas-devel-20150119-v3.19-rc5.txt"

## Booting kernel from Legacy Image at 41000000 ...
   Image Name:   Linux-3.19.0-rc5
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2629512 Bytes = 2.5 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpu
Linux version 3.19.0-rc5 (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #590 SMP Wed Jan 21 08:32:37 JST 2015
CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: APE6EVM
Ignoring memory block 0x200000000 - 0x240000000
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0521880, node_mem_map eeffa000
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
Memory: 1034044K/1048576K available (3777K kernel code, 220K rwdata, 980K rodata, 252K init, 188K bss, 14532K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc04ae5ec   (4762 kB)
      .init : 0xc04af000 - 0xc04ee000   ( 252 kB)
      .data : 0xc04ee000 - 0xc05253d8   ( 221 kB)
       .bss : 0xc05253d8 - 0xc05545fc   ( 189 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 13.00MHz (virt).
sched_clock: 56 bits at 13MHz, resolution 76ns, wraps every 2643056803840ns
Switching to timer-based delay loop, resolution 76ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 26.04 BogoMIPS (lpj=101562)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40394470 - 0x403944c8
Brought up 1 CPUs
SMP: Total of 1 processors activated (26.04 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc pfc-r8a73a4: r8a73a4_pfc handling gpio 0 -> 329
sh-pfc pfc-r8a73a4: r8a73a4_pfc support registered
renesas_irqc renesas_irqc.0: failed to request IRQ
renesas_irqc: probe of renesas_irqc.0 failed with error -2
renesas_irqc renesas_irqc.1: failed to request IRQ
renesas_irqc: probe of renesas_irqc.1 failed with error -2
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
sh_cmt sh-cmt-48-gen2.1: ch0: failed to request irq 152
sh_cmt sh-cmt-48-gen2.1: ch0: registration failed
sh_cmt: probe of sh-cmt-48-gen2.1 failed with error -22
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
sh-dma-engine sh-dma-engine.0: DMA failed requesting irq #252, error -22
sh-dma-engine: probe of sh-dma-engine.0 failed with error -22
SuperH (H)SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 176, base_baud = 0) is a scifa
console [ttySC0] enabled
sh-sci.1: ttySC1 at MMIO 0xe6c50000 (irq = 177, base_baud = 0) is a scifa
sh-sci.2: ttySC2 at MMIO 0xe6c20000 (irq = 180, base_baud = 0) is a scifb
sh-sci.3: ttySC3 at MMIO 0xe6c30000 (irq = 181, base_baud = 0) is a scifb
sh-sci.4: ttySC4 at MMIO 0xe6ce0000 (irq = 182, base_baud = 0) is a scifb
sh-sci.5: ttySC5 at MMIO 0xe6cf0000 (irq = 183, base_baud = 0) is a scifb
Unable to handle kernel NULL pointer dereference at virtual address 00000218
pgd = c0004000
[00000218] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc5 #590
Hardware name: ape6evm
task: ee81e9c0 ti: ee88a000 task.ti: ee88a000
PC is at irq_domain_activate_irq+0x2c/0x48
LR is at irq_startup+0x24/0x70
pc : [<c0065f94>]    lr : [<c00637a4>]    psr: 600001d3
sp : ee88bd90  ip : 00000000  fp : c050d598
r10: 60000153  r9 : ee8e92b8  r8 : 000007f8
r7 : 00000000  r6 : 00000001  r5 : ee8271c0  r4 : ee8e9280
r3 : 00000200  r2 : 00000000  r1 : 00000001  r0 : 00000000
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5307d  Table: 4000406a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xee88a238)
Stack: (0xee88bd90 to 0xee88c000)
bd80:                                     00000000 ee8e9280 ee8e9280 c00637a4
bda0: eeb7bd80 ee8e9280 ee8e92e0 c0062690 ee8f5e40 ffffffed eeb7aec0 eeb7a800
bdc0: eeb7bd80 ee8e9280 c0255ee8 00000084 00000000 eeb7a800 000007f8 c00629ec
bde0: eeb7a800 ee8e5400 eeb7acc0 ee8f5ec0 60000153 a0000153 00000011 c0257148
be00: eeb7a800 eeb7a800 eeb79218 ee8e5410 eeb7acec 00000404 ee8f5ec0 eeb7ace0
be20: 00000000 c0147124 eeb792b8 00000001 00000000 c04eab70 ee8ea268 c047227c
be40: ee8ea268 eeb792b8 00000001 00000000 c04eab70 ffffffed ee8e5410 c0517b54
be60: 00000000 00000000 c04eab70 c0517b54 00000000 c0233ccc ee8e5410 c0549c8c
be80: c0549c98 c02326b8 00000000 ee8e5410 c0517b54 ee8e5444 00000000 c04e3fa0
bea0: 00000061 c0232868 c0517b54 00000000 c02327dc c0231084 ee820c5c ee8bf434
bec0: c0517b54 eeb5e680 c0516880 c0231844 c04575d8 c04cd5fc c0517b54 c0517b54
bee0: 00000000 c04e3fa0 eea313c0 c0233164 00000000 c04cd5fc 00000000 c04afce4
bf00: 00000013 c0398aac ee833680 c0539198 c0525400 00000000 c048adec c013e478
bf20: 00000000 c04fea90 60000153 00000000 eefef2be 00000000 c048adec c003aeb4
bf40: c0476078 c048a7dc 00000006 00000006 c04fea68 c04e47f8 00000006 c04e47d8
bf60: c0525400 c04af584 c04eab70 00000061 00000000 c04afeac 00000006 00000006
bf80: c04af584 c038c7a0 00000000 c038c7a0 00000000 00000000 00000000 00000000
bfa0: 00000000 c038c7a8 00000000 c000ef78 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 80000000 00000000
[<c0065f94>] (irq_domain_activate_irq) from [<c00637a4>] (irq_startup+0x24/0x70)
[<c00637a4>] (irq_startup) from [<c0062690>] (__setup_irq+0x458/0x4bc)
[<c0062690>] (__setup_irq) from [<c00629ec>] (request_threaded_irq+0xb0/0x12c)
[<c00629ec>] (request_threaded_irq) from [<c0257148>] (smsc911x_drv_probe+0x5b0/0x108c)
[<c0257148>] (smsc911x_drv_probe) from [<c0233ccc>] (platform_drv_probe+0x30/0x80)
[<c0233ccc>] (platform_drv_probe) from [<c02326b8>] (driver_probe_device+0x118/0x23c)
[<c02326b8>] (driver_probe_device) from [<c0232868>] (__driver_attach+0x8c/0x90)
[<c0232868>] (__driver_attach) from [<c0231084>] (bus_for_each_dev+0x54/0x88)
[<c0231084>] (bus_for_each_dev) from [<c0231844>] (bus_add_driver+0xdc/0x1c4)
[<c0231844>] (bus_add_driver) from [<c0233164>] (driver_register+0x78/0xf4)
[<c0233164>] (driver_register) from [<c04afce4>] (do_one_initcall+0x100/0x1c0)
[<c04afce4>] (do_one_initcall) from [<c04afeac>] (kernel_init_freeable+0x108/0x1d4)
[<c04afeac>] (kernel_init_freeable) from [<c038c7a8>] (kernel_init+0x8/0xe4)
[<c038c7a8>] (kernel_init) from [<c000ef78>] (ret_from_fork+0x14/0x3c)
Code: e3500000 0a000000 ebfffff5 e595300c (e5933018) 
---[ end trace 32757f37745a089c ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="renesas-devel-20150119-v3.19-rc5+patched+earlyprintk.txt"

## Booting kernel from Legacy Image at 41000000 ...
   Image Name:   Linux-3.19.0-rc5-00001-gd6e5919-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2631840 Bytes = 2.5 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpu
Linux version 3.19.0-rc5-00001-gd6e5919-dirty (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #592 SMP Wed Jan 21 08:40:27 JST 2015
CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: APE6EVM
Ignoring memory block 0x200000000 - 0x240000000
bootconsole [earlycon0] enabled
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c05218c0, node_mem_map eeff8000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 8 pages/cpu @eefe3000 s11520 r0 d21248 u32768
pcpu-alloc: s11520 r0 d21248 u32768 alloc=8*4096
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: earlyprintk console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034040K/1048576K available (3777K kernel code, 221K rwdata, 980K rodata, 252K init, 188K bss, 14536K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc04ae634   (4762 kB)
      .init : 0xc04af000 - 0xc04ee000   ( 252 kB)
      .data : 0xc04ee000 - 0xc0525418   ( 222 kB)
       .bss : 0xc0525418 - 0xc055463c   ( 189 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
Unable to handle kernel paging request at virtual address f1001004
pgd = c0004000
[f1001004] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.19.0-rc5-00001-gd6e5919-dirty #592
Hardware name: ape6evm
task: c04f97e0 ti: c04ee000 task.ti: c04ee000
PC is at gic_init_bases+0x70/0x298
LR is at r8a73a4_init_irq+0x30/0x38
pc : [<c04ca288>]    lr : [<c04b5e54>]    psr: 600001d3
sp : c04eff78  ip : 00000000  fp : 00000000
r10: 0000001d  r9 : 412fc0f3  r8 : 00000000
r7 : f1002000  r6 : c04f6b90  r5 : f1001000  r4 : c04f6b90
r3 : ffffffff  r2 : f1001000  r1 : 0000001d  r0 : 00000000
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5307d  Table: 4000406a  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0xc04ee238)
Stack: (0xc04eff78 to 0xc04f0000)
ff60:                                                       0000000f c0500558
ff80: c0525440 c04e4930 412fc0f3 c04e4920 00000001 ffffffff c0525440 c04e4930
ffa0: ef7fcd40 c04b5e54 00000000 00000000 00000000 c04b08c4 00000000 c04afaac
ffc0: ffffffff ffffffff c04af660 00000000 00000000 c04e4930 00000000 c05257d4
ffe0: c04f647c c04e492c c04fa99c 4000406a 00000000 40008074 00000000 00000000
[<c04ca288>] (gic_init_bases) from [<c04b5e54>] (r8a73a4_init_irq+0x30/0x38)
[<c04b5e54>] (r8a73a4_init_irq) from [<c04b08c4>] (init_IRQ+0x24/0x74)
[<c04b08c4>] (init_IRQ) from [<c04afaac>] (start_kernel+0x224/0x35c)
[<c04afaac>] (start_kernel) from [<40008074>] (0x40008074)
Code: e5c43598 e5c43599 e5c4359a e5c4359b (e5953004) 
---[ end trace cb88537fdc8fa200 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

--J/dobhs11T7y2rNN--
