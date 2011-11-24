From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Nov 2011 07:41:13 +0000
Subject: Re: [RFC][PATCH] sh: setup clock parent from current register value
Message-Id: <20111124074113.GC32112@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87ty5wyb51.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ty5wyb51.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 21, 2011 at 09:33:18PM -0800, Kuninori Morimoto wrote:
> Some clocks can select its parent clock by CPG register.
> But it might have been modified by boot-loader or something.
> This patch removed fixed initial parent clock,
> and setup it from their current register settings.
> It works on div6 reparent clocks for now.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Looks good to me, however..

> @@ -190,6 +222,9 @@ static int __init sh_clk_div6_register_ops(struct clk *clks, int nr,
>  		clkp->ops = ops;
>  		clkp->freq_table = freq_table + (k * freq_table_size);
>  		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
> +		ret = sh_clk_init_parent(clkp);
> +		if (ret < 0)
> +			break;
>  
>  		ret = clk_register(clkp);

We are however suffering from some pretty sad looking error path handling
here, but that's not your fault.

I'll apply it to the clkfwk topic branch and then we can start layering
proper error path fixes on top after that. At the moment, almost anything
that's dealing with batched registration fails to clean up after itself.
