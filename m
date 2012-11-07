From: Felipe Balbi <balbi@ti.com>
Date: Wed, 07 Nov 2012 05:32:23 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: r8a7779/marzen: usb support
Message-Id: <20121107053223.GA8617@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
List-Id: <linux-sh.vger.kernel.org>
References: <87liep4rwy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87liep4rwy.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 06:00:12PM -0800, Kuninori Morimoto wrote:
>=20
> Hi Simon
>=20
> > > These are USB support patches for r8a7779/marzen board.
> > > To use USB, it needs USB-phy driver
> > > which is still not applied on USB maintainer's branch yet.
> > > But I know there is ARM-platform patch time-limit soon.
> > > So, I send these patches now.
> >=20
> > Hi Morimoto-san,
> >=20
> > I think that it is rather tricky for me to apply these changes
> > before the USB-phy driver is applied. Can you let me know if that
> > has happened /when that happens.
>=20
> OK. I will

FWIW, r-car phy is in my tree and will be part of v3.8 merge window:

http://git.kernel.org/?p=3Dlinux/kernel/git/balbi/usb.git;a=3Dcommit;h=3D17=
89e52acc90c87484a109d6349eefe63cabb257

--=20
balbi

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmfJnAAoJEIaOsuA1yqRE7EwP/jSQrcgwj8OqTdoj6u7VmZQB
DZQYxLCQXVtipfSu1nQqhhkAZeHi0Uv0ii4pVwk0FOQPqP8Kqo3z54qbql5CEpvP
ryaMiuA9IGhKaqm9YsMs+Wzd+8aFHbfKYRXkdzm93nav7b/NdQ6//lHAuqcCUy/+
SiTdEEoPX8xhzh8VRHHwPPdtq0oD3oVxVK1/MK22XufYGak8ERA9YKDiCwWIJDg8
zcBu/bQJuh/Z8aRr0dZcUwzOw19YWRE1eD9TB4Z24qW/QLHCADaDgSSsyOGfiiCm
5jrAXJFvunulG4moIC+v1tb0UmaCB9K0f8ZdVypFMcCcNcZ8+Xj7c1VuxbrtOIHN
MlGbML29aWQkvs/xpUw6fwQ3E/5BUuGIRofKGbrywKVuqdqkihvoxEKul8VIcqsl
uZJt8FkibRpFuhz0jgSNdKkd0wmObQ/ypEGcHfwsmrdnGiBF8XEx+YQ2mjg86tJ5
EicAHxiI0YM0i1aGlZGMbQFOQR8ypGY1um2xDILPgxFqDSu9UFLaO1XPpPFxoAPT
3V5uCQJX3B/8/b8/mIC/CxTcQGNBB2SJshwGamXLyGhKidCTsn6NrkLf2eoAKRk3
16CM4gMzJtt+YMnA0IJ1kPT7siEPdJTPKK2g8qJ88PhbpkeSHRo+Zz7Qj67z3BXY
3bUq65JB42iEaGJmyEx0
=KBlY
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
