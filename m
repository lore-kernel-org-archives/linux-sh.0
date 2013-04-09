From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Apr 2013 10:16:45 +0000
Subject: Re: [PATCH v4] dma: sudmac: add support for SUDMAC
Message-Id: <20130409101645.GD29186@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5163E470.7010107@renesas.com>
In-Reply-To: <5163E470.7010107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 06:50:40PM +0900, Shimoda, Yoshihiro wrote:
> Some Renesas USB modules have SUDMAC. This patch supports it using
> the shdma-base driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

...

> +#define SUDMAC_MAX_CHANNELS 2
> +
...

> +struct sudmac_device {
> +	struct shdma_dev shdma_dev;
> +	struct sudmac_chan *chan[SUDMAC_MAX_CHANNELS];
> +	struct sudmac_pdata *pdata;
> +	void __iomem *chan_reg;
> +};
> +
...

> +struct sudmac_pdata {
> +	const struct sudmac_slave_config *slave;
> +	int slave_num;
> +	const struct sudmac_channel *channel;
> +	int channel_num;
> +};
> +
I'm a bit perplexed as to why you have a hardcoded max channel count when
it can all be derived from the platform data in the first place?
