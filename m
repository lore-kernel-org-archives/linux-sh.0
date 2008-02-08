From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 08 Feb 2008 00:26:46 +0000
Subject: Re: Sorry but I do not understand.
Message-Id: <200802071926.46952.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4027167.jY42TH85hV"
List-Id: <linux-sh.vger.kernel.org>
References: <200802072128.34795.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200802072128.34795.fabio.giovagnini@aurion-tech.com>
To: linux-sh@vger.kernel.org

--nextPart4027167.jY42TH85hV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 07 February 2008, Fabio Giovagnini wrote:
> What exaclty means this following:
> root:/home> cp nfs/sdl5thApp .
> root:/home> ./sdl5thApp
> Allocation of length 1072838 from process 48 failed

your memory is full and/or fragmented and cannot satisfy the request for=20
1072838 bytes.  the rest of the message just describes the exact memory sta=
te=20
in the system at the time of failure.
=2Dmike

--nextPart4027167.jY42TH85hV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR6uhxkFjO5/oN/WBAQIhgRAAyhaFvfv3oOBpEJX8qQoLypndWOwqNnJD
4GJi+/MdwIDVG0ufe6A8pJaiMsR7S0OBC7KDDLHb1AFEZ6q7P/v8eH8im4ih1u6g
vcbjGKbmESCI1vVxY3/P6oo/gzhjQj8wDHq9OQSRiDo873NFJHWT0sTnypmY2Yki
HMEOZRfw+Q4STAzGBZ4nIJ3mdk1J0iCyeuEcfMpIz55MrOhHTyG8hBVdqNr0R6GB
v3S1D74bD9ko2xu/ttzStuBF8NwvNtGzCYFvxkk++Kr0fMRvz7j/q6sR+D5qjM6D
PxmnZbmKjd1TIbTNa5WtnI1R47GVXdwGsUz5OAABrQ3tpHoHsPf7F6O2sXzsQEfe
AmFrddOJcGi1R6vOcRX2JFTFuvSSzrmVazj5D2RgYIx45j4JyIoeGE0psTHs/EDt
hvXPV98GYu1NGKf6INizIaLwUe+nNbKnGWKXK6OHY1mxh9m+bPtiOzuLvuHDXh7b
ME6pvfnZmH3hLpr77QSK+r9Nvcda7n9K2BXDCd7mcr63DGYIWShzfzLYq/a4BGq0
/cs0/s4pctBaRh3/89aclTr8u6Pv6db0mLPXzCX5ecOGemIq+7nK6cFwGpp+QXOb
AZlm+hNkkITzpAsbCtrCG0IqiSlfMY8kFKgJyumF+D7aFMQKtU2A7oev9ven58Ov
gnM7Qb/W3Ko=
=EKxJ
-----END PGP SIGNATURE-----

--nextPart4027167.jY42TH85hV--
