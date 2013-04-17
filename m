From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Apr 2013 00:36:20 +0000
Subject: Re: [PATCH v2 2/2] ARM: sh-mobile: r8a7790: Make private clock arrays static
Message-Id: <20130417003620.GA16092@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366125380-14528-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366125380-14528-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 16, 2013 at 05:16:20PM +0200, Laurent Pinchart wrote:
> Both clock-r8a7740.c and clock-r8a7790.c define a div4_clks array as
> non-static. Compiling support for both SoCs thus result in a symbol
> redefinition. Fix it by defining the arrays as static.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, queued-up for v3.11 in the soc-r8a7790 branch.

> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index a481003..bedd20c 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -154,7 +154,7 @@ enum {
>  	DIV4_SDH, DIV4_SD0, DIV4_SD1, DIV4_NR
>  };
>  
> -struct clk div4_clks[DIV4_NR] = {
> +static struct clk div4_clks[DIV4_NR] = {
>  	[DIV4_SDH] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 8, 0x0dff, CLK_ENABLE_ON_INIT),
>  	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1de0, CLK_ENABLE_ON_INIT),
>  	[DIV4_SD1] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 0, 0x1de0, CLK_ENABLE_ON_INIT),
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
