From: Mark Brown <broonie@kernel.org>
Date: Wed, 14 Jan 2015 17:18:38 +0000
Subject: Re: [PATCH] ASoC: simple-card: Fix crash in asoc_simple_card_unref()
Message-Id: <20150114171838.GY4160@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2+IDmuKgu0wSQZlt"
List-Id: <linux-sh.vger.kernel.org>
References: <1421179417-23698-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421179417-23698-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--2+IDmuKgu0wSQZlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2015 at 09:03:37PM +0100, Geert Uytterhoeven wrote:
> If asoc_simple_card_probe() fails, asoc_simple_card_unref() may be
> called before dev_set_drvdata(), causing a NULL pointer dereference in
> asoc_simple_card_unref():

Applied, thanks.

--2+IDmuKgu0wSQZlt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtqTuAAoJECTWi3JdVIfQSpEH/1dq2UiGyLtXhJQMMso1FSBf
SnjsqSpspcbV7bjMPJJWI/f92411NgMYKxcix0W9dTlma9qYYfqdNgaBIPYyq+T9
YHAqOCyLm44qJlnucGF+LCqPbrxUFo81y1LZjGGQDEHgSajqmmvA0CkxVzHEzCqH
QAbeAQkpDDShpbeDNlecZSx0YF4I1/hdnHGvthXNKIenT2NL+Zk9SOkSsFf0m2LP
s+PF8DbhyRbSR7o3I2IHIh7gWE+D/WhjqfrhQ9uSHY2T72PJOR6P1d+2SUER9wru
mANqDmJXZsk93Jm7b2wiHHyWiyKNxDQHNoVT4K+w1Nvo+0pRUsjFAyEpW8VFpms=
=gqwy
-----END PGP SIGNATURE-----

--2+IDmuKgu0wSQZlt--
