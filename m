From: Felipe Balbi <balbi@ti.com>
Date: Wed, 06 Nov 2013 15:47:28 +0000
Subject: Re: [RFC PATCH 2/2] usb: hcd: Introduce CONFIG_USB_HCD_EXTERNAL_PHY option
Message-Id: <20131106154728.GM24322@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xJjS+Ds6jmpBvWv0"
List-Id: <linux-sh.vger.kernel.org>
References: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--xJjS+Ds6jmpBvWv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 06, 2013 at 12:33:27AM +0400, Valentine Barshak wrote:
> This adds external USB phy support to USB HCD driver that
> allows to find and initialize external USB phy, bound to
> the HCD when the HCD is added.
> The usb_add_hcd function returns -EPROBE_DEFER if the USB
> phy, bound to the HCD, is not ready.
> If no USB phy is bound, the HCD is initialized as usual.
>=20
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/usb/core/hcd.c   | 20 ++++++++++++++++++++
>  drivers/usb/host/Kconfig | 11 +++++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index d939521..da9c4ba 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2597,6 +2597,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	int retval;
>  	struct usb_device *rhdev;
> =20
> +#ifdef CONFIG_USB_HCD_EXTERNAL_PHY

I think here would be a nicer location for a flag:

if (hcd->has_external_phy) {
	phy =3D usb_get_phy_dev();

	....
}

that flag would get set by the glue driver (ehci-omap, ehci-msm,
ohci-omap, etc), where necessary.

--=20
balbi

--xJjS+Ds6jmpBvWv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSemSQAAoJEIaOsuA1yqREoP8P/2r5M3bLXW95KMktaDg6gY0J
BUbevMZBNQDXEUb8Cnqa153mE//4eyG+ccTmpyILZChC91vk3i8OQxe87nN4lsJm
f8sfyaZwGHJ5wkv8QX5mDdzPsRrFJRwkzC3g4TQINy0pyliB0CfgLb3Zmn2DD1uq
SvD3XQcZwJJLqH58OgQVrQ/MQVKk0u/xaUW1/QOFJfsP8yt9k6pcPZ8RpmNM5k0I
vS0rGmr5gyXLbzVT/pjWDPnA3hgx4P/J1oBCKkE4oAdQeUq2Gqs5b7oune4fp1si
X+5Tg7YT00C2VYs/yVW7FCKQSmds5XMnWnZlbWIvYRWmEtfrgbSG6M3BXqw2DNq5
kokT9xlr/XbjVh5QII7hK+6FtdZN8WNLXFpTysAGemnBPSfR/DrXWjCUKf+XBXet
7zTS5N05pmUE5Fx4z7Nqt6mRIwKE4d8k+5D1CwlDxJ90HbZ0uLVcRaLs9T8C8fBI
QRxU4aLBWRsf79x19z8w7Kc+m6ZPCy5j7Q15O+tGbtwQg7tLPAoBz80+fzJqKVQT
DlZvzPig+i37gZXFLc3pCVv36Ns47i0TGzc9Xy9M5uS7dGoSCN/DpVW0oNfDHkZQ
daGY/NZZjwdJ3GWd3LOFft+6qr4Fja3fS761txB2rUFIzF+HuL4G5HS8SCN2V8/c
rh2OugFNwhexIF+R0VHq
=mfe6
-----END PGP SIGNATURE-----

--xJjS+Ds6jmpBvWv0--
