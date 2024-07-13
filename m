Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EF33CD1;
	Sat, 13 Jul 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720857515; cv=none; b=FGcKBcxQ5KWz0S6gYRJtMzGQLfIH3ByVaOA70/i9+yj1gSdygZw95KIDFiTBPTv92SoZOFf2kPUfngyAqx3hPq4gihJPTX5I3FxhOj7kTmbKuO3MbgguY043huoSuVEVQU6VrWh9WxCbAashxXNT/V6VYniWV+vzkqr5GHqWwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720857515; c=relaxed/simple;
	bh=dLrEoyW/iYYmlsFSWVeLRejzeTi6glzi3X89UnmPpwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkNBtL2lDBXg8w5K2Z1kDOc78RfygfPVlgesYX4JYFd2mLZ/j68JeyXeIGyhc/cfHRgaUh3Xxh4j8h6AFyjfcahiAySKyBv6CHlD9Azw4jsf/xUv/Zz6xVgO7a/9zqG1+O/BNV4W8zTqxFTrwMLZAHZ/qyD1upn/4KuGeuWeHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=iZw8nD0c; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="iZw8nD0c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N/zJwrlK/ouWulqBOgVNdt7ra+u3M2oRr6xhbFWikvk=; t=1720857510; x=1721462310; 
	b=iZw8nD0cJaGQsetBjcmsf734/Rql/4zcEA6C1XYby1N8QxUQt5o1TtHiekUoBcoUM0PcP+aB+d4
	AKEqE9Zr1cgbv5Wtc6i0tpfkMrA/l6R9PMhYfTJTEP0pUCpSXCHbzbOI8wUXcWDbCTSwsCTYvijVX
	3U6UJ7zu313Uhqwpr1XDfu5rA9SQcLgPyLwbCMVueagCH/yqSwnFdH7/dO5Xekhr+V6HTXKOFvd8v
	MXr8txnt5rt/aqe6+wgAqNvGJySckKvh5pf1xXw03QLIXHqo/t76ADyrdzh/2j6x7bgSkdRMXt1OM
	LdnV0/CsfHXMyIjzwQkdhjtr4qTeRDoLh7Tg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sSXeE-00000001c2M-0n5u; Sat, 13 Jul 2024 09:58:26 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sSXeD-00000003Mfh-43Da; Sat, 13 Jul 2024 09:58:26 +0200
Message-ID: <a68b7cd0e3b143f023414feca279deb768d43575.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com
Date: Sat, 13 Jul 2024 09:58:25 +0200
In-Reply-To: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
References: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
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

review follows below.

On Thu, 2024-07-11 at 14:44 -0700, Oreoluwa Babatunde wrote:
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
> v4:
> - Rebase patch ontop of v6.10-rc1 as requested by Maintainer.
> - Add missing include in arch/sh/kernel/setup.c
>=20
> v3:
> https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicin=
c.com/
> - Instead of moving all of paging_init(), move only the parts
>   that are responsible for setting aside the reserved memory
>   regions.
>=20
> v2:
> https://lore.kernel.org/all/20240423233150.74302-1-quic_obabatun@quicinc.=
com/
> - Add Rob Herrings Reviewed-by.
> - cc Andrew Morton to assist with merging this for sh architecture.
>   Similar change made for loongarch and openrisc in v1 have already
>   been merged.
>=20
> v1:
> https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obaba=
tun@quicinc.com/
>  arch/sh/include/asm/setup.h |  1 -
>  arch/sh/kernel/setup.c      | 44 ++++++++++++++++++++++++++++++++++++-
>  arch/sh/mm/init.c           | 44 -------------------------------------
>  3 files changed, 43 insertions(+), 46 deletions(-)
>=20
> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
> index 84bb23a771f3..f8b814fb1c7f 100644
> --- a/arch/sh/include/asm/setup.h
> +++ b/arch/sh/include/asm/setup.h
> @@ -19,7 +19,6 @@
>  #define COMMAND_LINE ((char *) (PARAM+0x100))
> =20
>  void sh_mv_setup(void);
> -void check_for_initrd(void);
>  void per_cpu_trap_init(void);
>  void sh_fdt_init(phys_addr_t dt_phys);
> =20
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 620e5cf8ae1e..8477491f4ffd 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -35,6 +35,7 @@
>  #include <asm/io.h>
>  #include <asm/page.h>
>  #include <asm/elf.h>
> +#include <asm/kexec.h>
>  #include <asm/sections.h>
>  #include <asm/irq.h>
>  #include <asm/setup.h>
> @@ -114,7 +115,7 @@ static int __init early_parse_mem(char *p)
>  }
>  early_param("mem", early_parse_mem);
> =20
> -void __init check_for_initrd(void)
> +static void __init check_for_initrd(void)
>  {
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	unsigned long start, end;
> @@ -172,6 +173,42 @@ void __init check_for_initrd(void)
>  #endif
>  }

Making check_for_initrd() static seems like an unrelated change to me or am
I missing something? If yes, it should go into a separate patch.

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

I'm not really happy with moving early_reserve_mem() from mm/init.c to
kernel/setup.c. Can't we just leave it where it is while still keeping
the changes to paging_init()?

> @@ -319,9 +356,14 @@ void __init setup_arch(char **cmdline_p)
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

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
