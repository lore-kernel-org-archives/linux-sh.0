From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 May 2015 08:25:19 +0000
Subject: Re: [PATCH 1/4] dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
Message-Id: <2119137.Ez4XYKtCXC@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com> <871tib52vy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871tib52vy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Wednesday 20 May 2015 03:46:19 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current rcar-dmac driver is using spin_lock_irq() / spin_unlock_irq()
> in some functions. But, some other driver might call DMAEngine API
> during interrupt disabled. In such case, rcar-dmac side spin_unlock_irq()
> forcefully allows all interrupts. Therefore, other driver receives
> unexpected interruption, and its exclusive access control will be broken.
> This patch replaces spin_lock_irq() to spin_lock_irqsave(),
> and spin_unlock_irq() to spin_unlock_irqrestore().

I would have sworn I had fixed the issue already :-/ Sorry about it.

I believe (part of) the issue should be fixed in the DMA engine API by 
splitting descriptor allocation to non-atomic context, but that's a longer 
term solution of course, out of scope for this series.

The patch looks good, please see below for a couple of comments.

> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 55 +++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index a18d16c..6a5d4b9 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c

[snip]

> @@ -964,12 +969,13 @@ static void rcar_dmac_free_chan_resources(struct
> dma_chan *chan) struct rcar_dmac *dmac = to_rcar_dmac(chan->device);
>  	struct rcar_dmac_desc_page *page, *_page;
>  	struct rcar_dmac_desc *desc;
> +	unsigned long flags;
>  	LIST_HEAD(list);
> 
>  	/* Protect against ISR */
> -	spin_lock_irq(&rchan->lock);
> +	spin_lock_irqsave(&rchan->lock, flags);

The .device_free_chan_resources() can't be called with interrupts disabled, so 
we should be safe with spin_lock_irq() here. However, as the function isn't 
called in a performance-critical path, I'm fine with spin_lock_irqsave() too.

>  	rcar_dmac_chan_halt(rchan);
> -	spin_unlock_irq(&rchan->lock);
> +	spin_unlock_irqrestore(&rchan->lock, flags);
> 
>  	/* Now no new interrupts will occur */
> 
> @@ -1351,8 +1357,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int
> irq, void *dev) {
>  	struct rcar_dmac_chan *chan = dev;
>  	struct rcar_dmac_desc *desc;
> +	unsigned long flags;
> 
> -	spin_lock_irq(&chan->lock);
> +	spin_lock_irqsave(&chan->lock, flags);

Isn't the threaded IRQ handler called in a thread with interrupts enabled by 
definition ? spin_lock_irq() should thus be safe here. You could, however, 
convince me that spin_lock_irqsave() won't make much of a difference 
performance-wise, and would allow avoiding future similar bugs.
 
>  	/* For cyclic transfers notify the user after every chunk. */
>  	if (chan->desc.running && chan->desc.running->cyclic) {
> @@ -1364,9 +1371,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int
> irq, void *dev) callback_param = desc->async_tx.callback_param;
> 
>  		if (callback) {
> -			spin_unlock_irq(&chan->lock);
> +			spin_unlock_irqrestore(&chan->lock, flags);
>  			callback(callback_param);
> -			spin_lock_irq(&chan->lock);
> +			spin_lock_irqsave(&chan->lock, flags);
>  		}
>  	}
> 
> @@ -1381,20 +1388,20 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int
> irq, void *dev) list_del(&desc->node);
> 
>  		if (desc->async_tx.callback) {
> -			spin_unlock_irq(&chan->lock);
> +			spin_unlock_irqrestore(&chan->lock, flags);
>  			/*
>  			 * We own the only reference to this descriptor, we can
>  			 * safely dereference it without holding the channel
>  			 * lock.
>  			 */
>  			desc->async_tx.callback(desc->async_tx.callback_param);
> -			spin_lock_irq(&chan->lock);
> +			spin_lock_irqsave(&chan->lock, flags);
>  		}
> 
>  		list_add_tail(&desc->node, &chan->desc.wait);
>  	}
> 
> -	spin_unlock_irq(&chan->lock);
> +	spin_unlock_irqrestore(&chan->lock, flags);
> 
>  	/* Recycle all acked descriptors. */
>  	rcar_dmac_desc_recycle_acked(chan);

-- 
Regards,

Laurent Pinchart

