From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 20 Jan 2014 22:52:20 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <1566590.zu3Q3sqakp@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1634193.HdAEV76yrR"
List-Id: <linux-sh.vger.kernel.org>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <1482392.XFeYNLvUZH@avalon> <20140120155643.GQ17314@sirena.org.uk>
In-Reply-To: <20140120155643.GQ17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--nextPart1634193.HdAEV76yrR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Mark,

On Monday 20 January 2014 15:56:43 Mark Brown wrote:
> On Mon, Jan 20, 2014 at 04:48:10PM +0100, Laurent Pinchart wrote:
> > The problem isn't as simple as it seems, and more advanced implemen=
tations
> > that would allow listing clocks that should be managed automaticall=
y (or
> > the other way around) would also add another level of complexity. T=
he
> > required information is platform-dependent, but we currently don't
> > express it as such in DT.
>=20
> Well, the set of clocks an IP requires will tend to be the same - it'=
s
> normally just that integrators may have done things like tie them tog=
ether
> or decide to spread confusion by renaming them.

That's the problem :-) How should the runtime PM core be given the list=
 of=20
clocks it needs to manage ? That information needs to come from somewhe=
re.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1634193.HdAEV76yrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS3aikAAoJEIkPb2GL7hl17NQH/ixLeTaEA/5rSS46ljmO9oIc
KNBToXJHRMiNuEOzaVo3deebyZ3KuQpNB1S0ju+92UEfXQQv6AaChYFqqOZDvBke
QVg9xKt8NvlB4Vu6KYTVChUZoTtuB6AUe5BpZPu0ih5QcSyBXxXTvj+1vbYB2E3i
FQ4ueSzNBqtxVRvOmSIQbJerf/8qY3Iw+J7HzUeaqjEyJxEal8pJSV5SJ6v4E5iE
8TnXxtZ+cw54+4vx2YuV3ATn3M35OXB1El0ikIQDHxwJksOLq7lk+7Lj/Sl3b6QK
DrrC7h1QGqcbOwHhj+nmmVUE9YFGBvcuCGDsgChyPJxijGqvBz03IBq10V+/7GI=
=jyzU
-----END PGP SIGNATURE-----

--nextPart1634193.HdAEV76yrR--

