From: Felipe Balbi <balbi@ti.com>
Date: Mon, 03 Mar 2014 16:54:01 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <20140303165401.GF10987@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pyE8wggRBhVBcj8z"
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com>
 <20140303164426.GD10987@saruman.home>
 <5314C0E9.2020202@cogentembedded.com>
In-Reply-To: <5314C0E9.2020202@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-sh@vger.kernel.org, valentine.barshak@cogentembedded.com, rob@landley.net, linux-doc@vger.kernel.org

--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 03, 2014 at 08:50:33PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 03/03/2014 07:44 PM, Felipe Balbi wrote:
>=20
> >>Add support of the device tree probing for the Renesas R-Car generation=
 2 SoCs
> >>documenting the device tree binding as necessary.
>=20
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> >Unless someone on devicetree@vger gives me an ACK pretty soon, I'm
> >afraid this patch will miss v3.15.
>=20
>    Ugh, the USB acceptance window is getting very short...

well, -rc5 is already out... I want to have at least 2 weeks of
"linux-next soakage" (yes, I just coined a new term heh). Since most
releases go up to -rc7, it's about time to close the tree ;-)

> >>---
> >>This patch is against the 'next' branch of Felipe Balbi's 'usb.git' rep=
o.
> >>
> >>Changes in version 2:
> >>- restored devm_clk_get() call and the error handling logic in the prob=
e()
> >>   method, removed clk_put() call in the remove() method.
>=20
> >>  Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 ++++++=
+++++
> >>  drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42 ++++++=
++++++++--
> >>  2 files changed, 68 insertions(+), 3 deletions(-)
>=20
> >>Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
> >>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>--- /dev/null
> >>+++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
> >>@@ -0,0 +1,29 @@
> >>+* Renesas R-Car generation 2 USB PHY
> >>+
> >>+This file provides information on what the device node for the R-Car g=
eneration
> >>+2 USB PHY contains.
> >>+
> >>+Required properties:
> >>+- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A=
7790 SoC.
> >>+	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 So=
C.
> >>+- reg: offset and length of the register block.
> >>+- clocks: clock phandle and specifier pair.
> >>+- clock-names: string, clock input name, must be "usbhs".
> >>+
> >>+Optional properties:
> >>+- renesas,channel0-pci: boolean, specify when USB channel 0 should be =
connected
> >>+			to PCI EHCI/OHCI; otherwise, it will be connected to the
> >>+			USBHS controller.
> >>+- renesas,channel2-pci: boolean, specify when USB channel 2 should be =
connected
> >>+			to PCI EHCI/OHCI; otherwise, it will be connected to the
> >>+			USBSS controller (xHCI).
>=20
> >I wonder if these two properties should be taken care by pinctrl
> >framework instead.
>=20
>    No, the internal port multiplexing is controlled by the PHY
> itself, see the driver source. The same way it was with USB port 1 of
> the generation 1 R-Car SoCs.

ok, fair enough.

--=20
balbi

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTFLOpAAoJEIaOsuA1yqREYO4P/1Voy4+hARNcy2681yWmv/RA
GF8Gmht6ha3z5rJtvgoZTkeJ76ftHZ7OBQAKIfIj55z+rJMlysKN+LE+r+W76gMs
e93KzzFSQmU7eev0mEJNvOTWNOQBXeeIUQkMnr0N/lvhZJk7V3idDRVMU8LfQuWj
hDqB0wNGLmVr6zqb82PIe7S1N/b9PNIgDX+zA3yn1prAWsgBfImtKiM/SCaEicX1
p8ka/fW42ZwEbMW65BUI/I+qSFAisaz63qsibFRsoE1PN9O3D2+iXR6osLgARjj/
ZSZGQG9Rh4kYpM0AYD60Vq875kITpsYqJB8oqOjn7+eHt6X+QmDwCZhJqsdlfaN6
mLiorb0Z8tcgJ/KEGUNJhTzognJDYT3ox1hEZ6jM0k9skh/PFjigfAJHqnXUAPBE
Yn53bgTt7qkoGtsw7xtmfy9obNRfh6KE+eBa7b90SqwF4toso+uwMhEXrsVE/I+E
7FggrJZ5zKLbnx3tEfYTm+jbUxQu0BeLMugY4oyosIVBIdMYVVB+chIjShi7Igo2
Bk3CNrX3dwsCMZ2dIwg08q75GWQUwzWHEdEMbkhUsU+yZadQf4zaa3uZTQdf9giL
zC6ZKQ9I60MfyBMgnJ0TW5BIq2I5iEOQ6N7EaG2MvchkeoZfj2otd1SIUfvXuNBt
fv1SrEEe+LE2BpTiDWMP
=xjkT
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
