From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Dec 2013 14:21:51 +0000
Subject: Re: [PATCH 2/2] arm: shmobile: lager: Add VIN1 SoC camera support
Message-Id: <1489712.o3NYJrXxTL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387911334-27117-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387911334-27117-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Thank you for the patch.

Do you plan to implement DT support for the VIN driver in the near future ?

On Tuesday 24 December 2013 22:55:34 Valentine Barshak wrote:
> This adds VIN1 SoC camera along with ADV7180 subdevice support to Lager.
> VIN0 camera is not registered because it has ADV7612 I2C subdevice
> which is not supported yet.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c | 76 +++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-lager.c
> b/arch/arm/mach-shmobile/board-lager.c index f20c10a..50173ec 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -27,6 +27,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/pinctrl/machine.h>
> +#include <linux/platform_data/camera-rcar.h>
>  #include <linux/platform_data/gpio-rcar.h>
>  #include <linux/platform_data/rcar-du.h>
>  #include <linux/platform_device.h>
> @@ -39,6 +40,7 @@
>  #include <mach/common.h>
>  #include <mach/irqs.h>
>  #include <mach/r8a7790.h>
> +#include <media/soc_camera.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <linux/mtd/partitions.h>
> @@ -291,6 +293,62 @@ static const struct resource qspi_resources[]
> __initconst = { DEFINE_RES_IRQ(gic_spi(184)),
>  };
> 
> +/* VIN */
> +static const struct resource vin_resources[] __initconst = {
> +	/* VIN0 */
> +	DEFINE_RES_MEM(0xe6ef0000, 0x1000),
> +	DEFINE_RES_IRQ(gic_spi(188)),
> +	/* VIN1 */
> +	DEFINE_RES_MEM(0xe6ef1000, 0x1000),
> +	DEFINE_RES_IRQ(gic_spi(189)),
> +};
> +
> +void __init lager_add_vin_device(unsigned idx,
> +				 struct rcar_vin_platform_data *pdata)

You can make this function static.

> +{
> +	struct platform_device_info vin_info = {
> +		.parent		= &platform_bus,
> +		.name		= "r8a7790-vin",
> +		.id		= idx,
> +		.res		= &vin_resources[idx * 2],
> +		.num_res	= 2,
> +		.dma_mask	= DMA_BIT_MASK(32),
> +		.data		= pdata,
> +		.size_data	= sizeof(*pdata),
> +	};
> +
> +	BUG_ON(idx > 1);
> +
> +	platform_device_register_full(&vin_info);
> +}
> +
> +#define LAGER_CAMERA(idx, name, addr, pdata, flag)			\
> +static struct i2c_board_info i2c_cam##idx##_device = {			\
> +		I2C_BOARD_INFO(name, addr),				\
> +};									\
> +									\
> +static struct rcar_vin_platform_data vin##idx##_pdata = {		\
> +	.flags = flag,							\
> +};									\
> +									\
> +static struct soc_camera_link cam##idx##_link = {			\
> +	.bus_id = idx,							\
> +	.board_info = &i2c_cam##idx##_device,				\
> +	.i2c_adapter_id = 2,						\
> +	.module_name = name,						\
> +	.priv = pdata,							\
> +}
> +
> +/* Camera 0 is not currently supported due to adv7612 support missing */
> +LAGER_CAMERA(1, "adv7180", 0x20, NULL, RCAR_VIN_BT656);
> +
> +static void __init lager_add_camera1_device(void)
> +{
> +	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 1,
> +				      &cam1_link, sizeof(cam1_link));
> +	lager_add_vin_device(1, &vin1_pdata);
> +}
> +
>  static const struct pinctrl_map lager_pinctrl_map[] = {
>  	/* DU (CN10: ARGB0, CN13: LVDS) */
>  	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
> @@ -319,6 +377,22 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
> "eth_rmii", "eth"),
>  	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
>  				  "intc_irq0", "intc"),
> +	/* VIN0 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.0", "pfc-r8a7790",
> +				  "vin0_data24", "vin0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.0", "pfc-r8a7790",
> +				  "vin0_sync", "vin0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.0", "pfc-r8a7790",
> +				  "vin0_field", "vin0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.0", "pfc-r8a7790",
> +				  "vin0_clkenb", "vin0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.0", "pfc-r8a7790",
> +				  "vin0_clk", "vin0"),
> +	/* VIN1 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.1", "pfc-r8a7790",
> +				  "vin1_data8", "vin1"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.1", "pfc-r8a7790",
> +				  "vin1_clk", "vin1"),
>  };
> 
>  static void __init lager_add_standard_devices(void)
> @@ -368,6 +442,8 @@ static void __init lager_add_standard_devices(void)
>  				      &vccq_sdhi0_info, sizeof(struct 
gpio_regulator_config));
>  	platform_device_register_data(&platform_bus, "gpio-regulator",
> gpio_regulator_idx++, &vccq_sdhi2_info, sizeof(struct
> gpio_regulator_config)); +
> +	lager_add_camera1_device();
>  }
> 
>  /*
-- 
Regards,

Laurent Pinchart

