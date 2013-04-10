From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 18:40:18 +0000
Subject: Re: [PATCH v3 7/9] rcar-phy: add platform data
Message-Id: <20130410184018.GD20692@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZJcv+A0YCCLh2VIg"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 09:44:33PM +0400, Sergei Shtylyov wrote:
> >>>>Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong=
 since this
> >>>>register contains board-specific USB ports configuration and so its v=
alue should
> >>>>be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> =
file with
> >>>>the USBPCTRL0 bit #define's and 'struct rcar_phy_platform_data' conta=
ining the
> >>>>value to be set by the driver to that register.
> >>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>>>Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>>Acked-by: Simon Horman <horms+renesas@verge.net.au>
> >>>>---
> >>>>Changes since version 2:
> >>>>- added #include <linux/types.h>;
> >>>>- added ACKs from Simon Horman and Kuninori Morimoto.
> >>>>  include/linux/usb/rcar-phy.h |   40 +++++++++++++++++++++++++++++++=
+++++++++
> >>>>  1 file changed, 40 insertions(+)
> >>>>Index: renesas/include/linux/usb/rcar-phy.h
> >>>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>--- /dev/null
> >>>>+++ renesas/include/linux/usb/rcar-phy.h
> >>>>@@ -0,0 +1,40 @@
> >>>>+/*
> >>>>+ * Copyright (C) 2013 Renesas Solutions Corp.
> >>>>+ * Copyright (C) 2013 Cogent Embedded, Inc.
> >>>>+ *
> >>>>+ * This program is free software; you can redistribute it and/or mod=
ify
> >>>>+ * it under the terms of the GNU General Public License version 2 as
> >>>>+ * published by the Free Software Foundation.
> >>>>+ */
> >>>>+
> >>>>+#ifndef __RCAR_PHY_H
> >>>>+#define __RCAR_PHY_H
> >>>>+
> >>>>+#include <linux/bitops.h>
> >>>>+#include <linux/types.h>
> >>>>+
> >>>>+/* USBPCTRL0 register bits */
> >>>>+#define USBPCTRL0_OVC2	BIT(10)	/* Switches the OVC input pin for por=
t 2: */
> >>>>+				/* 1: USB_OVC2, 0: OVC2			*/
> >>>>+#define USBPCTRL0_OVC1_VBUS1 BIT(9) /* Switches the OVC input pin fo=
r port 1: */
> >>>>+				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
> >>>>+#define USBPCTRL0_OVC0	BIT(8)	/* Switches the OVC input pin for port=
 0: */
> >>>>+				/* 1: USB_OVC0 pin, 0: OVC0		*/
> >>>>+#define USBPCTRL0_OVC2_ACT BIT(6) /* Host mode: OVC2 polarity:		*/
> >>>>+				/* 1: active-high, 0: active-low	*/
> >>>>+				/* Function mode: be sure to set to 1	*/
> >>>>+#define USBPCTRL0_PENC	BIT(4)	/* Function mode: output level of PENC=
1 pin: */
> >>>>+				/* 1: high, 0: low			*/
> >>>>+#define USBPCTRL0_OVC0_ACT BIT(3) /* Host mode: OVC0 polarity:		*/
> >>>>+				/* 1: active-high, 0: active-low	*/
> >>>>+#define USBPCTRL0_OVC1_ACT BIT(1) /* Host mode: OVC1 polarity:		*/
> >>>>+				/* 1: active-high, 0: active-low	*/
> >>>>+				/* Function mode: be sure to set to 1	*/
> >>>>+#define USBPCTRL0_PORT1	BIT(0)	/* Selects port 1 mode:			*/
> >>>>+				/* 1: function, 0: host			*/
> >>>>+
> >>>>+struct rcar_phy_platform_data {
> >>>>+	u32 usbpctrl0;		/* USBPCTRL0 register value */
> >>>>+};
> >>>looks really wrong to me to pass register contents via pdata. You shou=
ld
> >>>pass flags which would aid the driver into figuring out how to program
> >>>that register.
> >>    That was my first thought (and implementation) but this didn't
> >>look good either (and even worse with the device tree approach) as we
> >>couldn't come up with the clear names for the bitfields. Also, not
> >>all these bits are present in R8A7778 support for which I'm adding in
> >>the later patchset.
> >>    Besides, IMO this little differs from having a flags field with
> >>the flags bits #define'd beforehand. Or did you mean that I should
> >>have surely used *bool* bitfields?
> >How about:
>=20
>     Er, I was asking you about the platform data only, not the DT
> representation yet. :-)

