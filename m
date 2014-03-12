From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 12 Mar 2014 18:22:57 +0000
Subject: Re: [PATCH 00/22] SH MTU2 DT support
Message-Id: <1494085.tZpBLnavTq@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1770098.1NLqldQ83b"
List-Id: <linux-sh.vger.kernel.org>
References: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart1770098.1NLqldQ83b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Wednesday 12 March 2014 19:04:02 Wolfram Sang wrote:
> > > > The patches are compile-tested only as I lack test hardware. Wo=
lfram,
> > > > would you be able to test this series with your CCF support pat=
ch set
> > > > for RZ/A1H ?
> > >=20
> > > Applying to current renesas/devel fails. What is this based on? O=
r
> > > better: is there a branch available somewhere?
> >=20
> > I've just rebased my timers devel branch on top of Simon's latest d=
evel
> > branch and pushed the result to
> >=20
> > =09git://linuxtv.org/pinchartl/fbdev.git timers/devel
>=20
> Thanks! I merged this into my r7s-ccf branch now. I could boot into a=

> shell and the printk-timestamps make sense. So, for the whole series
>=20
> Tested-by: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Daniel, I assume you use git-filter-branch, or shall I tag every patc=
h
> individually?

Thank you for the tests. I'll apply your Tested-by tag to my branch. We=
're=20
still missing review of the DT bindings for this series. I'll ping the=20=

devicetree mailing list, and if I don't get a reply in a week, I'll jus=
t send=20
a pull request to Daniel.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1770098.1NLqldQ83b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTIKYNAAoJEIkPb2GL7hl1vesH/AqwjlZEzYaf/VRzQU/vXtRe
88M19S8KTHgUMkbt1NMBI1IfKiHKZVVh5csy524bgPJ+JHsHS3/myM8J4LT16/eV
GYVYvxtevnk7W9oOAbxd++GXsNXg+4RIK+5ZPTySOvZ+bApUYMb3oWj4WbMBRdEq
0jJpFRkoklxRq4pVNWJceRz73rqUIoThpqUieDpv065+FLebIZbDjcnkV5K4lXDX
AiV7KhmRjKx1hxXlyI75S6Yk7BepEe6NTWTE8X+s+1cryJpvlY+RnM34elGywEjT
/GHWJwLPWi/WJW6E0TuYMWwk5RTZ0tf0BmHT9cvX8FT1QV3zQH0r8r4gKYxKIes=
=MjRj
-----END PGP SIGNATURE-----

--nextPart1770098.1NLqldQ83b--

