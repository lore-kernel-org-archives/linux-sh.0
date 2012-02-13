From: Felipe Balbi <balbi@ti.com>
Date: Mon, 13 Feb 2012 12:22:16 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: (cosmetic) simplify list operations
Message-Id: <20120213122209.GT6614@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="m1rwLFmcefDs/2Y3"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
To: linux-sh@vger.kernel.org


--m1rwLFmcefDs/2Y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2012 at 01:19:36PM +0100, Guennadi Liakhovetski wrote:
> On Mon, 13 Feb 2012, Felipe Balbi wrote:
>=20
> > On Thu, Feb 09, 2012 at 11:17:47PM +0100, Guennadi Liakhovetski wrote:
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >=20
> > if (patch_has_no_commit_log(path)) {
> > 	kfree(patch);
> > 	continue;
> > }
>=20
> It is a common practice to omit a commit log in trivial patches, where th=
e=20
> subject says it all, just look through git log. IMHO this is one of those=
=20
> cases - what else can you add to the statement in subj?

something like:

"list.h already provide helpers to find the first entry and to move the
tail of one list to another list. This patch simply uses those helpers,
no functional changes".

--=20
balbi

--m1rwLFmcefDs/2Y3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOQBxAAoJEIaOsuA1yqRE548P/RVbeb02QFJ64l1GsRKTnnAL
rV+FkHEJjYHW6rT3ku3QRNMuj/71F/XeH9QvCIQe891gd8mzV46CHceYukJpBp+6
b5VpcBNC/OuUCs5a8Xq862qAGt8CXfrbtvnWLptGmd9JAB6eFD6a1pyW1/YHFEly
B65hIm+tvUI1rR2hQLvH30f6B2PHUHuEJnuaSpY9IcFUlvPHxddg+v+r8xWVXFjL
+2d7kuX0IPBqM0DfM9Olu83cRROZ3bmkAtxeh1TaP6bKI8RHkh2nktjBEJPXy/Ox
7CHTyS/u4B1j16cBUDXN2z+v7vgMqkTVu1RfVWU+ZBySmYdz1pdgq8yX/TSva+8+
65Yq30qIqok7zADPTFnwDUaO/M+Qsbu03OwK5LscIZ/dstdkZNTCamqZ6KG/I6pN
gg2NuIiV7HV5EPAZXNbzteMgLVut3z64W2dlD/df+PU0GpkaX9R/c6aDXPMxN9kq
4bSWlzy5BqI2tSzyzYb94xhJvtiTF1511CigVZhLBgaB96mKw4Dib1e+0YqMoj5O
r0TmEp5FaP6QaKuAyzAcrRjQoov3oTf+n60lgqLycsAVwF45idEfL6T49jY5Qdky
YhXc70OVC6RlDvdJHQC+8QucGJ97gR1NkUPn6DGYKK3BbcvloYlBEQcH6XbJRr6O
JY0GBgJvLCHz/DG4a1Vr
=7Ayz
-----END PGP SIGNATURE-----

--m1rwLFmcefDs/2Y3--
