From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 Jun 2011 08:52:44 +0000
Subject: Re: [PATCH] drivers: sh: resume enabled clocks fix
Message-Id: <20110613085237.GJ2536@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110613044215.13907.39264.sendpatchset@t400s>
In-Reply-To: <20110613044215.13907.39264.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 13, 2011 at 01:42:15PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Extend the SH / SH-Mobile ARM clock framework to only
> resume clocks that has been enabled.
> 
> Without this fix divide-by-zero is triggering on sh7372
> FSIDIV during system wide resume of Suspend-to-RAM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  This is a rewrite of the patch recently posted as:
>  "[PATCH] ARM: mach-shmobile: sh7372 divide-by-zero FSIDIV fix"
> 
>  drivers/sh/clk/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I much prefer this to the approach that was in
"[PATCH] ARM: mach-shmobile: sh7372 divide-by-zero FSIDIV fix".

Reviewed-by: Simon Horman <horms@verge.net.au>

> 
> --- 0001/drivers/sh/clk/core.c
> +++ work/drivers/sh/clk/core.c	2011-06-13 13:32:10.000000000 +0900
> @@ -635,7 +635,7 @@ static void clks_core_resume(void)
>  	struct clk *clkp;
>  
>  	list_for_each_entry(clkp, &clock_list, node) {
> -		if (likely(clkp->ops)) {
> +		if (likely(clkp->usecount && clkp->ops)) {
>  			unsigned long rate = clkp->rate;
>  
>  			if (likely(clkp->ops->set_parent))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
