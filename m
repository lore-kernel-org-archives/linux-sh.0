Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95715A862;
	Thu, 11 Jul 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696052; cv=none; b=ZzEcim+gD7ZwvFjDbixX+IY7B/NMWmQQRWJlDThog9A803jBu8Bj955qBX5CIPgaj1MAAI+dCwYBYHAJucqLEnmyygqiTnd+uuXCtayg5Xq4JDvceeay/c/9V/DBvAhkg2NPUP7YI5KYd/4Of97cjPlxmqKaerPRTbYqd+FozFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696052; c=relaxed/simple;
	bh=kPusR43PaKG6xBD/RrcIcx3B27TqPHToNy/IwucFazM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHOGwUH8b8csqBiNwEtoZkhGQ05xce942YXwbhUWrq5YaAkb8ZeKr5OeSTw8pnYReOkk6hZul5TdmbZzuBSMc+GpZtOzHpW/sOIdKQJgvBWN1TqSZ6GumKxd643XB6rZyyaucha2MYYFs1tHhJTn3Py5jMZ2D97PCVJWz4ilfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OV9sPOO+; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OV9sPOO+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1JZyvQjOyuYs5ChZOgRL/rdy0pG9Al5yiAdrNH5g4ws=; t=1720696048; x=1721300848; 
	b=OV9sPOO+i0dmug1zofaGoiP6ry9KlQxBZnR0d8jEQycU19MKHVeIIT705hvtFg6MlfihXz0qFp1
	vDI0o4VBoVL19H/qDGbEL4fKou+2xXqIBm32kPMcftXOGMsOlvC5pOTPGSGIEPP5NDccB6CuTv82z
	xeBA2GGysv3XyaYLj7Vxq0TgrI5cjGHMJ076i8krbx6GmlEQKihmYS8EOlY+DrFr/KM1QALA9Btp8
	Jzpw1cFZZJ8geKbEdKVf/5T4Et+yFDMmtenAP2H64y+jq+/XARe+GbxYZuZm+WsgL6t3N7Mk/lnOy
	DkHcXfPxKE2m8xNl4nPztxFqH3ung4RJVdOQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sRre1-00000002a7O-1VAd; Thu, 11 Jul 2024 13:07:25 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sRre1-00000001796-0cwU; Thu, 11 Jul 2024 13:07:25 +0200
