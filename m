From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 21 Apr 2014 09:50:52 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <4042607.99R5mbOC5c@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Monday 21 April 2014 10:31:14 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> A simple serial port integration prototype that happens to
> target Koelsch. Written to propose how to move one step closer
> to integrate DT support for serial ports on mach-shmobile.

I think you've over-engineering it. I would just switch serial devices to DT 
in one go, like we do for all other devices.

> This patch handles all 3 cases of C-code less DT board support
> and the older board support with C code which includes both legacy
> and DT reference. The "enabling of serial DT devices in the board DTS"
> and "requiring serial DT devices at boot" are disconnected in this
> patch - only the former is implemented. The latter is best handled
> when C board code is phased out in my opinion.
> 
> To handle serial ports described in DT this patch does two things:
> 
> 1) It enables serial ports in the board specific DTS
>   -> Nothing special here, except perhaps the preserved device order
> 
> 2) It extends the existing platform device registration code
>   -> When the existing C board code calls to add serial platform devices
>      then we check if DT platform devices exist in the DTB. If so then
>      we disable the serial DT devices and stick with platform devices.
> 
> The combination of 1) and 2) allows us to use the same DTB regardless
> if C board code is compiled in or not. Also migration becomes easy
> and forgiving, if for instance the user only updates the kernel and
> uses the old DTB then the board code will keep on working even though
> serial devices may not be present in the DTS.
> 
> The patch simply postpones the entire "which serial port minor device
> shall we use" issue and simply uses the same device as the existing
> board code. If we want to reorder the serial ports then we can do that
> as an incremental step afterwards - after board code written in C
> has been removed. Not reordering has the benefit that it reduces
> complexity and allows us to keep the kernel command line in the
> board DTS as-is.
> 
> Needs to be beaten into better shape and made generic enough to support
> all mach-shmobile board code.
> 
> Not signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written on top of renesas-devel-v3.15-rc1-20140414v2
> 
>  arch/arm/boot/dts/r8a7791-koelsch.dts  |   21 ++++++++++++++++++++-
>  arch/arm/mach-shmobile/setup-r8a7791.c |   27 ++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 2 deletions(-)
> 
> --- 0001/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ work/arch/arm/boot/dts/r8a7791-koelsch.dts	2014-04-17 
17:02:42.000000000
> +0900 @@ -19,6 +19,11 @@
>  	model = "Koelsch";
>  	compatible = "renesas,koelsch", "renesas,r8a7791";
> 
> +	aliases {
> +		serial6 = &scif0;
> +		serial7 = &scif1;
> +	};
> +
>  	chosen {
>  		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs
> ip=dhcp"; };
> @@ -230,7 +235,7 @@
>  };
> 
>  &pfc {
> -	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
> +	pinctrl-0 = <&du_pins>;
>  	pinctrl-names = "default";
> 
>  	i2c2_pins: i2c2 {
> @@ -342,6 +347,20 @@
>  	status = "okay";
>  };
> 
> +&scif0 {
> +       pinctrl-0 = <&scif0_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&scif1 {
> +       pinctrl-0 = <&scif1_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
>  &qspi {
>  	pinctrl-0 = <&qspi_pins>;
>  	pinctrl-names = "default";
> --- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-04-17
> 16:32:32.000000000 +0900 @@ -94,7 +94,9 @@ static struct plat_sci_port
> scif##index#
>  static struct resource scif##index##_resources[] = {			\
>  	DEFINE_RES_MEM(baseaddr, 0x100),				\
>  	DEFINE_RES_IRQ(irq),						\
> -}
> +};									\
> +									\
> +static struct property scif##index##_property
> 
>  #define R8A7791_SCIF(index, baseaddr, irq)				\
>  	__R8A7791_SCIF(PORT_SCIF, index, baseaddr, irq)
> @@ -121,7 +123,30 @@ R8A7791_SCIFA(12, 0xe6c70000, gic_spi(29
>  R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
>  R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
> 
> +static void serial_disable_dt(struct resource *res, struct property *prop)
> +{
> +	struct device_node *np;
> +	char str[17];
> +	char *disabled = "disabled";
> +
> +	snprintf(str, ARRAY_SIZE(str), "/serial@%08x",
> +		 (unsigned int)res->start);
> +
> +	np = of_find_node_by_path(str);
> +	if (np) {
> +		if (of_device_is_available(np)) {
> +			prop->name = "status";
> +			prop->length = strlen(disabled) + 1;
> +			prop->value = disabled;
> +			of_update_property(np, prop);
> +			printk("xxx disabled %s\n", str);
> +		}
> +		of_node_put(np);
> +	}
> +}
> +
>  #define r8a7791_register_scif(index)					       \
> +	serial_disable_dt(scif##index##_resources, &scif##index##_property);   \
>  	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
>  					  scif##index##_resources,	       \
>  					  ARRAY_SIZE(scif##index##_resources), \

-- 
Regards,

Laurent Pinchart

