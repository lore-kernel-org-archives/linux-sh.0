From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Nov 2011 03:30:49 +0000
Subject: Re: Question about clk->usecount
Message-Id: <20111104033048.GB29825@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 28, 2011 at 03:53:19AM -0700, Kuninori Morimoto wrote:
> @@ -152,7 +159,12 @@ int __init sh_hwblk_clk_register(struct clk *clks, int nr)
>  			continue;
>  
>  		clkp->ops = &sh_hwblk_clk_ops;
> -		ret |= clk_register(clkp);
> +		ret = clk_register(clkp);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (hwblk_info)
> +			hwblk_info->hwblks[k].clk = clkp;
>  	}
>  
>  	return ret;

The error path handling here is a bit of an unusual case. clk_register()
failing on one clock is not necessarily an indicator that other clocks
can't be succesfully registered, so we're better off simply checking if
clk_register() succeeds and then stashing the clock pointer, rather than
bailing on the loop entirely.

The general idea seems to be heading in the right direction though.
