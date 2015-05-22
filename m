From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 May 2015 01:26:53 +0000
Subject: Re: [PATCH] DMA: shdma: r8a73a4: Make dma_ts_shift[] static
Message-Id: <20150522012652.GB27511@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1432209510-20449-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432209510-20449-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 21, 2015 at 01:58:30PM +0200, Geert Uytterhoeven wrote:
> dma_ts_shift[] isn't used outside this source file. All other users use
> the definition from arch/arm/mach-shmobile/dma-register.h.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/dma/sh/shdma-r8a73a4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
> index 4fb99970a3ea9b56..96ea3828c3eb8213 100644
> --- a/drivers/dma/sh/shdma-r8a73a4.c
> +++ b/drivers/dma/sh/shdma-r8a73a4.c
> @@ -11,7 +11,7 @@
>  
>  #include "shdma-arm.h"
>  
> -const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
> +static const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
>  
>  static const struct sh_dmae_slave_config dma_slaves[] = {
>  	{
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
