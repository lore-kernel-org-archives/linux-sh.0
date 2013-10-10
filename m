From: Felipe Balbi <balbi@ti.com>
Date: Thu, 10 Oct 2013 15:12:27 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <20131010151227.GB28375@radagast>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2013 at 10:32:12PM +0200, Laurent Pinchart wrote:
> Hi Valentine,
>=20
> Thank you for the patch.
>=20
> On Tuesday 08 October 2013 23:43:25 Valentine Barshak wrote:
> > This adds RCAR Gen2 USB phy support. The driver configures
> > USB channels 0/2 which are shared between PCI USB hosts and
> > USBHS/USBSS devices. It also controls internal USBHS phy.
> >=20
> > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > ---
> >  drivers/usb/phy/Kconfig                         |  13 ++
> >  drivers/usb/phy/Makefile                        |   1 +
> >  drivers/usb/phy/phy-rcar-gen2-usb.c             | 255 ++++++++++++++++=
+++++
> >  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
> >  4 files changed, 291 insertions(+)
> >  create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
> >  create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
> >=20
> > diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> > index d5589f9..297062c 100644
> > --- a/drivers/usb/phy/Kconfig
> > +++ b/drivers/usb/phy/Kconfig
> > @@ -214,6 +214,19 @@ config USB_RCAR_PHY
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called phy-rcar-usb.
> >=20
> > +config USB_RCAR_GEN2_PHY
> > +	tristate "Renesas R-Car Gen2 USB PHY support"
> > +	depends on ARCH_R8A7790 || ARCH_R8A7791
>=20
> From a development point of view it's always nice to be able to compile t=
he=20
> driver for a wider range of devices, even if the device is only found in =
the=20
> R8A779[01]. This allows catching compilation errors, for instance caused =
by=20
> API changes that affect all drivers using the API being modified.
>=20
> I would use either
>=20
> 	depends on ARM
>=20
> or
>=20
> 	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
>=20
> (assuming the driver can compile on non-ARM platforms, otherwise the abov=
e=20
> line could be changed to ARCH_R8A7790 || ARCH_R8A7791 || (ARM &&=20
> COMPILE_TEST)).

every driver should compile on all arches. I will be enforcing
COMPILE_TEST before applying any new drivers.

--=20
balbi

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVsPbAAoJEIaOsuA1yqREeV0QAJE+tfUWyYYNO3UzdSF/Elaa
Gk0sZZquMg/ncwZ8uWN9QepTONc6ok25KIjF9T8dq83g2keHZM0IvyDMrmN08NZm
JVPH1C3pC9YgonXsVBBxFOZDOpHwgUnKQKwEyKF3Ue9G8CQWrFSrvnwY4kvtbS3e
DyAfHAW6PiViU83M7bO7EHjCWw4DrbE5xQ1c5qdZtE9/zCMAkGHQkM0Q2F7A5MUp
yqJNHdDgEzi7Wl7eD2spdf/Cj8zR2WWEadZp368gh25mWpyiwfcQpcKNLu4epwA1
ToLV5pd+vg83xvrWbaJQAvOo1D8JGV/18bQspVusV/MVBB+FFWw7jEvQz+wJtACL
n1nF9eWOEEbnO1iF8dbDXigfshLeG8eZ7YUbGlPPjEU4EvvT21sF+6Qo5th7Eg58
qaWEfZ5IvUekrxIBEqd6PHnaMFoth5751+7/ES8O0LdhjDZW0BMfYs/tiJgFCM4D
5+XHzGj0njxvTOb9xOchxzpUIOoTiL4Vq1El0sQYyuDVDUTivZ2a6q2Kq1OmJhXp
FGYU7evZyaC5wKYLozzCiK/UCLZPjGWCXBiFP2Nmwprs33b7iFwFwIAJbum4zxjz
m/2l8pGjhytFZ22E62md+YRJcD7lN+rsbm46yVptfZOuZS9rfsnOuceBVyOeTePO
WfRWS/KciyNT9DXZwFBr
=p+pV
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
