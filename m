From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 02 Mar 2014 11:35:50 +0000
Subject: Re: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
Message-Id: <3584854.kj2ZbTBvnM@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3995506.yNc67RbtKp"
List-Id: <linux-sh.vger.kernel.org>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <20140301135002.GA4307@katana>
In-Reply-To: <20140301135002.GA4307@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart3995506.yNc67RbtKp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Saturday 01 March 2014 14:50:03 Wolfram Sang wrote:
> > +=09cpg =3D kzalloc(sizeof(*cpg), GFP_KERNEL);
> > +=09clks =3D kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> > +=09if (cpg =3D=3D NULL || clks =3D=3D NULL) {
> > +=09=09/* We're leaking memory on purpose, there's no point in clea=
ning
> > +=09=09 * up as the system won't boot anyway.
> > +=09=09 */
> > +=09=09pr_err("%s: failed to allocate cpg\n", __func__);
> > +=09=09return;
> > +=09}
>=20
> I have problems with this sloppiness. Writing the comment took probab=
ly
> the same time as writing the proper exit path :) On the drawback side=
,
> static code checkers will keep reporting this.

Then static code checkers should be fixed :-) or at least provide an ov=
erride.=20
Given that the system won't boot if this fails I don't see a point in a=
dding=20
useless code to the kernel that would just result in a larger binary si=
ze.

> > +=09cpg->reg =3D of_iomap(np, 0);
> > +=09if (WARN_ON(cpg->reg =3D=3D NULL))
> > +=09=09return;
>=20
> if (WARN(!cpg->reg, "can't ioremap CPG\n"))
>=20
> ?

We can probably remove this altogether given that the driver doesn't ma=
ke use=20
of the ioremap'ed memory.

=2D-=20
Regards,

Laurent Pinchart

--nextPart3995506.yNc67RbtKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTExegAAoJEIkPb2GL7hl1+f0IAKhADAj8LwPdCrSZatrjfmGc
zFGNWNYwF36mqHC4gCOPbwo4mUf3FPRg+zlEOD1vRcylMOXIr4sr64HpJJyNZ8JP
4cdqBRk0RVzLsJi+wKeGbZvZhLKd4NDTeZ6oHAIND4hUp7TYP/GkttcA4pIFPnuQ
4j43YATDQGqxKasuq2KzGKUZMIov4hHNqLf2aK7sRJEZBls9pMmfL4HEh+XPBrwI
Ypfxgwy+o5jMhnlh2o9xiOsiAnnSMJwEjIiSIoIwPa50jTWaeieMBj7xGi2rw0pq
Uaw6jOq8vxL58yQsQRwLBr3SOpUlt+QKGt/GOYjGwODEDJGiGMtJOZLW9ulcOSo=
=VNTl
-----END PGP SIGNATURE-----

--nextPart3995506.yNc67RbtKp--

