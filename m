From: Felipe Balbi <balbi@ti.com>
Date: Fri, 11 Jul 2014 15:12:37 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
Message-Id: <20140711151236.GG27864@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="iAL9S67WQOXgEPD9"
List-Id: <linux-sh.vger.kernel.org>
References: <53BF35B7.9000105@renesas.com>
 <87oawxy69b.wl%kuninori.morimoto.gx@renesas.com>
 <20140711090005.GH12420@verge.net.au>
In-Reply-To: <20140711090005.GH12420@verge.net.au>
To: linux-arm-kernel@lists.infradead.org

--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 11:00:07AM +0200, Simon Horman wrote:
> [Cc Felipe Balbi]
>=20
> On Thu, Jul 10, 2014 at 01:20:34AM -0700, Kuninori Morimoto wrote:
> >=20
> > Hi
> >=20
> > > Changes in v2:
> > > - move phy handle to struct usbhs_priv
> > > - add new default pipe type to driver
> > > - remove pipe type from Lager board code
> > >=20
> > > Ulrich Hecht (2):
> > >   usb: renesas_usbhs: add R-Car Gen. 2 init and power control
> > >   ARM: shmobile: lager: remove USBHS callbacks
> > >=20
> > >  arch/arm/mach-shmobile/board-lager.c | 126 ++++---------------------=
----------
> > >  drivers/usb/renesas_usbhs/Makefile   |   2 +-
> > >  drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
> > >  drivers/usb/renesas_usbhs/common.h   |   2 +
> > >  drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
> > >  drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
> > >  include/linux/usb/renesas_usbhs.h    |   6 ++
> > >  7 files changed, 163 insertions(+), 119 deletions(-)
> > >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
> > >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.h
> >=20
> > For all patches
> >=20
> > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> [snip]
>=20
> > I tested these patches on Lager legacy, and these patches worked correc=
tly.
> >=20
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Hi,
>=20
> it seems that the 2nd patch should go through my renesas tree
> but it depends on the first patch which should be taken by=20
> Felipe Balbi (Cced).
>=20
> Felipe, is there any chance that you could take this for v3.16?
> I am quite happy to make a branch for you to pull for renesas_usbhs
> if this would make your life easier.

you need to take both patches or just patch 1 ?

--=20
balbi

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTv/7kAAoJEIaOsuA1yqRE4YEP/0DA1eObVKCtnuL33Y4QKXA3
aV992Y3VnPTMeCytVk5Mtp2gfS2uC+QZH1s24X2Z0ohWseH3BlDAroAR8hzhsPi0
21+oyLh3lA7Urp3AbckLlJW0POHcriOY0jmPtjCfUs0OVkgdVQxPCHP3j9RleKt9
QHfzgSaTwDXroapuT6GosgxYHaDAs261hxafiUP9bxskcejnEAYIRfiJLI5d4k7O
WgBGiN9OUza1AvafXcujRJvRCgtANG8OV7d/tq4+KocQMn2NGYLOxIDINF5+Dqvj
4rIwF4xcC7u/o06GIQJ/wABlJmXcWPMgdd6FBUxbA3Lbtx7daDnvJKvLFncP+5Nw
Fxv+JMFSZhp9hf6ATXVnAtmdU2891uaYpuLYiM13W19GlJVxLD7GYh9EwIC1rZri
z9NeOoZQUNRftw4EbfTSgq/PuQ421FgYTuYIh/Sw/iUdRNzl23AvFECGOmrcHaZj
xvfBCpsqiOmjwjKRg8hGSVvcsBJF+tMrdFxpB59rpTN2Z9rRwOWgLLy21T4/PZGT
RqbrKtAvi+c1R8MJSm286uzQ+zAX4WkGej/ved3BYG89ZAByxK3xYBVgxg1NL/5t
gSLrBp95V2RVqebyvP1f9hJxs95lirqzraPtR/rzQnwBah16EGl5ae5pg1CQyHdK
c3KgRS5GQ/UgDHPpK0At
=dKdh
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
