From: Felipe Balbi <balbi@ti.com>
Date: Wed, 06 Nov 2013 15:45:17 +0000
Subject: Re: [RFC PATCH 1/2] usb: hcd: Remove USB phy if needed
Message-Id: <20131106154517.GL24322@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z87VqPJ/HsYrR2WM"
List-Id: <linux-sh.vger.kernel.org>
References: <1383683607-28119-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383683607-28119-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--z87VqPJ/HsYrR2WM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 06, 2013 at 12:33:26AM +0400, Valentine Barshak wrote:
> This adds remove_phy flag to the HCD structure. If the flag is
> set and if hcd->phy is valid, the phy is shutdown and released
> whenever usb_add_hcd fails or usb_hcd_remove is called.
> This can be used by the HCD drivers to auto-remove
> the external USB phy when it is no longer needed.
>=20
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/usb/core/hcd.c  | 14 +++++++++++++-
>  include/linux/usb/hcd.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index d6a8d23..d939521 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -43,6 +43,7 @@
> =20
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/phy.h>
> =20
>  #include "usb.h"
> =20
> @@ -2611,7 +2612,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	 */
>  	if ((retval =3D hcd_buffer_create(hcd)) !=3D 0) {
>  		dev_dbg(hcd->self.controller, "pool alloc failed\n");
> -		return retval;
> +		goto err_remove_phy;
>  	}
> =20
>  	if ((retval =3D usb_register_bus(&hcd->self)) < 0)
> @@ -2742,6 +2743,12 @@ err_allocate_root_hub:
>  	usb_deregister_bus(&hcd->self);
>  err_register_bus:
>  	hcd_buffer_destroy(hcd);
> +err_remove_phy:
> +	if (hcd->remove_phy && hcd->phy) {
> +		usb_phy_shutdown(hcd->phy);
> +		usb_put_phy(hcd->phy);
> +		hcd->phy =3D NULL;
> +	}

why do you need the flag at all ? If hcd->phy is valid, just casll
usb_phy_shutdown() followed by usb_put_phy(). Did you find any issues
with that ?

--=20
balbi

--z87VqPJ/HsYrR2WM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSemQNAAoJEIaOsuA1yqRErtkQAJJFoUQ69o/bpiThb/coecJX
jIEKGr5AK0BpPoR1Px8K9mb/F7yi24pKOEsQQb7G0zueNeqVQE7MxJF1aXgaMCPY
2GZS0QWbValyKeF4+OTda+p0dVaUmYA8IU33qoZO8q31n5+cYo3MUlKDX8jbLbnq
kPngdVMgvMenxrlY2pFzkAtVzdjkU06wQ1yzZQrDeAk4S+c2pAg5aIdMA4U/+DgD
hhtvIMSp8F3dSW0sFXLc0ICXS5zsmR/TUucC1tmq7h8KUOeOCOz5bWfPGXA3ONLx
PJ0O9O8S2jhCP/7kFYFO0GdZxbKrad2rR3SHjUwdcLCq2+06uNdc0EyHX/8JV0m3
KmEnpvwEXrFGftQFC15iUQO+6tsGMSuvcLLmgXvw3xP3IWNrXBTYeddehKIKnKFW
hWJYcW4CSxtREE7kh6qD1HIVLUMjdxVobCYnGwjbfmIrknhO7LGM0aD6UzRie4/B
VzHSk61roCm/X/n8eJDQBGnO9eEGvK+FHVTkOrEr52RETNKxjjZ432nqiwPIAJtR
XJZ6a1Q7pSCeHvUg8LdIfKy788S4d1fdHvTLlzxRiwZSWSiNP4nJT6+H1u6PjpVc
0cffi5+r2rG94YvY/pAz35aYaY6hg3PJTSYW8rFLVEBVNerUA+3qNv56bkNhVpD5
4i4jP10EsdSe7au0Sf0C
=ts0K
-----END PGP SIGNATURE-----

--z87VqPJ/HsYrR2WM--
