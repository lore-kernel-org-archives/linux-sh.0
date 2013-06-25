From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2013 10:35:43 +0000
Subject: Re: [PATCH 2/2] regulators: max8973: initial DT support
Message-Id: <20130625103543.GC27646@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ddcd+dsiJrvLd0CP"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306210825040.27277@axis700.grange>
 <Pine.LNX.4.64.1306210827090.27277@axis700.grange>
 <20130621144423.GX27646@sirena.org.uk>
 <Pine.LNX.4.64.1306211651120.27277@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306211651120.27277@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


--ddcd+dsiJrvLd0CP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2013 at 04:52:28PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 21 Jun 2013, Mark Brown wrote:

> > A common approach here is just to embed the platform data in the
> > driver data then copy actual platform data in there or parse the device
> > tree bindings (when added) into the structure.  This means that most of
> > the driver can just assume there's platform data which makes life a bit
> > simpler.

> But we can do this later, when we add DT support for those parameters,=20
> right?

Sure, but it does make sense to structure the code that way from the
start since it provides simplification.

--ddcd+dsiJrvLd0CP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyXJ8AAoJELSic+t+oim9RUAP/2GjlMq75wMmvlCJnA7z4rt3
HRkeGxxcG2mSQs/YnHlrEHVk7ApriF+VE+89zCAFF/jGgJusFNHZt5XLH6at7QUU
r5KZpkP+LHYJip8SKd7XlbeGeVJ5k1y3IithYquW5+xFIYN73jPKeVBcH5JVCqUi
nlxAOr5T6XQleRcHUzKKPRtteGet+l8+b4IlORkHp/cm1dw4LYbdc+LOqbnQW82y
QzQZF6TYYh1IiW9DK1dIXzA+qCkQiBb2VljdgFuuVLJQT/nroC2OThAr/ISS0JpQ
NjCJC3lz1SfNBCw7w9YNvDLECwb070LputeCfYc2rjSRaB+xfi1mMV62u1HROZsH
9X9Mzg/uT+IIldLoM2gAqikWr8AFQfuRYFnnMy/cimKzN2vwZaTDcRVlqCB+yhth
fqO82ZqHi08z+Vdn8L4VPRgQes1M2bbaK9pz2oYqX4AoN0BvTiXw7AGuzKHLu2xM
+1xd5DMAnxBDCbpACT3jmhiymx9Ot2hETcgjL/rv9tYu8LxzsQa11Uq7abRkf3/i
WpiW+TOdJc967Za8KUxJxlnGf2oo4bMc8mlk6Bu//xu7pabPyJ1aa5JfILj+XAHg
oSA3Z/FU+/k2+fbck6NgM7YYBwVX7NoU1ueypkP2WDD0Zuuxsxsyx5N2v1Gg9TAt
P4FjPL9blGHEaBPOrhK0
=RCRD
-----END PGP SIGNATURE-----

--ddcd+dsiJrvLd0CP--
