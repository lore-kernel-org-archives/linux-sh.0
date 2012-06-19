From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 19 Jun 2012 04:51:48 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: sh73a0: add USB clock support
Message-Id: <4FE00564.9080101@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87bokgt4ye.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bokgt4ye.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(2012/06/19 11:23), Kuninori Morimoto wrote:
> It is required from renesas_usbhs driver.
> This patch is based on v2.0 manual.
>
> Signed-off-by: Kuninori Morimoto<kuninori.morimoto.gx@renesas.com>
Tested-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

> ---
>   arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
> index 76bdcca..37ba014 100644
> --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> @@ -477,7 +477,7 @@ enum { MSTP001,
>   	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
>   	MSTP219, MSTP218, MSTP217,
>   	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
> -	MSTP331, MSTP329, MSTP328, MSTP325, MSTP323,
> +	MSTP331, MSTP329, MSTP328, MSTP325, MSTP323, MSTP322,
>   	MSTP314, MSTP313, MSTP312, MSTP311,
>   	MSTP303, MSTP302, MSTP301, MSTP300,
>   	MSTP411, MSTP410, MSTP403,
> @@ -511,6 +511,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>   	[MSTP328] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 28, 0), /*FSI*/
>   	[MSTP325] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 25, 0), /* IrDA */
>   	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
> +	[MSTP322] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 22, 0), /* USB */
>   	[MSTP314] = MSTP(&div6_clks[DIV6_SDHI0], SMSTPCR3, 14, 0), /* SDHI0 */
>   	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, 0), /* SDHI1 */
>   	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
> @@ -568,6 +569,7 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("sh_fsi2",&mstp_clks[MSTP328]), /* FSI */
>   	CLKDEV_DEV_ID("sh_irda.0",&mstp_clks[MSTP325]), /* IrDA */
>   	CLKDEV_DEV_ID("i2c-sh_mobile.1",&mstp_clks[MSTP323]), /* I2C1 */
> +	CLKDEV_DEV_ID("renesas_usbhs",&mstp_clks[MSTP322]), /* USB */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.0",&mstp_clks[MSTP314]), /* SDHI0 */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.1",&mstp_clks[MSTP313]), /* SDHI1 */
>   	CLKDEV_DEV_ID("sh_mmcif.0",&mstp_clks[MSTP312]), /* MMCIF0 */

