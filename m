From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 20 Jun 2012 09:48:56 +0000
Subject: Re: [PATCH 01/11] ARM: mach-shmobile: add a temporary macro to define fixed voltage regulators
Message-Id: <20120620094856.GC3978@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9Ek0hoCL9XbhcSqy"
List-Id: <linux-sh.vger.kernel.org>
References: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
To: linux-sh@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2012 at 10:01:30AM +0200, Guennadi Liakhovetski wrote:
> Providing fixed voltage permanently "on" regulators with different voltages
> shares a lot of identical code. It will be eliminated, once the
> regulator_register_fixed_volt() function becomes available. Until then we
> introduce a macro to define such regulators. This helps reduce the amount
> of added code in each platform file and keeps copy-paste errors to the
> minumum.

Or you could just pull in the topic branch I created for the purpose of
allowing other trees to pick this up:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed

which should save everyone work all round.  Just don't rebase.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4Zx7AAoJEBus8iNuMP3dctEQAJDsJY6fjYS5zZ3jdw9DubIr
snUgShEmB8IUfuKGrHQI2mVKF546L+HJl7WB7rNU8bP8hjWHIAWB5ISvDvShIECY
eDN3K9BzEwd8V2cKZEpkMS7t/DdPPGyC4Jp98AyDCTnuH6t/sNIjqy1j3cksU7P0
h8xVPBlp3C6+opfC8VtY1OLwp9/t0dT3JVtHX170dXT1Yz06EWK64DC1kb7EEdxO
VTjFI4uyfa2R+Q1WxQFwaZkk7B2JrC1KZivXR8cKxS678sIzOeUQDTFROe/Jppsr
M/IVzAFtPlddKth4lbDYWFFGegPZwGVrDZ0+7I0DxP+sEhkOQa+F8Cl1co3WW7RB
UZshp+i2zkYt6wCVWRbDIoh2P9cu1NofEb+pc1BvySV1d+pINGHcT996ZotBQlOs
uo1wG7dkOKY3ZxHapkkL/SMxO9xVoIuvP5hDXybw6gaCQ9TfovjnG+MKVQG7kwLx
TvVIMHn/pldoHJaUGD5iIfMXN4Aw8Rmjgzv9ZzOpwe0hPvCLULl0pFYlic7Zh4jg
KA/CAegsmITevULfe2Yb4uELGtIxciC359b7Rtd8xplzlh5AfYzABREjqYcKbhfI
iKI9Px/loEIovjDNuhBu77zf6msbnq1EH72QtSjyF8Y7AtBmpbAh9S6W2JdDwBy/
ceG6CQekw9HAt10jjCJu
=Ank+
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