Message-ID: <47f3716dd48ecdc35d823fbab087332fbf3a24d5.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com
Date: Thu, 11 Jul 2024 13:07:24 +0200
In-Reply-To: <20240520175802.2002183-1-quic_obabatun@quicinc.com>
References: <20240520175802.2002183-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Mon, 2024-05-20 at 10:58 -0700, Oreoluwa Babatunde wrote:
> The unflatten_device_tree() function contains a call to
> memblock_alloc(). This is a problem because this allocation is done
> before any of the reserved memory regions are set aside in
> paging_init().
> As a result, there is a possibility for memblock to unknowingly allocate
> from any of the memory regions that are meant to be reserved.
>=20
> Hence, restructure the setup code to set aside reserved memory
> regions before any allocations are done using memblock.
>=20
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
> v3:
> - Instead of moving all of paging_init(), move only the parts
>   that are responsible for setting aside the reserved memory
>   regions.
>=20
> v2:
> https://lore.kernel.org/all/20240423233150.74302-1-quic_obabatun@quicinc.=
com/
> - Added Rob Herrings Reviewed-by.
> - cc Andrew Morton to assist with merging this for sh architecture.
>   Similar change made for loongarch and openrisc in v1 have already
>   been merged.
>=20
> v1:
> https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obaba=
tun@quicinc.com/
>=20
>  arch/sh/include/asm/setup.h |  1 -
>  arch/sh/kernel/setup.c      | 43 +++++++++++++++++++++++++++++++++++-
>  arch/sh/mm/init.c           | 44 -------------------------------------
>  3 files changed, 42 insertions(+), 46 deletions(-)
>=20
> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
> index fc807011187f..5feed99b9b7a 100644
> --- a/arch/sh/include/asm/setup.h
> +++ b/arch/sh/include/asm/setup.h
> @@ -19,7 +19,6 @@
>  #define COMMAND_LINE ((char *) (PARAM+0x100))
> =20
>  void sh_mv_setup(void);
> -void check_for_initrd(void);
>  void per_cpu_trap_init(void);
> =20
>  #endif /* _SH_SETUP_H */
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 620e5cf8ae1e..f5b6078173c9 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -114,7 +114,7 @@ static int __init early_parse_mem(char *p)
>  }
>  early_param("mem", early_parse_mem);
> =20
> -void __init check_for_initrd(void)
> +static void __init check_for_initrd(void)
>  {
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	unsigned long start, end;
> @@ -172,6 +172,42 @@ void __init check_for_initrd(void)
>  #endif
>  }
> =20
> +static void __init early_reserve_mem(void)
> +{
> +	unsigned long start_pfn;
> +	u32 zero_base =3D (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
> +	u32 start =3D zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
> +
> +	/*
> +	 * Partially used pages are not usable - thus
> +	 * we are rounding upwards:
> +	 */
> +	start_pfn =3D PFN_UP(__pa(_end));
> +
> +	/*
> +	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
> +	 * this in two steps (first step was init_bootmem()), because
> +	 * this catches the (definitely buggy) case of us accidentally
> +	 * initializing the bootmem allocator with an invalid RAM area.
> +	 */
> +	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
> +
> +	/*
> +	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
> +	 */
> +	if (CONFIG_ZERO_PAGE_OFFSET !=3D 0)
> +		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
> +
> +	/*
> +	 * Handle additional early reservations
> +	 */
> +	check_for_initrd();
> +	reserve_crashkernel();
> +
> +	if (sh_mv.mv_mem_reserve)
> +		sh_mv.mv_mem_reserve();
> +}
> +
>  #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
>  void calibrate_delay(void)
>  {
> @@ -319,9 +355,14 @@ void __init setup_arch(char **cmdline_p)
> =20
>  	sh_mv_setup();
> =20
> +	sh_mv.mv_mem_init();
> +
>  	/* Let earlyprintk output early console messages */
>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
> =20
> +	/* set aside reserved memory regions */
> +	early_reserve_mem();
> +
>  #ifdef CONFIG_OF_EARLY_FLATTREE
>  #ifdef CONFIG_USE_BUILTIN_DTB
>  	unflatten_and_copy_device_tree();
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index bf1b54055316..4559f5bea782 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -242,55 +242,11 @@ static void __init do_init_bootmem(void)
>  	sparse_init();
>  }
> =20
> -static void __init early_reserve_mem(void)
> -{
> -	unsigned long start_pfn;
> -	u32 zero_base =3D (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
> -	u32 start =3D zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
> -
> -	/*
> -	 * Partially used pages are not usable - thus
> -	 * we are rounding upwards:
> -	 */
> -	start_pfn =3D PFN_UP(__pa(_end));
> -
> -	/*
> -	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
> -	 * this in two steps (first step was init_bootmem()), because
> -	 * this catches the (definitely buggy) case of us accidentally
> -	 * initializing the bootmem allocator with an invalid RAM area.
> -	 */
> -	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
> -
> -	/*
> -	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
> -	 */
> -	if (CONFIG_ZERO_PAGE_OFFSET !=3D 0)
> -		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
> -
> -	/*
> -	 * Handle additional early reservations
> -	 */
> -	check_for_initrd();
> -	reserve_crashkernel();
> -}
> -
>  void __init paging_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES];
>  	unsigned long vaddr, end;
> =20
> -	sh_mv.mv_mem_init();
> -
> -	early_reserve_mem();
> -
> -	/*
> -	 * Once the early reservations are out of the way, give the
> -	 * platforms a chance to kick out some memory.
> -	 */
> -	if (sh_mv.mv_mem_reserve)
> -		sh_mv.mv_mem_reserve();
> -
>  	memblock_enforce_memory_limit(memory_limit);
>  	memblock_allow_resize();
> =20

This is missing an include of <asm/kexec.h> in arch/sh/kernel/setup.c:

  CC      io_uring/notif.o
  CC      lib/zlib_inflate/inftrees.o
arch/sh/kernel/setup.c: In function 'early_reserve_mem':
arch/sh/kernel/setup.c:205:9: error: implicit declaration of function 'rese=
rve_crashkernel'; did you mean 'parse_crashkernel'? [-Werror=3Dimplicit-fun=
ction-declaration]
  205 |         reserve_crashkernel();
      |         ^~~~~~~~~~~~~~~~~~~
      |         parse_crashkernel
  CC      net/core/flow_dissector.o
  AR      block/partitions/built-in.a
  CC      block/elevator.o
  CC      block/blk-core.o
cc1: some warnings being treated as errors
  CC      crypto/shash.o
make[4]: *** [scripts/Makefile.build:244: arch/sh/kernel/setup.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC      crypto/crc32c_generic.o

Can you fix that? And, while at it, also rebase the patch against v6.10-rc1
so it applies cleanly against my SH Linux tree?

Besides, I have tested the patch and I can confirm that my J2 board still
boots fine with the patch applied.

Sorry for being so super-late with the review. I hope you can still send
an updated patch by tomorrow or Saturday.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
