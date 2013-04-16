From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Apr 2013 13:24:24 +0000
Subject: Re: [PATCH] ARM: sh-mobile: Fix symbol redefinition with r8a7740 and r8a7790 clocks
Message-Id: <20130416132421.GA30365@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366107012-24642-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366107012-24642-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 16, 2013 at 12:10:12PM +0200, Laurent Pinchart wrote:
> Both clock-r8a7740.c and clock-r8a7790.c define a div4_clks array as
> non-static. Compiling support for both SoCs thus result in a symbol
> redefinition. Fix it by defining the arrays as static.
> 
> To avoid further similar issues, also define the main_clks as static in
> clock-r8a7740.c.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Laurent,

please split this into two patches, one for each SoC.

> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c | 4 ++--
>  arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 8fc396a..a2a612f 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -266,7 +266,7 @@ static struct clk fsiack_clk = {
>  static struct clk fsibck_clk = {
>  };
>  
> -struct clk *main_clks[] = {
> +static struct clk *main_clks[] = {
>  	&extalr_clk,
>  	&extal1_clk,
>  	&extal2_clk,
> @@ -317,7 +317,7 @@ enum {
>  	DIV4_NR
>  };
>  
> -struct clk div4_clks[DIV4_NR] = {
> +static struct clk div4_clks[DIV4_NR] = {
>  	[DIV4_I]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
>  	[DIV4_ZG]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
>  	[DIV4_B]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT),
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
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
