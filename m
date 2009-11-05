From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 05 Nov 2009 05:02:09 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: Enable SPU2 clock when boot
Message-Id: <20091105050208.GB26910@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uocnifuik.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uocnifuik.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 04, 2009 at 07:34:43PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 2274985..d5d36fe 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -535,6 +535,8 @@ extern char ecovec24_sdram_leave_end;
>  
>  static int __init arch_setup(void)
>  {
> +	struct clk *clk;
> +
>  	/* register board specific self-refresh code */
>  	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
>  					&ecovec24_sdram_enter_start,
> @@ -780,6 +782,11 @@ static int __init arch_setup(void)
>  	i2c_register_board_info(1, i2c1_devices,
>  				ARRAY_SIZE(i2c1_devices));
>  
> +	/* enable SPU2 */
> +	clk = clk_get(NULL, "spu_clk");
> +	clk_enable(clk); /* start SPU2 */
> +	clk_put(clk);
> +
>  	return platform_add_devices(ecovec_devices,
>  				    ARRAY_SIZE(ecovec_devices));
>  }

This is just doing an enable on init, so it's better to just flag this in
the CPU code. ie:

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index dfe9192..9db7438 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -152,7 +152,7 @@ struct clk div6_clks[] = {
 	SH_CLK_DIV6("fsia_clk", &div3_clk, FCLKACR, 0),
 	SH_CLK_DIV6("fsib_clk", &div3_clk, FCLKBCR, 0),
 	SH_CLK_DIV6("irda_clk", &div3_clk, IRDACLKCR, 0),
-	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, 0),
+	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
 #define R_CLK (&r_clk)

Although this is going to be a nuisance for power management.
