From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 04 Feb 2016 19:45:06 +0000
Subject: Re: [PATCH 1/3] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <20160204194506.GB1958@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
List-Id: <linux-sh.vger.kernel.org>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
 <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 03:29:27PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> These bindings allow an I2C bus to switch between multiple masters. This
> is not hot-switching because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affecting your use case.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Squashed with patch 2 and applied to for-next, thanks!


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWs6pCAAoJEBQN5MwUoCm2gaQP/0H01Jd0MmAhBoAs1Trn+62N
es/Ml8+PUEqCAZoxi+NvyfqIGnpr8JROTqmdQkMCzCIYePyENH7p6p5q9Qeq0e7J
VGGfSXl1Oljdgu9b77m/wqvOI0K5KqIxG2i2O6f3mwyqlbv1pA/FVCNWfDIRXfIJ
WZFEz54mVfPPs9L9EUKkiQgdO0yQszOI/APkuud5iW3IWCYmG2ofkyy5YalaAuTp
tbOOHRdK2SWL0iuF8clEYJzbzIXqQ2tlPqhsSx1yOfCLomtkodHm9d2oSH6DmYQ/
0G2oYe/JHci1gnFEc+0DioNRJZo0Mk1XeJ5j0svVgL2I4qVJs9LvklPmDRQg+ODv
0c6jwE/0m4NADk8a4bJK8+HvuqF+UvYxvLU4KJwQwfjmDRcfz2TvPtfE/ujgxt7c
bJzbKgIfDkukLLhUU2ucpgjdFRmCEz2gd0zXjGdKBdrvQEXQ3nBeLVid4hfnyRi/
Y5spucBC5YsJd+jnY0RmTRGMSNqx3Ek8Sgjg+X8E4mdK3nhOJh6tT6DFwsEC3g4a
BZvrNABY5qe4BpHP8EoKWuA/v0sPNJBNNNqs9/i6a18DN+5MrP4tA7fJVWvl6KFV
/dc6FMVEEiuJYvVkOu8BKu0TJJnFKaNz65JKe1edBmVwwmQ+WS4zW0q9z2QFOCiD
WbSQw59bnhy69p2FcFzk
=fr29
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
