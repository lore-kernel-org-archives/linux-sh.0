From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 25 Apr 2012 21:13:23 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7740: add FSI clock
Message-Id: <201204252313.23899.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, April 02, 2012, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied to the r8a7740 branch of the renesas.git tree.

Thanks,
Rafael


> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 3b35b9a..4a659f2e 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -257,7 +257,7 @@ enum {
>  	MSTP222,
>  	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
>  
> -	MSTP329, MSTP323,
> +	MSTP329, MSTP328, MSTP323,
>  
>  	MSTP_NR
>  };
> @@ -280,6 +280,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP200] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  0, 0), /* SCIFA4 */
>  
>  	[MSTP329] = SH_CLK_MSTP32(&r_clk,		SMSTPCR3, 29, 0), /* CMT10 */
> +	[MSTP328] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 28, 0), /* FSI */
>  	[MSTP323] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR3, 23, 0), /* IIC1 */
>  };
>  
> @@ -334,6 +335,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
>  
>  	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
> +	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
>  	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
>  };
>  
> 

