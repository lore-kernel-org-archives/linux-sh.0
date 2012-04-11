From: Felipe Balbi <balbi@ti.com>
Date: Wed, 11 Apr 2012 09:35:48 +0000
Subject: Re: [PATCH] usb: r8a66597-udc: add support for set_selfpowered
Message-Id: <20120411093546.GI12064@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MPkR1dXiUZqK+927"
List-Id: <linux-sh.vger.kernel.org>
References: <4F62BD24.2060607@renesas.com>
In-Reply-To: <4F62BD24.2060607@renesas.com>
To: linux-sh@vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 01:10:12PM +0900, Shimoda, Yoshihiro wrote:
> The previous code always set to USB_DEVICE_SELF_POWERED in GET_STATUS.
> So, this patch adds set_selfpowered().
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/gadget/r8a66597-udc.c |   16 +++++++++++++++-
>  drivers/usb/gadget/r8a66597-udc.h |    1 +
>  2 files changed, 16 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66=
597-udc.c
> index c4401e7..683b3d2 100644
> --- a/drivers/usb/gadget/r8a66597-udc.c
> +++ b/drivers/usb/gadget/r8a66597-udc.c
> @@ -1170,7 +1170,7 @@ __acquires(r8a66597->lock)
>=20
>  	switch (ctrl->bRequestType & USB_RECIP_MASK) {
>  	case USB_RECIP_DEVICE:
> -		status =3D 1 << USB_DEVICE_SELF_POWERED;
> +		status =3D r8a66597->device_status;
>  		break;
>  	case USB_RECIP_INTERFACE:
>  		status =3D 0;
> @@ -1800,11 +1800,25 @@ static int r8a66597_pullup(struct usb_gadget *gad=
get, int is_on)
>  	return 0;
>  }
>=20
> +static int r8a66597_set_selfpowered(struct usb_gadget *gadget, int is_se=
lf)
> +{
> +	struct r8a66597 *r8a66597 =3D gadget_to_r8a66597(gadget);
> +	unsigned long flags;

compile warning here. Did you even test this patch ???

> +
> +	if (is_self)
> +		r8a66597->device_status |=3D 1 << USB_DEVICE_SELF_POWERED;
> +	else
> +		r8a66597->device_status &=3D ~(1 << USB_DEVICE_SELF_POWERED);
> +
> +	return 0;
> +}
> +
>  static struct usb_gadget_ops r8a66597_gadget_ops =3D {
>  	.get_frame		=3D r8a66597_get_frame,
>  	.udc_start		=3D r8a66597_start,
>  	.udc_stop		=3D r8a66597_stop,
>  	.pullup			=3D r8a66597_pullup,
> +	.set_selfpowered	=3D r8a66597_set_selfpowered,
>  };
>=20
>  static int __exit r8a66597_remove(struct platform_device *pdev)
> diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66=
597-udc.h
> index 8e3de61..8b855a8 100644
> --- a/drivers/usb/gadget/r8a66597-udc.h
> +++ b/drivers/usb/gadget/r8a66597-udc.h
> @@ -111,6 +111,7 @@ struct r8a66597 {
>  	u16			old_vbus;
>  	u16			scount;
>  	u16			old_dvsq;
> +	u16			device_status;	/* for GET_STATUS */
>=20
>  	/* pipe config */
>  	unsigned char bulk;
> --=20
> 1.7.1

--=20
balbi

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhVByAAoJEIaOsuA1yqRE36YP/23mLOpgjHs1ZR1wFQDs/6IO
Z1JEZoDYS8UOQR0UXPGPsNpKI+NZA53pyIxqxzREl3PCuKWnaJ7NxOHIVs0S5oMn
WOB+hDyyu6Sipcgl6q7YCzwR8G4BESyLx4cj58DWlwUZwiOrWivr0heo/XpI13HG
RV0kQAsEkPBRqcrZW2vbGMvXRTZT6JEWpZVtxbgfH2HguvfZM0Xuwa/ugDHBw0s2
eQLc1kEq1leDcXLe54qtIh7SNm0dH+Rsi1yA9Yu5UqhX8BPkttgtxyh82rVmBNXt
Chpc/a0sWPqxCmBVGAlrFp4v6qD1TyrmdX6G6USFs5cztQjKE+tgSt3HzpoSAE2V
sNI5yA64JHlkA3gMmhyJfCcHhzcbCU82e3WoUjYzb2kg8PY29nDpJ0S2X0h/PYky
uMmrSDM9r+pjDWj+lsMMdBtdJd0lJXG+fcGDZ2MOgZbPDKqdj3yduu2cH9eH8+0+
vjM9pS7Cp/GfH4JR/ZrAjBdXhy5ZIKtl0DLbJfZPfJIMTjFlGSx923y7LgPKGYbT
xAgMw96KMv2eojY2xW+pqg1vk+91c9mj95SNvlZiTtvYzRCE8CysLtSA28SFZxco
EYqAKyH7sDaNo6rD9h9GGg5WfabWJ1Axz4pPPl6wLNdUX/8zhIcO24Z9MBPubTYR
PrCvLJ0uC7w5UEgRFOkT
=A4tr
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
