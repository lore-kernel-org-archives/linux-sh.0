From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 23 Nov 2012 11:49:16 +0000
Subject: Re: [PATCH v2 2/2] regulator: add a regulator driver for the AS3711 PMIC
Message-Id: <20121123114915.GG4529@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Ublo+h3cBgJ33ahC"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1211221107520.28453@axis700.grange>
 <Pine.LNX.4.64.1211221110330.28453@axis700.grange>
 <20121123111515.GD12685@sortiz-mobl>
In-Reply-To: <20121123111515.GD12685@sortiz-mobl>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2012 at 12:15:15PM +0100, Samuel Ortiz wrote:

> Mark, does that look ok with you ? There's a build dependency with patch #1,
> so it would make sense for me to take it.

If there's a build dependency there's a problem - the Kconfig should
prevent the driver being selected without the MFD.

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr2KyAAoJELSic+t+oim9zFUQAI5kxYLHdr0Z/Yb8rKtAbDRG
j5ovejuFGzLRrej4+9a2+RBA4Bq/Cl4+m6gg+LbmpDDIqA/6L97QmMTYQoOojEBP
tSRWoOqsjTwiTwaO6BtgHluAJoMpI1EOZtwedKpocdLIyHDyZSCDANTmPF4X8Z4x
emXzoGYTEVVzNrivD/yTHDP/F22IJn6eeTAIwxQ30HilLithLPf/B65lH+yd4R5d
NPx2Y48zLq6MI96sQLwb9SgQLNJLyROpoiYiml3OC4tS0R756tfcwgIE6hu/zY5M
gXqHbpQNeMZSxh7CBlVt4DinT3WbvtyN+CQTNK/Zl56zZRfy7a5XaUb/yPJT+C7R
/jRs6FYVUmr0jn/ALUZsQs9SWTkKRBoEINKpOpKm8SfoPYZwHV4Z6CrQOLw5gEGq
WXUK4t8nOU7f3UKqJEGHp8A0FsXPlcxP8lK/NkLSfXpjxHv2UqHgqaGWBVtmvZdh
D68rcMmpOgyVPgBSTPmYR6BWMrgJf6tN+CYjNuTRJwBpQ1GsbVs2uHiONO5rM67/
ldL475b/4ggFUgs02HOIh959jUq0B6uCqMVDYIYYs9TWXHvhzTfIEK9XY6gZbST9
CkeabtoyLeV67z+/DRV6pRaJ2WhxY4Qu+WEKrA7q9Fgn2KPYxHMkLjndLIuTfOe7
lPdoHZ/lBDRjNHzP47sT
=FfST
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
