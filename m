From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Oct 2015 15:58:01 +0000
Subject: Re: [PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <3177874.uEB8hIjWEN@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Muhammad,

Thank you for the patch.

On Tuesday 29 September 2015 22:44:43 hamzahfrq.sub@gmail.com wrote:
> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
> 
> DMA engine does not stop instantaneously when transaction is going on
> (see datasheet). Wait has been added
> 
> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07..2b28291 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -716,14 +716,38 @@ static int rcar_dmac_fill_hwdesc(struct rcar_dmac_chan
> *chan, /*
> ---------------------------------------------------------------------------
>  * Stop and reset
>  */
> +#define NR_READS_TO_WAIT 5 /* number of times to check if DE = 0 */
> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
> +{
> +	unsigned int i = 0;
> +
> +	do {
> +		u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
> +
> +		if (!(chcr & RCAR_DMACHCR_DE))
> +			return 0;
> +		cpu_relax();
> +		dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be stopped");

Would it make sense to move the message out of the loop and use dev_err() ? It 
seems like a pretty serious error.

> +	} while (++i < NR_READS_TO_WAIT);

How long does the DMA engine typically need to stop ? Is there a safe upper 
bound ?

> -static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
> +	return -EBUSY;
> +}
> +
> +/* Called with chan lock held */
> +static int rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
>  {
> -	u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
> +	u32 chcr;
> +	int ret;
> 
> +	chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>  	chcr &= ~(RCAR_DMACHCR_DSE | RCAR_DMACHCR_DSIE | RCAR_DMACHCR_IE |
>  		  RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
>  	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
> +	ret = rcar_dmac_wait_stop(chan);

As the rcar_dmac_wait_stop() function is used here only I'd inline the code 
directly.

> +
> +	WARN_ON(ret < 0);

If you use dev_err() instead of dev_dbg() above you could remove the WARN_on.

> +
> +	return ret;
>  }
> 
>  static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)

-- 
Regards,

Laurent Pinchart

