From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 09:00:34 +0000
Subject: Re: [PATCH v3 7/9] rcar-phy: add platform data
Message-Id: <20130410090034.GO7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MWF3YmTHhoLNIVQC"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--MWF3YmTHhoLNIVQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 02:37:49AM +0400, Sergei Shtylyov wrote:
> Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong sin=
ce this
> register contains board-specific USB ports configuration and so its value=
 should
> be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> file=
 with
> the USBPCTRL0 bit #define's and 'struct rcar_phy_platform_data' containin=
g the
> value to be set by the driver to that register.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> ---
> Changes since version 2:
> - added #include <linux/types.h>;
> - added ACKs from Simon Horman and Kuninori Morimoto.
>=20
>  include/linux/usb/rcar-phy.h |   40 ++++++++++++++++++++++++++++++++++++=
++++
>  1 file changed, 40 insertions(+)
>=20
> Index: renesas/include/linux/usb/rcar-phy.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ renesas/include/linux/usb/rcar-phy.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __RCAR_PHY_H
> +#define __RCAR_PHY_H
> +
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +
> +/* USBPCTRL0 register bits */
> +#define USBPCTRL0_OVC2	BIT(10)	/* Switches the OVC input pin for port 2:=
 */
> +				/* 1: USB_OVC2, 0: OVC2			*/
> +#define USBPCTRL0_OVC1_VBUS1 BIT(9) /* Switches the OVC input pin for po=
rt 1: */
> +				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
> +#define USBPCTRL0_OVC0	BIT(8)	/* Switches the OVC input pin for port 0: =
*/
> +				/* 1: USB_OVC0 pin, 0: OVC0		*/
> +#define USBPCTRL0_OVC2_ACT BIT(6) /* Host mode: OVC2 polarity:		*/
> +				/* 1: active-high, 0: active-low	*/
> +				/* Function mode: be sure to set to 1	*/
> +#define USBPCTRL0_PENC	BIT(4)	/* Function mode: output level of PENC1 pi=
n: */
> +				/* 1: high, 0: low			*/
> +#define USBPCTRL0_OVC0_ACT BIT(3) /* Host mode: OVC0 polarity:		*/
> +				/* 1: active-high, 0: active-low	*/
> +#define USBPCTRL0_OVC1_ACT BIT(1) /* Host mode: OVC1 polarity:		*/
> +				/* 1: active-high, 0: active-low	*/
> +				/* Function mode: be sure to set to 1	*/
> +#define USBPCTRL0_PORT1	BIT(0)	/* Selects port 1 mode:			*/
> +				/* 1: function, 0: host			*/
> +
> +struct rcar_phy_platform_data {
> +	u32 usbpctrl0;		/* USBPCTRL0 register value */
> +};

looks really wrong to me to pass register contents via pdata. You should
pass flags which would aid the driver into figuring out how to program
that register.

--=20
balbi

--MWF3YmTHhoLNIVQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSoyAAoJEIaOsuA1yqREGucP/14Bztz8U+/8NKeOoeQZ1Qx8
cR7FhFLLvuOk6yEOI04zN/jgU1QK1Oi63/SQwDIpBuFnQoUR3ob/2X973lqWIHSH
LnFXaFa54izdkasCk8vsoAjkkZOaiif+BYiIRhr/e8vdHA5//Njiy/DVfjybI1Kc
LqiEqmXXS+affgkVdW9Ap5OxKv7p5yynbzFQFiPzEDolt94FDKVQwXxqPrqkJkdy
hD4ErZYUIAwap41bEEiVcpT7YKhL+nJLIG8i69vIKTqcyS6o+KSmd94ymeAI5W+L
4aRLekQVMFnmrYcCF792FlP3yNnNYA6QCnH3VG+2/Llgq9KodN3J4kHsiPCsN+Fl
hB5YYX8Rg8TDlTfKB15rcq6sUUNEjJNdeiCofBmInzBblAQkNtVYZ7GfdXBM575i
EI0euqQiy0OSqeHpZiMUR4+BBlA1CssBUpUcaesnXhbncVXhbWnejqYRMQzX9MTE
imhh/LEeE8H/Wnzaw4vISpS5hAV9vtr7GoQ+GYk4zqjue8p9AH9Tb/fkzzan2gQc
f0Fiw8vqVDNn+VnVnM1u59Qi9uO+CZ2B5NH7eaXnOCSJVNCmkdnAXR3HJ67iID2c
oxqHNL6CWnVXECKKT3Yaj5i5ZgCS0LPojhZwpRJbC0A9QE4XtQzlKFM8/9iRtHRv
+0KczrF5zx+6dLp676tH
=9qHL
-----END PGP SIGNATURE-----

--MWF3YmTHhoLNIVQC--
