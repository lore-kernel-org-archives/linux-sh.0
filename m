From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Dec 2011 05:25:35 +0000
Subject: Re: [PATCH 3/4] sh: clock-sh7724: all div6_clks use SH_CLK_DIV6_EXT()
Message-Id: <20111206052535.GE30055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8739cz8rfx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8739cz8rfx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 04, 2011 at 10:26:30PM -0800, Kuninori Morimoto wrote:
> -static struct clk div6_clks[DIV6_NR] = {
> -	[DIV6_V] = SH_CLK_DIV6(&div3_clk, VCLKCR, 0),
> -	[DIV6_I] = SH_CLK_DIV6(&div3_clk, IRDACLKCR, 0),
> -	[DIV6_S] = SH_CLK_DIV6(&div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
> +/* Indices are important - they are the actual src selecting values */
> +static struct clk *common_parent[] = {
> +	[0] = &div3_clk,
> +	[1] = NULL,
>  };
>  
> -enum { DIV6_FA, DIV6_FB, DIV6_REPARENT_NR };
> +static struct clk *vclkcr_parent[] = {
> +	[0] = &div3_clk,
> +	[1] = NULL,
> +	[2] = &sh7724_dv_clki,
> +	[3] = NULL,
> +	[4] = &extal_clk,
> +	[5] = NULL,
> +	[6] = NULL,
> +	[7] = NULL,
> +};
>  
You don't really need any of these NULL initializers, they can all be
dropped.
