From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 12 Jun 2013 07:55:55 +0000
Subject: Re: [PATCH 4/9] ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI
Message-Id: <Pine.LNX.4.64.1306120955020.23454@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

Same as the other one: there haven't been any unclarified replies to this 
patch, your patchwork status says "changes requested." Does anything 
really has to be changed here or can we apply this patch, please?

Thanks
Guennadi

On Fri, 17 May 2013, Guennadi Liakhovetski wrote:

> Add MSTP clock definitions and fix aliases for the two MMCIF and four SDHI
> interfaces on r8a7790 (H2).
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c |   26 +++++++++++++++++++-------
>  1 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index b393592..53a13b4 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -181,7 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
>  /* MSTP */
>  enum {
>  	MSTP721, MSTP720,
> -	MSTP304,
> +	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
>  	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
>  	MSTP_NR
>  };
> @@ -189,6 +189,12 @@ enum {
>  static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
>  	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
> +	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
> +	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
> +	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_SD1], SMSTPCR3, 13, 0), /* SDHI1 */
> +	[MSTP312] = SH_CLK_MSTP32(&div6_clks[DIV6_SD2], SMSTPCR3, 12, 0), /* SDHI2 */
> +	[MSTP311] = SH_CLK_MSTP32(&div6_clks[DIV6_SD3], SMSTPCR3, 11, 0), /* SDHI3 */
> +	[MSTP305] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC1], SMSTPCR3, 5, 0), /* MMC1 */
>  	[MSTP304] = SH_CLK_MSTP32(&cp_clk, SMSTPCR3, 4, 0), /* TPU0 */
>  	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
>  	[MSTP207] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
> @@ -229,14 +235,8 @@ static struct clk_lookup lookups[] = {
>  
>  	/* DIV4 */
>  	CLKDEV_CON_ID("sdh",		&div4_clks[DIV4_SDH]),
> -	CLKDEV_CON_ID("sd0",		&div4_clks[DIV4_SD0]),
> -	CLKDEV_CON_ID("sd1",		&div4_clks[DIV4_SD1]),
>  
>  	/* DIV6 */
> -	CLKDEV_CON_ID("sd2",		&div6_clks[DIV6_SD2]),
> -	CLKDEV_CON_ID("sd3",		&div6_clks[DIV6_SD3]),
> -	CLKDEV_CON_ID("mmc0",		&div6_clks[DIV6_MMC0]),
> -	CLKDEV_CON_ID("mmc1",		&div6_clks[DIV6_MMC1]),
>  	CLKDEV_CON_ID("ssp",		&div6_clks[DIV6_SSP]),
>  	CLKDEV_CON_ID("ssprs",		&div6_clks[DIV6_SSPRS]),
>  
> @@ -249,6 +249,18 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
>  	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
>  	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
> +	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
> +	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
> +	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
> +	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
> +	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]),
> +	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
> +	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP312]),
> +	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
> +	CLKDEV_DEV_ID("ee160000.sdhi", &mstp_clks[MSTP311]),
> +	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
> +	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
> +	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>  };
>  
>  #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
> -- 
> 1.7.2.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
