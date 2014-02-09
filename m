From: Paul Bolle <pebolle@tiscali.nl>
Date: Sun, 09 Feb 2014 21:36:01 +0000
Subject: Re: [PATCH 21/28] Remove CPU_SUBTYPE_SH7764
Message-Id: <1391981761.25855.58.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
	 <1391971686-9517-22-git-send-email-richard@nod.at>
In-Reply-To: <1391971686-9517-22-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: Paul Mundt <lethal@linux-sh.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Paul Mundt had something similar queued a year ago:
https://lkml.org/lkml/2013/3/11/211 . What happened?


Paul Bolle

>  arch/sh/drivers/dma/Kconfig                | 5 ++---
>  arch/sh/include/cpu-sh4/cpu/dma-register.h | 1 -
>  arch/sh/include/cpu-sh4a/cpu/dma.h         | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
> index cfd5b90..e07afe8 100644
> --- a/arch/sh/drivers/dma/Kconfig
> +++ b/arch/sh/drivers/dma/Kconfig
> @@ -12,9 +12,8 @@ config SH_DMA_IRQ_MULTI
>  	default y if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
>  		     CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7750R || \
>  		     CPU_SUBTYPE_SH7751R || CPU_SUBTYPE_SH7091  || \
> -		     CPU_SUBTYPE_SH7763  || CPU_SUBTYPE_SH7764  || \
> -		     CPU_SUBTYPE_SH7780  || CPU_SUBTYPE_SH7785  || \
> -		     CPU_SUBTYPE_SH7760
> +		     CPU_SUBTYPE_SH7763  || CPU_SUBTYPE_SH7780  || \
> +		     CPU_SUBTYPE_SH7785  CPU_SUBTYPE_SH7760
>  
>  config SH_DMA_API
>  	depends on SH_DMA
> diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
> index 02788b6..9cd81e5 100644
> --- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
> +++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
> @@ -32,7 +32,6 @@
>  #define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
>  #elif defined(CONFIG_CPU_SUBTYPE_SH7757) || \
>  	defined(CONFIG_CPU_SUBTYPE_SH7763) || \
> -	defined(CONFIG_CPU_SUBTYPE_SH7764) || \
>  	defined(CONFIG_CPU_SUBTYPE_SH7780) || \
>  	defined(CONFIG_CPU_SUBTYPE_SH7785)
>  #define CHCR_TS_LOW_MASK	0x00000018
> diff --git a/arch/sh/include/cpu-sh4a/cpu/dma.h b/arch/sh/include/cpu-sh4a/cpu/dma.h
> index 89afb65..8ceccce 100644
> --- a/arch/sh/include/cpu-sh4a/cpu/dma.h
> +++ b/arch/sh/include/cpu-sh4a/cpu/dma.h
> @@ -14,8 +14,7 @@
>  #define DMTE4_IRQ	evt2irq(0xb80)
>  #define DMAE0_IRQ	evt2irq(0xbc0)	/* DMA Error IRQ*/
>  #define SH_DMAC_BASE0	0xFE008020
> -#elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
> -	defined(CONFIG_CPU_SUBTYPE_SH7764)
> +#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
>  #define DMTE0_IRQ	evt2irq(0x640)
>  #define DMTE4_IRQ	evt2irq(0x780)
>  #define DMAE0_IRQ	evt2irq(0x6c0)


