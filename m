From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 04 Jun 2014 11:52:44 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <538F05BC.7000800@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org
Cc: rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Saturday 24 May 2014 03:36 AM, Sergei Shtylyov wrote:
> This PHY, though formally being a part of Renesas USBHS controller, contains the
> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls them
> channels) to the different USB controllers: channel 0 can be connected to either
> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI EHCI/OHCI
> or xHCI controllers.
> 
> This is a new driver for this USB PHY currently already supported under drivers/
> usb/phy/. The reason for writing the new driver was the requirement that the
> multiplexing of USB channels to the controller be dynamic, depending on what
> USB drivers are loaded,  rather than static as provided by the old driver.
> The infrastructure provided by drivers/phy/phy-core.c seems to fit that purpose
> ideally. The new driver only supports device tree probing for now.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'next' branch of Kishon's 'linux-phy.git' repo.
> 
> Changes in version 4:
> - added subnodes to the USB PHY node, described their properties in the binding
>   document; rewrote the probe() method to parse out PHY selection and UGCTRL2
>   mask values out of these child nodes;
> - changed NUM_USB_CHANNELS to 2, removed the former channel #1 support as we
>   don't have control over it anyway;
> - refreshed the patch.
> 
> Changes in version 3:
> - removed 'rcar_gen2_usbhs_phy_ops', moving 'power_{on|off}' intializers to
>   'rcar_gen2_phy_ops' and adding a check for USBHS PHY to power_{on|off}()
>   methods;
> - renamed the power_{on|off}() methods;
> - replaced io{read|write}16() calls with {read|write}w();
> - removed the comment to '#define USBHS_UGSTS_LOCK';
> - broke the line in the dev_err() call in the probe() method;
> - moved the driver's line in the 'Makefile' before OMAP drivers.
> 
> Changes in version 2:
> - rebased the patch, resolving reject.
> 
>  Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt |   60 +++
>  drivers/phy/Kconfig                                     |    7 
>  drivers/phy/Makefile                                    |    1 
>  drivers/phy/phy-rcar-gen2.c                             |  288 ++++++++++++++++
>  4 files changed, 356 insertions(+)
> 
> Index: linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
> =================================> --- /dev/null
> +++ linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
> @@ -0,0 +1,60 @@
> +* Renesas R-Car generation 2 USB PHY
> +
> +This file provides information on what the device node for the R-Car generation
> +2 USB PHY contains.
> +
> +Required properties:
> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
> +	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
> +- reg: offset and length of the register block.
> +- #phy-cells: see phy-bindings.txt in the same directory, must be 2.
> +- clocks: clock phandle and specifier pair.
> +- clock-names: string, clock input name, must be "usbhs".
> +
> +The phandle's first argument in the PHY specifier identifies the USB channel,
> +the second one is the USB controller selector and depends on the first:
> +
> ++-----------+---------------+---------------+
> +|\ Selector |               |               |
> ++ --------- +       0       |       1       |
> +| Channel  \|               |               |
> ++-----------+---------------+---------------+
> +| 0         | PCI EHCI/OHCI | HS-USB        |
> +| 1         | PCI EHCI/OHCI | xHCI          |
> ++-----------+---------------+---------------+
> +
> +The USB PHY device tree node should be the subnodes corresponding to the USB
> +channels and the controllers connected to them. These subnodes must contain the
> +following properties:
> +- renesas,phy-select: the first cell identifies the USB channel, the second cell
> +  is the USB controller selector; see the table above for the values.
> +- renesas,ugctrl2-masks: the first cell is the UGCTRL2 mask corresponding to
> +  the USB channel, the second cell is the UGCTRL2 value corresponding to the
> +  USB controller selected for that channel.
> +
> +Example (Lager board):
> +
> +	usb-phy@e6590100 {
> +		compatible = "renesas,usb-phy-r8a7790";
> +		reg = <0 0xe6590100 0 0x100>;
> +		#phy-cells = <2>;
> +		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> +		clock-names = "usbhs";
> +
> +		usb-phy@0,0 {
> +			renesas,phy-select = <0 0>;
> +			renesas,ugctrl2-masks = <0x00000030 0x00000010>;
> +		};
> +		usb-phy@0,1 {
> +			renesas,phy-select = <0 1>;
> +			renesas,ugctrl2-masks = <0x00000030 0x00000030>;
> +		};
> +		usb-phy@1,0 {
> +			renesas,phy-select = <1 0>;
> +			renesas,ugctrl2-masks = <0x80000000 0x00000000>;
> +		};
> +		usb-phy@1,1 {
> +			renesas,phy-select = <1 1>;
> +			renesas,ugctrl2-masks = <0x80000000 0x80000000>;
> +		};
> +	};

