From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 03 Jul 2012 15:06:56 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120703150656.GU29030@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kbZGpL0ScFxCd8mt"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--kbZGpL0ScFxCd8mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 05:05:46PM +0200, Guennadi Liakhovetski wrote:
> On Tue, 3 Jul 2012, Mark Brown wrote:
> > On Tue, Jul 03, 2012 at 03:44:32PM +0200, Guennadi Liakhovetski wrote:
> > > On Tue, 3 Jul 2012, Mark Brown wrote:

> > > > This doesn't seem right.  If this is useful we should just remove t=
he
> > > > configuration for the fixed voltage regulator entirely as there's
> > > > nothing platform specific about this, and we probably ought to be g=
oing
> > > > through all the boards using "real" regulators adding selects for t=
heir
> > > > drivers too.

> > > Hm, why? Let's take smsc911x. The driver needs "some" regulators for =
its=20
> > > two power pins. On different systems different regulators are used fo=
r=20
> > > those supplies. It just happens to be the case, that many sh and=20
> > > arm/mach-shmobile platform use the fixed voltage regulator for smsc91=
1x=20

> > What I'm saying is that that statement is equally true if you replace
> > "sh and arm/mach-shmobile platform" with "systems".

> So, you think, each board should select all required regulators=20
> individually?

That's not what I wrote above (at least not for the fixed voltage
regulator).  But in general I'm not sure we're requiring that .configs
that people can generate do more than build.

--kbZGpL0ScFxCd8mt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8wqJAAoJEBus8iNuMP3deyAP+QFl64gC12Dnt8AedXT+9eRR
/kQlbOj8TBCyr7QN39nk3wqzzyaaXTu+PT4+ftkvKv7Vtqrg3dOYYKYWwFVw5Bu5
11GQpbz2XlzC94Flguslm/kar6WYKS8LUCiu4DIU0AoJ9s4psXq8snnTFpk+kVtw
YXwyXfYiVSSEKe/ezuKIopPD+wCVwC2+Uw82OkitLPe8HDssMjslD9seJUiLA6Lm
eKIbQsI24hGME5N6u2ZXqFChkEcWnX/fX42cDGHU+zA34BVi0rC7ud5I0hLwkEv6
/ONH29vhLBw1ZrWClLUihMZA9K/uwD7fyUhAxkoUrmeUT/DV1fbKAOvTZKEu0G6a
gUMReTYqDAfAWY90d5d7lB1S07JdZP0LcpXlzxiWggFCHGu60s7/AuZHWJk+CEVb
yv1/3O2R1MxTxNP//XcbP4eWKt+bUNIq8gWnfaqiMHHMHf09dj+R2E6KvKYnjad3
yyTwXepupycjray7kVdlBT8sYZWhtCMCJ9Xcsri5xA2i0ZG+F3dC5Gn5+ygkS+Y9
MNfqFIgtmI4JnntP0wau6CEormRH97VdZFp5WiblEC+o99Zfu+vwl5qbuFynZhek
lIqsDKvB6IC2iYf9eMsKZIO3MO66u5tB1wKjJFEz8d//HFHRtP3a3rUE7Mj8gsVl
mfbXbYG9ccvQOXmTSXZP
=bW+g
-----END PGP SIGNATURE-----

--kbZGpL0ScFxCd8mt--
