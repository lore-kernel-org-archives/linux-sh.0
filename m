From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 13 Jul 2015 20:36:33 +0000
Subject: Re: [PATCH/RFC 1/3] dmaengine: shdmac: Use generic residue handling
Message-Id: <25209725.IJZN4YurBP@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436529553-30571-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436529553-30571-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 10 July 2015 13:59:11 Geert Uytterhoeven wrote:
> Convert the existing support for partial DMA transfers to use the
> generic dmaengine residual data framework.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Notes:
>   - Untested, as this mostly affects legacy (non-DT) drivers on more or
>     less legacy platforms,
>   - This cannot be applied yet, as drivers/tty/serial/sh-sci.c still
>     uses shdma_desc.partial!
> ---
>  drivers/dma/sh/rcar-hpbdma.c | 10 +++++-----
>  drivers/dma/sh/shdma-base.c  | 12 ++++++++----
>  drivers/dma/sh/shdmac.c      | 13 +++++--------
>  drivers/dma/sh/sudmac.c      | 10 +++++-----
>  include/linux/shdma-base.h   |  4 ++--
>  5 files changed, 25 insertions(+), 24 deletions(-)

Changes to the individual drivers look fine to me, but I think there's an 
issue with the change to the shdma-base code.

[snip]

> diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> index 10fcabad80f3c65c..370b6c6895f3d48e 100644
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
> @@ -539,7 +539,7 @@ static struct shdma_desc *shdma_add_desc(struct
> shdma_chan *schan, new->mark = DESC_PREPARED;
>  	new->async_tx.flags = flags;
>  	new->direction = direction;
> -	new->partial = 0;
> +	new->residue = *len;
> 
>  	*len -= copy_size;
>  	if (direction = DMA_MEM_TO_MEM || direction = DMA_MEM_TO_DEV)
> @@ -763,11 +763,11 @@ static int shdma_terminate_all(struct dma_chan *chan)
>  	spin_lock_irqsave(&schan->chan_lock, flags);
>  	ops->halt_channel(schan);
> 
> -	if (ops->get_partial && !list_empty(&schan->ld_queue)) {
> -		/* Record partial transfer */
> +	if (ops->get_residue && !list_empty(&schan->ld_queue)) {
> +		/* Record residual transfer */
>  		struct shdma_desc *desc = list_first_entry(&schan->ld_queue,
>  							   struct shdma_desc, node);
> -		desc->partial = ops->get_partial(schan, desc);
> +		desc->residue = ops->get_residue(schan, desc);
>  	}
> 
>  	spin_unlock_irqrestore(&schan->chan_lock, flags);
> @@ -825,6 +825,7 @@ static enum dma_status shdma_tx_status(struct dma_chan
> *chan, struct shdma_chan *schan = to_shdma_chan(chan);
>  	enum dma_status status;
>  	unsigned long flags;
> +	u32 residue = 0;
> 
>  	shdma_chan_ld_cleanup(schan, false);
> 
> @@ -842,12 +843,15 @@ static enum dma_status shdma_tx_status(struct dma_chan
> *chan, list_for_each_entry(sdesc, &schan->ld_queue, node)
>  			if (sdesc->cookie = cookie) {
>  				status = DMA_IN_PROGRESS;
> +				residue = sdesc->residue;

The residue value cached in the descriptor is set to the transfer size and 
then updated in shdma_terminate_all() only. You will thus not return the 
correct residue for transfers that are ongoing. Furthermore 
shdma_terminate_all() will remove all descriptors from schan->ld_queue, so 
this code block will never report the right residue.

>  				break;
>  			}
>  	}
> 
>  	spin_unlock_irqrestore(&schan->chan_lock, flags);
> 
> +	dma_set_residue(txstate, residue);
> +
>  	return status;
>  }
> 

-- 
Regards,

Laurent Pinchart

