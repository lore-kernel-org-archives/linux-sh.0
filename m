From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Apr 2015 18:41:40 +0000
Subject: Re: [PATCH] spi: Make master->handle_err() callback optional to avoid crashes
Message-Id: <20150407184140.GQ6023@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XjxGazX6lEnETewT"
List-Id: <linux-sh.vger.kernel.org>
References: <1428431959-23935-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1428431959-23935-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--XjxGazX6lEnETewT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 08:39:19PM +0200, Geert Uytterhoeven wrote:
> If a driver doesn't implement the master->handle_err() callback and an
> SPI transfer fails, the kernel will crash with a NULL pointer
> dereference:

Applied, thanks.

--XjxGazX6lEnETewT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJCTjAAoJECTWi3JdVIfQcCEH/RVvZiRnSaqyTsib81/xzWke
KtmEF4owG5K/jOlzT0huGu9e4yU9+uFvFYSrgk35lDOYxKtKZBjJGh4AzFWwLpV8
z/MbHp77kGiMAbR30dBzbbBG/QrMW0k3ssBvvw0J70L2kNOQeRlH/alnGbsb6xS7
n8uNCFuXzooIs5/+w7L0kjRqVXe4a1WK0Xk8kkvv/O4LBWP17Q9V+5Rlq4WB83GG
eeogXWNmWUlLp50exrjr4ldIuSpPSooQidomFHQErZ+Cu9ewUlh92f+N33/g5IvD
fgg7t+t6CJqUHVcZN9DDrZzA60WRjV1yLAvDxmwSllEJtKxplGkp+Qd2xmq7nMI=
=LuoB
-----END PGP SIGNATURE-----

--XjxGazX6lEnETewT--
