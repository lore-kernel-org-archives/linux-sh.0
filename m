From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Thu, 03 May 2012 06:01:48 +0000
Subject: Re: [PATCH v3 02/10] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <1336024908.2056.3.camel@koala>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-UBLMXI6VR5uuO/Ys1CN4"
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335951710-9390-3-git-send-email-hechtb@gmail.com>
 <201205022249.30426.rjw@sisk.pl> <1336024825.2056.2.camel@koala>
In-Reply-To: <1336024825.2056.2.camel@koala>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Brian Norris <computersforpeace@gmail.com>, Bastian Hecht <hechtb@googlemail.com>


--=-UBLMXI6VR5uuO/Ys1CN4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-03 at 09:00 +0300, Artem Bityutskiy wrote:
> On Wed, 2012-05-02 at 22:49 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, May 02, 2012, Bastian Hecht wrote:
> > > Supply the platform data for the FLSTEI error IRQ.
> > >=20
> > > Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> >=20
> > I'm going to take this patch into the renesas.git tree and push it
> > upstream throuch arm-soc, if that's not a problem.
>=20
> It is already in the MTD tree with the rest of the 10 patches...

Ops, sorry, this is not true. Then Bastian should separate it out and
not send it to the MTD tree.

--=20
Best Regards,
Artem Bityutskiy

--=-UBLMXI6VR5uuO/Ys1CN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPoh9MAAoJECmIfjd9wqK0iN8QALm8r3Qd7Q4lW0n0I16/SGSx
mT7c1YyLsHh1Lp+0ZBaR8oDIxTwTn+5zeZPNBImVNMK7YuuI5+yV79J+S1E6Q/3n
9QaEqwsL/YPoB5dCLDqj2sJ3iUnGId4qsp/nOvxwC+kbMxNph3qhzsT+3XjbZSYf
vp+fY63JjNCHntA2VR0Clrs3hI/w0rc2Uo1zlKIvJ5gE8cbIQ28FBqUEHlQxMQw2
fzn1F8KNDaFP7ced9ec64QXhEAqGu4LZq4495nR+QvHaEvN4uohaK4pBU7r4mtG1
U35AAOKuRyfyuf0YmEFzSiRH0FjzSzXZ/BQx/MDLtWNS3TTTvFRutkx4OjPt31Vn
1vwladmBuFDDYivuaVC2UjlAp++TdbEQq7gc/Y4KLOGccmcrr70gODaJTzRbjFLw
Y48VEt0Q9S1zQaJBptxFAL4ktzF8Zp9WnrarPtLLabs75UB2oGVvUaZsaKMjnIZ/
6dQj9lyT8t3e9/pdPZzJZ1DMf2Z0//tAH4c2xteLVYTn4EJU3cwLlkeCunYC0D1A
fNplUjiL5lVVwrA00tsy7+ti7/D/uisIO3EOf6Y5k4tzaR8+BmTys15WWUyH0fBN
/Sbwnp8EazxjocBTzaheV5UfvwVpN84hUWta7gjeg60GKguHeQfZ3EaVPIb17/Mr
YeHKX6wz81O5p7NL9Als
=6chE
-----END PGP SIGNATURE-----

--=-UBLMXI6VR5uuO/Ys1CN4--

