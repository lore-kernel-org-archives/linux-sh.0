From: Felipe Balbi <balbi@ti.com>
Date: Wed, 06 Nov 2013 17:05:24 +0000
Subject: Re: [RFC PATCH 2/2] usb: hcd: Introduce CONFIG_USB_HCD_EXTERNAL_PHY option
Message-Id: <20131106170524.GS24322@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kigERAySUJmIn/9g"
List-Id: <linux-sh.vger.kernel.org>
References: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--kigERAySUJmIn/9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 08:47:36PM +0400, Valentine wrote:
> On 11/06/2013 08:39 PM, Alan Stern wrote:
> >On Wed, 6 Nov 2013, Felipe Balbi wrote:
> >
> >>Hi,
> >>
> >>On Wed, Nov 06, 2013 at 12:33:27AM +0400, Valentine Barshak wrote:
> >>>This adds external USB phy support to USB HCD driver that
> >>>allows to find and initialize external USB phy, bound to
> >>>the HCD when the HCD is added.
> >>>The usb_add_hcd function returns -EPROBE_DEFER if the USB
> >>>phy, bound to the HCD, is not ready.
> >>>If no USB phy is bound, the HCD is initialized as usual.
> >>>
> >>>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>>---
> >>>  drivers/usb/core/hcd.c   | 20 ++++++++++++++++++++
> >>>  drivers/usb/host/Kconfig | 11 +++++++++++
> >>>  2 files changed, 31 insertions(+)
> >>>
> >>>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>>index d939521..da9c4ba 100644
> >>>--- a/drivers/usb/core/hcd.c
> >>>+++ b/drivers/usb/core/hcd.c
> >>>@@ -2597,6 +2597,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>>  	int retval;
> >>>  	struct usb_device *rhdev;
> >>>
> >>>+#ifdef CONFIG_USB_HCD_EXTERNAL_PHY
> >
> >I don't see any reason to add a new Kconfig symbol.  Just use "#ifdef
> >USB_PHY" instead.
>=20
> I just thought that most of the drivers would not need this code,
> so I added a config option which can be enabled only if necessary.
> I'll remove and use USB_PHY instead. Thanks.
>=20
> >
> >>I think here would be a nicer location for a flag:
> >>
> >>if (hcd->has_external_phy) {
> >>	phy =3D usb_get_phy_dev();
> >>
> >>	....
> >>}
> >>
> >>that flag would get set by the glue driver (ehci-omap, ehci-msm,
> >>ohci-omap, etc), where necessary.
> >
> >The problem Valentine is facing is that the glue driver doesn't know
> >whether or not to set the flag.  The way he set it up, the decision is
> >pushed down into usb_get_phy_dev, which ought to have enough
> >information.
>=20
> Exactly.

got it ;-)

--=20
balbi

--kigERAySUJmIn/9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSenbUAAoJEIaOsuA1yqREX1sP/34mjQErvae1Zw8fWXLz+nRO
tzmLg7z0SvnuFmCFdLzoEU1KW1t+x2xJ4d3zqRCh9IRCdVPFDbDXGRsVXoL0dNcl
efE/AEfWA1u94NJx2X+sjujYZs9sAbUjXYu6FWOj3iYXGEkYnb3Cvh/U86+odlb3
SbPcj3BPgZNqnuSokgkBYBnAeWPPUpcWZLRUpgwJLtDA6ViuWcQIXGNbC6w6S7ou
7Xx/3k2umv+6HwhNwBiUda4tOBI8O+rDdUTJCQLIOUUB9ahKNDvLZkYDsAP6WFIR
mt+f34g2mG+ffDNpnInE1xpYbh9pRlBjW25G/08sHVM3hG3W6LB7JxGnnHvb0oWi
aoHW43gBq6zEtRo5i8RD03hHtrV6rxL0ZY192T4Z44QiLYYEgwpzVvGFmidffBTM
O41RmYAmYahs005Yy1DGQWAuWv7ZZHAkK8PZ/SoGhSVUc/bmkciEvoviUi9IxcRB
GWEMO22aVwa/pEDWKZL82VFSbkJT7k26W0wUh50YRHom1fSgaLdu7LIZ/ZIxZOEL
DBKdfwo25OyLRr7GFhGabQCXoMdq7BlcjAcZKBV9gBotg4V/HMHDscG9a/2m9wdQ
/8hKQdZTbu9o9dNlYEnkUiaNTEV3SYaPOHvvKs1JEOmU1cWq+88YUG1PZ4td1YLD
pBbXxa3eVN1+6i7g4q6t
=fg9W
-----END PGP SIGNATURE-----

--kigERAySUJmIn/9g--
