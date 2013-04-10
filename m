From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 17:16:14 +0000
Subject: Re: [PATCH v3 7/9] rcar-phy: add platform data
Message-Id: <20130410171614.GA15173@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 06:03:49PM +0400, Sergei Shtylyov wrote:
> On 10-04-2013 13:00, Felipe Balbi wrote:
>=20
> >>Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong s=
ince this
> >>register contains board-specific USB ports configuration and so its val=
ue should
> >>be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> fi=
le with
> >>the USBPCTRL0 bit #define's and 'struct rcar_phy_platform_data' contain=
ing the
> >>value to be set by the driver to that register.
>=20
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> >>---
> >>Changes since version 2:
> >>- added #include <linux/types.h>;
> >>- added ACKs from Simon Horman and Kuninori Morimoto.
>=20
> >>  include/linux/usb/rcar-phy.h |   40 +++++++++++++++++++++++++++++++++=
+++++++
> >>  1 file changed, 40 insertions(+)
>=20
> >>Index: renesas/include/linux/usb/rcar-phy.h
> >>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>--- /dev/null
> >>+++ renesas/include/linux/usb/rcar-phy.h
> >>@@ -0,0 +1,40 @@
> >>+/*
> >>+ * Copyright (C) 2013 Renesas Solutions Corp.
> >>+ * Copyright (C) 2013 Cogent Embedded, Inc.
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License version 2 as
> >>+ * published by the Free Software Foundation.
> >>+ */
> >>+
> >>+#ifndef __RCAR_PHY_H
> >>+#define __RCAR_PHY_H
> >>+
> >>+#include <linux/bitops.h>
> >>+#include <linux/types.h>
> >>+
> >>+/* USBPCTRL0 register bits */
> >>+#define USBPCTRL0_OVC2	BIT(10)	/* Switches the OVC input pin for port =
2: */
> >>+				/* 1: USB_OVC2, 0: OVC2			*/
> >>+#define USBPCTRL0_OVC1_VBUS1 BIT(9) /* Switches the OVC input pin for =
port 1: */
> >>+				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
> >>+#define USBPCTRL0_OVC0	BIT(8)	/* Switches the OVC input pin for port 0=
: */
> >>+				/* 1: USB_OVC0 pin, 0: OVC0		*/
> >>+#define USBPCTRL0_OVC2_ACT BIT(6) /* Host mode: OVC2 polarity:		*/
> >>+				/* 1: active-high, 0: active-low	*/
> >>+				/* Function mode: be sure to set to 1	*/
> >>+#define USBPCTRL0_PENC	BIT(4)	/* Function mode: output level of PENC1 =
pin: */
> >>+				/* 1: high, 0: low			*/
> >>+#define USBPCTRL0_OVC0_ACT BIT(3) /* Host mode: OVC0 polarity:		*/
> >>+				/* 1: active-high, 0: active-low	*/
> >>+#define USBPCTRL0_OVC1_ACT BIT(1) /* Host mode: OVC1 polarity:		*/
> >>+				/* 1: active-high, 0: active-low	*/
> >>+				/* Function mode: be sure to set to 1	*/
> >>+#define USBPCTRL0_PORT1	BIT(0)	/* Selects port 1 mode:			*/
> >>+				/* 1: function, 0: host			*/
> >>+
> >>+struct rcar_phy_platform_data {
> >>+	u32 usbpctrl0;		/* USBPCTRL0 register value */
> >>+};
>=20
> >looks really wrong to me to pass register contents via pdata. You should
> >pass flags which would aid the driver into figuring out how to program
> >that register.
>=20
>    That was my first thought (and implementation) but this didn't
> look good either (and even worse with the device tree approach) as we
> couldn't come up with the clear names for the bitfields. Also, not
> all these bits are present in R8A7778 support for which I'm adding in
> the later patchset.
>    Besides, IMO this little differs from having a flags field with
> the flags bits #define'd beforehand. Or did you mean that I should
> have surely used *bool* bitfields?

How about:

rcar {
	compatible ...
	reg...

	/* switch OVC for all three ports */
	renesas,rcar-ovc-port-config =3D <2 "high",
					1  "low",
					0  "high" >;
	renesas,rcar-port1-mode =3D "host"; /* could also be peripheral */;
};

Or something similar (not sure if the syntax is entirely correct). PENC
apparently doesn't anything if it always needs to be set to 1. Would
this work for you ?

--=20
balbi

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZZ5eAAoJEIaOsuA1yqRExMsP/2kxpAoSowwkU/dcU5TJzpC5
v90n0om0OV11B2EQ33F7MqTST5UVG3hk/lc8k5vPKLTTqZfAkFtdbTIySJ8UTyBT
4+FwdwkwKlSpQsH/OvKuv+FlJ4DeejlMM6TguULwWGhQZ2lU6yhi3WUCmPuj7IcK
lgyEPt1+PShiSjPtSRj6Af/+ehmJi6a/yohnfZgKDdGuwp8+/JepG4GdePt+myDP
B1zqFzOt5+52FaEb/lNQ9vtrT3cWwAGSrjuUwf24dmhXb+IcXDLBu4FbeZs2CwAG
xoP+VzOPg0rGRgjcTTXRBn/OwgNKq11ZFoRTh8ZyLpfbTAywLgSbsQAMQhDiLJaC
W1yEXEFr5pvW24UmYH1If6joW4u4mhR8K8foRO0yR8V96WX3Cg+irspuHf6DFTY3
Zj2fXn1iZS5DWfLNB8hCVvVa1CDhcBYnA3orfdHP+Wpla+F3Il5h51VGhUlNvLs+
iQQ7jhE5bfLrRmAFmRd92qQgMCgcDQ4PbkKfP+BXkLArpoYCHUAJixEHfCm5d0YR
8c9TUPnQ6Td0HeVSHnaQ7otjgdS18J+i3OVX+HojOFZoN/8pHEvpuGwM6/sfb1SZ
zIc8IfvvANWjJc5Nm+1u6XK4U3FRiQ6259FDb03PASrJlUpmYTNOy1V+a78M9pku
aJq6hGNej+W7nULG4yFa
=wkXl
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
