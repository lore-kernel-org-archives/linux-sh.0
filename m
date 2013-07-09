From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Jul 2013 12:15:30 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: bockw: add USB Function support
Message-Id: <51DBFEE2.2000606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9lwth26.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9lwth26.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09-07-2013 9:53, Kuninori Morimoto wrote:

> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
> was selected

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-bockw.c |   49 +++++++++++++++++++++++++++++++---
>   1 file changed, 46 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index a57be8a..1a4918f 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -58,6 +58,16 @@
>    * SW19	(MMC)	1 pin
>    */
>
> +/*
> + * USB
> + *
> + * USB1 (CN29) can be Host/Function
> + *
> + *		Host	Func
> + * SW98		0	2
> + * SW99		0	3
> + */
> +
>   /* Dummy supplies, where voltage doesn't matter */
>   static struct regulator_consumer_supply dummy_supplies[] = {
>   	REGULATOR_SUPPLY("vddvario", "smsc911x"),
> @@ -140,7 +150,39 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
>   			  MMC_CAP_NEEDS_POLL,
>   };
>
> -static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
> +/* USB */
> +#if	defined(CONFIG_USB_RENESAS_USBHS_UDC) || \
> +	defined(CONFIG_USB_RENESAS_USBHS_UDC_MODULE)

    #if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)

> +
> +	/* USB1 is Func */
> +	static struct renesas_usbhs_platform_info usbhs_info = {

    Don't indent here please.

> +		.platform_callback = {
> +			/* .get_id	will be set in register function */
> +			/* .power_ctrl	will be set in register function */
> +		},

    Why have empty initializer?

> +		.driver_param = {
> +			.buswait_bwait	= 4,
> +		},
> +	};
> +
> +	#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
> +	#define PIN_MAP_MUX_GROUP_USB1 \
> +		PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7778", \
> +					  "usb1_ovc", "usb1")

     USB_OVC1 is 3.3V pin and your common PHY settings above don't 
select it. I don't think you need this group, actually the group should 
be the same as for the USB host mode.

WBR, Sergei

