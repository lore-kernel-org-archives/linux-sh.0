From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Feb 2015 01:48:22 +0000
Subject: RE: [PATCH] dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
Message-Id: <HKNPR06MB322EDED5E6133F19A0C18ADD8240@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sielhz1i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sielhz1i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

> Current rcar-dmac driver is using spin_lock_irq() / spin_unlock_irq()
> in some functions. But, some other driver might call DMAEngine API
> during interrupt disabled. In such case, rcar-dmac side spin_unlock_irq()
> forcefully allows all interrupts. Therefore, other driver receives
> unexpected interruption, and its exclusive access control will be broken.
> This patch replaces spin_lock_irq() to spin_lock_irqsave(),
> and spin_unlock_irq() to spin_unlock_irqrestore().
> 
> Signed-off-by: Jun Watanabe <jun.watanabe.ue@renesas.com>
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesasu.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
< snip >
> @@ -493,15 +494,18 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
>  static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
>  			       struct rcar_dmac_desc *desc)
>  {
> -	spin_lock_irq(&chan->lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->lock, flags);
>  	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
>  	list_add_tail(&desc->node, &chan->desc.free);
> -	spin_unlock_irq(&chan->lock);
> +	spin_unlock_irqrestore(&chan->lock, flags);
>  }

This change is already submitted from Laurent-san:
http://thread.gmane.org/gmane.linux.ports.sh.devel/43446/focusC451

< snip >
> @@ -542,12 +546,13 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
>  static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
>  {
>  	struct rcar_dmac_desc *desc;
> +	unsigned long flags;
>  	int ret;
> 
>  	/* Recycle acked descriptors before attempting allocation. */
>  	rcar_dmac_desc_recycle_acked(chan);
> 
> -	spin_lock_irq(&chan->lock);
> +	spin_lock_irqsave(&chan->lock, flags);
> 
>  	do {
>  		if (list_empty(&chan->desc.free)) {

I guess this will conflict the following patch.
But, I'm not sure how to fix conflict with other patch:
http://thread.gmane.org/gmane.linux.ports.sh.devel/43446/focusC447

< snip >
> @@ -617,9 +623,10 @@ static struct rcar_dmac_xfer_chunk *
>  rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
>  {
>  	struct rcar_dmac_xfer_chunk *chunk;
> +	unsigned long flags;
>  	int ret;
> 
> -	spin_lock_irq(&chan->lock);
> +	spin_lock_irqsave(&chan->lock, flags);
> 
>  	do {
>  		if (list_empty(&chan->desc.chunks_free)) {

Same the above.

< snip >
> @@ -1349,8 +1357,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
>  {
>  	struct rcar_dmac_chan *chan = dev;
>  	struct rcar_dmac_desc *desc;
> +	unsigned long flags;
> 
> -	spin_lock_irq(&chan->lock);
> +	spin_lock_irqsave(&chan->lock, flags);

Since this function is not dmaengine API, I don't think we need this change.

Best regards,
Yoshihiro Shimoda

