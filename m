From: Felipe Balbi <balbi@ti.com>
Date: Fri, 13 Jun 2014 14:25:25 +0000
Subject: Re: [PATCH v6 1/1] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <20140613142525.GE8319@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Fnm8lRGFTVS/3GuM"
List-Id: <linux-sh.vger.kernel.org>
References: <539AEC8F.4030003@renesas.com>
In-Reply-To: <539AEC8F.4030003@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 13, 2014 at 09:20:31PM +0900, Yoshihiro Shimoda wrote:
> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> some specific initializations related to the firmware downloading and
> some specific registers. This patch adds the support for this special
> configuration as an xHCI quirk executed during probe and start.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/host/Kconfig     |    8 +++
>  drivers/usb/host/Makefile    |    3 +
>  drivers/usb/host/xhci-plat.c |   19 ++++++
>  drivers/usb/host/xhci-rcar.c |  148 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/usb/host/xhci-rcar.h |   27 ++++++++
>  5 files changed, 205 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-rcar.c
>  create mode 100644 drivers/usb/host/xhci-rcar.h
>=20
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 61b7817..537d9e1 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -37,6 +37,14 @@ config USB_XHCI_MVEBU
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Marvell Armada 375/38x ARM SOCs.
>=20
> +config USB_XHCI_RCAR
> +	tristate "xHCI support for Renesas R-Car SoCs"
> +	select USB_XHCI_PLATFORM
> +	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	---help---
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	  found in Renesas R-Car ARM SoCs.
> +
>  endif # USB_XHCI_HCD
>=20
>  config USB_EHCI_HCD
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index af89a90..144c038 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -22,6 +22,9 @@ ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
>  ifneq ($(CONFIG_USB_XHCI_MVEBU), )
>  	xhci-hcd-y		+=3D xhci-mvebu.o
>  endif
> +ifneq ($(CONFIG_USB_XHCI_RCAR), )
> +	xhci-hcd-y		+=3D xhci-rcar.o
> +endif
>  endif
>=20
>  obj-$(CONFIG_USB_WHCI_HCD)	+=3D whci/
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 29d8adb..b6f2b6b 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -20,6 +20,7 @@
>=20
>  #include "xhci.h"
>  #include "xhci-mvebu.h"
> +#include "xhci-rcar.h"
>=20
>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>  {
> @@ -34,11 +35,27 @@ static void xhci_plat_quirks(struct device *dev, stru=
ct xhci_hcd *xhci)
>  /* called during probe() after chip reset completes */
>  static int xhci_plat_setup(struct usb_hcd *hcd)
>  {
> +	struct device_node *of_node =3D hcd->self.controller->of_node;
> +	int ret;
> +
> +	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
> +	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791")) {
> +		ret =3D xhci_rcar_init_quirk(hcd);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return xhci_gen_setup(hcd, xhci_plat_quirks);
>  }
>=20
>  static int xhci_plat_start(struct usb_hcd *hcd)
>  {
> +	struct device_node *of_node =3D hcd->self.controller->of_node;
> +
> +	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
> +	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
> +		xhci_rcar_start(hcd);
> +
>  	return xhci_run(hcd);
>  }
>=20
> @@ -270,6 +287,8 @@ static const struct of_device_id usb_xhci_of_match[] =
=3D {
>  	{ .compatible =3D "xhci-platform" },
>  	{ .compatible =3D "marvell,armada-375-xhci"},
>  	{ .compatible =3D "marvell,armada-380-xhci"},
> +	{ .compatible =3D "renesas,xhci-r8a7790"},
> +	{ .compatible =3D "renesas,xhci-r8a7791"},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> new file mode 100644
> index 0000000..ff0d1b4
> --- /dev/null
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -0,0 +1,148 @@
> +/*
> + * xHCI host controller driver for R-Car SoCs
> + *
> + * Copyright (C) 2014 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/phy.h>
> +
> +#include "xhci.h"
> +#include "xhci-rcar.h"
> +
> +#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem"
> +MODULE_FIRMWARE(FIRMWARE_NAME);
> +
> +/*** Register Offset ***/
> +#define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
> +#define RCAR_USB3_DL_CTRL	0x250	/* FW Download Control & Status */
> +#define RCAR_USB3_FW_DATA0	0x258	/* FW Data0 */
> +
> +#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
> +#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */
> +#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */
> +#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */
> +#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
> +#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */
> +
> +/*** Register Settings ***/
> +/* Interrupt Enable */
> +#define RCAR_USB3_INT_XHC_ENA	0x00000001
> +#define RCAR_USB3_INT_PME_ENA	0x00000002
> +#define RCAR_USB3_INT_HSE_ENA	0x00000004
> +#define RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \
> +				RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA)
> +
> +/* FW Download Control & Status */
> +#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
> +#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010
> +#define RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100
> +
> +/* LCLK Select */
> +#define RCAR_USB3_LCLK_ENA_VAL	0x01030001
> +
> +/* USB3.0 Configuration */
> +#define RCAR_USB3_CONF1_VAL	0x00030204
> +#define RCAR_USB3_CONF2_VAL	0x00030300
> +#define RCAR_USB3_CONF3_VAL	0x13802007
> +
> +/* USB3.0 Polarity */
> +#define RCAR_USB3_RX_POL_VAL	BIT(21)
> +#define RCAR_USB3_TX_POL_VAL	BIT(4)
> +
> +void xhci_rcar_start(struct usb_hcd *hcd)
> +{
> +	u32 temp;
> +
> +	if (hcd->regs !=3D NULL) {
> +		/* Interrupt Enable */
> +		temp =3D readl(hcd->regs + RCAR_USB3_INT_ENA);
> +		temp |=3D RCAR_USB3_INT_ENA_VAL;
> +		writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
> +		/* LCLK Select */
> +		writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK);
> +		/* USB3.0 Configuration */
> +		writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CONF1);
> +		writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CONF2);
> +		writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CONF3);
> +		/* USB3.0 Polarity */
> +		writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL);
> +		writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL);
> +	}
> +}
> +
> +static int xhci_rcar_download_firmware(struct device *dev, void __iomem =
*regs)
> +{
> +	const struct firmware *fw;
> +	int retval, index, j, time;
> +	int timeout =3D 10000;
> +	u32 data, val, temp;
> +
> +	/* request R-Car USB3.0 firmware */
> +	retval =3D request_firmware(&fw, FIRMWARE_NAME, dev);
> +	if (retval)
> +		return retval;
> +
> +	/* download R-Car USB3.0 firmware */
> +	temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> +	temp |=3D RCAR_USB3_DL_CTRL_ENABLE;
> +	writel(temp, regs + RCAR_USB3_DL_CTRL);
> +
> +	for (index =3D 0; index < fw->size; index +=3D 4) {
> +		/* to avoid reading beyond the end of the buffer */
> +		for (data =3D 0, j =3D 3; j >=3D 0; j--) {
> +			if ((j + index) < fw->size)
> +				data |=3D fw->data[index + j] << (8 * j);
> +		}
> +		writel(data, regs + RCAR_USB3_FW_DATA0);
> +		temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> +		temp |=3D RCAR_USB3_DL_CTRL_FW_SET_DATA0;
> +		writel(temp, regs + RCAR_USB3_DL_CTRL);
> +
> +		for (time =3D 0; time < timeout; time++) {
> +			val =3D readl(regs + RCAR_USB3_DL_CTRL);
> +			if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) =3D=3D 0)
> +				break;
> +			udelay(1);
> +		}
> +		if (time =3D=3D timeout) {
> +			retval =3D -ETIMEDOUT;
> +			break;
> +		}
> +	}
> +
> +	temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> +	temp &=3D ~RCAR_USB3_DL_CTRL_ENABLE;
> +	writel(temp, regs + RCAR_USB3_DL_CTRL);
> +
> +	for (time =3D 0; time < timeout; time++) {
> +		val =3D readl(regs + RCAR_USB3_DL_CTRL);
> +		if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> +			retval =3D 0;
> +			break;
> +		}
> +		udelay(1);
> +	}
> +	if (time =3D=3D timeout)
> +		retval =3D -ETIMEDOUT;
> +
> +	release_firmware(fw);
> +
> +	return retval;
> +}
> +
> +/* This function needs to initialize a "phy" of usb before */

