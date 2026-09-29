Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA64F3EAF;
	Tue, 29 Sep 2026 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673649; cv=none; b=Lnh+xEc3nnFmvdK9ebG0kss5ut5phCfiES41u1pbWcT7LK6xxwh5DVZrdKwwnEqz59u1eFGLkpOSp7nipCg8GXPwSWtDQjCQDRNm5dv6oShiyPECS19vuErn8IRMkHxoNAY3oKwAUn/GawAq2NAKOXPvc3RvtDeiNhsQCbM0G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673649; c=relaxed/simple;
	bh=XmfpJj5Kuk+pe1WiJwTXJO/VTgycMaTuxQUl/xgfc24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gir8ElucMmsp0JaH4FUPxsCGyG8C/sg+ljoSUU9pGlT942tyVkpmq/rSDK6cqwC+xzifXrOJdVPpsXWQ1SuGr4ftOfzIrTZaASMDAPwkOqLx5wBoEX74jyM65b71c6Yaigs6cCho427kTiURcfeTtD020ckMuQyVaq0zAmmS+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eefuhJVq; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eefuhJVq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=2nH2iCptZkj8JZ+V3XnNMTWZ5XKD1GpcsqOmgyIkIzE=; t=1790673633;
	x=1791278433; b=eefuhJVqnTC3qZQf7Tipw/xmZD4308w/+iGVJT2LhYaiGgkPtSigxsL/h9coE
	gIaXpj/kSlzFyL9Y2hMKYQXWmOzRXyIbmdb6y8f0GAQzbLNt6FK+UOZ28NMzhKL1IZXND4aitJSlA
	iJw/1VhAWYLFSHY8ho1467zLt6LaZHfQpC7HJhkUbd7l2Vg5e2LQkZlWk8pxo8aD3RKJNvnjV9Izs
	8OPUFMaTre684e6nobjP3YiS9LaI0FdWO8arTCGocKLVf9PmBBGRv8dVFs7ryzc84vUe2PMExZ8pA
	aBKLHG4e3b2Ka1wSW7Z3mjAzR4XYMByvKDH35lmyrqXUin5ZbQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBU0Y-00000000LL9-1kgs; Tue, 29 Sep 2026 11:20:18 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBU0Y-00000001kUy-0bWz; Tue, 29 Sep 2026 11:20:18 +0200
Message-ID: <a58e77acde18b5f9498b5ebef92b78035b1b4355.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 11:20:17 +0200
In-Reply-To: <arrZ4bFPXPsvjXvb@gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
	 <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
	 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
	 <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
	 <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
	 <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
	 <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
	 <a6242d982e0815131fb2436091c77f0e7e545424.camel@physik.fu-berlin.de>
	 <arrZ4bFPXPsvjXvb@gmail.com>
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

On Mon, 2026-09-28 at 23:22 +0200, Karl Mehltretter wrote:
> On Mon, Sep 28, 2026 at 09:02:55PM +0100, John Paul Adrian Glaubitz wrote=
:
> > On Mon, 2026-09-28 at 20:34 +0200, Geert Uytterhoeven wrote:
> > > > usb reset ; fatload usb 0:1 0x89000000 uImage-git.gz ; pmb ; bootm
> > >=20
> > > Do you have a config for that kernel?
> >=20
> > Here are some known configs:
> >=20
> > https://people.debian.org/~glaubitz/sh7785lcr/configs/
>=20
> I think it's the config. Your new image loads at 0x8c010000, the working
> one at 0x80001000.
>=20
> 0x8c010000 is what an R2D config gives, and config-SH7785LCR-6.5 is one:
> CPU_SUBTYPE_SH7751R and SH_RTS7751R2D, 29BIT, MEMORY_START 0x0c000000.
> config-SH7785LCR-2024 still has SH7785LCR, 32BIT/PMB and MEMORY_START
> 0x40000000, which gives 0x80001000.
>=20
> I tried both on my QEMU model of the SH7785LCR with 7.3: the 2024 config
> boots up to the root mount, the 6.5 one prints nothing at all.
>=20
> So I'd start from config-SH7785LCR-2024 (or sh7785lcr_32bit_defconfig):
>=20
>   cp config-SH7785LCR-2024 .config make ARCH=3Dsh olddefconfig
>=20
> and check for "Load Address: 80001000". Keep the intc patch applied, the
> overflow crashed v6.5 and v6.6 with SLUB on my QEMU model.
>=20
> With the right config the kernel may then really be too large: 7.3-rc5
> with config-SH7785LCR-2024 uncompresses to 8.2 MiB, and U-Boot's default
> CONFIG_SYS_BOOTM_LEN is 8 MiB. U-Boot then prints "Image too large:
> increase CONFIG_SYS_BOOTM_LEN". With CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy it i=
s
> 7.3 MiB and boots through U-Boot on the model.