IIUC, channel 0 can be configured for either EHCI/OHCI or HS-USB but can't be
used for both. And channel 1 can be configured for either PCI EHCI/OHCI or
xHCI. right?

So ideally only two sub-nodes should be created for channel '0' and channel
'1'. You can configure a channel to a particular mode by passing the mode in
PHY specifier (The channel should be configured to a particualr mode in xlate).

Btw I'm not sure if it is recommended to pass register mask values from dt.
> Index: linux-phy/drivers/phy/Kconfig
> =================================> --- linux-phy.orig/drivers/phy/Kconfig
> +++ linux-phy/drivers/phy/Kconfig
> @@ -31,6 +31,13 @@ config PHY_MVEBU_SATA
>  	depends on OF
>  	select GENERIC_PHY
>  
> +config PHY_RCAR_GEN2
> +	tristate "Renesas R-Car generation 2 USB PHY driver"
> +	depends on ARCH_SHMOBILE
> +	depends on GENERIC_PHY
> +	help
> +	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
> +
>  config OMAP_CONTROL_PHY
>  	tristate "OMAP CONTROL PHY Driver"
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> Index: linux-phy/drivers/phy/Makefile
> =================================> --- linux-phy.orig/drivers/phy/Makefile
> +++ linux-phy/drivers/phy/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
> +obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
>  obj-$(CONFIG_OMAP_CONTROL_PHY)		+= phy-omap-control.o
>  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
> =================================> --- /dev/null
> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
> @@ -0,0 +1,288 @@
> +/*
> + * Renesas R-Car Gen2 PHY driver
> + *
> + * Copyright (C) 2014 Renesas Solutions Corp.
> + * Copyright (C) 2014 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#define USBHS_LPSTS			0x02
> +#define USBHS_UGCTRL			0x80
> +#define USBHS_UGCTRL2			0x84
> +#define USBHS_UGSTS			0x88
> +
> +/* Low Power Status register (LPSTS) */
> +#define USBHS_LPSTS_SUSPM		0x4000
> +
> +/* USB General control register (UGCTRL) */
> +#define USBHS_UGCTRL_CONNECT		0x00000004
> +#define USBHS_UGCTRL_PLLRESET		0x00000001
> +
> +/* USB General control register 2 (UGCTRL2) */
> +#define USBHS_UGCTRL2_USB2SEL		0x80000000
> +#define USBHS_UGCTRL2_USB2SEL_PCI	0x00000000
> +#define USBHS_UGCTRL2_USB2SEL_USB30	0x80000000
> +#define USBHS_UGCTRL2_USB0SEL		0x00000030
> +#define USBHS_UGCTRL2_USB0SEL_PCI	0x00000010
> +#define USBHS_UGCTRL2_USB0SEL_HS_USB	0x00000030
> +
> +/* USB General status register (UGSTS) */
> +#define USBHS_UGSTS_LOCK		0x00000300
> +
> +#define	NUM_USB_CHANNELS	2
> +
> +struct rcar_gen2_phy {
> +	struct phy *phy;
> +	struct rcar_gen2_phy_driver *drv;
> +	u32 select_mask;
> +	u32 select_value;
> +};
> +
> +struct rcar_gen2_phy_driver {
> +	void __iomem *base;
> +	struct clk *clk;
> +	spinlock_t lock;
> +	struct rcar_gen2_phy phys[NUM_USB_CHANNELS][2];

This can be created dynamically based on the number of sub-nodes. In this case
it'll be only rcar_gen2_phy phys[2], one for each channel.
By this we need not hard code NUM_USB_CHANNELS.

Thanks
Kishon
