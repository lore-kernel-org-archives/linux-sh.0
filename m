From: Felipe Balbi <balbi@ti.com>
Date: Tue, 07 Oct 2014 14:09:07 +0000
Subject: Re: [PATCH v2 3/3] usb: renesas_usbhs: add support for generic PHY
Message-Id: <20141007140907.GC24720@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="adJ1OR3c6QgCpb/j"
List-Id: <linux-sh.vger.kernel.org>
References: <1412653386-5856-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412653386-5856-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 07, 2014 at 12:43:06PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for the generic PHY. The generic PHY will be
> used in multiplatform environment.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Kishon, does this look ok to you ?

> ---
>  drivers/usb/renesas_usbhs/common.h |    1 +
>  drivers/usb/renesas_usbhs/rcar2.c  |   29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usb=
hs/common.h
> index e0d53c5..c45667f 100644
> --- a/drivers/usb/renesas_usbhs/common.h
> +++ b/drivers/usb/renesas_usbhs/common.h
> @@ -270,6 +270,7 @@ struct usbhs_priv {
>  	struct usbhs_fifo_info fifo_info;
> =20
>  	struct usb_phy *usb_phy;
> +	struct phy *phy;
>  };
> =20
>  /*
> diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbh=
s/rcar2.c
> index 485b889..8fc15c0 100644
> --- a/drivers/usb/renesas_usbhs/rcar2.c
> +++ b/drivers/usb/renesas_usbhs/rcar2.c
> @@ -12,6 +12,7 @@
> =20
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
> +#include <linux/phy/phy.h>
>  #include <linux/platform_data/gpio-rcar.h>
>  #include <linux/usb/phy.h>
>  #include "common.h"
> @@ -21,6 +22,16 @@ static int usbhs_rcar2_hardware_init(struct platform_d=
evice *pdev)
>  {
>  	struct usbhs_priv *priv =3D usbhs_pdev_to_priv(pdev);
> =20
> +	if (IS_ENABLED(CONFIG_GENERIC_PHY)) {
> +		struct phy *phy =3D phy_get(&pdev->dev, "usb");
> +
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		priv->phy =3D phy;
> +		return 0;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_USB_PHY)) {
>  		struct usb_phy *usb_phy =3D usb_get_phy_dev(&pdev->dev, 0);
> =20
> @@ -38,6 +49,11 @@ static int usbhs_rcar2_hardware_exit(struct platform_d=
evice *pdev)
>  {
>  	struct usbhs_priv *priv =3D usbhs_pdev_to_priv(pdev);
> =20
> +	if (priv->phy) {
> +		phy_put(priv->phy);
> +		priv->phy =3D NULL;
> +	}
> +
>  	if (priv->usb_phy) {
>  		usb_put_phy(priv->usb_phy);
>  		priv->usb_phy =3D NULL;
> @@ -52,6 +68,19 @@ static int usbhs_rcar2_power_ctrl(struct platform_devi=
ce *pdev,
>  	struct usbhs_priv *priv =3D usbhs_pdev_to_priv(pdev);
>  	int retval =3D -ENODEV;
> =20
> +	if (priv->phy) {
> +		if (enable) {
> +			retval =3D phy_init(priv->phy);
> +
> +			if (!retval)
> +				retval =3D phy_power_on(priv->phy);
> +		} else {
> +			phy_power_off(priv->phy);
> +			phy_exit(priv->phy);
> +			retval =3D 0;
> +		}
> +	}
> +
>  	if (priv->usb_phy) {
>  		if (enable) {
>  			retval =3D usb_phy_init(priv->usb_phy);
> --=20
> 1.7.9.5
>=20

--=20
balbi

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUM/QDAAoJEIaOsuA1yqRENSoP/2LwC21ap+CBii8icdaUnfjG
Wko4Z2VWIiQKAAOdVTnzCgck/AfEs064y9m0z0Dwd1w3a10nIxw5kB8eEmwmWdgA
suIu9cJltFccDQF6PR5Jb09AOMpf4AeTJ1nTTzPXOzmeKSEoGcXZDZp/jz0WQNBr
K0a71o92Sg2kcUtBOmAwx7fEccReKlBk8k8is2H4C6Ji0u41m3RktYmOPKZ/5+pe
/coqvqWIDH2UTstUpN1rWuZEJu0dnNUdMipQY/yf5SGizoi8UhjfGxwKo8Td568M
jfChRfM+69O/nJkdO8PRNUXMyh3ZmKYa/iVneW+8TCXJHSB0orEZp3grAW0tVWdS
c0zqBKIrwSCsmHkMTcAICeb98gwMu5v3u6avlaJJ/shdxsefWqW3J46Pai5FI4cT
IFUQYjSDihPnaMm8iEmuWqzPmjkPLS6Kyj7Wyy31ZlM8DkkgVIv0QM/fFt7OiOK1
nGsz6CciIvv+GM31agpM0p6l0OwJ1bXfUocvp/oCz7QjDdVmFyCkdDA3O5VSaiTl
QKOZDDey2r4o7trK1xB4CBcyXfOoEkVAEn9ZqXdAatBGiUwRHE6hVtxYl9R9usr/
0J0zWB+U6DNRFzBltEPtlWger6s2BA9dnjbohGxR7AjSA/xEBWqXs+KWIY1Jyz8X
/jiwZ5UMreS1PXhqLyme
=KVOE
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
