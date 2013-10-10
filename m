From: Felipe Balbi <balbi@ti.com>
Date: Thu, 10 Oct 2013 16:32:15 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <20131010163215.GD11449@radagast>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="at6+YcpfzWZg/htY"
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2013 at 08:29:43PM +0400, Valentine wrote:
> On 10/10/2013 07:23 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Thu, Oct 10, 2013 at 02:14:45AM +0400, Valentine Barshak wrote:
> >>This adds RCAR Gen2 USB phy support. The driver configures
> >>USB channels 0/2 which are shared between PCI USB hosts and
> >>USBHS/USBSS devices. It also controls internal USBHS phy.
> >>
> >>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>---
> >>  drivers/usb/phy/Kconfig                         |  13 ++
> >>  drivers/usb/phy/Makefile                        |   1 +
> >>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 248 +++++++++++++++=
+++++++++
> >>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 +++
> >>  4 files changed, 284 insertions(+)
> >>  create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
> >>  create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
> >>
> >>diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> >>index d5589f9..bba7d29 100644
> >>--- a/drivers/usb/phy/Kconfig
> >>+++ b/drivers/usb/phy/Kconfig
> >>@@ -214,6 +214,19 @@ config USB_RCAR_PHY
> >>  	  To compile this driver as a module, choose M here: the
> >>  	  module will be called phy-rcar-usb.
> >>
> >>+config USB_RCAR_GEN2_PHY
> >>+	tristate "Renesas R-Car Gen2 USB PHY support"
> >>+	depends on ARCH_R8A7790 || ARCH_R8A7791 || (ARM && COMPILE_TEST)
> >
> >see my question on other thread, why the forced ARM dependency ?
> >
>=20
> I just can't test building it architectures other than ARM and X86,
> though I guess it should probably build fine.

right, the idea of COMPILE_TEST is exactly that. You gotta be willing to
build test on that arch. Let me rephrase that a bit: if someone with PPC
cross-compilers installed wants to build-test your driver, they can set
COMPILE_TEST on their builds, if something breaks you never "supported"
that arch, fixes are welcome though ;-)

> Just thought restricting to ARM would be safe enough.
> I'll remove ARM dependency and resubmit just this patch in a bit.

please do.

--=20
balbi

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVtaPAAoJEIaOsuA1yqRE7gIQAJH/uS03+hzCGcZlp3A75l+k
Xl6gDDTkVL3eMG/I5RbTXFGxzvwgQYgNffJt/GRov9hejuxOsuIQ3aE7XL1MdlqH
z1oJq86rZpxa5z8XHafbVFDBjjiGlObeuluL8xhH0t7UJNiG0aO/6bfQqLv00iQH
rgMZSckOhrKzdaqMjKsiO675mpyWTnp9C9Q/+2gzWsmYz9hATkeov8/JqIlY0BP2
3Qvbt/cWoglBR4+rSCcpzZJrudcuubo84yT3n3RGtCMfbjEGQ/NwEdiXCWJLvBPN
BM9RqsG1TJUB7EVLbgrkWfNCSUsA2n8uZrxXgmJ1csjFswc9rZqVldOBvI5G6SyA
UW8hhw7su29YtlxPrn1XG+dHKdfu8rh2XHjdOxSLz3fVaBDCVe6hB1wG2T2Vb3WZ
favi5gKFigJ4RY5Oar8joSs3rB0xraAJkwVdl2L3DeoGCICmxr2nxUc1lqzeO6iC
vhtXVgarEJQTDFU2EHj6r37jXhySmTKGSTWLnmAQ/KEBzT+832S2euNfvfP/FOBk
kFmZe58EeAdr3QH15QM7lPkWL/NEg1TG2swUtyP7H01rnfyuv5DzgzDzHRXVZb0n
iI7QFHH5jGY5ZQmHRnlE1fZfNTIFUQ+85J2vXhvJ5yE93hSwY7XikXF/kM/E3Xnc
P5OPn1J6NqJJt/oQs/ON
=eN9F
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
