From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 31 Jul 2013 12:39:33 +0000
Subject: Re: [PATCH 2/2 v2] ARM: shmobile: bockw: add USB Function support
Message-Id: <51F90585.10006@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pptzb68g.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pptzb68g.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 31-07-2013 10:20, Kuninori Morimoto wrote:

> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
> was selected on this patch

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 07009f5..7de8a94 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
[...]
> @@ -79,13 +90,71 @@ static struct resource smsc911x_resources[] = {
>   	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
>   };
>
> +#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
> +/*
> + * When USB1 is Func
> + */
> +static int usbhsf_get_id(struct platform_device *pdev)
> +{
> +	return USBHS_GADGET;
> +}
> +
> +#define SUSPMODE	0x102
> +static int usbhsf_power_ctrl(struct platform_device *pdev,
> +			     void __iomem *base, int enable)
> +{
> +	enable = !!enable;
> +
> +	r8a7778_usb_phy_power(enable);
> +
> +	iowrite16(enable << 14, base + SUSPMODE);
> +
> +	return 0;
> +}
> +
> +static struct resource usbhsf_resources[] __initdata = {
> +	DEFINE_RES_MEM(0xffe60000, 0x110),
> +	DEFINE_RES_IRQ(gic_iid(0x4f)),
> +};
> +
> +static struct renesas_usbhs_platform_info usbhs_info = {

    Forgot __initdata here.

> +	.platform_callback = {
> +		.get_id		= usbhsf_get_id,
> +		.power_ctrl	= usbhsf_power_ctrl,
> +	},
> +	.driver_param = {
> +		.buswait_bwait	= 4,
> +	},
> +};
> +
> +#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
> +#define USB1_DEVICE	"renesas_usbhs"
> +#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE				\

    Add () please, it will look better when invoked. Lowercase the name and 
remove '_IF_POSSIBLE' too, perhaps.

> +	platform_device_register_resndata(			\
> +		&platform_bus, "renesas_usbhs", -1,		\
> +		usbhsf_resources,				\
> +		ARRAY_SIZE(usbhsf_resources),			\
> +		&usbhs_info, sizeof(struct renesas_usbhs_platform_info))

    Why not sizeof(usbhs_info)?

> diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
> index a0e9eb7..1395a2ac 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7778.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7778.c
> @@ -148,6 +148,7 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("r8a777x-ether", &mstp_clks[MSTP114]), /* Ether */
>   	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
>   	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
> +	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP100]), /* USB FUNC */
>   	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
>   	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
>   	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */

    Board and clock code in the single patch? Anyway, you haven't described 
this change in the changelog...

WBR, Sergei


