From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Aug 2012 03:02:36 +0000
Subject: Re: [PATCH 2/2] marzen: add SDHI0 support
Message-Id: <87a9yec7xz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1342526039-11128-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1342526039-11128-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi phil

I tested this patch, and it works well.
But this is small comment from me.

> ---
>  arch/arm/mach-shmobile/board-marzen.c |   48 +++++++++++++++++++++++++++++++++
>  1 files changed, 48 insertions(+), 0 deletions(-)

it is better if this patch update defconfig

> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 3a528cf..3c54a2f 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -30,6 +30,8 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/smsc911x.h>
> +#include <linux/mmc/sh_mobile_sdhi.h>
> +#include <linux/mfd/tmio.h>
>  #include <mach/hardware.h>
>  #include <mach/r8a7779.h>
>  #include <mach/common.h>
> @@ -75,8 +77,44 @@ static struct platform_device eth_device = {
>  	.num_resources	= ARRAY_SIZE(smsc911x_resources),
>  };
>  
> +/* Fixed 3.3V regulator to be used by SDHI0 */
> +static struct regulator_consumer_supply fixed3v3_power_consumers[] > +{
> +	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
> +	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> +};

I got warning

${LINUX}/arch/arm/mach-shmobile/board-marzen.c:81:41: \
   warning: 'fixed3v3_power_consumers' defined but not used [-Wunused-variable]

> +
> +static struct resource sdhi0_resources[] = {
> +	[0] = {
> +		.name   = "sdhi0",
> +		.start  = 0xffe4c000,
> +		.end    = 0xffe4c0ff,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = gic_spi(104),
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct sh_mobile_sdhi_info sdhi0_platform_data = {
> +	.tmio_flags	= (TMIO_MMC_WRPROTECT_DISABLE
> +			  | TMIO_MMC_HAS_IDLE_WAIT),

	.tmio_flags =	TMIO_MMC_WRPROTECT_DISABLE |
			TMIO_MMC_HAS_IDLE_WAIT,

is readable for me.

> +	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
> +};
> +
> +static struct platform_device sdhi0_device = {
> +	.name		= "sh_mobile_sdhi",
> +	.num_resources	= ARRAY_SIZE(sdhi0_resources),
> +	.resource	= sdhi0_resources,
> +	.id		= 0,
> +	.dev = {
> +		.platform_data = &sdhi0_platform_data,
> +	}
> +};
>  static struct platform_device *marzen_devices[] __initdata = {
>  	&eth_device,
> +	&sdhi0_device,
>  };
>  
>  static void __init marzen_init(void)
> @@ -97,6 +135,16 @@ static void __init marzen_init(void)
>  	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
>  	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
>  
> +	/* SD0 (CN20) */
> +	gpio_request(GPIO_FN_SD0_CLK, NULL);
> +	gpio_request(GPIO_FN_SD0_CMD, NULL);
> +	gpio_request(GPIO_FN_SD0_DAT0, NULL);
> +	gpio_request(GPIO_FN_SD0_DAT1, NULL);
> +	gpio_request(GPIO_FN_SD0_DAT2, NULL);
> +	gpio_request(GPIO_FN_SD0_DAT3, NULL);
> +	gpio_request(GPIO_FN_SD0_CD, NULL);
> +	gpio_request(GPIO_FN_SD0_WP, NULL);
> +
>  	r8a7779_add_standard_devices();
>  	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
>  }
> -- 


Best regards
---
Kuninori Morimoto
