From: Felipe Balbi <balbi@ti.com>
Date: Fri, 11 Jul 2014 16:23:48 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
Message-Id: <20140711162348.GF22572@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JSkcQAAxhB1h8DcT"
List-Id: <linux-sh.vger.kernel.org>
References: <53BF35B7.9000105@renesas.com>
 <87oawxy69b.wl%kuninori.morimoto.gx@renesas.com>
 <20140711090005.GH12420@verge.net.au>
 <20140711151236.GG27864@saruman.home>
 <20140711154152.GC1777@verge.net.au>
In-Reply-To: <20140711154152.GC1777@verge.net.au>
To: linux-arm-kernel@lists.infradead.org

--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 05:41:52PM +0200, Simon Horman wrote:
> On Fri, Jul 11, 2014 at 10:12:37AM -0500, Felipe Balbi wrote:
> > On Fri, Jul 11, 2014 at 11:00:07AM +0200, Simon Horman wrote:
> > > [Cc Felipe Balbi]
> > >=20
> > > On Thu, Jul 10, 2014 at 01:20:34AM -0700, Kuninori Morimoto wrote:
> > > >=20
> > > > Hi
> > > >=20
> > > > > Changes in v2:
> > > > > - move phy handle to struct usbhs_priv
> > > > > - add new default pipe type to driver
> > > > > - remove pipe type from Lager board code
> > > > >=20
> > > > > Ulrich Hecht (2):
> > > > >   usb: renesas_usbhs: add R-Car Gen. 2 init and power control
> > > > >   ARM: shmobile: lager: remove USBHS callbacks
> > > > >=20
> > > > >  arch/arm/mach-shmobile/board-lager.c | 126 ++++-----------------=
--------------
> > > > >  drivers/usb/renesas_usbhs/Makefile   |   2 +-
> > > > >  drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
> > > > >  drivers/usb/renesas_usbhs/common.h   |   2 +
> > > > >  drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
> > > > >  drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
> > > > >  include/linux/usb/renesas_usbhs.h    |   6 ++
> > > > >  7 files changed, 163 insertions(+), 119 deletions(-)
> > > > >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
> > > > >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.h
> > > >=20
> > > > For all patches
> > > >=20
> > > > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >=20
> > > [snip]
> > >=20
> > > > I tested these patches on Lager legacy, and these patches worked co=
rrectly.
> > > >=20
> > > > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >=20
> > > Hi,
> > >=20
> > > it seems that the 2nd patch should go through my renesas tree
> > > but it depends on the first patch which should be taken by=20
> > > Felipe Balbi (Cced).
> > >=20
> > > Felipe, is there any chance that you could take this for v3.16?
> > > I am quite happy to make a branch for you to pull for renesas_usbhs
> > > if this would make your life easier.
> >=20
> > you need to take both patches or just patch 1 ?
>=20
> Please just take patch 1.

will do.

--=20
balbi

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTwA+UAAoJEIaOsuA1yqREK2wQAJEA9a4SXE0/l7RJNdx9gVn7
m2WNHLUpsibeOT4wu3I1uWm8lCvQksEI4VghTKvT71IxBxaCmupVxGkiNL9HCp0I
4EBDqBjqoLf+tmp6jv/bvpbloj56l07eKMFOoWopru/jwfy8NKX+gcRNPnsVLTJS
OkoilDra5h32WdyLZ8+bFy3KhLlwcEQhYxw/AWKSjcEVbvCAj2k8JGF9nKC+R13B
urha5HqXdVtB9Xs3uQjPE5HtMitzPYeuraKzWD2A9r5uLMvyu0TqpHbOv+nPCCty
pf0+bDo231AkFfohszvshUuplEZM3Ae8GdAWDMuN6DbCHQF4smjJrRWlUYXGuHpP
+gRvIiz8aWhu7a/7XoiAFt/V0MMH0YRQbXOenIUV+brC/cBZRQRdpEV/HBiKgbIp
HJYqZ7uLUcBgh8RJeqotiIvUI8NPxe+Gy8M+t2JpNcJmG9JoHMfazpR6etxrPP0r
DpvCbOOUALsCNwVfR7yhmlyPc4FjzGnzawv5+4hnXfxaGnqFiSKG7j2k03hS4X+L
5aaBV01fx7u/xK/we74CZ0uhD7zylDXpQhB/zoWIXlzAuZr3F/lt0mRjW90OG3K2
k7kCm7nioWBv9qOFAQ3XB6oFdcambOGFrCPEnOjFq5omkfAuIu+6NurlLSja2B2q
dgzJVid0FxENdmvLcJIE
=RQJI
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