initializing a PHY looks like something that the PHY layer should do.
Why don't you write a PHY driver and teach xhci-core about PHYs ? Then,
more people would benefit.

cheers

--=20
balbi

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTmwnVAAoJEIaOsuA1yqREuRoP/322qYkAOicVjGZk74bI43HZ
TZw1bsx7HJvvryyIXbWxJM/zUUOFSbNFZhW7VwVQ6T+D8Y7EP+frZEsJ7gNQr89K
CqINmRbBQAKROcDLh4M42p3d7p8khJjLzi+67ztzwjpLa0mSHiVWiKIVyE9gL87t
JLvtaWXD/PDSQjOBU8c+FCvXn4SS1cImmNJLt7Qy6gvHhYMihVMx3HAa6Uxe7rOX
0DdokCRKxpLEMwlhtAS2pMHPGqj0VK9gRqD001WYT6tK/fOBsU+6PwVzxdA39CJu
c7mM1JTQG3GmD57I1rQMJfamzuCAZEEkBRCLD0jxfXFt7BzRgNTdAJt0Vf2vY3mQ
GO1/ULXpMa5exEkkoFy57CVitdPpfM1Tdi+dPD3J6JAMbVah35y83tOGlV5jPXde
eIDAHAYOnxXfxEwQom/W63fnbkCMtToJiM3z2U9aDzLYmkUuL+GrmQLFUxL/nVuj
++tLaBE1CRWCLlcMAYi4yfuWBheN+B7XaNsFTlUqN/vwDGaGirzUdAo4av4+mFhF
RRlXqnLiaotNmOlQ95jYAoMiQTVQL5wkwXFz++G6pr/w4LU7Q0k4s57E7qDqPo6a
6mXj+LhMSmBmkx+EHg2ifPZuDUjywcfSpPa1KhfMCNGdxbQmtqzzf7zpdhjo0zly
PYGt7Y5RDRQW2iCqFxsf
=dL86
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
