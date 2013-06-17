From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2013 15:48:11 +0000
Subject: Re: [PATCH v2 3/3] DMA: shdma: add DT support
Message-Id: <201306171748.11836.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de> <1370533645-23690-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533645-23690-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Simon Horman <horms@verge.net.au>

On Thursday 06 June 2013, Guennadi Liakhovetski wrote:
> +Required properties:
> +- dmas:		a list of <[DMA controller phandle] [MID/RID value]> pairs
> +- dma-names:	a list of DMA channel names, one per "dmas" entry

Looks ok to me, although it might be helpful to clarify what MID/RID means,
by expanding the acronym and describing whether one needs to pass both
or just one of them. If both, what is the bit pattern?

>   * services would have to provide their own filters, which first would check
>   * the device driver, similar to how other DMAC drivers, e.g., sa11x0-dma.c, do
>   * this, and only then, in case of a match, call this common filter.
> + * NOTE 2: This filter function is also used in the DT case by shdma_xlate().
> + * In that case the MID-RID value is used for slave channel filtering and is
> + * passed to this function in the "arg" parameter.
>   */
>  bool shdma_chan_filter(struct dma_chan *chan, void *arg)
>  {
>  	struct shdma_chan *schan = to_shdma_chan(chan);
>  	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
>  	const struct shdma_ops *ops = sdev->ops;
> -	int slave_id = (int)arg;
> +	int match = (int)arg;
>  	int ret;
>  
> -	if (slave_id < 0)
> +	if (match < 0)
>  		/* No slave requested - arbitrary channel */
>  		return true;
>  
> -	if (slave_id >= slave_num)
> +	if (!schan->dev->of_node && match >= slave_num)
>  		return false;
>  
> -	ret = ops->set_slave(schan, slave_id, true);
> +	ret = ops->set_slave(schan, match, true);
>  	if (ret < 0)
>  		return false;

This is complicated by the fact that you are using the same function for
two entirely different purposes. It would be easier to have a separate
filter for the DT case, rather than reusing the one that uses the slave_id
as an argument.

> @@ -867,6 +883,29 @@ void shdma_chan_remove(struct shdma_chan *schan)
>  }
>  EXPORT_SYMBOL(shdma_chan_remove);
>  
> +struct dma_chan *shdma_xlate(struct of_phandle_args *dma_spec,
> +				 struct of_dma *ofdma)
> +{
> +	struct shdma_dev *sdev = ofdma->of_dma_data;
> +	u32 id = dma_spec->args[0];
> +	dma_cap_mask_t mask;
> +	struct dma_chan *chan;
> +
> +	if (dma_spec->args_count != 1 || !sdev)
> +		return NULL;
> +
> +	dma_cap_zero(mask);
> +	/* Only slave DMA channels can be allocated via DT */
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	chan = dma_request_channel(mask, shdma_chan_filter, (void *)id);
> +	if (chan)
> +		to_shdma_chan(chan)->hw_req = id;
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL(shdma_xlate);

I would suggest keeping this to the drivers/dma/sh/shdma.c file
and not exporting it. The sudma would use a different binding anyway.

> +/*
> + * Find a slave channel configuration from the contoller list by either a slave
> + * ID in the non-DT case, or by a MID/RID value in the DT case
> + */
>  static const struct sh_dmae_slave_config *dmae_find_slave(
> -	struct sh_dmae_chan *sh_chan, int slave_id)
> +	struct sh_dmae_chan *sh_chan, int match)
>  {
>  	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
>  	struct sh_dmae_pdata *pdata = shdev->pdata;
>  	const struct sh_dmae_slave_config *cfg;
>  	int i;
>  
> -	if (slave_id >= SH_DMA_SLAVE_NUMBER)
> -		return NULL;
> +	if (!sh_chan->shdma_chan.dev->of_node) {
> +		if (match >= SH_DMA_SLAVE_NUMBER)
> +			return NULL;
>  
> -	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
> -		if (cfg->slave_id = slave_id)
> -			return cfg;
> +		for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
> +			if (cfg->slave_id = match)
> +				return cfg;
> +	} else {
> +		for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
> +			if (cfg->mid_rid = match) {
> +				sh_chan->shdma_chan.slave_id = cfg->slave_id;
> +				return cfg;
> +			}
> +	}

The pdata and slave_id should really not be needed here for the lookup in the DT
case. Is this just temporary until all slave drivers use dmaenging_slave_config
to pass the address? That should be clarified in a comment.

	Arnd
