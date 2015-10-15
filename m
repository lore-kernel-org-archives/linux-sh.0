From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Oct 2015 16:15:27 +0000
Subject: Re: [PATCH v3 3/6] dma: rcar-dma: check if complete DMA packet received but not processed
Message-Id: <2344072.t3AI9iTV0d@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-4-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-4-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Muhammad,

Thank you for the patch.

On Tuesday 29 September 2015 22:44:45 hamzahfrq.sub@gmail.com wrote:
> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
> 
> At high speeds, DMA interrupts come very fast. If there's an interrupt
> pending before previous is handled, this method can help return actual
> status of the DMA transaction by reading the hardware flag
> 
> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index c7cd4ed..6c806d0 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -314,6 +314,14 @@ static bool rcar_dmac_chan_is_busy(struct
> rcar_dmac_chan *chan) return (chcr & (RCAR_DMACHCR_DE | RCAR_DMACHCR_TE))
> = RCAR_DMACHCR_DE; }
> 
> +/* Transfer completed but not yet handled */
> +static bool rcar_dmac_last_tx_complete(struct rcar_dmac_chan *chan)
> +{
> +	u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
> +
> +	return (chcr & RCAR_DMACHCR_TE) = RCAR_DMACHCR_TE;
> +}
> +
>  static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
>  {
>  	struct rcar_dmac_desc *desc = chan->desc.running;
> @@ -1238,6 +1246,10 @@ static enum dma_status rcar_dmac_tx_status(struct
> dma_chan *chan, unsigned long flags;
>  	unsigned int residue;
> 
> +	/* Interrupt not yet serviced */
> +	if (rcar_dmac_last_tx_complete(rchan))
> +		return DMA_COMPLETE;
> +

I don't think this will work. In particular rcar_dmac_tx_status() can be 
called with a cookie corresponding to a transfer not yet scheduled. A pending 
transfer complete interrupt doesn't mean that that cookie is complete.

Furthermore I'm not sure this will really improve performances. The 
dma_cookie_status() call below just compares cookie values, I don't expect it 
to be much slower than a register read.

>  	status = dma_cookie_status(chan, cookie, txstate);
>  	if (status = DMA_COMPLETE || !txstate)
>  		return status;

-- 
Regards,

Laurent Pinchart