Yes, that did the trick! Just need to figure out now why it didn't parse th=
e
bootargs from u-boot to set the proper root device:

=3D> usb reset; fatload usb 0:1 0x89000000 uImage-7.3.0.gz ; pmb ; bootm
(Re)start USB...
USB0:   scanning bus 0 for devices... 2 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
reading uImage-7.3.0.gz
4319551 bytes read in 2457 ms (1.7 MiB/s)
## Booting kernel from Legacy Image at 89000000 ...
   Image Name:   Linux-7.3.0-rc5-00002-g02d53450e
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    4319487 Bytes =3D 4.1 MiB
   Load Address: 80001000
   Entry Point:  80002000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
[    0.000000] Linux version 7.3.0-rc5-00002-g02d53450ebff (glaubitz@node54=
.cloud.suse.de) (sh4-linux-gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) =
#2 PREEMPT Tue Sep 29 09:12:51 UTC 2026
[    0.000000] Boot params:
[    0.000000] ... MOUNT_ROOT_RDONLY - 00000000
[    0.000000] ... RAMDISK_FLAGS     - 00000000
[    0.000000] ... ORIG_ROOT_DEV     - 00000000
[    0.000000] ... LOADER_TYPE       - 00000000
[    0.000000] ... INITRD_START      - 00000000
[    0.000000] ... INITRD_SIZE       - 00000000
[    0.000000] Booting machvec: SH7785LCR
[    0.000000] PMB: boot mappings:
[    0.000000]        0x00080000 -> 0x00040000 [  512MB   cached ]
[    0.000000]        0x000a0000 -> 0x00040000 [   16MB uncached ]
[    0.000000] Renesas Technology Corp. R0P7785LC0011RL support.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000005ffff=
fff]
[    0.000000] Kernel command line: console=3DttySC1,115200
[    0.000000] printk: log buffer data + meta data: 65536 + 204800 =3D 2703=
36 bytes
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 13107=
2
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] stackdepot: allocating hash table via alloc_large_system_has=
h
[    0.000000] stackdepot hash table entries: 32768 (order: 6, 262144 bytes=
, linear)
[    0.000000] stackdepot: allocating space for 8192 stack pools via memblo=
ck
[    0.000000] PVR=3D10300700 CVR=3D71440211 PRR=3D00000250
[    0.000000] I-cache : n_ways=3D4 n_sets=3D256 way_incr=3D8192
[    0.000000] I-cache : entry_mask=3D0x00001fe0 alias_mask=3D0x00001000 n_=
aliases=3D2
[    0.000000] D-cache : n_ways=3D4 n_sets=3D256 way_incr=3D8192
[    0.000000] D-cache : entry_mask=3D0x00001fe0 alias_mask=3D0x00001000 n_=
aliases=3D2
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xdffd7000 - 0xdffff000   ( 160 kB)
[    0.000000]     vmalloc : 0xc0000000 - 0xdffd5000   ( 511 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xa0000000   ( 512 MB) (cached)
[    0.000000]             : 0xa0000000 - 0xa1000000   (  16 MB) (uncached)
[    0.000000]       .init : 0x8071c000 - 0x80749000   ( 180 kB)
[    0.000000]       .data : 0x80495280 - 0x8071b5f0   (2584 kB)
[    0.000000]       .text : 0x80001000 - 0x80495280   (4688 kB)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] intc: Registered controller 'sh7785' with 67 IRQs
[    0.000000] intc: Registered controller 'sh7785-irq4567' with 4 IRQs
[    0.000000] intc: Registered controller 'sh7785-irq0123' with 4 IRQs
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.000000] Console: colour dummy device 80x25
[    0.000000]  sh-tmu.0: ch0: used for clock events
[    0.000000]  sh-tmu.0: ch0: used for periodic clock events
[    0.000000]  sh-tmu.0: ch1: used as clock source
[    0.000000] clocksource: sh-tmu.0: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 152900847964 ns
[    0.000000]  sh-tmu.1: ch0: used for clock events
[    0.000000]  sh-tmu.1: ch1: used as clock source
[    0.000000] clocksource: sh-tmu.1: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 152900847964 ns
[    0.000000] sched_clock: 32 bits at 250 Hz, resolution 4000000ns, wraps =
every 8589934590000000ns
[    0.000000] Calibrating delay loop (skipped)... 599.99 BogoMIPS PRESET (=
lpj=3D1199999)
[    0.000000] CPU: SH7785
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.004000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, =
linear)
[    0.004000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes, linear)
[    0.012000] VFS: Finished mounting rootfs on nullfs
[    0.040000] Performance Events: sh4a support registered
[    0.044000] rcu: Hierarchical SRCU implementation.
[    0.044000] rcu:     Max phase no-delay instances is 1000.
[    0.052000] Memory: 508924K/524288K available (4684K kernel code, 452K r=
wdata, 2128K rodata, 180K init, 2149K bss, 14428K reserved, 0K cma-reserved=
)
[    0.056000] devtmpfs: initialized
[    0.084000] posixtimers hash table entries: 512 (order: 2, 10240 bytes, =
linear)
[    0.084000] futex hash table entries: 256 (7168 bytes on 1 NUMA nodes, t=
otal 7 KiB, linear).
[    0.104000] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.196000] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.196000] audit: initializing netlink subsys (disabled)
[    0.204000] audit: type=3D2000 audit(0.200:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1
[    0.212000] cpuidle: using governor ladder
[    0.212000] cpuidle: using governor menu
[    0.252000] gpio gpiochip0: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.260000] sh-pfc pfc-sh7785: sh7785_pfc handling gpio 0 -> 110
[    0.264000] gpio gpiochip1: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.268000] sh-pfc pfc-sh7785: sh7785_pfc handling gpio 111 -> 275
[    0.268000] sh-pfc pfc-sh7785: sh7785_pfc support registered
[    0.268000] HW Breakpoints: SH-4A UBC support registered
[    0.272000] PCI: Starting initialization.
[    0.524000] PCI: Found a Renesas SH7785 host controller, revision 1.
[    0.524000] PCI: Checking 66MHz capabilities...
[    0.524000] PCI: Running at 66MHz.
[    0.536000] HugeTLB: registered 1.00 MiB page size, pre-allocated 0 page=
s
[    0.536000] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 MiB page
[    0.568000] SCSI subsystem initialized
[    0.580000] usbcore: registered new interface driver usbfs
[    0.580000] usbcore: registered new interface driver hub
[    0.584000] usbcore: registered new device driver usb
[    0.588000] sh_tmu sh-tmu.0: kept as earlytimer
[    0.588000] sh_tmu sh-tmu.1: kept as earlytimer
[    0.612000] DMA: Registering sh_dmac handler (12 channels).
[    0.640000] DMA: Registering DMA API.
[    0.644000] PCI host bridge to bus 0000:00
[    0.644000] pci_bus 0000:00: root bus resource [io  0x1000-0x3fffff]
[    0.644000] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfdfffff=
f]
[    0.644000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13fffff=
f]
[    0.644000] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdffffff=
f]
[    0.644000] pci_bus 0000:00: No busn resource found for root bus, will u=
se [bus 00-ff]
[    0.644000] pci 0000:00:00.0: [10ec:8169] type 00 class 0x020000 convent=
ional PCI endpoint
[    0.644000] pci 0000:00:00.0: BAR 0 [io  0x0000-0x00ff]
[    0.644000] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000000ff]
[    0.644000] pci 0000:00:00.0: ROM [mem 0x00000000-0x0001ffff pref]
[    0.644000] pci 0000:00:00.0: supports D1 D2
[    0.644000] pci 0000:00:00.0: PME# supported from D1 D2 D3hot
[    0.652000] pci 0000:00:01.0: [1095:3512] type 00 class 0x018000 convent=
ional PCI endpoint
[    0.652000] pci 0000:00:01.0: BAR 0 [io  0x0000-0x0007]
[    0.652000] pci 0000:00:01.0: BAR 1 [io  0x0000-0x0003]
[    0.652000] pci 0000:00:01.0: BAR 2 [io  0x0000-0x0007]
[    0.652000] pci 0000:00:01.0: BAR 3 [io  0x0000-0x0003]
[    0.652000] pci 0000:00:01.0: BAR 4 [io  0x0000-0x000f]
[    0.652000] pci 0000:00:01.0: BAR 5 [mem 0x00000000-0x000001ff]
[    0.652000] pci 0000:00:01.0: ROM [mem 0x00000000-0x0007ffff pref]
[    0.652000] pci 0000:00:01.0: supports D1 D2
[    0.660000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.660000] pci 0000:00:01.0: ROM [mem 0xfd000000-0xfd07ffff pref]: assi=
gned
[    0.660000] pci 0000:00:00.0: ROM [mem 0xfd080000-0xfd09ffff pref]: assi=
gned
[    0.660000] pci 0000:00:01.0: BAR 5 [mem 0xfd0a0000-0xfd0a01ff]: assigne=
d
[    0.660000] pci 0000:00:00.0: BAR 0 [io  0x1000-0x10ff]: assigned
[    0.660000] pci 0000:00:00.0: BAR 1 [mem 0xfd0a0200-0xfd0a02ff]: assigne=
d
[    0.660000] pci 0000:00:01.0: BAR 4 [io  0x1400-0x140f]: assigned
[    0.660000] pci 0000:00:01.0: BAR 0 [io  0x1410-0x1417]: assigned
[    0.660000] pci 0000:00:01.0: BAR 2 [io  0x1418-0x141f]: assigned
[    0.660000] pci 0000:00:01.0: BAR 1 [io  0x1420-0x1423]: assigned
[    0.660000] pci 0000:00:01.0: BAR 3 [io  0x1424-0x1427]: assigned
[    0.664000] clocksource: Switched to clocksource sh-tmu.0
[    0.668000] sh_tmu sh-tmu.0: ch0: used for oneshot clock events
[    0.916000] NET: Registered PF_INET protocol family
[    0.920000] IP idents hash table entries: 8192 (order: 4, 65536 bytes, l=
inear)
[    0.928000] tcp_listen_portaddr_hash hash table entries: 256 (order: 1, =
5120 bytes, linear)
[    0.928000] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.928000] TCP established hash table entries: 4096 (order: 2, 16384 by=
tes, linear)
[    0.928000] TCP bind hash table entries: 4096 (order: 6, 163840 bytes, l=
inear)
[    0.928000] TCP: Hash tables configured (established 4096 bind 4096)
[    0.932000] UDP hash table entries: 256 (order: 3, 20480 bytes, linear)
[    0.932000] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.932000] PCI: CLS 0 bytes, default 32
[    0.936000] sq: Registering store queue API.
[    0.988000] workingset: timestamp_bits=3D30 (anon: 25) max_order=3D17 bu=
cket_order=3D0 (anon: 0)
[    1.012000] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    1.012000] io scheduler mq-deadline registered
[    1.020000] SuperH (H)SCI(F) driver initialized
[    1.044000] sh-sci.0: ttySC0 MMIO:0xffea0000 (irq =3D 56, base_baud =3D =
0) is a scif
[    1.072000] sh-sci.1: ttySC1 MMIO:0xffeb0000 (irq =3D 60, base_baud =3D =
0) is a scif
[    1.072000] printk: legacy console [ttySC1] enabled
[    2.044000] sh-sci.2: ttySC2 MMIO:0xffec0000 (irq =3D 76, base_baud =3D =
0) is a scif
[    2.080000] sh-sci.3: ttySC3 MMIO:0xffed0000 (irq =3D 77, base_baud =3D =
0) is a scif
[    2.112000] sh-sci.4: ttySC4 MMIO:0xffee0000 (irq =3D 78, base_baud =3D =
0) is a scif
[    2.156000] sh-sci.5: ttySC5 MMIO:0xffef0000 (irq =3D 79, base_baud =3D =
0) is a scif
[    2.624000] brd: module loaded
[    2.872000] loop: module loaded
[    2.876000] sm501 sm501: SM501 At (ptrval): Version 050100c0, 4 Mb, IRQ =
26
[    2.884000] sm501 sm501: setting M1XCLK to 112000000
[    2.912000] sm501 sm501: setting MCLK to 84000000
[    2.960000] sata_sil 0000:00:01.0: enabling device (0000 -> 0003)
[    2.968000] sata_sil 0000:00:01.0: cache line size not set.  Driver may =
not function
[    2.976000] sata_sil 0000:00:01.0: Applying R_ERR on DMA activate FIS er=
rata fix
[    3.040000] scsi host0: sata_sil
[    3.064000] scsi host1: sata_sil
[    3.084000] ata1: SATA max UDMA/100 mmio m512@0xfd0a0000 tf 0xfd0a0080 i=
rq 82 lpm-pol 0
[    3.092000] ata2: SATA max UDMA/100 mmio m512@0xfd0a0000 tf 0xfd0a00c0 i=
rq 82 lpm-pol 0
[    3.120000] physmap-flash physmap-flash.0: physmap platform flash device=
: [mem 0x00000000-0x03ffffff]
[    3.132000] physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank. =
Manufacturer ID 0x000001 Chip ID 0x002201
[    3.144000] Amd/Fujitsu Extended Query Table at 0x0040
[    3.148000]   Amd/Fujitsu Extended Query version 1.3.
[    3.152000] number of CFI chips: 1
[    3.164000] Creating 4 MTD partitions on "physmap-flash.0":
[    3.172000] 0x000000000000-0x000000080000 : "loader"
[    3.244000] 0x000000080000-0x000000100000 : "bootenv"
[    3.320000] 0x000000100000-0x000000500000 : "kernel"
[    3.396000] 0x000000500000-0x000004000000 : "data"
[    3.412000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    3.420000] ata1.00: ATA-9: TOSHIBA THNSNJ128GCSU, JURA0101, max UDMA/10=
0
[    3.436000] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.444000] ata1.00: Features: Dev-Sleep HIPM DIPM
[    3.460000] ata1.00: configured for UDMA/100
[    3.484000] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNSNJ12 01=
01 PQ: 0 ANSI: 5
[    3.620000] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB=
/119 GiB)
[    3.656000] sd 0:0:0:0: [sda] Write Protect is off
[    3.668000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    3.680000] r8169 0000:00:00.0: enabling device (0000 -> 0003)
[    3.696000] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.780000]  sda: sda1 sda2 sda3
[    3.812000] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.836000] r8169 0000:00:00.0 eth0: RTL8169sc/8110sc, 00:00:87:6b:bd:69=
, XID 180, IRQ 81
[    3.844000] r8169 0000:00:00.0 eth0: jumbo features [frames: 7146 bytes,=
 tx checksumming: ok]
