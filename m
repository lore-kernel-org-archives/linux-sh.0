From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 17 Jul 2014 03:02:48 +0000
Subject: Re: [PATCH 4/7] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <871ttkg040.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent again

I found bug/trouble

> +/* -----------------------------------------------------------------------------
> + * OF xlate and channel filter
> + */
> +
> +static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
> +{
> +	struct rcar_dmac *dmac = to_rcar_dmac(chan->device);
> +	unsigned int id = (unsigned int)arg;
> +
> +	return !test_and_set_bit(id, dmac->modules);
> +}

I got 2 troubles on this filter.

You know sound driver needs both "Audio DMAC" and "Audio DMAC peri peri"
now, DMAC drivers are
 - Audio DMAC           : rcar-dma
 - Audio DMAC peri peri : rcar-audma (= shdma-base)

If I enabled both DMAC, this filter will be called
with Audio DMAC peri peri side (= shdma-base) chan.
This filter needs to check "chan" itself.
(I used "chan->private" for checking as local hack.)
This is 1st trouble.

2nd trouble is chan/filter again :P
Now, your [6/7] patch adds 2 SYS-DMAC on DTSI file.
And, I need to add Audio DMAC / Audio DMAC peri peri entry
So, total entrys are...

	dmac0: dma-controller@e6700000 {
	..
	};
	dmac1: dma-controller@e6720000 {
	...
	};
	audma0: dma-contorller@ec700000 {
	...
	};
	audma1: dma-controller@ec720000 {
	...
	};
	audmapp: audio-dma-pp@0xec740000 {
	...
	};

But, this filter doesn't check DMAC itself.
So, my driver requests "audma0's 0x01 ID", but,
this filter accepts as "dmac0's 0x01 ID".


> +/* -----------------------------------------------------------------------------
> + * Probe and remove
> + */
> +
> +static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> +				struct rcar_dmac_chan *rchan,
> +				unsigned int index)
> +{
> +	struct platform_device *pdev = to_platform_device(dmac->dev);
> +	struct dma_chan *chan = &rchan->chan;
> +	char irqname[16];
> +	int irq;
> +	int ret;
> +
> +	rchan->index = index;
> +	rchan->iomem = dmac->iomem + RCAR_DMAC_CHAN_OFFSET(index);
> +	rchan->mid_rid = -EINVAL;
> +
> +	spin_lock_init(&rchan->lock);
> +	mutex_init(&rchan->power_lock);
> +
> +	/* Request the channel interrupt. */
> +	sprintf(irqname, "ch%u", index);
> +	irq = platform_get_irq_byname(pdev, irqname);
> +	if (irq < 0) {
> +		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
> +		return -ENODEV;
> +	}
> +
> +	sprintf(irqname, "DMAC channel %u", index);
> +	ret = devm_request_threaded_irq(dmac->dev, irq, rcar_dmac_isr_channel,
> +					rcar_dmac_isr_channel_thread, 0,
> +					irqname, rchan);
> +	if (ret) {
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> +		return ret;
> +	}

Here, you used "irqname" which exists on stack memory for devm_request_threaded_irq().
It breaks /proc/interrupt interrupt names.

Best regards
---
Kuninori Morimoto
