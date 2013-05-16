From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 16 May 2013 15:22:05 +0000
Subject: Re: [PATCH 09/12] ARM: shmobile: bockw: add MMCIF support
Message-Id: <5194F99D.4070708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761yjwg26.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761yjwg26.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16-05-2013 11:16, Kuninori Morimoto wrote:

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-bockw.c |   32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 769069e..2f51e8b 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
[...]
> @@ -100,10 +117,24 @@ static struct spi_board_info spi_board_info[] __initdata = {
>   	},
>   };
>
> +/* MMC */
> +static struct sh_mmcif_plat_data sh_mmcif_plat = {

    You can annotate this as '__initdata' as it will be kmemdup()'ed 
when registering the device.

> +	.sup_pclk	= 0,
> +	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.caps		= MMC_CAP_4_BIT_DATA |
> +			  MMC_CAP_8_BIT_DATA |
> +			  MMC_CAP_NEEDS_POLL,
> +};
> +
[...]
> @@ -133,6 +164,7 @@ static void __init bockw_init(void)
>   	r8a7778_add_standard_devices();
>   	r8a7778_add_i2c_device(0);
>   	r8a7778_add_hspi_device(0);
> +	r8a7778_add_mmc_device(&sh_mmcif_plat);
>
>   	i2c_register_board_info(0, i2c0_devices,
>   				ARRAY_SIZE(i2c0_devices));

WBR, Sergei

