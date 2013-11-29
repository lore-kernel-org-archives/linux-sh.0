From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 29 Nov 2013 17:32:06 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7790: add I2C support
Message-Id: <4764433.UJ4QzBhLLp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 28 November 2013 19:02:12 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c |    4 ++++
>  arch/arm/mach-shmobile/setup-r8a7790.c |   25 +++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c
> b/arch/arm/mach-shmobile/clock-r8a7790.c index 7960dc0..cf6dd7f 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -277,9 +277,13 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
>  	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
>  	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
> +	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
>  	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
> +	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
>  	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
> +	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
>  	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
> +	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
>  	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
>  	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
>  	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c
> b/arch/arm/mach-shmobile/setup-r8a7790.c index 3543c3b..8474818 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -67,6 +67,27 @@ R8A7790_GPIO(5);
>  		&r8a7790_gpio##idx##_platform_data,			\
>  		sizeof(r8a7790_gpio##idx##_platform_data))
> 
> +static struct resource i2c_resources[] __initdata = {
> +	/* I2C0 */
> +	DEFINE_RES_MEM(0xE6508000, 0x40),
> +	DEFINE_RES_IRQ(gic_spi(287)),
> +	/* I2C1 */
> +	DEFINE_RES_MEM(0xE6518000, 0x40),
> +	DEFINE_RES_IRQ(gic_spi(288)),
> +	/* I2C2 */
> +	DEFINE_RES_MEM(0xE6530000, 0x40),
> +	DEFINE_RES_IRQ(gic_spi(286)),
> +	/* I2C3 */
> +	DEFINE_RES_MEM(0xE6540000, 0x40),
> +	DEFINE_RES_IRQ(gic_spi(290)),
> +
> +};
> +
> +#define r8a7790_register_i2c(idx)		\
> +	platform_device_register_simple(	\
> +		"i2c-rcar", idx,		\
> +		i2c_resources + (2 * idx), 2);	\
> +
>  void __init r8a7790_pinmux_init(void)
>  {
>  	r8a7790_register_pfc();
> @@ -76,6 +97,10 @@ void __init r8a7790_pinmux_init(void)
>  	r8a7790_register_gpio(3);
>  	r8a7790_register_gpio(4);
>  	r8a7790_register_gpio(5);
> +	r8a7790_register_i2c(0);
> +	r8a7790_register_i2c(1);
> +	r8a7790_register_i2c(2);
> +	r8a7790_register_i2c(3);
>  }

I might be wrong, but I believe we have been requested to add new devices 
directly to the board-*.c files, not to the setup-*.c files.

> 
>  #define SCIF_COMMON(scif_type, baseaddr, irq)			\
-- 
Regards,

Laurent Pinchart

