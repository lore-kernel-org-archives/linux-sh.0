From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 12 Mar 2014 18:04:02 +0000
Subject: Re: [PATCH 00/22] SH MTU2 DT support
Message-Id: <20140312180402.GA28891@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
List-Id: <linux-sh.vger.kernel.org>
References: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > The patches are compile-tested only as I lack test hardware. Wolfram,
> > > would you be able to test this series with your CCF support patch set=
 for
> > > RZ/A1H ?
> >
> > Applying to current renesas/devel fails. What is this based on? Or
> > better: is there a branch available somewhere?
>=20
> I've just rebased my timers devel branch on top of Simon's latest devel b=
ranch=20
> and pushed the result to
>=20
> 	git://linuxtv.org/pinchartl/fbdev.git timers/devel

Thanks! I merged this into my r7s-ccf branch now. I could boot into a
shell and the printk-timestamps make sense. So, for the whole series

Tested-by: Wolfram Sang <wsa@sang-engineering.com>

Daniel, I assume you use git-filter-branch, or shall I tag every patch
individually?

Kind regards,

   Wolfram


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIKGRAAoJEBQN5MwUoCm2PEIQAIQF3CHVF9WhjylGqUljY1Sh
Syj5i/JSalAvp/I1AeNz5XSfVZkk+sUzw7PT8oV3HIFfQPM2UwcQv3IQRusHsYmg
NYN8Krn3a2+APDY8gC4fLnx6bkxDvPqZs3YMGL7Q40U5AwE6p6f6kFHMul5LNuKQ
juNGzzRzgTyJaRa3J/g8tf2kqciMDtVHOHk9ChywmO6HQRz/9k9nJTvzyRiaNEqA
ljpWhdZ6dMN3dGIGGvkT7VmoEjHQzSHS+P05tMmdeJ4mfCoVTwokviOPqB0IMey5
DcZp8EIuemAW+d/e2P8jvI12WuUwBheIxVflrwouQtk+Sl08ZBqngapfTR+UyvmB
ZNui921YEgXqGMASjhwfpV8WUrvx0+t1RR2XXe5JeaUTjK1hTcVZMBLRpM4Y6P1m
uwcj72kEIrXScwuvIo2Ak/vNCOvn6e/YTGTh0CoP8zSNanky4foaG1mVrRGbV6Js
UqZYz7Pfbt3KYBR2l/N6/L5RlPU4SOnYGpmx6/OboHa1VjOYiwj/ajXq+GLFGpXg
U9c+gthaHB8uD2V9ymJsmPgRhZ2w36+JGQVtrcO2pGl+urt1mElrN0hfi4OQlUM+
AAJVfzJEhufSJbfTBViVVGG0FcIG+UR2XDlXM1e6ULZHHCbxGf07+U1uRkEiIs8M
Y884IMyv0pl85Hq8FUZ+
=mxma
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
