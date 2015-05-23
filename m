From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 19:23:40 +0000
Subject: Re: [PATCH/RFC 8/8] serial: sh-sci: Add DT support to DMA setup
Message-Id: <9488404.tq2DYoA6by@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432145174-11534-9-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432145174-11534-9-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 20 May 2015 20:06:14 Geert Uytterhoeven wrote:
> Add support for obtaining DMA channel information from the device tree.
> 
> This requires switching from the legacy sh_dmae_slave structures with
> hardcoded channel numbers and the corresponding filter function to:
>   1. dma_request_slave_channel_compat(),
>        - On legacy platforms, dma_request_slave_channel_compat() uses
> 	 the passed DMA channel numbers that originate from platform
> 	 device data,
>        - On DT-based platforms, dma_request_slave_channel_compat() will
> 	 retrieve the information from DT.
>   2. and the generic dmaengine_slave_config() configuration method,
>      which requires filling in DMA register ports and slave bus widths.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This looks good to me,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Note: There's still one shdmac'ism (shdma_desc.partial) left, which is
>       used to retrieve the number of transfered bytes of an incomplete
>       DMA request.
>       While rcar-dmac supports dma_tx_state.residue, I believe this is
>       not supported by shdmac on legacy ARM and SH platforms?

More than that, residue reporting is only supported by the DMA engine API for 
the current DMA transfer. There's no way to stop a DMA transfer and find out 
how many bytes are left in a race-free way. I think we should add support for 
that use case to the DMA engine API.

> ---
>  drivers/tty/serial/sh-sci.c | 78 +++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 42634d99d047681f..20eaa120815f7fbe 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -113,8 +113,6 @@ struct sci_port {
>  	unsigned int			sg_len_tx;
>  	struct scatterlist		sg_rx[2];
>  	size_t				buf_len_rx;
> -	struct sh_dmae_slave		param_tx;
> -	struct sh_dmae_slave		param_rx;
>  	struct work_struct		work_tx;
>  	struct work_struct		work_rx;
>  	struct timer_list		rx_timer;
> @@ -1664,17 +1662,6 @@ static void sci_break_ctl(struct uart_port *port, int
> break_state) }
> 
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
> -static bool filter(struct dma_chan *chan, void *slave)
> -{
> -	struct sh_dmae_slave *param = slave;
> -
> -	dev_dbg(chan->device->dev, "%s: slave ID %d\n",
> -		__func__, param->shdma_slave.slave_id);
> -
> -	chan->private = &param->shdma_slave;
> -	return true;
> -}
> -
>  static void rx_timer_fn(unsigned long arg)
>  {
>  	struct sci_port *s = (struct sci_port *)arg;
> @@ -1690,29 +1677,63 @@ static void rx_timer_fn(unsigned long arg)
>  	schedule_work(&s->work_rx);
>  }
> 
> +static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
> +					     enum dma_transfer_direction dir,
> +					     unsigned int id)
> +{
> +	dma_cap_mask_t mask;
> +	struct dma_chan *chan;
> +	struct dma_slave_config cfg;
> +	int ret;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +					(void *)(unsigned long)id, port->dev,
> +					dir = DMA_MEM_TO_DEV ? "tx" : "rx");
> +	if (!chan) {
> +		dev_warn(port->dev,
> +			 "dma_request_slave_channel_compat failed\n");
> +		return NULL;
> +	}
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +	cfg.direction = dir;
> +	if (dir = DMA_MEM_TO_DEV) {
> +		cfg.dst_addr = port->mapbase +
> +			(sci_getreg(port, SCxTDR)->offset << port->regshift);
> +		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	} else {
> +		cfg.src_addr = port->mapbase +
> +			(sci_getreg(port, SCxRDR)->offset << port->regshift);
> +		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	}
> +
> +	ret = dmaengine_slave_config(chan, &cfg);
> +	if (ret) {
> +		dev_warn(port->dev, "dmaengine_slave_config failed %d\n", ret);
> +		dma_release_channel(chan);
> +		return NULL;
> +	}
> +
> +	return chan;
> +}
> +
>  static void sci_request_dma(struct uart_port *port)
>  {
>  	struct sci_port *s = to_sci_port(port);
> -	struct sh_dmae_slave *param;
>  	struct dma_chan *chan;
> -	dma_cap_mask_t mask;
>  	int nent;
> 
>  	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
> 
> -	if (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0)
> +	if (!port->dev->of_node &&
> +	    (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0))
>  		return;
> 
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	param = &s->param_tx;
> -
> -	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
> -	param->shdma_slave.slave_id = s->cfg->dma_slave_tx;
> -
>  	s->cookie_tx = -EINVAL;
> -	chan = dma_request_channel(mask, filter, param);
> +	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV, s->cfg->dma_slave_tx);
>  	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
>  	if (chan) {
>  		s->chan_tx = chan;
> @@ -1736,12 +1757,7 @@ static void sci_request_dma(struct uart_port *port)
>  		INIT_WORK(&s->work_tx, work_fn_tx);
>  	}
> 
> -	param = &s->param_rx;
> -
> -	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
> -	param->shdma_slave.slave_id = s->cfg->dma_slave_rx;
> -
> -	chan = dma_request_channel(mask, filter, param);
> +	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM, s->cfg->dma_slave_rx);
>  	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
>  	if (chan) {
>  		dma_addr_t dma[2];

-- 
Regards,

Laurent Pinchart

