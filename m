From: Felipe Balbi <balbi@ti.com>
Date: Mon, 27 Jan 2014 15:33:22 +0000
Subject: Re: [PATCH] phy-rcar-usb-gen2: add device tree support
Message-Id: <20140127153322.GB13268@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xgyAXRrhYN0wYx8y"
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk>
 <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 26, 2014 at 05:05:01PM +0000, Ben Dooks wrote:
> Add support for the phy-rcar-gen2-usb driver to be probed from device tre=
e.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
> Fixes from v2:
> 	- fix missing of_if patch
> (I clearly should not be let near git-rebase when hungry)
>=20
> Fixes from v1:
> 	- use of_property_reasd-bool()
> 	- remove unused of_id variable
>=20
> Cc: linux-usb@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: devicetree@vger.kernel.org

it's a good practice to Cc maintainers ;-)

patch looks good to me, but I'd like to get an Ack from one of DT
maintainers

> ---
>  drivers/usb/phy/phy-rcar-gen2-usb.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rc=
ar-gen2-usb.c
> index db3ab34..e4665b9 100644
> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/usb-rcar-gen2-phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/of_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/usb/otg.h>
> =20
> @@ -167,6 +168,12 @@ out:
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
> =20
> +static struct of_device_id rcar_gen2_usb_phy_ofmatch[] =3D {
> +	{ .compatible =3D "renesas,usb-phy-r8a7790", },
> +	{ .compatible =3D "renesas,rcar-gen2-usb-phy", },
> +	{ },
> +};
> +
>  static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -178,7 +185,7 @@ static int rcar_gen2_usb_phy_probe(struct platform_de=
vice *pdev)
>  	int retval;
> =20
>  	pdata =3D dev_get_platdata(&pdev->dev);
> -	if (!pdata) {
> +	if (!pdata && !dev->of_node) {
>  		dev_err(dev, "No platform data\n");
>  		return -EINVAL;
>  	}
> @@ -203,16 +210,29 @@ static int rcar_gen2_usb_phy_probe(struct platform_=
device *pdev)
>  	spin_lock_init(&priv->lock);
>  	priv->clk =3D clk;
>  	priv->base =3D base;
> -	priv->ugctrl2 =3D pdata->chan0_pci ?
> -			USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
> -	priv->ugctrl2 |=3D pdata->chan2_pci ?
> -			USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
>  	priv->phy.dev =3D dev;
>  	priv->phy.label =3D dev_name(dev);
>  	priv->phy.init =3D rcar_gen2_usb_phy_init;
>  	priv->phy.shutdown =3D rcar_gen2_usb_phy_shutdown;
>  	priv->phy.set_suspend =3D rcar_gen2_usb_phy_set_suspend;
> =20
> +	if (dev->of_node) {
> +		if (of_property_read_bool(dev->of_node, "renesas,usb0-hs"))
> +			priv->ugctrl2 =3D USBHS_UGCTRL2_USB0_HS;
> +		else
> +			priv->ugctrl2 =3D USBHS_UGCTRL2_USB0_PCI;
> +
> +		if (of_property_read_bool(dev->of_node, "renesas,usb2-ss"))
> +			priv->ugctrl2 |=3D USBHS_UGCTRL2_USB2_SS;
> +		else
> +			priv->ugctrl2 |=3D USBHS_UGCTRL2_USB2_PCI;
> +	} else {
> +		priv->ugctrl2 =3D pdata->chan0_pci ?
> +			USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
> +		priv->ugctrl2 |=3D pdata->chan2_pci ?
> +			USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
> +	}
> +
>  	retval =3D usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
>  	if (retval < 0) {
>  		dev_err(dev, "Failed to add USB phy\n");
> @@ -236,6 +256,7 @@ static int rcar_gen2_usb_phy_remove(struct platform_d=
evice *pdev)
>  static struct platform_driver rcar_gen2_usb_phy_driver =3D {
>  	.driver =3D {
>  		.name =3D "usb_phy_rcar_gen2",
> +		.of_match_table =3D rcar_gen2_usb_phy_ofmatch,
>  	},
>  	.probe =3D rcar_gen2_usb_phy_probe,
>  	.remove =3D rcar_gen2_usb_phy_remove,
> --=20
> 1.8.5.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS5nxCAAoJEIaOsuA1yqRE6QoQAKIdILc8lpJVaUT5GdplIDDH
H8AAeZODdFPE24R8UmA8Ok9uwH8CLg4YBPfxVbm0JZmNgIYU++xY6REeKAcxTre3
Dhh9o+oH0NYnzQCZHXC8DVGFlsCqGMaf2cFayMj52UGzm2aWOfAfu30KH7LWBO2M
Bo8bM+h0VhZNcnV+RrM2iHiBiZnFrYQq6y23m4qj2jifzGkvTr2RAHYPBtx6TzZn
LiL3iD8bdtouNcaVXTFlMwTeyKKgwHEQceD+IpkiJGBT2ENZjIt4Bf7FjkjMsyQu
uhFbebWAeBtdIwyCalEDV/etCMVx/lYAqesEwMubXxpC/9O8dtY78EBOxZTGE2gp
uSdqRSuZ7PaQRSV2w9gMtSX2dBWXx4oFYSXNOm/xRH/+BnHgpYeZzdAvpSrP3MD8
wgrgBK4sFRZLIOoARhSXieCbf/UpqIoAR/rnGIUNjhdCwkfOLs6OW/sW991sJfQY
X/GjZqIFuzupRsMyNydy+SSckz1mLAX/Rcjj49zSQH8LR0YmSZUxP1kfZtjJB5+5
kW8LPNoCobHknHFXL13XedCWCX996pIcGbVQcCVneNXghAyIFxcZ1tUUCxsOTKHq
oYTBBMMV2zjync2Ro3ShYMEiNcd414XvAPpCzOG9Pn+fe/OLU1Qu+O0Z4IKKVYzW
MHqoXsdvl37mSV0PmVqH
=dWWF
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
