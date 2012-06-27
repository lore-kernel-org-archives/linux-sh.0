From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 27 Jun 2012 15:56:51 +0000
Subject: Re: [PATCH 04/10 v3] ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
Message-Id: <Pine.LNX.4.64.1206271734420.24173@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1340749952-8534-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340749952-8534-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 27 Jun 2012, Guennadi Liakhovetski wrote:

> On armadillo800eva provide a 3.3V supply for its SD/MMC-card interfaces.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 9e37026..819cee5 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -28,6 +28,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
>  #include <linux/sh_eth.h>
>  #include <linux/videodev2.h>
>  #include <linux/usb/renesas_usbhs.h>
> @@ -407,6 +409,17 @@ static struct platform_device gpio_keys_device = {
>  	},
>  };
>  
> +/* Fixed 3.3V regulator to be used by SDHI0, SDHI1, MMCIF */
> +static struct regulator_consumer_supply fixed3v3_power_consumers[] > +{
> +	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
> +	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> +	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
> +	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
> +	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
> +	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),

There is a slight problem with this patch: a1 (r8a7740) SoCs are currently 
the only ones registering their MMCIF device without an index, i.e., with 
.id = -1. This is reflected in board-armadillo800eva.c and in 
clock-r8a7740.c. This patch erroneously uses sh_mmcif.0 for device name, 
which is also what every single other ARM and sh platform in the mainline, 
using mmcif, AFAICS, currently does.

Therefore question: Magnus, Rafael: what would you prefer - fix the above 
regulator entries to not use a device ID, or unify a1 with other SoCs to 
use .id = 0?

Thanks
Guennadi

> +};
> +
>  /* SDHI0 */
>  /*
>   * FIXME
> @@ -584,6 +597,9 @@ clock_error:
>   */
>  static void __init eva_init(void)
>  {
> +	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
> +				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
> +
>  	eva_clock_init();
>  
>  	r8a7740_pinmux_init();
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
