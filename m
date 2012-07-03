From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 03 Jul 2012 13:22:55 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120703132254.GM29030@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8m/hfNLtAhX2NvnO"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 02:44:33PM +0200, Guennadi Liakhovetski wrote:

> Well, I'm not sure what approach would be the preferred by the=20
> maintainers, how about the diff below. If it is acceptable, I'll split it=
=20
> into 2 patches and submit properly.

This doesn't seem right.  If this is useful we should just remove the
configuration for the fixed voltage regulator entirely as there's
nothing platform specific about this, and we probably ought to be going
through all the boards using "real" regulators adding selects for their
drivers too.

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8u7QAAoJEBus8iNuMP3dhnwQAIkJFk7Gdp798kqz+WqHsNC0
wC/4tR9Kv2qfJn2HA7TN0JdOx/NlY1ouks/8b76Rc6C6A6lMDDSS0dafsOvd/oIf
FwIaTncX73s/F27tot05Bq+R6qA2bA1iVEn0eYsNgmq7CmW/B1NmmWypd2zVQRJe
J49I9zjtfGE8ucglA8JbjIImT5rX4v0UAUs8DamicdcAtsYfHSpT7W9f1yNPpt4W
qtHzlb+cQ8p39EwdAqzajjCPY73HdiUMjnqKa+zjVfJPb8E6dEc0HV21HhSAncQF
Kyn5zFunWgqjb9dmJTC27N9kTK3ogyJz2F/32LimQztRyTqNNEUNYJxGOBusGkzx
bG9NrV/JHxXkRVF8aA6bJXOdb+giX7nfG4ZWIfle2dADPfSWYQRVXOznyMJXN8OY
39L+VbxOnK9SEw4bkLxbR0+WNCo2gurfuxkf/LMY0Y8bCOtNI1pLcF7w9wk5EaHf
WpR3BrzScp+0OHde301Oddm8jUxB1aA5pkseJFWDaqw/wuegl8bnO175zXUgZPf6
dPVIn05333QsSGijbXKT9pyD4BNyYlW4RZ3la7BCimyB9zLbHpFMPqYpy7htPooa
rqGgcT+0W9/aTjDDCUdUynkhl0tZ/YSTdHWI5jINKiK62nX0FJcGqzEkuIMQmq+l
+r6JjCT+LQjLAlyjJQqf
=gfCo
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--
