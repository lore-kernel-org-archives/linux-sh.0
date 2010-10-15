From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Oct 2010 06:16:31 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <20101015061630.GA7489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 15, 2010 at 02:15:14PM +0900, Kuninori Morimoto wrote:
> +static long fsidiv_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	/*
> +	 * FSIDIV doesn't have freq_table.
> +	 * it mean fsidiv can not use clk_rate_table_round.
> +	 * self calculate here
> +	 */

Is there some particular reason why you can't just construct a rate table
for FSIDIV instead? sh_clk_div6_register_ops() in drivers/sh/clk-cpg.c is
an example of how to set it up. It's provided generically in the struct
clk largely for these sorts of cases.
