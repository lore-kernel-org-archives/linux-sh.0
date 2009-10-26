From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 26 Oct 2009 21:14:53 +0000
Subject: Re: [PATCH] sh: add uImage.bin target
Message-Id: <200910261714.54493.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1587950.krxc28RfD7"
List-Id: <linux-sh.vger.kernel.org>
References: <20091026101239.13565.94659.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026101239.13565.94659.sendpatchset@rxone.opensource.se>
To: linux-sh@vger.kernel.org

--nextPart1587950.krxc28RfD7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 26 October 2009 06:12:39 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
>=20
> Add an uImage.bin target to allow uncompressed uImages.
> Useful for boards with busted u-boot decompression like
> the rsk7203 on my desk.

might want to update/fix arch/sh/Makefile's archhelp in the process (seems =
to=20
have random tab/spaces intermixed).

i'll be poaching & adding this to Blackfin too ;)
=2Dmike

--nextPart1587950.krxc28RfD7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK5hFOAAoJEEFjO5/oN/WBqcUP/0S57Xwsql8fyp0C9unaOzPZ
kFbxj07q/bcaIf6XzXgGg96qn55O7cmj0StKUJ8QtRgyBeJqQGN2kzdhByqk+3g+
MucsdIkAsfwgpnjyU6ckwzN/o6Cqg57X+VfWUpeggXmIi2P3BqSDsMpX4nrjINVe
rCVkV4MXR5P7eM+40p9Jn/8yQ4fTmLjo3UmtH4QoE+IWjnkS3bE9A6Lkh/rZA88H
8I5BQX9BeTI3Igp+dGb93RN/m5B/BPz7EwVhT9TEp0uKRB0CmmVUurLKBnY+yHvq
5sM2wSIVY/tTHNpn8kB25v3Hxm/UvRlys8zkP73geGfTpgKXjwfIDuqUMO1H3uiM
cd8DMUHgdm+Km3PYToznoXj/vx5EOjBr0NRr954LkojHaop8iClslJlWZCcX9Ly3
OupyLAAIx96doVh5m43fPq/saJTHcIFy6nPuYihB1Ts5TC3VkdcUXods9vWMguj+
41bmqkaQ5tjSGuuZWYIwzRMtXEFZJh7A2fhKUEfMkAGqByiuGNwr+zc9/Gbx3eaM
RtM3p+Cu9p5JfG0lUkPg+GCY8VnCaMeakB7n72XiLiJ0sd87BRuv/twWt1jV0AfI
3615wSOYWsZTGw/gUkcTsdZracMTYcJ+haBE7bnkf4T8h8rqMPVV+eWz0/1arn+P
sMMhqkn05dwkzpNmBJfa
=r3vD
-----END PGP SIGNATURE-----

--nextPart1587950.krxc28RfD7--
