From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 03 May 2012 15:25:58 +0000
Subject: Re: [PATCH 06/29] regulator: export a function to check if regulator can change status
Message-Id: <20120503152558.GL3955@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UUBKWyapWpFAak7q"
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


--UUBKWyapWpFAak7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 05:05:35PM +0200, Guennadi Liakhovetski wrote:
> Some consumers, e.g., the mmc subsystem, can benefit from an ability to
> check, whether a regulator can switch power on and off.

You're going to have to expand a lot more on why this is a good idea...
Bear in mind that the regulator may be shared by other users so even if
the regulator is flagged as potentially being able to change status that
doesn't mean that it actually can change status.

--UUBKWyapWpFAak7q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoqN9AAoJEBus8iNuMP3d8zYP/iBcASEgMlHzW1IK3LjgbWbP
0/f6a7jtOibJFhxlgWlGdNy0zn/U1DCG1DAydAKhTzsxQPq5Z32Iw4sRi8OWCANu
iV4iT3cPkTImkENWDBN2XP99azfj5srnoWoRr9npoNloqQtRVKzAG87vNJUEfQFC
H/9wM4yhMAsL6QPZEnBHWa3yUhz30eN23V1gBkKSUGapAPsfuHMxTASMpm22t8t5
3JvAmJ6a07wpCFVrHQ6GbRsKP/KQr+PjHXNOYCM25v4mrePgqMJ6Loqfu16VWBZU
ZqIV+hmHPVGPtKeB9VpflK9SpOFiMjoSSjdrm/5DztxPMU1NCYWOCcnvak0/0VD7
FKrvXUk8qJY63aWzBnzWt9BK4jiRPqH9DgB0lJeo1FqbXklOYKVvFwFZNpSavw9C
6THf0ZKpIT1hb00nImylSDk022l6QDmizz1yhx8OVz1aMrDTHKsDKuy49fm0DKyl
zO/TAxHwD2Vu4p4Tc27yUpGhqEJS18a7XKrSeVRMu0kgPY7cM+1VWZqoTqwo0pDN
8hNDgVovhs6f3wv58UGqyt5Us8ZjeLwnieelahtkMUyEfcenUfxy0xMfD1vtmg20
8GHknqmxWTED4hF/6XNFt16iMZ+uy5YT5UVZLkczgNl9P2KHRcPYhLFBDmVSOuUX
GUTzevEpS0zA3jWHjih6
=LgQd
-----END PGP SIGNATURE-----

--UUBKWyapWpFAak7q--
