From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 18:03:33 +0000
Subject: Re: [PATCH 1/4] sh: convert shdma dmaengine driver to use platform
Message-Id: <Pine.LNX.4.64.1002031900540.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031554020.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031554020.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 3 Feb 2010, Guennadi Liakhovetski wrote:

> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> index aa0f6e9..460d147 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -28,15 +28,143 @@
>  #include <cpu/sh7724.h>
>  
>  /* DMA */
> -static struct sh_dmae_pdata dma_platform_data = {
> -	.mode = SHDMA_DMAOR1,
> +static struct sh_dmae_channel sh7722_dmae0_channels[] = {

				 ^^^^^^

Yes, an obvious copy-paste fsck-up - throughout this file. I'll wait for 
reviews though before submitting a v2.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
