From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 15 Sep 2011 05:57:15 +0000
Subject: Re: [PATCH 09/10] fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
Message-Id: <20110915055714.GA28503@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehzqqabh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehzqqabh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 09, 2011 at 03:28:22AM -0700, Kuninori Morimoto wrote:
> +static int sh_mipi_set_dot_clock(struct platform_device *pdev,
> +				 void __iomem *base,
> +				 int enable)
> +{
> +	struct clk *pck;
> +	int ret = -EIO;
> +
> +	pck = clk_get(&pdev->dev, "dsip_clk");
> +	if (IS_ERR(pck))
> +		goto sh_mipi_set_dot_clock_pck_err;
> +
> +	if (enable) {
> +		clk_set_rate(pck, clk_round_rate(pck,  24000000));
> +		__raw_writel(0x2a809010, DSI0PHYCR);
> +		clk_enable(pck);
> +	} else {
> +		clk_disable(pck);
> +	}
> +
> +	ret = 0;
> +
> +	clk_put(pck);
> +
> +sh_mipi_set_dot_clock_pck_err:
> +	return ret;
> +}
> +
I'm not sure why you're using this convention of clobbering the return
value. There are a number of reasons why clk_get() could fail, and you're
simply discarding that information outright and unconditionally kicking
up -EIO. You should simply do this as:

	if (IS_ERR(...)) {
		ret = PTR_ERR(...);
		...
	}

in order to propagate the error value all the way down the chain. This
seems to apply to some of the other patches in this series, too.
