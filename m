From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 16 Sep 2011 10:29:40 +0000
Subject: Re: [PATCH 07/10] sh: clkfwk: add clk_rate_multi_range_round()
Message-Id: <20110916102940.GA15428@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87hb4mqack.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hb4mqack.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 09, 2011 at 03:27:43AM -0700, Kuninori Morimoto wrote:
> Some Clock Pulse Generator has PLL multiplication.
> clk_rate_multi_range_round() will be good helper for it.
> 
clk_rate_mult_range_round() would be more logically consistent.

> +long clk_rate_multi_range_round(struct clk *clk, unsigned int div_min,
> +				unsigned int div_max, unsigned long rate)
> +{
> +	struct clk_rate_round_data div_range_round = {
> +		.min	= div_min,
> +		.max	= div_max,
> +		.func	= clk_rate_multi_range_iter,
> +		.arg	= clk_get_parent(clk),
> +		.rate	= rate,
> +	};
> +
> +	return clk_rate_round_helper(&div_range_round);
> +}
> +
Clearly you want mult_range and not div_range here. Likewise div_min/max
should be mult_min/max or so, as you're clearly not doing division on
anything here.

Beyond that, I have no particular objections to the API addition.
