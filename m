From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Oct 2015 11:31:08 +0000
Subject: Re: [PATCH 4/4] spi: spi-coldfire-qspi: enable RuntimePM before registering to the core
Message-Id: <20151009113108.GA1542@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
List-Id: <linux-sh.vger.kernel.org>
References: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
 <1444373693-2372-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444373693-2372-4-git-send-email-wsa@the-dreams.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2015 at 07:54:53AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, other=
wise
> this will fail.

I'm missing patches 1-3 and the cover letter - what's going on with
dependencies here?

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWF6V4AAoJECTWi3JdVIfQkK8H/1WjOx33gPtzJpaObrl7XB59
y4XjcBpM4mfE+u41PlO+l8BFyen0rZVMxBW9tRaL5Ol39i9k2R4zEtdYp5nltlAd
jRfdv4Y10MelWG1X+vZCBEQDYL4EqaD3GASoYlvvDXJcjdZlmfuko4ZfdA4Jxl4f
5CT5aQU4/Yyes872cFuZYb32+hqH3DJebbgQF1ucTCFZwhw30ErwPHCo5e+uT0lY
v4EMCq2+PNlhfP0aMihmB6iwoAg5uRlABuza2ZrSwwRZS2xq6IQ+8NL+PKarGShH
kWGFLhWbd2vUhhGNtycsPCqoy7Bo4PF1iUFshrzUMrxehD10phja1Aokf7BxcW0=
=vcm3
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