[    3.868000] r8a66597_hcd r8a66597_hcd: USB Host Controller
[    3.876000] r8a66597_hcd r8a66597_hcd: new USB bus registered, assigned =
bus number 1
[    3.884000] r8a66597_hcd r8a66597_hcd: irq 18, io port 0x08000000
[    3.924000] hub 1-0:1.0: USB hub found
[    3.932000] hub 1-0:1.0: 2 ports detected
[    3.960000] ata2: SATA link down (SStatus 0 SControl 310)
[    3.980000] usbcore: registered new interface driver usb-storage
[    3.992000] PCA9564/PCA9665 at 0x06000000: PCA9564 detected.
[    3.996000] PCA9564/PCA9665 at 0x06000000: Choosing the clock frequency =
based on index is deprecated. Use the nominal frequency.
[    4.008000] PCA9564/PCA9665 at 0x06000000: Clock frequency is 330kHz
[    4.016000]  (null): No reset-pin found. Chip may get stuck!
[    4.028000] i2c-pca-platform i2c-pca-platform: registered.
[    4.044000] cpufreq: SuperH CPU frequency driver.
[    4.052000] cpufreq: cpufreq_policy_online: ->get() failed
[    4.080000] usbcore: registered new interface driver usbhid
[    4.088000] usbhid: USB HID core driver
[    4.100000] NET: Registered PF_INET6 protocol family
[    4.124000] Segment Routing with IPv6
[    4.128000] In-situ OAM (IOAM) with IPv6
[    4.132000] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.160000] NET: Registered PF_PACKET protocol family
[    4.168000] Key type dns_resolver registered
[    4.172000] heartbeat: version 0.1.2 loaded
[    4.252000] usb 1-1: new high-speed USB device number 2 using r8a66597_h=
cd
[    5.164000] kmemleak: Automatic memory scanning thread started
[    5.172000] kmemleak: Kernel memory leak detector initialized (mem pool =
available: 15862)
[    5.188000] /dev/root: Can't lookup blockdev
[    5.192000] VFS: Cannot open root device "" or unknown-block(0,0): error=
 -19
