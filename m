From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 02 Jul 2012 21:59:29 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add SDHI2 to the 2.8V fixed regulator consumers on kzm9g
Message-Id: <201207022359.29397.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday, July 01, 2012, Guennadi Liakhovetski wrote:
> The recently added SDHI2 interface to kzm9g needs power supplies for the
> upcoming transition away from OCR masks, provided in platform data.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Rafael, please, take this one too for 3.6. SDHI2 has just been added, so, 
> we need a power regulator for it as well.

Applied to the kzm9g branch of the renesas.git tree.

Thanks,
Rafael


>  arch/arm/mach-shmobile/board-kzm9g.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index e72ff8d..53b7ea9 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -373,11 +373,13 @@ static struct platform_device mmc_device = {
>  	.resource	= sh_mmcif_resources,
>  };
>  
> -/* Fixed 2.8V regulators to be used by SDHI0 */
> +/* Fixed 2.8V regulators to be used by SDHI0 and SDHI2 */
>  static struct regulator_consumer_supply fixed2v8_power_consumers[] >  {
>  	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
>  	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> +	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
> +	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
>  };
>  
>  /* SDHI */
> 

