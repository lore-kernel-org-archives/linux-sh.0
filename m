From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 07 Mar 2014 16:48:52 +0000
Subject: Re: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
Message-Id: <1588047.pDivzA3PtA@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart13154847.QyJKWzLJLR"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <14375215.AZLobqST6Y@avalon> <20140307164427.GI28943@katana>
In-Reply-To: <20140307164427.GI28943@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart13154847.QyJKWzLJLR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Friday 07 March 2014 17:44:27 Wolfram Sang wrote:
> > > > As port usages is board specific, shouldn't this be moved to th=
e board
> > > > .dts file, with only serial0 =3D &scif2 ?
> > >=20
> > > Nope, the intention of these aliases is to have a consistent numb=
ering
> > > of SCIF cores, similar to platform.dev_id.
> >=20
> > But do we want that ? Isn't it better from a user point of view to =
have
> > ttySC0 regardless of whether scif2 or scif3 is used when the board =
has a
> > single serial port only ?
>=20
> Some prefer this, some that. The current standard pattern is what I
> implemented. I think consistency makes sense for my series. If you li=
ke to
> prefer another pattern, please start a discussion at the devicetree l=
ist.

When you say standard pattern, do you mean the practice followed by mos=
t .dts=20
in mainline, or is there an actual document that recommends this patter=
n ?

=2D-=20
Regards,

Laurent Pinchart

--nextPart13154847.QyJKWzLJLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTGfh0AAoJEIkPb2GL7hl1do8H/jJ/fEhpGYiVrkR4YWUXBSHv
WbY/agYABHuy4NWCAqqShFJS2Y3TprZk0Y5ggJNItvE7DNIFeejY9Lg5KdrdouU5
ks86vgHTvowCcKjSIZVo6qyAPjWReRFE/OD4S/sQXG2DTZOnQJa+ws0nuGaUaJ9b
inEmbO2kPL4gBvXKbAGsh3ECrb++UbHO9SV1AeU8XFjSC1wgzOjObacsQcgL9aez
RJEXDUpi/yF56oDEeYDV6a1pKFfiFR5lWSf26lTgbuIk44xU8aSp2wMvW1LApd1j
O0fTFxA+0rS1Do3bUHQK0N7mcP/AVuj9qq8FOyeVa+o8EZjbvdga3all78wXAEE=
=VAjB
-----END PGP SIGNATURE-----

--nextPart13154847.QyJKWzLJLR--

