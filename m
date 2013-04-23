From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Apr 2013 00:41:15 +0000
Subject: Re: [PATCH 2/2 v7] sudmac: add support for SUDMAC
Message-Id: <87k3nu5b9z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5174FDF3.8060809@renesas.com>
In-Reply-To: <5174FDF3.8060809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Shimoda-san

Thank you for your patches.

> Some Renesas USB modules have SUDMAC. This patch supports it using
> the shdma-base driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
(snip)
> +config SUDMAC
> +	tristate "Renesas SUDMAC support"
> +	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
> +	depends on !SH_DMA_API
> +	select DMA_ENGINE
> +	help
> +	  Enable support for the Renesas SUDMAC controllers.
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
> index 54ae957..16f9225 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_SH_DMAE) += shdma-base.o
>  obj-$(CONFIG_SH_DMAE) += shdma.o
> +obj-$(CONFIG_SUDMAC) += shdma-base.o sudmac.o

I'm not sure detail of it, but, I thought we can do like this.
Is it possible ? 

--- Kconfig ---
config SH_DMAE_BASE
	xxx

config SH_DMAE
	xxx
	depends on SH_DMAE_BASE

config SH_SUDMAC
	xxx
	depends on SH_DMAE_BASE

--- Makefile ---

obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o
obj-$(CONFIG_SH_DMAE) += shdma.o
obj-$(CONFIG_SUDMAC) += sudmac.o

Best regards
---
Kuninori Morimoto
