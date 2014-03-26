From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 26 Mar 2014 06:29:33 +0000
Subject: Re: [PATCH V2 1/5] ARM: shmobile: r8a7791: add IIC0/1 clock macros
Message-Id: <20140326062933.GA2664@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
List-Id: <linux-sh.vger.kernel.org>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
 <9236675.ot3B0M2rgc@avalon>
 <CANqRtoSYTSZV-wxXBeGWYnPLPGZNL3WEtXgHh1U8CQxAEhx5zQ@mail.gmail.com>
In-Reply-To: <CANqRtoSYTSZV-wxXBeGWYnPLPGZNL3WEtXgHh1U8CQxAEhx5zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> To clarify, I can't seem to find any cover letter for this series, so
> instead I will with this email reply to [1/1]. Here is also a list of
> the patches that I believe are part of this series, please correct me
> if I'm wrong:

You are absolutely right.

> They all look good to me!
>=20
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks!

> Simon, can you please pick up these changes? I believe there are no
> special dependencies.

The dependencies (pfc entries and new compatible for the driver) are
already in linux-next.


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMnPMAAoJEBQN5MwUoCm2p6oP/0lV/U4nSqY4SCGLWhgTfmIe
+E7Z7ZMtFCsELRi9sz/Y2dROFAs6F82N1cWo9Ag4TBSsuuJrC1sID0bPwto2X4ZU
N4uEg4uAeQdJpA1WSKlLYlCJdZFDLpaIq97XlT3WXfY1uV6IppISSeRHX6RWIGFk
e2RAbkoJ4XZQcZvadErzTgaNDFoPlqA2JzyC8snMrAWNBdbpAYJXS4XJGHGoLpgz
IoEp6lwFP8ZPoy5anc3/jAp53thYn9O+1FwSvb6ngRL6kDYJITQ2Pe6diYFfC6rv
hRsFs77TnwDC/5PbWtk//eUW9NUfmd5TtHG4PCrQ9ygXvIjSh9xDMK0GuJ1RhI5f
W9wpIaAUSNo2aaQP44gdypaHgixC0S2V+yv8fU9u+zUombkRBL2W7Sx7uf69T+Hs
jMDk2eO7ngOzNuQdoq5TSOoygCcdnDwE12GI74Fe/aCuF11CTWbsERN3AJeJ+O+R
gVQMz4HkMI7XgCXnw2U8w3L6Mh95tNzqlpXQpEdDx2EOJSQsyC7Zb/Rw34LYLSlV
w4efjHud81R3StJIBXkMQwnY+Z/fq6Ykk7dm4UBM9Ii4YzkcwwtoDza+wtu9dwSR
sPE2/awhlz6w4AlPh2ZoRFOS+hovYamTKfaeNVZ823EYGYpPoOueEcEIiz1/2tHk
OPgO337hmCvvaHJEjLvL
=59eE
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
