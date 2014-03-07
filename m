From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:44:27 +0000
Subject: Re: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
Message-Id: <20140307164427.GI28943@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="byLs0wutDcxFdwtm"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1930280.sZNcfhZEL8@avalon> <20140307162510.GF28943@katana>
 <14375215.AZLobqST6Y@avalon>
In-Reply-To: <14375215.AZLobqST6Y@avalon>
To: linux-arm-kernel@lists.infradead.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > As port usages is board specific, shouldn't this be moved to the board
> > > .dts file, with only serial0 =3D &scif2 ?
> >=20
> > Nope, the intention of these aliases is to have a consistent numbering
> > of SCIF cores, similar to platform.dev_id.
>=20
> But do we want that ? Isn't it better from a user point of view to have t=
tySC0=20
> regardless of whether scif2 or scif3 is used when the board has a single=
=20
> serial port only ?

Some prefer this, some that. The current standard pattern is what I impleme=
nted.
I think consistency makes sense for my series. If you like to prefer another
pattern, please start a discussion at the devicetree list.


--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGfdrAAoJEBQN5MwUoCm25+8P/ijOb+8mijgJoUyztnAdgblN
xvsUMG0Pn9rL6G71owJf8+jmD3SWCdBdfEm3bpI0khwTCNc6wSznjLcu3gUtiXXD
NgwZQkh/34yOdS8PshXGfo3nM1RC26BE2+vPHS8mCa32xJpxwsgaTdZzVxqjAzZm
p85Nn0mOJuCSrhhuboIF2tGvviwWe+ErMQD/TGAkB8R610n6Hdlhb8OopVmEK+ht
zi2MDOSoGq3Ven1cXne/q1NAMtTjlLB0DYYKPzAGGH2eggY9JK8R7DiSLdknE7EU
zvZjC1yLItrvcW7gEwm6GutUpSzu0jhCxhNsReD475IOA6YRFWQhA7S4Is79E81z
tpSg5F3q3PDBmYxRpGbYTYpt4kDmMOmDZiAnFKbMdU2+kmbfa/hPjQ0eZM98Q1iQ
kkqZ45maXcJzjA4+GtRQJWVIUSY74+XGscCuxYJ/yvbNGugCW4Z7rfG+jFIR1Uxr
R9yTGOw21+scW5BkPcn5YYtt2q3e23lyPJM/y8M83wbhA0KCn9I5llzt5vagS93V
kr+Ce+5CUqkQBKrWBnb+ld3bZAPfIG/Y0r/b+rF2+3I0f30VRJ9IgwMWeykp2vDq
5F8RK+ia1YNx0cUuHroKgZjkoAJswcpkksFqF3HqRbAIwb7qK7hKgixNq+cVbteY
NPesdHwMO/MQAlMlLNDc
=UFc7
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
