From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 18 Jan 2015 09:58:15 +0000
Subject: Re: Bug#775611: [sh]: FTBFS due to unknown compiler option '-m32'
Message-Id: <1421575095.31046.99.camel@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-n/x/CH6kQyL/6FhOz7Ps"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--=-n/x/CH6kQyL/6FhOz7Ps
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2015-01-18 at 00:35 +0100, John Paul Adrian Glaubitz wrote:
> Package: linux
> Version: 3.16.7-ckt4-1
> Severity: normal
> Tags: patch
>=20
> Hi!
>=20
> The kernel package currently fails to build from source on sh4 since
> the build scripts try to pass the '-m32' compiler option on gcc which
> is not available with gcc on sh4 (also according to the manpage).
>=20
> Selecting HAVE_C_RECORDMCOUNT in arch/sh/Kconfig (see attached patch
> by Ben Hutchings) fixes the issues. However, I also suggest removing
> the line "$cc .=3D " -m32";" for sh compiler options in scripts/
> recordmcount.pl.

Steven and SH experts, what do you think of this?

Ben.

--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                            - Robert Coveyo=
u

--=-n/x/CH6kQyL/6FhOz7Ps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVLuDt+e/yOyVhhEJAQrk9A/+PdfFjKw4o82u4UbOSIST+Ht3Kaar7514
dqDF+asouXT3XNvNmvmHBFaLezOymv81AWJbRZn3QNVbH85rFrboCfiAPdBQ8FIx
H78UiZF2E0unX/U/G/Z5dY7uMLGeMUn/GBPHHuUWksgcaS3gN5EiWc7BWuxiQC3G
G27ggnCC5Q/yc4Hj/3MCj+n6+h2U48G1SGsOTo1OUpSo2uTuR4y4JxDZl5MVSBU7
jB8k+WRgaP2pfmXZOKWQzLLh74ZSF4OgnBSNx4aCVOlTfb5JB7dWp4KvpTr9ILPb
q0t8mx+5ja2vYqY9wFHVlj4aAJlr97g2oiezzG83MCMxAEd04x+Pgg8v3nEkcaRP
ZEDSnBIyEqYiscKhmK0RJj+ki1KjEN5gKVITd2Izc+XcC1lu+AnKYDk2A+nU2E6g
vGQzGHQlBpAyhr12DU5RXySaAW6ZucfaAiX5RTkJNHv5XQw+5djiSNi2s+U9Bt6/
h5b3irnQNN1t2cnzetsLHDWkrkI44UNcJ2E1JFcLWHH6VvSAAJbLVtejn+DO1EMf
gJiRYGLC2vU05W5OELBbMDs8u8OgmJDJClaA3dteX0gPq2F/kbD+eKmXu0F3bekI
ED/G/FihDgzzH4BjKjO2lYvumrilBZmW8EmJdqN17vpaM/XZ1jlv+u2uvpQW329k
O7hEFVXowO0=
=M/vF
-----END PGP SIGNATURE-----

--=-n/x/CH6kQyL/6FhOz7Ps--