[    5.200000] Please append a correct "root=3D" boot option; here are the =
available partitions:
[    5.208000] 0100            4096 ram0=20
[    5.208000]  (driver?)
[    5.216000] 0101            4096 ram1=20
[    5.216000]  (driver?)
[    5.220000] 0102            4096 ram2=20
[    5.220000]  (driver?)
[    5.228000] 0103            4096 ram3=20
[    5.228000]  (driver?)
[    5.232000] 0104            4096 ram4=20
[    5.232000]  (driver?)
[    5.240000] 0105            4096 ram5=20
[    5.240000]  (driver?)
[    5.248000] 0106            4096 ram6=20
[    5.248000]  (driver?)
[    5.252000] 0107            4096 ram7=20
[    5.252000]  (driver?)
[    5.260000] 0108            4096 ram8=20
[    5.260000]  (driver?)
[    5.264000] 0109            4096 ram9=20
[    5.268000]  (driver?)
[    5.272000] 010a            4096 ram10=20
[    5.272000]  (driver?)
[    5.280000] 010b            4096 ram11=20
[    5.280000]  (driver?)
[    5.284000] 010c            4096 ram12=20
[    5.284000]  (driver?)
[    5.292000] 010d            4096 ram13=20
[    5.292000]  (driver?)
[    5.300000] 010e            4096 ram14=20
[    5.300000]  (driver?)
[    5.304000] 010f            4096 ram15=20
[    5.304000]  (driver?)
[    5.312000] 1f00             512 mtdblock0=20
[    5.312000]  (driver?)
[    5.320000] 1f01             512 mtdblock1=20
[    5.320000]  (driver?)
[    5.324000] 1f02            4096 mtdblock2=20
[    5.324000]  (driver?)
[    5.332000] 1f03           60416 mtdblock3=20
[    5.332000]  (driver?)
[    5.340000] 0800       125034840 sda=20
[    5.340000]  driver: sd
[    5.344000]   0801        51200000 sda1 e6077cf7-01
[    5.344000]=20
[    5.352000]   0802        65011712 sda2 e6077cf7-02
[    5.352000]=20
[    5.360000]   0803         8822104 sda3 e6077cf7-03
[    5.360000]=20
[    5.368000] List of all bdev filesystems:
[    5.372000]  ext3
[    5.372000]  ext4
[    5.372000]  ext2
[    5.376000]  vfat
[    5.376000]  msdos
[    5.380000]=20
[    5.384000] Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(0,0)
[    5.384000] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc5-0=
0002-g02d53450ebff #2 PREEMPT=20
[    5.384000] Stack: (0x8108be4c to 0x8108c000)
[    5.384000] be40:                            8000bd2a 8108be60 80608484 =
806164e0 00000001=20
[    5.384000] be60: 8000bd64 8108be74 80608484 807495ac 00000000 800026d6 =
8108be7c 00000005=20
[    5.384000] be80: 80003260 800028cc 8108bea4 80608478 80474760 00000005 =
80003260 00000005=20
[    5.384000] bea0: 8105a01a 8108beb4 a4cfc1f8 8071d252 8108bec0 8108becc =
00000000 00000000=20
[    5.384000] bec0: 00000000 ffffff9c 80608518 6e6b6e75 2d6e776f 636f6c62 =
2c30286b 80002930=20
[    5.384000] bee0: 807406c4 00000000 00000000 a4cfc1f8 8071d382 8108bf10 =
000000c0 80749024=20
[    5.384000] bf00: 807406c4 8074902c 00000000 807406c4 8074028c 8108bf44 =
8071d578 8108bf38=20
[    5.384000] bf20: 000000c0 80749000 807406c4 8074902c 807406b8 80003260 =
8074026c a4cfc1f8=20
[    5.384000] bf40: 8071cd1e 8108bf60 000000c0 80749000 8074028c 8074026c =
810898e0 806b37bc=20
[    5.384000] bf60: 00000007 00000007 00000000 8071c0a0 80746b74 8048c7a8 =
8108bf94 81098740=20
[    5.384000] bf80: 806be21c 00000000 806b3d7c 806b1164 80003260 80010200 =
806aded8 806bdbe0=20
[    5.384000] bfa0: 8003f0c4 00000000 00000000 00000000 00000000 00000000 =
8048c788 00000000=20
[    5.384000] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000=20
[    5.384000] bfe0: 00000000 00000000 00000000 40008000 00000000 00000000 =
00000000 00000000=20
[    5.384000]=20
[    5.384000] Call trace:
[    5.384000]  [<8000bd2a>] dump_stack_lvl+0x36/0x64
[    5.384000]  [<8000bd64>] dump_stack+0xc/0x1c
[    5.384000]  [<800026d6>] vpanic+0xae/0x280
[    5.384000]  [<80003260>] _printk+0x0/0x50
[    5.384000]  [<800028cc>] panic+0x24/0x2c
[    5.384000]  [<80474760>] strlen+0x0/0x58
[    5.384000]  [<80003260>] _printk+0x0/0x50
[    5.384000]  [<8071d252>] mount_root_generic+0x12e/0x224
[    5.384000]  [<80002930>] pr_cont_pool_info+0x5c/0x80
[    5.384000]  [<8071d382>] mount_root+0x3a/0x168
[    5.384000]  [<8071d578>] prepare_namespace+0xc8/0x208
[    5.384000]  [<80003260>] _printk+0x0/0x50
[    5.384000]  [<8071cd1e>] kernel_init_freeable+0x16e/0x240
[    5.384000]  [<8071c0a0>] ignore_unknown_bootoption+0x0/0xc
[    5.384000]  [<8048c7a8>] kernel_init+0x20/0x120
[    5.384000]  [<80003260>] _printk+0x0/0x50
[    5.384000]  [<80010200>] ret_from_kernel_thread+0xc/0x14
[    5.384000]  [<8003f0c4>] schedule_tail+0x0/0x78
[    5.384000]  [<8048c788>] kernel_init+0x0/0x120
[    5.384000]=20
[    5.384000] ---[ end Kernel panic - not syncing: VFS: Unable to mount ro=
ot fs on unknown-block(0,0) ]---

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
