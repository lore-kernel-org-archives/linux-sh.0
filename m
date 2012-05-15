From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Tue, 15 May 2012 10:47:05 +0000
Subject: Re: [PATCH v4 0/8] sh_flctl hardware ECC mode cleanup
Message-Id: <1337078825.2528.157.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-fZ5BGZjC5PHIrVz684HH"
List-Id: <linux-sh.vger.kernel.org>
References: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, linux-mtd@lists.infradead.org, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org


--=-fZ5BGZjC5PHIrVz684HH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-14 at 14:14 +0200, Bastian Hecht wrote:
> changelog v4:
>=20
>   - removed arch/arm related patches
>   - rebased on current l2-mtd.git
>   - fixed some compiler warnings
> 	- patch 2: use "int irq" when removing irq binding in error case to fix =
smatch breakage
> 	- patch 7 and 8: just directly use the void __iomem pointer instead of t=
he unprecise void pointer to fix sparse breakage

Pushed to l2-mtd.git. You can send a follow-up patch for using
"oob_required" parameter. Also, I CCed you to a thread which discusses
busy-loops I complained about - your driver also has a similar
busy-loop.

Thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-fZ5BGZjC5PHIrVz684HH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPsjQpAAoJECmIfjd9wqK0S4EP/ie7bJQlMeDKxLa/eao0ub40
drLsPVNoq4aFRFF6LxOFYn5v90j7I9cp3OFHJLBB9PxxM+MdUoRKTNr/PQm7BusR
2McnGrlHwKNjhUziFwp/GrMsIFW2YV79yDE5TdAqNCiy4zFdIysb59VTI8TmnUxt
YsqX+FOPjvEDoPUhrGomPWUR75m+zKvDSK4KtS9X5PoWMSYMY0f2oc3UhdbPHWKD
KU+ykeRT/W6vRFZ+bDw2UjVtOT6WR8xYa6CGanU0xfa4lmY0p8bFMDjBgXCOZ3v9
KFWDX1tyRj4ivIO0GaRJ2tPNMo5aw4PvQUszJKkQpSVw+ienq6VqH7GRnZ3jr5aC
XD0A6JTtMZyF0SIlUOVZyN28zqkXGrBP61iDFQPT9pcdSQQsi1ApHFwMsGGJubv6
LjoJEv5wJ/ZvIKm0oC5ehdPdX6qXwZWU8ywVfF0F2C98cJWHXzz7Z8uM7AhifATq
hMz3grNFzxsMGHGKbsZv/Cmd3MxCzRJVGkcyERnd7geNbK1teLORJF5hg3tjUgdX
hoeymsYOeUyDAsdyY8s22MjisUOmzLL5rObWVdXXpELK4TTnI8Hh4Ly9CVbe6Jft
6XtAIqhRec0HLkX8fLNraXO9ZPCub/KfxxbJYegDgVpvuEJaZqteEtLntkI+voXI
4dcs0NxI0Xy8qlMZnCGI
=Pewg
-----END PGP SIGNATURE-----

--=-fZ5BGZjC5PHIrVz684HH--

