From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Jan 2015 22:16:18 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix uninitialized variable usage
Message-Id: <1601519.I0fRl2WXHb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1420734565-23815-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1420734565-23815-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

Could you please apply this patch to your tree for v3.20 ?

On Thursday 08 January 2015 18:29:25 Laurent Pinchart wrote:
> The desc variable is used uninitialized in the rcar_dmac_desc_get() and
> rcar_dmac_xfer_chunk_get() functions if descriptors need to be
> allocated. Fix it.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 69 +++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 29dd09ad41ff..8367578bac63 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -549,26 +549,22 @@ static struct rcar_dmac_desc
> *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
> 
>  	spin_lock_irq(&chan->lock);
> 
> -	do {
> -		if (list_empty(&chan->desc.free)) {
> -			/*
> -			 * No free descriptors, allocate a page worth of them
> -			 * and try again, as someone else could race us to get
> -			 * the newly allocated descriptors. If the allocation
> -			 * fails return an error.
> -			 */
> -			spin_unlock_irq(&chan->lock);
> -			ret = rcar_dmac_desc_alloc(chan, GFP_NOWAIT);
> -			if (ret < 0)
> -				return NULL;
> -			spin_lock_irq(&chan->lock);
> -			continue;
> -		}
> +	while (list_empty(&chan->desc.free)) {
> +		/*
> +		 * No free descriptors, allocate a page worth of them and try
> +		 * again, as someone else could race us to get the newly
> +		 * allocated descriptors. If the allocation fails return an
> +		 * error.
> +		 */
> +		spin_unlock_irq(&chan->lock);
> +		ret = rcar_dmac_desc_alloc(chan, GFP_NOWAIT);
> +		if (ret < 0)
> +			return NULL;
> +		spin_lock_irq(&chan->lock);
> +	}
> 
> -		desc = list_first_entry(&chan->desc.free, struct rcar_dmac_desc,
> -					node);
> -		list_del(&desc->node);
> -	} while (!desc);
> +	desc = list_first_entry(&chan->desc.free, struct rcar_dmac_desc, node);
> +	list_del(&desc->node);
> 
>  	spin_unlock_irq(&chan->lock);
> 
> @@ -621,26 +617,23 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
> 
>  	spin_lock_irq(&chan->lock);
> 
> -	do {
> -		if (list_empty(&chan->desc.chunks_free)) {
> -			/*
> -			 * No free descriptors, allocate a page worth of them
> -			 * and try again, as someone else could race us to get
> -			 * the newly allocated descriptors. If the allocation
> -			 * fails return an error.
> -			 */
> -			spin_unlock_irq(&chan->lock);
> -			ret = rcar_dmac_xfer_chunk_alloc(chan, GFP_NOWAIT);
> -			if (ret < 0)
> -				return NULL;
> -			spin_lock_irq(&chan->lock);
> -			continue;
> -		}
> +	while (list_empty(&chan->desc.chunks_free)) {
> +		/*
> +		 * No free descriptors, allocate a page worth of them and try
> +		 * again, as someone else could race us to get the newly
> +		 * allocated descriptors. If the allocation fails return an
> +		 * error.
> +		 */
> +		spin_unlock_irq(&chan->lock);
> +		ret = rcar_dmac_xfer_chunk_alloc(chan, GFP_NOWAIT);
> +		if (ret < 0)
> +			return NULL;
> +		spin_lock_irq(&chan->lock);
> +	}
> 
> -		chunk = list_first_entry(&chan->desc.chunks_free,
> -					  struct rcar_dmac_xfer_chunk, node);
> -		list_del(&chunk->node);
> -	} while (!chunk);
> +	chunk = list_first_entry(&chan->desc.chunks_free,
> +				 struct rcar_dmac_xfer_chunk, node);
> +	list_del(&chunk->node);
> 
>  	spin_unlock_irq(&chan->lock);

-- 
Regards,

Laurent Pinchart

