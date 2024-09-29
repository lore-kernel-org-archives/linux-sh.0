Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5D1F95A;
	Sun, 29 Sep 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642106; cv=none; b=A7dSxoHvqV2nf6rFLcV4nDtOELF3DA7QeVKUbzP29hdCBmlueczn2M1N5gd63fvG3S96DmYxn36Da+zE0uHQLE3Zyg7siQZ98GFYjcyDBWB6wmnkQihsPawF4bOnlmkoQwXU0tTjF9s92A3KZsHiVSqPr8iyQiNYLQ/235U1aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642106; c=relaxed/simple;
	bh=DLAuxEpvSOj0ujPKSoEJPWt33cOwsZsk0QVYKAyfS+w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z7z8H8/gpcMMFFM1V3qhkG3ZqUItYipNitaKTWcfoWgUNcoEmx549lfOcCey18x2LUhn4jAbgR+jTdN1tdUgKiDOoSlqH6sbmAAFNenhwjWuRJO1HUnZ0qVeZkDns5vQih4pSO2Q5pGFv4/XrmCNT0wm84c/KPH4XzJC/NMPa2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB155E0002;
	Sun, 29 Sep 2024 20:34:54 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 29 Sep 2024 22:34:54 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: dalias@libc.org, glaubitz@physik.fu-berlin.de,
 ysato@users.sourceforge.jp, kernel@quicinc.com,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, robh+dt@kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v5 1/2] sh: Restructure call site for early_reserve_mem()
In-Reply-To: <20240718021822.1545976-2-quic_obabatun@quicinc.com>
References: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
 <20240718021822.1545976-2-quic_obabatun@quicinc.com>
Message-ID: <f36740a3b7f5a4b031aa656533403f1f@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu

On 2024-07-18 04:18, Oreoluwa Babatunde wrote:
> early_reserve_mem() reserves memory for important regions in the kernel
> such as kernel text region and bootmem bitmap.
> Reserving these memory regions should take precedence over any other
> reserved memory allocations so that the system does not unknowingly
> reserve them for some other use case.
> 
> Hence, move the call site of early_reserve_mem() out of the
> paging_init() function and into an earlier point in setup_arch()
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

Hi Oreoluwa,

the patch is looking fine to me. Verified on J2 Turtle Board.

Reviewed-by: Artur Rojek <contact@artur-rojek.eu>

Cheers,
Artur

> ---
>  arch/sh/include/asm/mmu.h | 1 +
>  arch/sh/kernel/setup.c    | 3 +++
>  arch/sh/mm/init.c         | 5 ++---
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
> index 172e329fd92d..696e303a2f19 100644
> --- a/arch/sh/include/asm/mmu.h
> +++ b/arch/sh/include/asm/mmu.h
> @@ -96,6 +96,7 @@ static inline int pmb_unmap(void __iomem *addr)
> 
>  #endif /* CONFIG_PMB */
> 
> +void __init early_reserve_mem(void);
>  static inline void __iomem *
>  pmb_remap(phys_addr_t phys, unsigned long size, pgprot_t prot)
>  {
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 620e5cf8ae1e..3b0bc191a2a2 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -40,6 +40,7 @@
>  #include <asm/setup.h>
>  #include <asm/clock.h>
>  #include <asm/smp.h>
> +#include <asm/mmu.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mmzone.h>
>  #include <asm/processor.h>
> @@ -319,6 +320,8 @@ void __init setup_arch(char **cmdline_p)
> 
>  	sh_mv_setup();
> 
> +	early_reserve_mem();
> +
>  	/* Let earlyprintk output early console messages */
>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index bf1b54055316..643e3617c6a6 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <asm/mmu.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mmzone.h>
>  #include <asm/kexec.h>
> @@ -242,7 +243,7 @@ static void __init do_init_bootmem(void)
>  	sparse_init();
>  }
> 
> -static void __init early_reserve_mem(void)
> +void __init early_reserve_mem(void)
>  {
>  	unsigned long start_pfn;
>  	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
> @@ -282,8 +283,6 @@ void __init paging_init(void)
> 
>  	sh_mv.mv_mem_init();
> 
> -	early_reserve_mem();
> -
>  	/*
>  	 * Once the early reservations are out of the way, give the
>  	 * platforms a chance to kick out some memory.
