From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 21 Jan 2015 10:15:17 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <54BF7C35.6020604@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 21/01/15 09:25, Simon Horman wrote:
> On Wed, Jan 21, 2015 at 09:57:43AM +0100, Geert Uytterhoeven wrote:
>> Hi Simon,
>>
>> On Wed, Jan 21, 2015 at 12:50 AM, Simon Horman <horms@verge.net.au> wrot=
e:
>>> My na=C3=AFve guess is that the GIC setup for the r8a73a4 is somehow
>>> more complex or than calling gic_init() and that this is reflected
>>> in its DT - which seems more complex than for the r8a77{40,98,99} which
>>> we have been fixed in a manner very close to the patch you propose here.
>>
>> According to the bindings, the extra 2 reg property ranges are for the
>> virtualization extensions, which we don't use.
>=20
> Thanks, now there is one less mystery in my life.
>=20
> Perhaps we could tidy up the dts file to remove bits that are unused?
> Or are they used when booting using DT?
>=20
>>> * renesas-devel-20150119-v3.19-rc5+patched+earlyprintk: This is
>>>   a boot of renesas-devel-20150119-v3.19-rc5 with your patch applied,
>>
>> | Unable to handle kernel paging request at virtual address f1001004
>>
>> So the GIC's registers are not mapped.
>>
>> Ape6evm doesn't provide machine_desc.map_io(), so you have to map the
>> GIC yourself. Does the below work?
>>
>> -       void __iomem *gic_dist_base =3D IOMEM(0xf1001000);
>> -       void __iomem *gic_cpu_base =3D IOMEM(0xf1002000);
>> +       void __iomem *gic_dist_base =3D ioremap_nocache(0xf1001000, 0x10=
00);
>> +       void __iomem *gic_cpu_base =3D ioremap_nocache(0xf1002000, 0x100=
0);
>=20
> I also added:
>=20
>         printk("%s gic_dist_base:%p gic_cpu_base:%p\n", __func__,
> 	               gic_dist_base, gic_cpu_base);
>=20
> It does seem promising solve the problem that was manifesting with Magnus=
's
> patch. But it seems the interrupt controller isn't being initialised as
> expected.
>=20
>=20
> Starting kernel ...
>=20
> Booting Linux on physical CPU 0x0
> Initializing cgroup subsys cpu
> Linux version 3.19.0-rc5-00001-gd6e5919-dirty (horms@ayumi.isobedori.kobe=
.vergenet.net) (gcc version 4.6.3 (GCC) ) #705 SMP Wed Jan 21 18:11:46 JST =
2015
> CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5307d
> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> Machine model: APE6EVM
> Ignoring memory block 0x200000000 - 0x240000000
> bootconsole [earlycon0] enabled
> debug: ignoring loglevel setting.
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat c05238c0, node_mem_map eeff8000
>   Normal zone: 1520 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 194560 pages, LIFO batch:31
>   HighMem zone: 67584 pages, LIFO batch:15
> PERCPU: Embedded 8 pages/cpu @eefe3000 s11520 r0 d21248 u32768
> pcpu-alloc: s11520 r0 d21248 u32768 alloc=3D8*4096
> pcpu-alloc: [0] 0=20
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2606=
24
> Kernel command line: earlyprintk console=3DttySC0,115200 ignore_loglevel =
root=3D/dev/nfs ip=3Ddhcp rw
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1034032K/1048576K available (3777K kernel code, 221K rwdata, 984K=
 rodata, 256K init, 188K bss, 14544K reserved, 0K cma-reserved, 270336K hig=
hmem)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
>     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
>     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>       .text : 0xc0008000 - 0xc04af634   (4766 kB)
>       .init : 0xc04b0000 - 0xc04f0000   ( 256 kB)
>       .data : 0xc04f0000 - 0xc0527418   ( 222 kB)
>        .bss : 0xc0527418 - 0xc055663c   ( 189 kB)
> Hierarchical RCU implementation.
>         RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D1.
> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=3D1
> NR_IRQS:16 nr_irqs:16 16
> r8a73a4_init_irq gic_dist_base:f0000000 gic_cpu_base:f0002000
> irq: no irq domain found for /interrupt-controller@f1001000 !
> irq: no irq domain found for /interrupt-controller@f1001000 !
> irq: no irq domain found for /interrupt-controller@f1001000 !
> irq: no irq domain found for /interrupt-controller@f1001000 !
> arch_timer: No interrupt available, giving up
> sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 1677721=
6000000000ns
> Console: colour dummy device 80x30
> Calibrating delay loop...

That's because you seems to be using a horrible mix of DT devices (arch
timers, for example), and hardcoded devices, with the added complexity
of having secondary interrupt controllers.

The only workaround I can think of is to patch the hardcoded interrupts
at boot time with something similar to what I cooked there:

http://www.spinics.net/lists/linux-omap/msg114814.html

At the moment, you either end-up with no interrupts for the DT devices
(as above), or with an exploding system because the hardcoded interrupts
completely wrong (as in the original post).

I don't have access to such hardware, but I'm happy to help.

Thanks,

	M.
--=20
Jazz is not dead. It just smells funny...
