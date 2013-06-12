From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:08:13 +0000
Subject: Re: [PATCH 1/3 v4] ARM: shmobile: bockw: add I2C device support
Message-Id: <20130612140812.GF32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo7c6ptp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo7c6ptp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 11, 2013 at 07:11:17PM -0700, Kuninori Morimoto wrote:
> This patch enables rx8581 on I2C0

Thanks, queued up in the boards branch.

> 
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - based on renesas-next-20130611v2
> 
>  arch/arm/mach-shmobile/board-bockw.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 5036d53..29cf3ed 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -66,6 +66,13 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
>  
>  static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
>  
> +/* I2C */
> +static struct i2c_board_info i2c0_devices[] = {
> +	{
> +		I2C_BOARD_INFO("rx8581", 0x51),
> +	},
> +};
> +
>  static const struct pinctrl_map bockw_pinctrl_map[] = {
>  	/* SCIF0 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
> @@ -93,7 +100,10 @@ static void __init bockw_init(void)
>  	r8a7778_init_irq_extpin(1);
>  	r8a7778_add_standard_devices();
>  	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
> +	r8a7778_add_i2c_device(0);
>  
> +	i2c_register_board_info(0, i2c0_devices,
> +				ARRAY_SIZE(i2c0_devices));
>  	pinctrl_register_mappings(bockw_pinctrl_map,
>  				  ARRAY_SIZE(bockw_pinctrl_map));
>  	r8a7778_pinmux_init();
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