easy(-ish) to translate, just needs more fields in your structure.

> >rcar {
> >	compatible ...
> >	reg...
> >
> >	/* switch OVC for all three ports */
> >	renesas,rcar-ovc-port-config =3D <2 "high",
> >					1  "low",
> >					0  "high" >;
>=20
>     Hm, 'dtc' allows mixed type properties now?
>     Also, we need to describe the multiplexing of the OVCn pins (5V
> or 3.3V input),
> not only the active level.

fair enough, it can now be pre-processed so you can have defines, then
you can:

#define PORT_HIGH	1
#define PORT_LOW	0

#define MUX_ABC		foo
#define MUX_XYZ		bar
#define MUX_MNO		baz

=2E..-port-config =3D <2 PORT_HIGH MUX_ABC,
		   1 PORT_LOW MUX_XYZ,
		   0 PORT_HIGH MUX_MNO>;

> >	renesas,rcar-port1-mode =3D "host"; /* could also be peripheral */;
>=20
>     You see, all this involves string type (and so more complex to
> deal with) props.
> We were hoping to use only boolean props, more or less corresponding
> to the register bits...

see above.

> >PENC
> >apparently doesn't anything if it always needs to be set to 1.
>=20
>    You've mixed it with some other pin -- it can be 0 or 1 in
> function mode.
>=20
> >Would this work for you ?
>=20
>     I should try... All this surely looks more complex than we would
> hope...

passing register contents will hurt you in the future if some other
device comes up with more bits or a slightly different layout and stuff
like that.

--=20
balbi

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZbIRAAoJEIaOsuA1yqREEZ0P/A+UWRuKj3qJBV1f/uRt46PF
fSj1tQN5yAeiImTvNhWyekLCoww6+l2rC0wkLRUyQtFPaYsAwNvY5tb9OcCf3M98
1VC6TirbcHhaBl8/EChHxZuZJI47rbCeLJhDIMgYvw8M3wRcHnbYHCI6710addJc
N0zDwnerLoZbB4EGt46gwdqeBgz71NIn5NEWjjhl2QBfjaA5kWlOm6xW/BKLTZRm
9ka6X7hftfNkumYHUNT3ym6CnAhn5kZ9GBf/z3gVpIetmlgYd7I2IaVyY/mP4/qR
rjBCDL6W/NN3zrK3dGj7Qur5olgL7zomyiJzb0zr7Zz/giK2ibYmqpdT8O2NSur2
um+MB6A51zwp3Wsq92/AVkkjdpiMqTGG0Xs92qxl2MTAggnA9FGrMkYLoQqbTZdb
yMlWwDAYdGRyeX1M/Ug4e3mgbQfH+AoktT3feHX2lUeXKOszV1n5N2uLoIdI8l2w
L+ehD9bAiViIL6rrIFoCTRCPU2hM5UF4EZHd1m3YQhzgsdzr/nbLYd2QljWrAV0f
JMZsuHm/HUE0rbwnsZ30jQTQzbNj2DMLXqGXq9gd5l1bpVpIpoPoip090ftytG1E
3xg1AUNrDVFGK6M0OUCthOM+b5hgpbS0qfXuN4TcARYr0WnMMFI6Jaz5LkuXXKHC
pEIntAmeCBfJo/wqfwM6
=wA0u
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
