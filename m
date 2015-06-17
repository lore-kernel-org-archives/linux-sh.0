From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Jun 2015 02:48:37 +0000
Subject: possible regression caused by "clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast"
Message-Id: <20150617024833.GE5143@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

cpu_possible_mask to fix SMP broadcast
Reply-To: 
Organisation: Horms Solutions Ltd.

Hi Magnus, Hi All,

I have observed what appears to be a regression caused by
f2a5473861cf ("clocksource: sh_tmu: Set cpu_possible_mask to fix SMP
broadcast"), which was included in v3.19.

The problem I see is that with a kernel compiled using marzen_defconfig on
the r8a7779/marzen board: i.e. a "legacy" kernel.

The problem does not manifest when booting the same board using
a kernel built with shmobile_defconfig: i.e. a multiplatform kernel.

It does not appear to affect other boards I have access to:
emev2/kzm9d, r7s72100/genmai, r8a73a4/ape6evm, r8a7740/armadillo900eva,
r8a77798/bockw r8a7790/lager r8a7791/koelsch, r8a7794/alt, sh73a0/kzm9g.

I have observed this problem on the renesas-devel-20150617-v4.1-rc8
tag of my renesas tree. But I do not believe it is exclusive to that tag.

The problem appears to be that there is no clocksource available during
early boot. The boot log at the end of the email was obtained by
enabling DEBUG_LL and earlyprintk. 

Linux version 4.1.0-rc8-dirty (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #311 SMP Wed Jun 17 10:53:11 JST 2015
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), crc5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: marzen
bootconsole [earlycon0] enabled
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c049bec0, node_mem_map eeff8000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 9 pages/cpu @eefc4000 s14976 r0 d21888 u36864
pcpu-alloc: s14976 r0 d21888 u36864 alloc=9*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: earlyprintk console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034480K/1048576K available (3533K kernel code, 138K rwdata, 812K rodata, 200K init, 167K bss, 14096K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0447490   (4350 kB)
      .init : 0xc0448000 - 0xc047a000   ( 200 kB)
      .data : 0xc047a000 - 0xc049cbe0   ( 139 kB)
       .bss : 0xc049cbe0 - 0xc04c6960   ( 168 kB)
Hierarchical RCU implementation.
        Additional per-CPU info printed with stalls.
NR_IRQS:16 nr_irqs:16 16
smp_twd: clock not found -2
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 2097151999511718ns
 sh-tmu.0: ch0: used for clock events
 sh-tmu.0: ch1: used as clock source
clocksource sh-tmu.0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
Calibrating delay loop... 

