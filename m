From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 15 May 2013 06:40:33 +0000
Subject: Re: [PATCH] mmc: mmcif: don't clear masked interrupts
Message-Id: <Pine.LNX.4.64.1305150839550.10596@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305150746480.10596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305150746480.10596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

On Wed, 15 May 2013, Guennadi Liakhovetski wrote:

> Masking events on MMCIF means, an occurrence of the masked event won't raise
> an interrupt, but the event bit will still be set in the interrupt status
> register. If simultaneously a different event occurs, that was enabled, both
> flags will be set. However, only the unmasked event bit should be cleared in
> the status register in such a case. Clearing also the masked bit can lead to
> lost interrupts, which indeed can be observed on the armadillo800eva r8a7740
> board with an eMMC chip. The problem has been introduced by the recent "mmc:
> sh_mmcif: simplify IRQ processing" patch. Fix the problem by only clearing
> enabled interrupts.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Sorry, forgot to add a

Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>

Thanks
Guennadi

> ---
> 
> Chris, please, push this fix to 3.10, thanks.
> 
>  drivers/mmc/host/sh_mmcif.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index ba76a53..06caaae 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1244,7 +1244,8 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
>  	u32 state;
>  
>  	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
> -	sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
> +	sh_mmcif_writel(host->addr, MMCIF_CE_INT,
> +			~(state & sh_mmcif_readl(host->addr, MMCIF_CE_INT_MASK)));
>  	sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state & MASK_CLEAN);
>  
>  	if (state & ~MASK_CLEAN)
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
