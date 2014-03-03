From: Felipe Balbi <balbi@ti.com>
Date: Mon, 03 Mar 2014 16:44:26 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <20140303164426.GD10987@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3Pql8miugIZX0722"
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403010407.54639.sergei.shtylyov@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-sh@vger.kernel.org, valentine.barshak@cogentembedded.com, rob@landley.net, linux-doc@vger.kernel.org

--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 01, 2014 at 04:07:53AM +0300, Sergei Shtylyov wrote:
> Add support of the device tree probing for the Renesas R-Car generation 2=
 SoCs
> documenting the device tree binding as necessary.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Unless someone on devicetree@vger gives me an ACK pretty soon, I'm
afraid this patch will miss v3.15.

>=20
> ---
> This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.
>=20
> Changes in version 2:
> - restored devm_clk_get() call and the error handling logic in the probe()
>   method, removed clk_put() call in the remove() method.
>=20
>  Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++++=
++
>  drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42 +++++++++=
+++++--
>  2 files changed, 68 insertions(+), 3 deletions(-)
>=20
> Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
> @@ -0,0 +1,29 @@
> +* Renesas R-Car generation 2 USB PHY
> +
> +This file provides information on what the device node for the R-Car gen=
eration
> +2 USB PHY contains.
> +
> +Required properties:
> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A77=
90 SoC.
> +	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
> +- reg: offset and length of the register block.
> +- clocks: clock phandle and specifier pair.
> +- clock-names: string, clock input name, must be "usbhs".
> +
> +Optional properties:
> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be co=
nnected
> +			to PCI EHCI/OHCI; otherwise, it will be connected to the
> +			USBHS controller.
> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be co=
nnected
> +			to PCI EHCI/OHCI; otherwise, it will be connected to the
> +			USBSS controller (xHCI).

I wonder if these two properties should be taken care by pinctrl
framework instead.

> +
> +Example (Lager board):
> +
> +	usb-phy@e6590100 {
> +		compatible =3D "renesas,usb-phy-r8a7790";
> +		reg =3D <0 0xe6590100 0 0x100>;
> +		clocks =3D <&mstp7_clks R8A7790_CLK_HSUSB>;
> +		clock-names =3D "usbhs";
> +		renesas,channel2-pci;
> +	};
> Index: usb/drivers/usb/phy/phy-rcar-gen2-usb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb.orig/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ usb/drivers/usb/phy/phy-rcar-gen2-usb.c
> @@ -1,8 +1,8 @@
>  /*
>   * Renesas R-Car Gen2 USB phy driver
>   *
> - * Copyright (C) 2013 Renesas Solutions Corp.
> - * Copyright (C) 2013 Cogent Embedded, Inc.
> + * Copyright (C) 2013-2014 Renesas Solutions Corp.
> + * Copyright (C) 2013-2014 Cogent Embedded, Inc.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/usb-rcar-gen2-phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> @@ -167,6 +168,37 @@ out:
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
> =20
> +#ifdef CONFIG_OF
> +static struct rcar_gen2_phy_platform_data *
> +rcar_gen2_usb_phy_parse_dt(struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct rcar_gen2_phy_platform_data *pdata;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	pdata->chan0_pci =3D of_property_read_bool(np, "renesas,channel0-pci");
> +	pdata->chan2_pci =3D of_property_read_bool(np, "renesas,channel2-pci");
> +
> +	return pdata;
> +}
> +
> +static const struct of_device_id rcar_gen2_usb_phy_match_table[] =3D {
> +	{ .compatible =3D "renesas,usb-phy-r8a7790" },
> +	{ .compatible =3D "renesas,usb-phy-r8a7791" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rcar_gen2_usb_phy_match_table);
> +#else
> +static inline struct rcar_gen2_phy_platform_data *
> +rcar_gen2_usb_phy_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -177,7 +209,10 @@ static int rcar_gen2_usb_phy_probe(struc
>  	struct clk *clk;
>  	int retval;
> =20
> -	pdata =3D dev_get_platdata(dev);
> +	if (dev->of_node)
> +		pdata =3D rcar_gen2_usb_phy_parse_dt(dev);
> +	else
> +		pdata =3D dev_get_platdata(dev);
>  	if (!pdata) {
>  		dev_err(dev, "No platform data\n");
>  		return -EINVAL;
> @@ -236,6 +271,7 @@ static int rcar_gen2_usb_phy_remove(stru
>  static struct platform_driver rcar_gen2_usb_phy_driver =3D {
>  	.driver =3D {
>  		.name =3D "usb_phy_rcar_gen2",
> +		.of_match_table =3D of_match_ptr(rcar_gen2_usb_phy_match_table),
>  	},
>  	.probe =3D rcar_gen2_usb_phy_probe,
>  	.remove =3D rcar_gen2_usb_phy_remove,

--=20
balbi

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTFLFqAAoJEIaOsuA1yqREEqMP/3GRwLyUq1TWonB1wd324Lrj
1hAJMFVHv+nQtpx5e4A2EKdcVGJWZlOuBuGjySYG+PgBCWpBMhrV8kz0IJtC+LoS
ietBzG6j7qAAZEGgUGqQ4YsoKxXg94iVzmPZMhnXzJPl/KICaGgqOgaCibpoQOIo
V4kqKNta4VY7Yfju1ATui73X0j3nTI750MVODbCqdxBw56rJZsQmDLXygaN4KLfB
eirat+IUwKMVauivrdklwQ9Mx5vFxn1bYY24hqRYq0Obkk5Q11N9m8GqKuGA2rBP
KlQfVz56pZDQI0LWmCQ+8p+ZinjixRXtQ04j9eVIkoNuVBZAH3Cy9Qx/cNzT4alg
zkXrJCTFC5OFqBUnu6VsuRqOwkF3EvitfZvQdBQD0uuA+d5Nsc3TrK8Ra2xenJPA
YrWITCUxakxsrWh60J46sPxJRBd5MwqwTLsb+BmITEFhGdhaPv2SJEyTEgzwuo7k
5/xNa9NWgqr1knsOA0pH6ItY90brmlVYY9NCjIz2maOfdqdMXw+b7E7qSJcPkCRW
qHvHsWGxHbI/+HMdD4XMaXHtJJCYOF2Ah1CxnG/Lg3rGzUJPqBWc4SlVGtMJkoMG
wjzcgNsh5LrEcZcViqvCIA6Xi9UerMalbtNaVEO92xDuQsCGrQRU0mhAKI3mGuVT
ceXn/106sPl9C1HszYUY
=HdyP
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
