From: Felipe Balbi <balbi@ti.com>
Date: Tue, 30 Apr 2013 10:42:09 +0000
Subject: Re: [PATCH v6 9/9] rcar-phy: handle platform data
Message-Id: <20130430104209.GF12161@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pyE8wggRBhVBcj8z"
List-Id: <linux-sh.vger.kernel.org>
References: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2013 at 07:42:07PM +0400, Sergei Shtylyov wrote:
> Set the USBPCTRL0 register from the passed platform data in rcar_usb_phy_=
init();
> don't reset it to 0 in  rcar_usb_phy_shutdown()  anymore as that does not=
 make
> sense.  Also, don't allow the driver's probe to succeed when the platform=
 data
> are not supplied with a device.
>=20
> The patch has been tested on the Marzen and BOCK-W boards.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Felipe Balbi <balbi@ti.com>

> Index: renesas/drivers/usb/phy/rcar-phy.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- renesas.orig/drivers/usb/phy/rcar-phy.c
> +++ renesas/drivers/usb/phy/rcar-phy.c
> @@ -11,10 +12,11 @@
> =20
>  #include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/usb/otg.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
> +#include <linux/usb/otg.h>

trailing change here. Please just mention it on the commit log. It
doesn't a patch of its own :-p

> @@ -89,8 +112,21 @@ static int rcar_usb_phy_init(struct usb_
>  		/* (4) USB-PHY reset clear */
>  		iowrite32(PHY_ENB | PLL_ENB | PHY_RST, (reg0 + USBPCTRL1));
> =20
> -		/* set platform specific port settings */
> -		iowrite32(0x00000000, (reg0 + USBPCTRL0));
> +		/* Board specific port settings */
> +		val =3D 0;
> +		if (pdata->port1_func)
> +			val |=3D PORT1;
> +		if (pdata->penc1)
> +			val |=3D PENC;
> +		for (i =3D 0; i < 3; i++) {
> +			/* OVCn bits follow each other in the right order */
> +			if (pdata->ovc_pin[i].select_3_3v)
> +				val |=3D OVC0 << i;
> +			/* OVCn_ACT bits are spaced by irregular intervals */
> +			if (pdata->ovc_pin[i].active_high)
> +				val |=3D ovcn_act[i];
> +		}
> +		iowrite32(val, (reg0 + USBPCTRL0));

not all architectures provide iowrite32(). Please make sure your driver
builds on x86 and ARM by using SHOW_ALL_DRIVERS (on Kconfig).

BTW, conversion away from iowrite32() could (should) be part of a
separate patch. No need to prevent this one from being applied.

--=20
balbi

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRf6ABAAoJEIaOsuA1yqREwx0P/AwOdSCZ2k3Q+Y+hxRaY9MXY
1DlDWWG2HGf3VPL7/Bmuok0WI0Ch9wuooDNDd+EhtPsoCsxZiHxJKZP7jkrR9H0p
Hhaf7VuNMiN3Id9ME6PNACzpFjtQ3dCFWjzsdPAzPkzLxPGMfEM0hMswMH4HHfQs
HkBoZf566kcU7f+Fbw6IAvpnD6rQssBlkmWU6zgCE41iAYmsTk44lqCjYbkcjNrY
YDr4dD2bBf3l+X6wM7LFgnSwCke7Y8b+0JrMZkK6tC8hvCzKk/dR1K8Y3NOt+R05
plulqO9/ExR0sgpA9gKjDMbBGs/yeEjj+7vM1JRb55FBDawAvrtbjmbOLoK38R2I
vjp7lJP2k2ZtEijrEdv5DNVYJL68preCiaGcsg+ZBg+3ailHvncYdg/0mcKyUe7O
N4WCui2G7qteu179RVTQRkHYFH5L5uf9d6OCl6ICvRFO28grmB8+IN9QfjP5RR98
fr/m7fK/oY50K0qGaGiJu0BHSZZj2XMEYXCtArEK8uMFd8V7DamYBiIsBuRahUeV
62KaEPqqk2gHkJMIchP+s5VFbLifFMTiGk5MESgIilMgexDrfPo3fENfM0EiroSP
0W0HZdIMHIUZMy5SH4MvqsD5ybziyr2zii94lPNfIIpkb6eEQzYb0OiwyJs8QYxp
YwORjUCUKFTbzRTq+5Dz
=knUV
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
