From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 12 Mar 2014 08:29:44 +0000
Subject: Re: [PATCH 00/22] SH MTU2 DT support
Message-Id: <20140312082944.GD2756@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="g7w8+K/95kPelPD2"
List-Id: <linux-sh.vger.kernel.org>
References: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 06:47:07PM +0100, Laurent Pinchart wrote:
> Hello,
>=20
> This patch set implements DT support for the MTU2 driver.
>=20
> The first 17 patches clean up the driver to get rid of its platform data.
> Patches 18/22 and 19/22 then remove platform data from arch/ code. Patches
> 20/22 and 21/22 drop support for platform data completely from the driver,
> and patch 22/22 finally add DT support.
>=20
> The patches are compile-tested only as I lack test hardware. Wolfram, wou=
ld
> you be able to test this series with your CCF support patch set for RZ/A1=
H ?

Applying to current renesas/devel fails. What is this based on? Or
better: is there a branch available somewhere?


--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIBr4AAoJEBQN5MwUoCm2ZcIP/01xkejtJIu1yvxHC3NdiSd2
RNLovFHGRP53SYhWh8Huvm0UfHwqWCIHvksdVUsvI1lhRqmprH67aHQwYc6wSHQm
5oYMCvmxbkr4l7ctPPuBX6YvSNrH7q+xbIhNwJmXFRy+DYfLu3Hdbgi4zsTPadMy
hPEF2uQLxZJKWReztG+NsPvqmpqiuVuuZ5DvAVxh2cJ4BW9JqZU3mH7KDkNXOTWi
GL3RjUL5upFDpV21NunGBznpEEnfsr0/QiH1esMAu72zQI0tSzMNj37EmuQYLu85
JqPQAWI72/li4OiN7ydeCAj0dsAn4FQJ7NlHQyVk5IHI4NbvFTfCJPDfOUMV34xm
//V3OANb+LWL0Is/dStgD2qAeIKlwxlJLDq0Qs5NIn9/8NeoVizXXQaS1EtEsKB4
ClBnK3iuGYIfbLZM+VAsDBpuT/0kDq4KQxHaAU3xc3vKCom+bqGTzgDgx5NghldX
PBW0BvPGoo8e6J93mYl77I7HBKk66knVBYQj1Tslyy7flh1q0xqU72ioOzt/9nvu
3BvCdX5Ss3oVEIHB9oiOhRCVQF0U8PErcUWlMI3hRsaacmCRwHtwC4bB+P9qw5o5
/X5mQYieQGx+x8G7j1WKq4h4mFxF57WYV/nV+qtywHK5Y5Ki7yQ6StUsKk5Ta3rM
Z+alb+7zNzoEQRDKqe8r
=8rV8
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
