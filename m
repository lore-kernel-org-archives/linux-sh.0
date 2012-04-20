From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 20 Apr 2012 01:36:11 +0000
Subject: Re: [PATCH] spi: spi-rspi: add dmaengine supporting
Message-Id: <20120420013610.GE22189@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F8FE77D.7020000@renesas.com>
In-Reply-To: <4F8FE77D.7020000@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, SH-Linux <linux-sh@vger.kernel.org>

On Thu, Apr 19, 2012 at 07:22:53PM +0900, Shimoda, Yoshihiro wrote:
> +static struct dma_async_tx_descriptor *rspi_dma_prep_sg(struct scatterlist *sg,
> +				void *buf, unsigned len, struct dma_chan *chan,
> +				enum dma_transfer_direction dir)
> +{
> +	sg_init_table(sg, 1);
> +	sg_set_buf(sg, buf, len);
> +	sg_dma_len(sg) = len,
> +	dma_map_sg(chan->device->dev, sg, 1, dir);
> +	return dmaengine_prep_slave_sg(chan, sg, 1, dir,
> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +}
> +
..

> +	desc = rspi_dma_prep_sg(&sg, buf, len, rspi->chan_tx, DMA_TO_DEVICE);
> +	if (!desc) {
> +		ret = -EIO;
> +		goto error;
> +	}
> +
..
> +error:
> +	if (rspi->dma_width_16bit)
> +		kfree(buf);
> +
> +	return ret;
> +}
> +
The sg list handling is unbalanced. Specifically you always map the
scatterlist with dma_map_sg() but you have no corresponding
dma_unmap_sg() anywhere, either in the error path or your regular exit
path.
