From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 30 Oct 2015 11:41:45 +0000
Subject: Re: [PATCH] i2c: rcar: Revert the latest refactoring series
Message-Id: <20151030114145.GD25117@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rz+pwK2yUstbofK6"
List-Id: <linux-sh.vger.kernel.org>
References: <1446204606-25541-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446204606-25541-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2015 at 12:30:06PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This whole series caused sometimes timeouts and even OOPSes on some
> r8a7791 Koelsch boards. We need to understand and fix those first.
>=20
> Revert "i2c: rcar: clean up after refactoring"
> Revert "i2c: rcar: revoke START request early"
> Revert "i2c: rcar: check master irqs before slave irqs"
> Revert "i2c: rcar: don't issue stop when HW does it automatically"
> Revert "i2c: rcar: init new messages in irq"
> Revert "i2c: rcar: refactor setup of a msg"
> Revert "i2c: rcar: remove spinlock"
> Revert "i2c: rcar: remove unused IOERROR state"
> Revert "i2c: rcar: rework hw init"
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWM1d5AAoJEBQN5MwUoCm2WpQP/3yEg4ATxkoAMk5Bb4UB2byz
02bYwxBVjr5LeuRXDNmilncRbBRF7TB7YUtjIulotb/fg7mJs5bmjrQiwN92rnqP
/GL/qmp1gpXU9AaeCH8TOHqYoeJIJ7DNBH+RutVhsV2STvRJduOZfY4ZLZEZ4n5I
QfcX8wPva8OfaZuiHiKQ0CvfDkYap3WDcw5fl9J678woQacmiSm+lUz4vS3S0Eol
oNkVduk8hiyLOEGOQM4GONmYyY3UXgxmTqwdQce+7gitwZa4yJ0ug2wDOPRoBUx3
f8oQeGouuTfRFeZt2URs6eP9/mf+XQkXH0mh3VmnlpHyDUvy8TzeNnpNrBocJJlP
1v28nwTWFMdh3GK4kd3lofehTPtlBui4VpmszGoWAfvXQsrlzQ6qtE0pS0WhTTVQ
V6RYIGZ08iK4tjM362M1ioisxzniH9HYTPgt/HXem68iMfdehVym7/7hDpzal+pR
8h2V+rb05vmrbocJpeGwYSLI1m4/cZRuqy2RXUsFVJn9drptdLoTAvKCDHi23laj
+8FCKVn+FezG3O3UuTfus+NWSshg+v/MVj34aj1BC+GkhC8y/vOnCg1Xgh2/gbHD
735rGRClLz2xIROcFzHZMkM5eZ4vwyjM4kyKhoPw8lE9dT3OSBnuP4mS5S+YnWHM
2m2dI1PVn0O87/EHibpz
=3U3t
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
