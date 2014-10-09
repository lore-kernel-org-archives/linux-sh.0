From: Felipe Balbi <balbi@ti.com>
Date: Thu, 09 Oct 2014 14:14:26 +0000
Subject: Re: [PATCH] usb: host: xhci-plat: fix suspend/resume on xhci-rcar
Message-Id: <20141009141426.GA16002@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
List-Id: <linux-sh.vger.kernel.org>
References: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 01:45:47PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes an issue that suspend/resume cannot work correctly
> on xhci-rcar because the xhci driver output the following log:
>=20
>         xhci-hcd ee000000.usb: WARN: xHC CMD_RUN timeout
>=20
> So, this patch adds to set the XHCI_SLOW_SUSPEND quirk if xhci-rcar.

do you have erratum number confirming this is needed for your platform ?
We really don't want to enable quirks just because they help, we need to
be sure HW is quirky. For example, we triggered the same thing on DRA7xx
(which uses dwc3) but after digging a little, it seems like we're having
memory access latency issues, not a problem with XHCI.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the Greg's usb.git / usb-next branch.
>  (commit id : 4ed9a3d455558406cad83d38764ee659de25851c)
>=20
>  drivers/usb/host/xhci-plat.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 3d78b0c..a266883 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -27,12 +27,18 @@ static struct hc_driver __read_mostly xhci_plat_hc_dr=
iver;
> =20
>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>  {
> +	struct device_node *of_node =3D dev->of_node;

add also a blank line here.

>  	/*
>  	 * As of now platform drivers don't provide MSI support so we ensure
>  	 * here that the generic code does not try to make a pci_dev from our
>  	 * dev struct in order to setup MSI
>  	 */
>  	xhci->quirks |=3D XHCI_PLAT;
> +
> +	/* QUIRK: R-Car xHCI must be suspended extra slowly */

why ? Who says that ? Where's the errata document ?

> +	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
> +	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
> +		xhci->quirks |=3D XHCI_SLOW_SUSPEND;
>  }
> =20
>  /* called during probe() after chip reset completes */
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNphCAAoJEIaOsuA1yqREnk8P/1SSVXPLjfNvz5w/QTrB4LVl
AugUeVaCZr7rhGaQKt5koQfWbCBsvzztOmOp9b+k/JBEz5Bw3oYkFTdceLQWiM3v
G9RbTC4aUDCJO+V8QJvWFQZiCJyeNPK9fXQmZM8xT0ORGqGl8rJdCEiYOrQm10M1
Hwsv32lbMulpTdjZoxnF/j8KUURNV6rqDe0FXEruSWVaJCu1LjDWHmiElC2z1vlP
xT0d22JfXae+Ic3dX0dCMu7quKv9I+ByZ3SComzimmflmZ0RkvLAMFEXMLa2TGvc
ulgH1fd48+2IQGiiLi9ocOKGBsVBjlGdv5WkvV+facK9SBJCXARzdKzwiNX7hhg9
gFnAGWCV35txJwcF6HcZDMdcf+XwYxHla5eK7+TIL0HnN5smmU9DizT/iHGv6MXp
rh6S1JJrnV6A6CBx/vozYPblaiycqOOew38R2wFsn4o3zaFesFK88S0SmtjbZdhu
8Am4C3caGWfbTfG9Mn2JUkhNl9TpsGzJ9ukonr5t/7Vu+L225kqA8BxgihZG3Noy
xJtpojida4D/wd0RNxcGBj6XWuxfPPwe5ifebfziEMzeTu3gE4nxP0mrh84ze4uT
0+2r7aoeVtADDD/DynkNBM8KalVYUbUzZ9lfcMDK71ymEnCTIYdjQS0ubP66kQ1d
NYnU06lTdXFuDUUa3Nom
=4TN5
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
