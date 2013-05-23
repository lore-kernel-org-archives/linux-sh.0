From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 13:01:47 +0000
Subject: Re: [PATCH 11/17 v2] ARM: shmobile: bockw: add MMCIF support
Message-Id: <519E133B.8020400@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wqqq2xh6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqqq2xh6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 23.05.2013 7:20, Kuninori Morimoto wrote:

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

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

    I keep telling you that platform data and platform device resources 
should be annotated with __initdata if you're using 
platfrom_device_register_*() functions as they are copied to the heap 
memory in this case...

> +	.sup_pclk	= 0,
> +	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.caps		= MMC_CAP_4_BIT_DATA |
> +			  MMC_CAP_8_BIT_DATA |
> +			  MMC_CAP_NEEDS_POLL,
> +};
> +

WBR, Sergei

