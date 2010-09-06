From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 06 Sep 2010 10:07:37 +0000
Subject: Re: [PATCH 4/4 v2] ARM: mach-shmobile: ap4evb: Add HDMI sound support
Message-Id: <Pine.LNX.4.64.1009061150220.20387@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
 <w3py6bn5o6m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3py6bn5o6m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, 31 Aug 2010, Kuninori Morimoto wrote:

> It support only 48kHz frame rate
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>   no change
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |   56 ++++++++++++++++++++++++++++++++-
>  1 files changed, 55 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 23d472f..1545277 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -515,6 +515,8 @@ static struct platform_device *qhd_devices[] __initdata = {
>  /* FSI */
>  #define IRQ_FSI		evt2irq(0x1840)
>  #define FSIACKCR	0xE6150018
> +#define FSIDIV		0xFE1F8000
> +#define FSIDIV_SIZE	32

32 bytes? There are only 2 registers 4 bytes each in FSIDIV?

>  static void fsiackcr_init(struct clk *clk)
>  {
>  	u32 status = __raw_readl(clk->enable_reg);
> @@ -535,12 +537,58 @@ static struct clk fsiackcr_clk = {
>  	.rate		= 0, /* unknown */
>  };
>  
> +static int fsi_set_rate(int is_porta, int rate)
> +{
> +	struct clk *clk;
> +	void __iomem *base;
> +	int ret = 0;

No need to initialise ret.

> +
> +	/* set_rate is not needed if port A */
> +	if (is_porta)
> +		return 0;
> +
> +	clk = clk_get(NULL, "fsib_clk");
> +	if (IS_ERR(clk))
> +		return -EINVAL;
> +
> +	base = ioremap_nocache(FSIDIV, FSIDIV_SIZE);
> +	if (!base) {
> +		ret = -ENXIO;
> +		goto fsi_set_rate_err;
> +	}
> +
> +	switch (rate) {
> +	case 48000:
> +		clk_set_rate(clk, clk_round_rate(clk, 85428000));
> +		__raw_writel(0x00070003, base + 0x8);

Hm, these two registers seem to be a perfect candidate for the clock API?

> +		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> +		break;
> +	default:
> +		pr_err("unsupported rate in FSI2 port B\n");
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	iounmap(base);
> +
> +fsi_set_rate_err:
> +	clk_put(clk);
> +
> +	return ret;
> +}
> +
>  static struct sh_fsi_platform_info fsi_info = {
>  	.porta_flags = SH_FSI_BRS_INV |
>  		       SH_FSI_OUT_SLAVE_MODE |
>  		       SH_FSI_IN_SLAVE_MODE |
>  		       SH_FSI_OFMT(PCM) |
>  		       SH_FSI_IFMT(PCM),
> +
> +	.portb_flags = SH_FSI_BRS_INV |
> +		       SH_FSI_BRM_INV |
> +		       SH_FSI_LRS_INV |
> +		       SH_FSI_OFMT(SPDIF),
> +	.set_rate = fsi_set_rate,
>  };
>  
>  static struct resource fsi_resources[] = {
> @@ -624,6 +672,7 @@ static struct platform_device lcdc1_device = {
>  static struct sh_mobile_hdmi_info hdmi_info = {
>  	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
>  	.lcd_dev = &lcdc1_device.dev,
> +	.flags = HDMI_SRC_SPDIF,
>  };
>  
>  static struct resource hdmi_resources[] = {
> @@ -825,6 +874,7 @@ static void __init ap4evb_map_io(void)
>  
>  #define GPIO_PORT9CR	0xE6051009
>  #define GPIO_PORT10CR	0xE605100A
> +#define USCCR1		0xE6058144
>  static void __init ap4evb_init(void)
>  {
>  	u32 srcr4;
> @@ -909,7 +959,7 @@ static void __init ap4evb_init(void)
>  	/* setup USB phy */
>  	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
>  
> -	/* enable FSI2 */
> +	/* enable FSI2 port A (ak4643) */
>  	gpio_request(GPIO_FN_FSIAIBT,	NULL);
>  	gpio_request(GPIO_FN_FSIAILR,	NULL);
>  	gpio_request(GPIO_FN_FSIAISLD,	NULL);
> @@ -922,6 +972,10 @@ static void __init ap4evb_init(void)
>  	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
>  	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
>  
> +	/* setup FSI2 port B (HDMI) */
> +	gpio_request(GPIO_FN_FSIBCK, NULL);
> +	__raw_writew(__raw_readw(USCCR1) & ~(1 << 6), USCCR1); /* use SPDIF */
> +
>  	/* set SPU2 clock to 119.6 MHz */
>  	clk = clk_get(NULL, "spu_clk");
>  	if (!IS_ERR(clk)) {
> -- 
> 1.7.0.4

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
