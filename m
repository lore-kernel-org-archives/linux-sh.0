From: Felipe Balbi <balbi@ti.com>
Date: Thu, 10 Oct 2013 15:13:47 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <20131010151347.GC28375@radagast>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Bu8it7iiRSEf40bY"
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2013 at 01:21:27AM +0400, Valentine wrote:
> On 10/10/2013 12:32 AM, Laurent Pinchart wrote:
> >Hi Valentine,
> >
>=20
> Hi Laurent,
>=20
> >Thank you for the patch.
> >
> >On Tuesday 08 October 2013 23:43:25 Valentine Barshak wrote:
> >>This adds RCAR Gen2 USB phy support. The driver configures
> >>USB channels 0/2 which are shared between PCI USB hosts and
> >>USBHS/USBSS devices. It also controls internal USBHS phy.
> >>
> >>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>---
> >>  drivers/usb/phy/Kconfig                         |  13 ++
> >>  drivers/usb/phy/Makefile                        |   1 +
> >>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 255 +++++++++++++++=
++++++
> >>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
> >>  4 files changed, 291 insertions(+)
> >>  create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
> >>  create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
> >>
> >>diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> >>index d5589f9..297062c 100644
> >>--- a/drivers/usb/phy/Kconfig
> >>+++ b/drivers/usb/phy/Kconfig
> >>@@ -214,6 +214,19 @@ config USB_RCAR_PHY
> >>  	  To compile this driver as a module, choose M here: the
> >>  	  module will be called phy-rcar-usb.
> >>
> >>+config USB_RCAR_GEN2_PHY
> >>+	tristate "Renesas R-Car Gen2 USB PHY support"
> >>+	depends on ARCH_R8A7790 || ARCH_R8A7791
> >
> > From a development point of view it's always nice to be able to compile=
 the
> >driver for a wider range of devices, even if the device is only found in=
 the
> >R8A779[01]. This allows catching compilation errors, for instance caused=
 by
> >API changes that affect all drivers using the API being modified.
>=20
> Compiling a dirver for an unsupported architecture also seems to be
> more error-prone.

quite the opposite, it helps finding wrong includes and indirect
inclusion mistakes.

> >I would use either
> >
> >	depends on ARM
> >
> >or
> >
> >	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
> >
> >(assuming the driver can compile on non-ARM platforms, otherwise the abo=
ve
> >line could be changed to ARCH_R8A7790 || ARCH_R8A7791 || (ARM &&
> >COMPILE_TEST)).
>=20
> OK, I'll take a look.
> Do all the drivers have to support COMPILE_TEST?

new ones, yes. Older ones, just a few. It depends on the subsystem too,
I like to enforce COMPILE_TEST because it helps me build-testing drivers
for which I don't have the HW.

--=20
balbi

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVsQrAAoJEIaOsuA1yqREY80P/0FmLZL36vJsHDuvIzRl7pWt
LuusYDRzxmWNjGDF4FT9e0xCPOwvc+GhIo5QqBsea4dTrzwkRuRMB1Kf1QaDrIft
hI5wcCGbGdqRObfooIYLS1JQ/ZjwK5ZCH/KU5Gapj9UMb0xt5Pbmn3Z4qXzNKnfv
6ywM8DsOYm71ArzPggBPqF2BSc+Ei0hPW9MRDdJTneFVXUXkD0v9h3Kkd6U6l4tl
rglvcx24u1pwE6UXaZ0ttHOuwWxnb7uWMwpZPGGEFK82lsvy8mUlqhX9/GXD6yXa
hkCRyN0CKHq63VltYq0Lmko87b172atlME8lQljqrnKPqhbiSrsyLZm+VGRkZrxU
yFWr31gYix4LnATPNLAh6lz/7AKLTnPvnT3Gpb+geTEB8BgJJIAjZrZrcgKtWTRZ
nQ0Nq7OHug3PHRDvisOuXUsavgClwiTTMHErF/MgJnJjkaB5yPBk0W6Sk9r1FALs
ulWzPOTN13wWkqKqJdBZLrHk7Ri+S4hoKof4tlwqm3MktEWmn2K71cgZ7XiSuDc4
jB8WJjGyk0zQGmWoCTVhcwM1ZJO98PvYIHvihoDl8hLm2TWpJX6jscca+xjkz2B3
7ws9nI2m5+2q/vy3RPDptAPH/ktyT3Gcc+7hk/hl+p81atThtHAskhz2S0f/AdpM
7cQ4H9bjZLM6b7Olm0HZ
=V3XI
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
