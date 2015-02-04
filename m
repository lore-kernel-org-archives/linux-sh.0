From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 04 Feb 2015 17:32:34 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <20150204173233.GA30930@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 01:27:21PM +0100, Geert Uytterhoeven wrote:
> Anyone may call clk_round_rate() with a zero rate value, so we have to
> protect against that.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I agree that this should not be fixed in the core because the fixup is
really driver dependant.


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0lexAAoJEBQN5MwUoCm2LnIP/145DCdCAQhqZ9kfNWC+y4ne
M6uWIeVWwseZnzdu1wqhIqc1Zq/ca2Vfx/16IOYI5sBORx7XxbY2TSq+Pj+zchYc
6NKTNF1DRFFfVrzTemjSWZ9cqF5HP0pjlGwZXZLyYSgmiOEvF1m8jAtFvFTwPe0z
svocac+hq7bnynmTg1y2XH54gGI1rwrtvS9QX7dYMXSC6tULNuppQ06Y/rVsZcIb
Gd/dzE5dQv+PBL95dPSQgWOBhoGiaXENcE/EQlo6Q9YOOgBLIR1I6yJP8aQDb9cW
Fie9skMA0rPSN6wuLJmA/0woMvoIOgbCDLK4sryJS7hD2i3rWm6orzayjSfp36qY
UWDcWfcpFgCl6FHEhhuURgMx+lli2Qk9dwBWmuAU12/jIB3b71+Wobp49RZs759Z
wCFyGF/Mx3FjO9Y15gCI7nhLe1ivKUIU3xQkM5kPVNRFDLV/efregXtaqtzUP6Vu
DG4zp9SP45XJPAA1dqcf7Zw58m/g6XfhKOhNPiMOtMjpFCDLrkgz5Kla+hFSoBID
RqIYmgQaOd1BjZ3D4jrn2YavBGj8rLvcE1ZiJknntv/w19LPFDV5LUB8Fgrp+hpf
jSgKnit9N+ssEYHdOFUAyipX3ZXOwqKI+IGPjEjpVd0qCOJfha+ZXXiLvcW6ZddI
RYQYykCkRePDZn/LPseo
=p4lZ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
