From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 10 Dec 2014 05:58:23 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <20141210055838.GF16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 10, 2014 at 04:34:21AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +static struct dma_async_tx_descriptor *
> +audmapp_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +			size_t buf_len, size_t period_len,
> +			enum dma_transfer_direction dir, unsigned long flags)
> +{
> +	struct audmapp_chan *achan = chan_to_achan(chan);
> +
> +	return &achan->async_tx;
> +}
I had commented last time as well. This doesnt look right. You are ignoring
all input parameters, so how does it work at all?

> +
> +static void audmapp_slave_config(struct audmapp_chan *achan,
> +				 struct dma_slave_config *cfg)
> +{
> +	achan->src = cfg->src_addr;
> +	achan->dst = cfg->dst_addr;
> +}
> +
> +static int audmapp_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +			   unsigned long arg)
> +{
> +	struct audmapp_chan *achan = chan_to_achan(chan);
> +
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		audmapp_halt(achan);
> +		break;
> +	case DMA_SLAVE_CONFIG:
> +		audmapp_slave_config(achan, (struct dma_slave_config *)arg);
> +		break;
This needs to be updated to new APIs i have merged at
topic/slave_caps_device_control_fix
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum dma_status audmapp_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	return dma_cookie_status(chan, cookie, txstate);
> +}
> +
> +static void audmapp_issue_pending(struct dma_chan *chan)
> +{
> +	struct audmapp_chan *achan = chan_to_achan(chan);
> +	struct audmapp_priv *priv = achan_to_priv(achan);
> +	struct device *dev = priv_to_dev(priv);
> +	u32 chcr = achan->chcr | PDMACHCR_DE;
> +
> +	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
> +		&achan->src, &achan->dst, chcr);
> +
> +	audmapp_write(achan, achan->src,	PDMASAR);
> +	audmapp_write(achan, achan->dst,	PDMADAR);
> +	audmapp_write(achan, chcr,		PDMACHCR);
no locking?

I don't see any interrupt code, does that get done by some other lib code?
something seems missing here

-- 
~Vinod

