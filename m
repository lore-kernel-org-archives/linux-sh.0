From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Feb 2015 14:04:36 +0000
Subject: Re: [PATCH/RFC 1/2] regulator: da9210: Mask all interrupt sources to deassert interrupt line
Message-Id: <20150217140436.GW9110@finisterre.sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sr8SBrQ3fbgntwtR"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ@mail.gmail.com>
 <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Steve Twiss <stwiss.opensource@diasemi.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--sr8SBrQ3fbgntwtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2015 at 01:11:11PM +0100, Geert Uytterhoeven wrote:
> After boot-up, some events may be set, and cause the da9210 interrupt
> line to be asserted. As the da9210 driver doesn't have interrupt support
> yet, this causes havoc on systems where the interrupt line is shared
> among multiple devices.

Applied, thanks.

--sr8SBrQ3fbgntwtR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU40pzAAoJECTWi3JdVIfQJKgH/2JVCVq9HxO5AQ5hTaji9me+
h09wpXq77hyCrxyH6vPkBg5x0PhQskBVncoMTIJa+8xD5SB8KKTofty6352tVEze
XvMOkHQ29U1kGfei0YTnCqbDebJ34omFhh1V9CEnXEmSoGmhf7vCmpdtrhS7QU1H
aHIGoHEpQrhYhOF9Am7Na2PrMKTa2l9s1Pz8FltD8J42y2NoVZ6rnY5ywvFGVaV2
+bKmGiJ39iMriy/beSpgPv7Oz+O1uEpxZ7++3Gv2Av1N4513xBgyjOVOCs0pGG7l
3uO8hmcBpzEbC6g7pxhIuKdXPmg8zOFoiOXEIhGRpAw6g1VCUR7a+Qe9wUnW6mo=
=2GZf
-----END PGP SIGNATURE-----

--sr8SBrQ3fbgntwtR--
