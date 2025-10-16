Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457B18FDDB;
	Thu, 16 Oct 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652530; cv=none; b=DPy7Wo/4cgWyuSKRWucyPG+t1z6mFaNjxRiENu+IvWkLZnmVypzlj86ZvgT5ilze/RYOEeIl7ZwnwP9zcTvTrcGFOSZZfxaEhzNVNpr9BPGSvW5Lmfcm7wd4ntw5qPtYUJAlh/0aW4JTrOnEedu4cV/4qULIWxjoiFw1PIIFqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652530; c=relaxed/simple;
	bh=pKvKUgdkUKwG51UlkTrr4qg6LoxInFipSwpVGXY8GxA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bKnRV932o5fk9MB2VGA5+Fbwy1DftN+1X0JBE+lYm7J7v3LY58REcj9mqEt990XPgNm6UrlUWK1uBso8ACbiXM78ygbVC1vQhCrJgcniQwF/WYk7zELhL645DFCBgHs8HXBGWLHPC3YImxX6wnFP2+SefrN0LEA8lO9VJ494goQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Bc71DBDn; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Bc71DBDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1760652317;
	bh=pKvKUgdkUKwG51UlkTrr4qg6LoxInFipSwpVGXY8GxA=;
	h=Date:From:To:Subject:From;
	b=Bc71DBDnoopyJthECfqjKho6/kpN85QibzGqtInElep4fRX6DtlRY1ExoNIxtEIvA
	 xMlKW76vxkio74Cz86IBI9gOcqkzCrDXju3MzDr8SrLVVmhCyiGaEuHsNBOFkersJJ
	 bdU7oHMZM/P8gslKKX1cPG9+qWuWyI8KGRVEWwZlTkFP0pCn4k7WVKHIC5JpekzvWl
	 lImgAGwys7rMRwE7pUDMmOe42MiON1W5fPISLbOI1bft7IG7aT8ErrSLfZZv3QkKPW
	 V/FzQi2NYkMHcGPm3e7iI6cP2Z9PdacldSZEnqmNtvv4pNaeCNXkgX7XoqRq0/jJpL
	 /dHhze1si+S/g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 20A3A9540;
	Fri, 17 Oct 2025 00:05:17 +0200 (CEST)
Date: Fri, 17 Oct 2025 00:05:16 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Paul Mundt <lethal@linux-sh.org>, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: hp6xx: unset apm_get_power_status on unload
Message-ID: <ydtnrqqjuaz6uifqplujmqwdnpxoe7ma33d5hp4waavekerod2@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ethnvwrgdpexrx2w"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--ethnvwrgdpexrx2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The API for apm_get_power_status is "call it if it isn't NULL".
If the module is unloaded and it's not unset,
reading /proc/apm will jump into unloaded kernel memory.

The first commit that added this incompletely refactored
the assigned-to variable in __exit,
the second deleted it instead of fixing it.

Unset it on unload like drivers/macintosh/apm_emu.c.

Fixes: 0a9b0db19262 ("[APM] SH: Convert to use shared APM emulation.")
Fixes: 8c8ee8254767 ("sh: hp6xx: APM build fix and new battery values.")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 arch/sh/boards/mach-hp6xx/hp6xx_apm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c b/arch/sh/boards/mach-hp=
6xx/hp6xx_apm.c
index e5c4c7d34139..089eca39c4e6 100644
--- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
+++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
@@ -98,6 +98,9 @@ static int __init hp6x0_apm_init(void)
=20
 static void __exit hp6x0_apm_exit(void)
 {
+	if (apm_get_power_status =3D=3D hp6x0_apm_get_power_status)
+		apm_get_power_status =3D NULL;
+
 	free_irq(HP680_BTN_IRQ, 0);
 }
=20
--=20
2.39.5

--ethnvwrgdpexrx2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmjxbBwACgkQvP0LAY0m
WPH3KA//U1fjA6GQZjwTQGkOuBhgN5DIwPgQ0S3sEx2P0ExvqCiyxzM5iO1xr3oP
iMwWyZukLxQ5hhMpRHdWizQiJjEQSWaUJfp58xNtfXiE7F7V7GPd3BN8q6osJTEt
TMBP02Idm9nDCFqbA9/AWAmL4Fvkn2erqIQVL9fWu6zfykySHbNzq6lKhtrBnK32
3tA1ngQcjKQf1SJl0hc/9Kij49j8TjzN5SyYxt9giqT6SbLAfi7W6UQDoiRhnzq/
9qWabu56d/g8XnzjJCfHM6Ei4GoN5aFucv5ieg8z5prT6MrZzgDXYA+bGt22AK0K
ZN1lGAB6yKzUnbyEhEzLsqNcka+twqaXsVjTMe+sWW0cKdxi7hsPv9yW5/upEpmC
gIp7/ldRCeFJWyNU+Xq+fC/eZyMqj+FzyxgVg3pp3IAaFFK/XJeTK95Ut5jX3QLR
AGJr+iw6lMdPoB04+SowtEq8ZZhc6jAsvH0KGba6z57PfpXaH3dUQsrzDt4RMArD
fazqosY5g55mcPY8sSJ1ftHG2/LHBUHVaz+0q50TKM9jQDF/zC9DgRkQH91tiXr+
BYzpXVUYufdpdkBWBfhP6T+a298MIE20i2RH2lkESm5c7v6kD+IPpZQBZ4siXKnD
p29Sy6c6QDdnCL6xWnAQQH5hTjV3Z+3AiBuHwXcTT6/qg9Bt5C0=
=yztO
-----END PGP SIGNATURE-----

--ethnvwrgdpexrx2w--
