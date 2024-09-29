Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CABB65C;
	Sun, 29 Sep 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727644550; cv=none; b=P8nDgiT9OSPqePWRfTbsu1iv/OYfzeW2Qmb1ddeejv4Qbvirtc7HcG6lVLHXM1qGYGIL0ma4+CddxzlKEuaoMSrdiOa+DjFQBs6Bs3n3EBl/sqiUnJ5SCKwVmyEVCjikfyBYmUMTvcPWNwwQg4Nl/vCSPFD3jSz0wB4gkX0ZItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727644550; c=relaxed/simple;
	bh=wegcv/7tglSN1+MTO2CrjyZ882nEx6leEcDsQ1LURi8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kwApFF+ZESCjGDpnz4fUSFOIulCbk0mZ4wE86cEzkJ/y1dcdtRKUcKhDjGJJBM1P9Jh20mqWvwA3L1OZ6IOE8SRU34fV2zF6zRGeIXIjr6x1cRa8u1w1QFtOfg6xJUIxEtaJjOgXEYmBM1GDEXb++ff167eRwr09Evpz3zm5jOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B53BC0006;
	Sun, 29 Sep 2024 21:15:35 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 29 Sep 2024 23:15:35 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: dalias@libc.org, glaubitz@physik.fu-berlin.de,
 ysato@users.sourceforge.jp, kernel@quicinc.com,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, robh+dt@kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v5 2/2] sh: Restructure setup code to reserve memory
 regions earlier
In-Reply-To: <20240718021822.1545976-3-quic_obabatun@quicinc.com>
References: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
 <20240718021822.1545976-3-quic_obabatun@quicinc.com>
Message-ID: <aba64912a7cf700fd281016d4a2ad82d@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu

On 2024-07-18 04:18, Oreoluwa Babatunde wrote:
> The unflatten_device_tree() function contains a call to
> memblock_alloc(). This is a problem because this allocation is done
> before any of the reserved memory regions are set aside in
> paging_init().
> As a result, there is a possibility for memblock to unknowingly 
> allocate
> from any of the memory regions that are meant to be reserved.
> 
> Hence, restructure the setup code to reserve the memory regions before
> any allocation is done by the unflatten_devicetree*() using memblock.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

Hi Oreoluwa,

> ---
>  arch/sh/mm/init.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 643e3617c6a6..857ce8cc84bd 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -249,6 +249,7 @@ void __init early_reserve_mem(void)
>  	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
>  	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
> 
> +	sh_mv.mv_mem_init();

One side effect of moving mv_mem_init here is that it makes cache
operations available earlier. But I see no harm in doing that.

Otherwise the patch is looking good. Verified on J2 Turtle Board.

Reviewed-by: Artur Rojek <contact@artur-rojek.eu>

Cheers,
Artur

>  	/*
>  	 * Partially used pages are not usable - thus
>  	 * we are rounding upwards:
> @@ -274,14 +275,6 @@ void __init early_reserve_mem(void)
>  	 */
>  	check_for_initrd();
>  	reserve_crashkernel();
> -}
> -
> -void __init paging_init(void)
> -{
> -	unsigned long max_zone_pfns[MAX_NR_ZONES];
> -	unsigned long vaddr, end;
> -
> -	sh_mv.mv_mem_init();
> 
>  	/*
>  	 * Once the early reservations are out of the way, give the
> @@ -289,6 +282,12 @@ void __init paging_init(void)
>  	 */
>  	if (sh_mv.mv_mem_reserve)
>  		sh_mv.mv_mem_reserve();
> +}
> +
> +void __init paging_init(void)
> +{
> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> +	unsigned long vaddr, end;
> 
>  	memblock_enforce_memory_limit(memory_limit);
>  	memblock_allow_resize();
