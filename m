From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 12:53:34 +0000
Subject: Re: [PATCH 08/17 v2] ARM: shmobile: r8a7778: add MMCIF support
Message-Id: <519E114E.6070905@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871u8y4c3a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u8y4c3a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:19, Kuninori Morimoto wrote:

    I would like a proper changelog here.

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
> index c2c1895..842aed7 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7778.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7778.c
[...]
> @@ -137,6 +139,7 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
>
>   	/* MSTP32 clocks */
> +	CLKDEV_DEV_ID("sh_mmcif",	&mstp_clks[MSTP331]), /* MMC */

    Either actually align with others, or use single space after comma.

>   	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
[...]
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 8f011cb..b0cc4ba 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -220,6 +220,19 @@ void __init r8a7778_add_hspi_device(int id)
>   		hspi_resources + (2 * id), 2);
>   }
>
> +/* MMC */
> +static struct resource mmc_resources[] = {

    You forgot to specify __initdata.

> +	DEFINE_RES_MEM(0xffe4e000, 0x100),
> +	DEFINE_RES_IRQ(gic_iid(0x5d)),
> +};

WBR, Sergei

