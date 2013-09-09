From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Sep 2013 16:04:06 +0000
Subject: Re: [PATCH 2/2] regulator: da9210: add Device Tree support
Message-Id: <20130909160406.GS29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XlarKorwDmMoGA5O"
List-Id: <linux-sh.vger.kernel.org>
References: <1378741920-11085-1-git-send-email-g.liakhovetski@gmx.de>
 <1378741920-11085-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378741920-11085-3-git-send-email-g.liakhovetski@gmx.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>


--XlarKorwDmMoGA5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 05:52:00PM +0200, Guennadi Liakhovetski wrote:
> This patch adds basic Device Tree support to the da9210 regulator driver -
> with no special properties, since also driver's platform data only contai=
ns
> standard regulator initialisation parameters.
>=20
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  drivers/regulator/da9210-regulator.c |    9 ++++++---

I'd expect to see a binding document, even if it is just a very brief
one documenting the prefix and pointing to the standard regulator
properties.

--XlarKorwDmMoGA5O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLfFzAAoJELSic+t+oim9jtIP/1Mocp62UXAiXIdHeUcEimQu
KD6Q8qc/wjnLPzmReNJ1/IrJi1yv9u4rewCDCTMvEVLxqLzgXpbn4yJYUAllw2LU
f1hdc1BQfEZ5LebqtVz8jxT4PnzwXZ69YjZ6rZLxoZE0yAUYj9g9gjUANNaBIBdh
KGVe9xjPmXUJWOARq9PjN1lELdn2QJKpueck5K/U2GZpg7DCGzj1KJ+pfU/SXKUf
banRQixjOis9a+X+wKYZrH+TBxMj3YeMPw2pRMInKp6v/DOGSnETnKm3KPb1l6nk
lEH4E5iurqVhkx9viOWyTEp0Bgs/svZEB+TTXaLvvKrAMxXQgq9t5jp2lcPyPk/F
qpn7ph7BX4B57HtAH6KuhcMrTPWhTzT/6/7PbeIfOP5VTEyezNTjqKTAJcjabNT4
d2HdcdJrPpgm+hhecV+YIC9BWIKzpBFWGDuGv5x4XTRz/B93Jyu+D3YibafXereR
6HeZt/NUOftIeoVqJaOq0bpyREQEuiz7NT9/v3kmr3Kfiig+HK11geOcA5BM3wUP
tnJUdN4HnNNre2kZNLQeav0peCFYkltuc5rp8wQzgekLE/G2pg6WxVjDzQvNbcJt
LYQJht6ssXjlXRyg7XNJmflC2FHFESztFJ5CGrpJO3kuAN87k4qgHtDkB6CbRqse
q+WeAY4sRB6hgpNpFItS
=L25T
-----END PGP SIGNATURE-----

--XlarKorwDmMoGA5O--
