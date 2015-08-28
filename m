From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 28 Aug 2015 19:37:47 +0000
Subject: Re: [PATCH v3 02/04] clk: shmobile: Make MSTP clock-output-names optional
Message-Id: <1776985.pyjG3Le2BL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150828091550.21731.85227.sendpatchset@little-apple> <20150828091613.21731.8527.sendpatchset@little-apple>
In-Reply-To: <20150828091613.21731.8527.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk@vger.kernel.org, kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org

Hi Magnus,

Thank you for the patch.

On Friday 28 August 2015 18:16:13 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> This patch updates the MSTP driver to make the "clock-output-names"
> DT property optional instead of mandatory. In case the DT property
> is omitted then the function clk_register_clkdev() is skipped.
> 
> The default for new SoCs is to not use "clock-output-names".
> 
> This version of the patch is kind of early, so please handle with care.
> So far the patch has only been tested with a single MSTP clock. =)
> 
> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/clk/shmobile/clk-mstp.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> --- 0001/drivers/clk/shmobile/clk-mstp.c
> +++ work/drivers/clk/shmobile/clk-mstp.c	2015-08-28 15:03:28.002366518 
+0900
> @@ -198,15 +198,12 @@ static void __init cpg_mstp_clocks_init(
> 
>  	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
>  		const char *parent_name;
> -		const char *name;
> +		const char *name = NULL;
>  		u32 clkidx;
>  		int ret;
> 
> -		/* Skip clocks with no name. */
>  		ret = of_property_read_string_index(np, "clock-output-names",
>  						    i, &name);

I think we can remove this completely.

> -		if (ret < 0 || strlen(name) = 0)
> -			continue;
> 
>  		parent_name = of_clk_get_parent_name(np, i);
>  		ret = of_property_read_u32_index(np, idxname, i, &clkidx);
> @@ -214,12 +211,13 @@ static void __init cpg_mstp_clocks_init(
>  			break;
> 
>  		if (clkidx >= MSTP_MAX_CLOCKS) {
> -			pr_err("%s: invalid clock %s %s index %u)\n",
> -			       __func__, np->name, name, clkidx);
> +			pr_err("%s: invalid clock %s index %u)\n",
> +			       __func__, np->name, clkidx);
>  			continue;
>  		}
> 
> -		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
> +		clks[clkidx] = cpg_mstp_clock_register(name ? name : np->name,

This would result in several clocks being registered with the same name. I 
would instead construct the name with sprintf(name, "%s.%u", np->name, 
clkidx).

> +						       parent_name,
>  						       clkidx, group);
>  		if (!IS_ERR(clks[clkidx])) {
>  			group->data.clk_num = max(group->data.clk_num,
> @@ -232,7 +230,8 @@ static void __init cpg_mstp_clocks_init(
>  			 * FIXME: Remove this when all devices that require a
>  			 * clock will be instantiated from DT.
>  			 */
> -			clk_register_clkdev(clks[clkidx], name, NULL);
> +			if (name) /* only if clock-output-names is provided */
> +				clk_register_clkdev(clks[clkidx], name, NULL);

Better than that, as all our devices are now instantiated from DT, we can 
remove the clk_register_clkdev() call completely as well as the FIXME comment.

>  		} else {
>  			pr_err("%s: failed to register %s %s clock (%ld)\n",
>  			       __func__, np->name, name, PTR_ERR(clks[clkidx]));

name can be NULL here, I'd use "%s.%u", np->name, clkidx.

-- 
Regards,

Laurent Pinchart

