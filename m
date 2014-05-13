From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 May 2014 16:59:21 +0000
Subject: Re: [PATCH 1/2] regulator: gpio-regulator: Add required regulator-type property
Message-Id: <20140513165921.GK12304@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MBvrg9yBmBnxRi7n"
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131205000928.GI29268@sirena.org.uk> <2248657.5UVkYxaC6z@avalon>
 <2193707.R9XiqBsnU4@avalon>
In-Reply-To: <2193707.R9XiqBsnU4@avalon>
To: linux-arm-kernel@lists.infradead.org


--MBvrg9yBmBnxRi7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 02:06:23AM +0200, Laurent Pinchart wrote:

> What's the status of this ? The gpio regulator driver now defaults to vol=
tage=20
> regulator when the regulator-type property is not set. Should the DT bind=
ings=20
> document the property as optional (I can submit a patch for that), or do =
you=20
> consider that the gpio regulator driver should support voltage regulators=
 only=20
> when used with DT, and just keep the regulator-type property support in t=
he=20
> driver for backward compatibility ?

I don't really care either way, I did write a patch for the bindings but
there was some language lawyering over it and I never cared enough to
get round to updating it.

--MBvrg9yBmBnxRi7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTck9mAAoJELSic+t+oim9flUP+wY5sh1P9PWuuQqcJoBx8rxV
cUlSprpLHC3fwt7rxqkHOUPz3blJopPgSKz/BhC3if+PjdcTGIw50isJk2rllfVi
1j4qotTlAO6MhuPjk/wn1gEOyzTxNb+cpKCVeOgfpW1DdPNer6NuRALZQ7RfswEJ
cpGeFTPiBRJnWain/28oe/FEYwKdvM3hbyuPtVwe1q1hG06OyjVkZlZP26Y2cBoA
s8vHwom3BAB3JnzTSwGZ83zHDvdMentgdbJR0N5m4HSznRakIOgC8KzTyJA9FBXj
k2ahrPqhBNEvh7mj3HCZXmm4AT6wgkDVO2dp7kPINjVSCAxiyC5Eyf3b/2MbLSD9
rsQP6ww+Yk7GfzfI8bHEM7G3UrEVGkN7UudP5twms93QjizNEe5uwgJ4j9+38OBB
uE2P5YnPZ1sF/yrj+yuHHAEX4syp2yEDiq3Xj0FX9RP4p3B3XFyjzFjP5jSRUEvN
+LFvYMbBAd9bwLAkca4F76aSb27kCYSPuBb/3/Q5G52hXUjsuX+6NqoSYjaViy2H
r9BqaIx7EmZ784Um/8/xXJOki69asW8iZzrmww71AjGXRVYRaZkMM59btWgYoMJs
fAUOMRifK0IscKYVP1c6QcX/6ZwVlDMoUocrJvgdnUsK3eN2/OfvH+78YvgsWm3R
IA4fx+sbFb/F94T/y0z6
=0KZY
-----END PGP SIGNATURE-----

--MBvrg9yBmBnxRi7n--
