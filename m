From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 29 Nov 2013 17:33:42 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: r8a7790: add sound clock support
Message-Id: <3611133.B3dmtpPo8L@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3fr52r4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3fr52r4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 28 November 2013 19:02:42 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Could you please split this in a patch that adds the MSTP clocks and a patch 
that adds the audio_clk inputs ? The reason for that is that I believe the 
first patch can be applied now, but the second will also need a CCF 
implementation.

> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c |   41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c
> b/arch/arm/mach-shmobile/clock-r8a7790.c index cf6dd7f..9dd5499b4 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -53,6 +53,7 @@
>  #define SMSTPCR7 0xe615014c
>  #define SMSTPCR8 0xe6150990
>  #define SMSTPCR9 0xe6150994
> +#define SMSTPCR10 0xe6150998
> 
>  #define SDCKCR		0xE6150074
>  #define SD2CKCR		0xE6150078
> @@ -81,6 +82,15 @@ static struct clk main_clk = {
>  	.ops	= &followparent_clk_ops,
>  };
> 
> +static struct clk audio_clk_a = {
> +};
> +
> +static struct clk audio_clk_b = {
> +};
> +
> +static struct clk audio_clk_c = {
> +};
> +
>  /*
>   * clock ratio of these clock will be updated
>   * on r8a7790_clock_init()
> @@ -114,6 +124,9 @@ SH_FIXED_RATIO_CLK_SET(ddr_clk,			pll3_clk,	1, 8);
>  SH_FIXED_RATIO_CLK_SET(mp_clk,			pll1_div2_clk,	1, 15);
> 
>  static struct clk *main_clks[] = {
> +	&audio_clk_a,
> +	&audio_clk_b,
> +	&audio_clk_c,
>  	&extal_clk,
>  	&extal_div2_clk,
>  	&main_clk,
> @@ -182,6 +195,8 @@ static struct clk div6_clks[DIV6_NR] = {
> 
>  /* MSTP */
>  enum {
> +	MSTP1015, MSTP1014, MSTP1013, MSTP1012, MSTP1011, MSTP1010,
> +	MSTP1009, MSTP1008, MSTP1007, MSTP1006, MSTP1005,
>  	MSTP931, MSTP930, MSTP929, MSTP928,
>  	MSTP917,
>  	MSTP813,
> @@ -196,6 +211,17 @@ enum {
>  };
> 
>  static struct clk mstp_clks[MSTP_NR] = {
> +	[MSTP1015] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 15, 0), /* SSI0 */
> +	[MSTP1014] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 14, 0), /* SSI1 */
> +	[MSTP1013] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 13, 0), /* SSI2 */
> +	[MSTP1012] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 12, 0), /* SSI3 */
> +	[MSTP1011] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 11, 0), /* SSI4 */
> +	[MSTP1010] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 10, 0), /* SSI5 */
> +	[MSTP1009] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  9, 0), /* SSI6 */
> +	[MSTP1008] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  8, 0), /* SSI7 */
> +	[MSTP1007] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  7, 0), /* SSI8 */
> +	[MSTP1006] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  6, 0), /* SSI9 */
> +	[MSTP1005] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  5, 0), /* SSI ALL */
>  	[MSTP931] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 31, 0), /* I2C0 */
>  	[MSTP930] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 30, 0), /* I2C1 */
>  	[MSTP929] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 29, 0), /* I2C2 */
> @@ -232,6 +258,10 @@ static struct clk mstp_clks[MSTP_NR] = {
>  static struct clk_lookup lookups[] = {
> 
>  	/* main clocks */
> +	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
> +	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
> +	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
> +	CLKDEV_CON_ID("audio_clk_internal",	&m2_clk),
>  	CLKDEV_CON_ID("extal",		&extal_clk),
>  	CLKDEV_CON_ID("extal_div2",	&extal_div2_clk),
>  	CLKDEV_CON_ID("main",		&main_clk),
> @@ -266,6 +296,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_CON_ID("ssprs",		&div6_clks[DIV6_SSPRS]),
> 
>  	/* MSTP */
> +	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP1005]),
>  	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
>  	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
>  	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
> @@ -310,6 +341,16 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7790", &mstp_clks[MSTP724]),
>  	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7790", &mstp_clks[MSTP723]),
>  	CLKDEV_ICK_ID("du.2", "rcar-du-r8a7790", &mstp_clks[MSTP722]),
> +	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP1015]),
> +	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP1014]),
> +	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP1013]),
> +	CLKDEV_ICK_ID("ssi.3", "rcar_sound", &mstp_clks[MSTP1012]),
> +	CLKDEV_ICK_ID("ssi.4", "rcar_sound", &mstp_clks[MSTP1011]),
> +	CLKDEV_ICK_ID("ssi.5", "rcar_sound", &mstp_clks[MSTP1010]),
> +	CLKDEV_ICK_ID("ssi.6", "rcar_sound", &mstp_clks[MSTP1009]),
> +	CLKDEV_ICK_ID("ssi.7", "rcar_sound", &mstp_clks[MSTP1008]),
> +	CLKDEV_ICK_ID("ssi.8", "rcar_sound", &mstp_clks[MSTP1007]),
> +	CLKDEV_ICK_ID("ssi.9", "rcar_sound", &mstp_clks[MSTP1006]),
> 
>  };
-- 
Regards,

Laurent Pinchart

