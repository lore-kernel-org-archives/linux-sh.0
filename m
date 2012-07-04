From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 04 Jul 2012 10:48:42 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120704104841.GJ4111@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jIYo0VRlfdMI9fLa"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2012 at 07:41:09PM +0900, Magnus Damm wrote:

> Right, so what's wrong with having a "select REGULATOR_FIXED_VOLTAGE"
> on boards that make use of them? That seems to be the most
> straightforward way to me.

I tend to agree; as I've said several times now the only sensible
options I see are:

 - Add the selects per board.
 - Just enable the fixed voltage driver whenever the regulator core is
   enabled.

Anything else seems silly.

> Also, I know too little about the regulator subsystem, but to me it is
> somewhat special that REGULATOR=n behaves differently than REGULATOR=y
> and REGULATOR_DRIVER=n.

What's happening is that the regulator API stubs itself out when it's
not in use in order to avoid having lots of ifdefs every time anyone
tries to use the API in generic code or drivers that get used on
multiple platforms.  This is the same behaviour as gpiolib, it's a
similar sort of utility API.

If the power on defaults for the system weren't suitable for whatever is
being done you'd still have an issue even with the stubs but a lot of
the time the main effect of the API is to allow drivers to do additional
power optimisations.

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9B94AAoJEBus8iNuMP3dVUoP/j/tyzMuGY0Gcq7UGf52+qy+
f8xxPr4v9ug11YJcDdC8DJT20zMb3ogv7AaNHNX9g8yukUdOYzuSRvsDB8vrH80Z
8I0da4xHSZkPdjnLNCEU/dAujRjx6Qs0+gepq6El02DRsnuCvyx6FNhjA3d5M11e
XfYe51wFpBce3tFzJeiqt7v9EevB3QwsEomHxBuvIhYkzsTV/3zmoQ2UmmKTbeuZ
EUM4TdojmIfwLDavPt61Jbwv4r9NVqCLH8m+QAFOSPhz+6Vm0Dufw3giJOm8O2md
E1ibdTHBgAU9Be7l3F2cGKYVF5Vyz3MSUjIcUY+hKhiOJ0qiz9PjL9E2+5ROmXAD
s/Xkd3Lh68fQ4xa0UGPZ/9MzDL+AhKAudSy7whccnyJ+BPNF0sWQMZEkP/3EZsEy
dC/+43ca49p0Z/vY42N1TBGvzeflIQ7gMl3T8FqzMzKT0Y0c/BAxtC9XF3twUdwF
p/oHwBofQ4wboZ7c+idxhxHRre24S6mCx8zIOj/mBqyRjxPnwuA5ckGlXZln0xgg
5ozCHHmw7hYnoK0h9GRMEUBMwjRg+7q9KVdFGDCqcaNNZE/Cu9BQHRQMWVVJUS0z
+AZ8wo9f35aFdFSE6OjcLeef08OYzAKNnQtyvPOAFtgi9QUDwjcdd8LCmjcFhcuQ
WKwSRlZJEA1g+lSr6q+R
=yZ/w
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
