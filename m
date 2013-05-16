From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 16 May 2013 15:02:01 +0000
Subject: Re: [PATCH 06/12] ARM: shmobile: r8a7778: add MMCIF support
Message-Id: <5194F4E9.20600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9nvwg30.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9nvwg30.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 16-05-2013 11:15, Kuninori Morimoto wrote:

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/clock-r8a7778.c        |    3 +++
>   arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
>   arch/arm/mach-shmobile/setup-r8a7778.c        |   13 +++++++++++++
>   3 files changed, 18 insertions(+)

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

    Either you align the second argument with others or you use single 
space.

>   	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
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

    You can annotate this with '__initdata', these resources will be 
kmemdup()'ed when registering the device anyway.

> +	DEFINE_RES_MEM(0xffe4e000, 0x100),
> +	DEFINE_RES_IRQ(gic_iid(0x5d)),
> +};
> +
> +void __init r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info)
> +{
> +	platform_device_register_resndata(
> +		&platform_bus, "sh_mmcif", -1,
> +		mmc_resources, ARRAY_SIZE(mmc_resources),
> +		info, sizeof(*info));
> +}

WBR, Sergei


