Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0004D90D6;
	Mon, 28 Sep 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604264; cv=none; b=K+4IdsdgJegvOqUiPse83n+g7zwHECxvFCRKAz2AnnjshePy4CgejaCM1X+m/LboSyafwmRMvjoJjSIAvzWISt4CVkayVAOfN/5KMYFno/r65nceaRJEdjM9gcw/VdZD2cwnSFal/v1AZdWu7mjJH/IzfNcMWjqVZ9YbGpGh7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604264; c=relaxed/simple;
	bh=D6oiO8v/DG/12BhEH54Cif1DQT5eq/11FTnpjgzxU1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRYC6wIk7v+8zEFmc1GvRJKLX9OmP2yWV990slUicXQG6ps1GltuBkFM8rSUfQ+n+JsIh8UtmZxMR6uy4W96RPbX4/WQmKwQF3+KJbdaIxds66Qg1IjFJe1j0beXdSpWoYsdObighTUFeXg74ugPFtnZHoeY4Bc8ombTs5CobLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dKVwWMvb; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dKVwWMvb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9Pt0jDoWN5mIs9mqNdKbE0ErZjHLFS6xosG+DNB0ICs=; t=1790604257;
	x=1791209057; b=dKVwWMvb9HP8qYu1GtT4kD8yvIzfMjX5Wkl4FNoZzPzNbuXmc3QN8sWJHRATP
	pFjVkgl46BeG1qsTI61c0F4tBn9ijnCdTGFFyXpyHj8PJ2iSWvxn1YYkx9O0K5jnMmTQ7+1rz9Pu6
	XyTGkQM3olaZmBfeDqKL4emfMM6Ya2gLshAdInc2l7bhZLOvHOeCuq0+T7kad0L6IrLl24ciDDDtK
	h/o/7rtyEJDW78JZZuTuWwAEgNn3v2jnnE8M3yXF9qzN60L0j7VdhYgYJZRyTDPOYUxrsLhMjdtG9
	WmilU3W2Zr7lsNneTtWELC1rhBJTkEVBpZQ7w0zEImkESUr/GA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBBxl-00000000DqI-1PWv; Mon, 28 Sep 2026 16:04:13 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBBxk-000000027NR-447y; Mon, 28 Sep 2026 16:04:13 +0200
Message-ID: <bc6d03044ceece6453ae8765d29dfac55f36e0ab.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix lost IPIs on SMP
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Radu Rendec <radu@rendec.net>, Artur
 Rojek	 <contact@artur-rojek.eu>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 16:04:12 +0200
In-Reply-To: <20260928035408.25871-1-kmehltretter@gmail.com>
References: <20260928035408.25871-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Karl,

