From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Feb 2013 18:15:32 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: shmobile: switch SDHI and MMCIF interfaces on kzm9g-reference to pinctrl
Message-Id: <5099037.a5EKgFySbT@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thank you for the patch.

On Tuesday 12 February 2013 16:50:04 Guennadi Liakhovetski wrote:
> The recently added on sh73a0 DT pinctrl support enables us to switch SDHI
> and MMCIF interface pins to pinctrl and to add GPIO bindings for their
> card-detection pins and regulators.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   61 ++++++++++++++++-----
>  arch/arm/boot/dts/sh73a0-reference.dtsi        |    9 ----
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |   36 ++------------
>  3 files changed, 54 insertions(+), 52 deletions(-)

[snip]

> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> b/arch/arm/mach-shmobile/board-kzm9g-reference.c index d92da6d..1490246
> 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -90,38 +90,12 @@ static void __init kzm_init(void)
>  	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
>  	platform_device_register(&smsc_device);
> 
> -	/* enable MMCIF */
> -	gpio_request(GPIO_FN_MMCCLK0,		NULL);
> -	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_0_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_1_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_2_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_3_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_4_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_5_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
> -	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);

Don't hate me, but... the PFC implementation doesn't support controlling pull-
ups through the pinctrl API yet :-( That's something I still need to 
implement.

> -
> -	/* enable SD */
> -	gpio_request(GPIO_FN_SDHIWP0,		NULL);
> -	gpio_request(GPIO_FN_SDHICD0,		NULL);
> -	gpio_request(GPIO_FN_SDHICMD0,		NULL);
> -	gpio_request(GPIO_FN_SDHICLK0,		NULL);
> -	gpio_request(GPIO_FN_SDHID0_3,		NULL);
> -	gpio_request(GPIO_FN_SDHID0_2,		NULL);
> -	gpio_request(GPIO_FN_SDHID0_1,		NULL);
> -	gpio_request(GPIO_FN_SDHID0_0,		NULL);
> +	/*
> +	 * Enable SD: this is a pseudo-GPIO, it actually only sets bit 28 in
> +	 * MSEL3CR to turn VCCQ_MC0 on. One could make a primitive fixed
> +	 * regulator of this and use it as vqmmc-supply for SDHI0.
> +	 */
>  	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
> -	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
> -
> -	/* enable Micro SD */
> -	gpio_request(GPIO_FN_SDHID2_0,		NULL);
> -	gpio_request(GPIO_FN_SDHID2_1,		NULL);
> -	gpio_request(GPIO_FN_SDHID2_2,		NULL);
> -	gpio_request(GPIO_FN_SDHID2_3,		NULL);
> -	gpio_request(GPIO_FN_SDHICMD2,		NULL);
> -	gpio_request(GPIO_FN_SDHICLK2,		NULL);
> -	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
> 
>  #ifdef CONFIG_CACHE_L2X0
>  	/* Early BRESP enable, Shared attribute override enable, 64K*8way */

-- 
Regards,

Laurent Pinchart