On Mon, 2026-09-28 at 05:54 +0200, Karl Mehltretter wrote:
> Since commit bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for
> non-overlapping affinities"), handle_percpu_devid_irq() only runs an
> action whose affinity mask contains the current CPU. Only actions set up
> through the percpu_devid request functions have such a mask.
>=20
> handle_jcore_irq() passes every per-CPU interrupt to
> handle_percpu_devid_irq(). The J2 IPI is not a percpu_devid interrupt.
> j2_prepare_cpus() requests it with request_irq() and IRQF_PERCPU, so its
> action has no affinity mask and cpumask_test_cpu() reads through a NULL
> pointer. J2 has no MMU to catch this. The read returns whatever is at
> address 0, the action is not found, and IPIs are dropped as spurious
> ("Spurious percpu IRQ20 on CPU1", printed once).
>=20
> Pass only percpu_devid interrupts (the PIT) to handle_percpu_devid_irq()
> and the other per-CPU interrupts to handle_percpu_irq() again, as before
> commit d7e3fd658248f ("irqchip/jcore-aic, clocksource/drivers/jcore: Fix
> jcore-pit interrupt request").
>=20
> Found with a two-CPU J2 model simulated from the J-Core RTL. Without
> this change the boot stalls with both CPUs idle shortly after
> "smp: Brought up 1 node, 2 CPUs". With it, the boot reaches userspace.
>=20
> Fixes: bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for non-ov=
erlapping affinities")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Notes:
>     Tested on a two-CPU J2 model simulated from the J-Core RTL with
>     Verilator (J2 CPUs, caches, bus mux and AIC1 from jcore-cpu/jcore-soc=
),
>     kernel v7.3-rc4 j2_defconfig with SMP=3Dy:
>    =20
>     - unpatched: "Spurious percpu IRQ20 on CPU1", pending IPI messages ar=
e
>       never cleared (the message word of CPU1 grows to 0x6), boot stalls
>       with both CPUs idle after SMP bring-up
>     - patched: IPIs are handled, boot reaches userspace on both CPUs
>    =20
>     Not tested on J-Core hardware. Testing on real hardware is welcome.
>=20
>  drivers/irqchip/irq-jcore-aic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-=
aic.c
> index 94c05cf974be8..b4fee02997eee 100644
> --- a/drivers/irqchip/irq-jcore-aic.c
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -37,8 +37,10 @@ static struct irq_chip jcore_aic;
> =20
>  static void handle_jcore_irq(struct irq_desc *desc)
>  {
> -	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
> +	if (irq_is_percpu_devid(irq_desc_get_irq(desc)))
>  		handle_percpu_devid_irq(desc);
> +	else if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
> +		handle_percpu_irq(desc);
>  	else
>  		handle_simple_irq(desc);
>  }

Without this patch, the kernel gets stuck after bringing up both cores:

GDB Stub for HSCPU tests passed                                            =
                                                          =20
GDB Stub for HS-2J0 SH2 ROM                                                =
                                                          =20
revision: v0.47a-55-873868e6e9ae
build: Mon Dec  9 20:32:25 EST 2019
Booting
SD:start
SD:init good
Storage device initialized
Open vmlinux OK
Use bootloader's DTB
RUN program
Linux version 7.3.0-rc5 (glaubitz@node54.cloud.suse.de) (sh2eb-linux-muslfd=
pic-gcc (GCC) 9.4.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Mon Sep 28 13:39:=
06 UTC 2026
Boot params:
... MOUNT_ROOT_RDONLY - 00000001
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000200
... LOADER_TYPE       - 00000001
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
earlycon: uartlite_a0 MMIO:0xabcd0100 (options '')
printk: legacy bootconsole [uartlite_a0] enabled
Booting machvec: devicetree
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
initrd disabled
SH generic board support: scanning for cpus
CPU enable method: jcore,spin-table
Zone ranges:
  Normal   [mem 0x0000000010000000-0x0000000017ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000010000000-0x0000000017ffffff]
Initmem setup node 0 [mem 0x0000000010000000-0x0000000017ffffff]           =
                                                          =20
percpu: max_distance=3D0x14000 too large for vmalloc space 0x0             =
                                                            =20
percpu: Embedded 10 pages/cpu s17852 r0 d23108 u40960                      =
                                                          =20
percpu: wasting 12 pages per chunk                                         =
                                                          =20
Kernel command line: console=3DttyUL0 earlycon                             =
                                                            =20
printk: log buffer data + meta data: 131072 + 409600 =3D 540672 bytes
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
Sorting __ex_table...
Built 1 zonelists, mobility grouping on.  Total pages: 32768
mem auto-init: stack:off, heap alloc:off, heap free:off
Initial J2 CCR is 80000003
I-cache : n_ways=3D1 n_sets=3D256 way_incr=3D0
I-cache : entry_mask=3D0xffffffe0 alias_mask=3D0x00000000 n_aliases=3D0
D-cache : n_ways=3D1 n_sets=3D256 way_incr=3D0
D-cache : entry_mask=3D0xffffffe0 alias_mask=3D0x00000000 n_aliases=3D0
virtual kernel memory layout:
    fixmap  : 0xdffef000 - 0xdffff000   (  64 kB)
    vmalloc : 0xc0000000 - 0xdffed000   ( 511 MB)
    lowmem  : 0x10000000 - 0x18000000   ( 128 MB) (cached)
      .init : 0x1054b000 - 0x1060c000   ( 772 kB)
      .data : 0x103f6844 - 0x1054a314   (1358 kB)
      .text : 0x10001000 - 0x103f6844   (4054 kB)
SLUB: HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
rcu: Hierarchical RCU implementation.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
SH generic board support: scanning for interrupt controllers
Initializing J-Core AIC
rcu: srcu_init: Setting srcu_struct sizes based on contention.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 7645041785100000 ns
Initializing J-Core PIT at (ptrval) IRQ 16
clocksource: jcore_pit_cs: mask: 0xffffffff max_cycles: 0xffffffff, max_idl=
e_ns: 1911260446 ns
sched_clock: 32 bits at 1000MHz, resolution 1ns, wraps every 2147483647ns
Local J-Core PIT init on cpu 0
SH generic board support: scanning for clk providers
Console: colour dummy device 80x25
Calibrating delay loop... 28.54 BogoMIPS (lpj=3D57088)
CPU: J2
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
VFS: Finished mounting rootfs on nullfs
rcu: Hierarchical SRCU implementation.
rcu:    Max phase no-delay instances is 1000.
Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode leve=
l
smp: Bringing up secondary CPUs ...
J2 SMP: requested start of cpu 1
Local J-Core PIT init on cpu 1
Spurious percpu IRQ20 on CPU0
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (85.88 BogoMIPS).
Memory: 122512K/131072K available (4050K kernel code, 546K rwdata, 812K rod=
ata, 772K init, 191K bss, 7600K reserved, 0K cma-reserved)
random: crng init done
devtmpfs: initialized
posixtimers hash table entries: 1024 (order: 1, 8192 bytes, linear)
futex hash table entries: 512 (8192 bytes on 1 NUMA nodes, total 8 KiB, lin=
ear).
NET: Registered PF_NETLINK/PF_ROUTE protocol family
clocksource: Switched to clocksource jcore_pit_cs

After the patch, the kernel successfully boots to the shell prompt:

CPU tests passed
GDB Stub for HS-2J0 SH2 ROM
revision: v0.47a-55-873868e6e9ae
build: Mon Dec  9 20:32:25 EST 2019
Booting
SD:start                                                                   =
                                                          =20
SD:init good                                                               =
                                                          =20
Storage device initialized                                                 =
                                                          =20
Open vmlinux OK                                                            =
                                                          =20
Use bootloader's DTB                                                       =
                                                          =20
RUN program
Linux version 7.3.0-rc5 (glaubitz@node54.cloud.suse.de) (sh2eb-linux-muslfd=
pic-gcc (GCC) 9.4.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Mon Sep 28 13:56:=
24 UTC 2026
Boot params:
... MOUNT_ROOT_RDONLY - 00000001
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000200
... LOADER_TYPE       - 00000001
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
earlycon: uartlite_a0 MMIO:0xabcd0100 (options '')
printk: legacy bootconsole [uartlite_a0] enabled
Booting machvec: devicetree
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
initrd disabled
SH generic board support: scanning for cpus
CPU enable method: jcore,spin-table
Zone ranges:
  Normal   [mem 0x0000000010000000-0x0000000017ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000010000000-0x0000000017ffffff]
Initmem setup node 0 [mem 0x0000000010000000-0x0000000017ffffff]
percpu: max_distance=3D0x14000 too large for vmalloc space 0x0
percpu: Embedded 10 pages/cpu s17852 r0 d23108 u40960
percpu: wasting 12 pages per chunk
Kernel command line: console=3DttyUL0 earlycon
printk: log buffer data + meta data: 131072 + 409600 =3D 540672 bytes
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
Sorting __ex_table...
Built 1 zonelists, mobility grouping on.  Total pages: 32768
mem auto-init: stack:off, heap alloc:off, heap free:off
Initial J2 CCR is 80000003
I-cache : n_ways=3D1 n_sets=3D256 way_incr=3D0
I-cache : entry_mask=3D0xffffffe0 alias_mask=3D0x00000000 n_aliases=3D0
D-cache : n_ways=3D1 n_sets=3D256 way_incr=3D0
D-cache : entry_mask=3D0xffffffe0 alias_mask=3D0x00000000 n_aliases=3D0
virtual kernel memory layout:
    fixmap  : 0xdffef000 - 0xdffff000   (  64 kB)
    vmalloc : 0xc0000000 - 0xdffed000   ( 511 MB)
    lowmem  : 0x10000000 - 0x18000000   ( 128 MB) (cached)
      .init : 0x1054b000 - 0x1060c000   ( 772 kB)
      .data : 0x103f6874 - 0x1054a314   (1358 kB)
      .text : 0x10001000 - 0x103f6874   (4054 kB)
SLUB: HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
rcu: Hierarchical RCU implementation.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
SH generic board support: scanning for interrupt controllers
Initializing J-Core AIC
rcu: srcu_init: Setting srcu_struct sizes based on contention.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 7645041785100000 ns
Initializing J-Core PIT at (ptrval) IRQ 16
clocksource: jcore_pit_cs: mask: 0xffffffff max_cycles: 0xffffffff, max_idl=
e_ns: 1911260446 ns
sched_clock: 32 bits at 1000MHz, resolution 1ns, wraps every 2147483647ns
Local J-Core PIT init on cpu 0
SH generic board support: scanning for clk providers
Console: colour dummy device 80x25
Calibrating delay loop... 28.35 BogoMIPS (lpj=3D56704)
CPU: J2
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
VFS: Finished mounting rootfs on nullfs
rcu: Hierarchical SRCU implementation.
rcu:    Max phase no-delay instances is 1000.
Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode leve=
l
smp: Bringing up secondary CPUs ...
J2 SMP: requested start of cpu 1
Local J-Core PIT init on cpu 1
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (85.69 BogoMIPS).
Memory: 122568K/131072K available (4050K kernel code, 546K rwdata, 812K rod=
ata, 772K init, 191K bss, 7600K reserved, 0K cma-reserved)
devtmpfs: initialized
posixtimers hash table entries: 1024 (order: 1, 8192 bytes, linear)
futex hash table entries: 512 (8192 bytes on 1 NUMA nodes, total 8 KiB, lin=
ear).
NET: Registered PF_NETLINK/PF_ROUTE protocol family
clocksource: Switched to clocksource jcore_pit_cs
NET: Registered PF_INET protocol family
IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, lin=
ear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP bind hash table entries: 1024 (order: 2, 16384 bytes, linear)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 2, 14336 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
workingset: timestamp_bits=3D30 (anon: 25) max_order=3D15 bucket_order=3D0 =
(anon: 0)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
fuse: init (API version 7.46)
abcd0100.serial: ttyUL0 MMIO:0xabcd0100 (irq =3D 18, base_baud =3D 0) is a =
uartlite
printk: legacy console [ttyUL0] enabled
printk: legacy console [ttyUL0] enabled
printk: legacy bootconsole [uartlite_a0] disabled
printk: legacy bootconsole [uartlite_a0] disabled
loop: module loaded
jcore_spi abcd0040.spi: Runtime PM disabled, clock forced on.
spi-nor spi0.1: unrecognized JEDEC id bytes: ff ff ff ff ff ff
mmc_spi spi0.0: SD/MMC host mmc0, no WP, no poweroff, cd polling
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
NET: Registered PF_PACKET protocol family
mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new SDHC card on SPI
mmcblk0: mmc0:0000 SL16G 14.8 GiB
 mmcblk0: p1 p2
netconsole: network logging started
clk: Disabling unused clocks
Warning: unable to open an initial console.
Freeing unused kernel image (initmem) memory: 772K
This architecture does not have kernel memory protection.
Run /init as init process
ifconfig: ioctl 8916: No such device
sntp: sendto: Network unreachable
sntp: time.google.com:123: Try again
Type exit when done.
$ uname -a
Linux (none) 7.3.0-rc5 #1 SMP Mon Sep 28 13:56:24 UTC 2026 sh2eb Toybox
$

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
