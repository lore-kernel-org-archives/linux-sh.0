From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 18 Jan 2015 11:52:48 +0000
Subject: Re: Bug#775611: [sh]: FTBFS due to unknown compiler option '-m32'
Message-Id: <1421581968.31046.131.camel@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-MhFOt0s7hIEQwpilLxsa"
List-Id: <linux-sh.vger.kernel.org>
References: <1421575095.31046.99.camel@decadent.org.uk>
In-Reply-To: <1421575095.31046.99.camel@decadent.org.uk>
To: linux-sh@vger.kernel.org


--=-MhFOt0s7hIEQwpilLxsa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2015-01-18 at 12:15 +0100, Geert Uytterhoeven wrote:
> On Sun, Jan 18, 2015 at 10:58 AM, Ben Hutchings <ben@decadent.org.uk> wro=
te:
> > On Sun, 2015-01-18 at 00:35 +0100, John Paul Adrian Glaubitz wrote:
> >> Package: linux
> >> Version: 3.16.7-ckt4-1
> >> Severity: normal
> >> Tags: patch
> >>
> >> Hi!
> >>
> >> The kernel package currently fails to build from source on sh4 since
> >> the build scripts try to pass the '-m32' compiler option on gcc which
> >> is not available with gcc on sh4 (also according to the manpage).
> >>
> >> Selecting HAVE_C_RECORDMCOUNT in arch/sh/Kconfig (see attached patch
> >> by Ben Hutchings) fixes the issues. However, I also suggest removing
> >> the line "$cc .=3D " -m32";" for sh compiler options in scripts/
> >> recordmcount.pl.
> >
> > Steven and SH experts, what do you think of this?
>=20
> It seems most compilers don't support -m32, unless they're biarch.
> On an Ubuntu 14.04 LTS box with lots of cross-compilers from korg/crossto=
ol:
[...]

Right.  It's also not mentioned at all in the documentation of SH
options for gcc 4.9.  There appear to be multiple 32-bit modes and
instruction encodings to choose from, so it wouldn't be very useful.

The next question is whether recordmcount.c works properly for SH.

Adrian, can you check whether ftrace seems to work on the kernel built
with HAVE_C_RECORDMCOUNT selected?  (See Documentation/trace/ftrace.txt
and particularly the 'function' example.)

Ben.

--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                            - Robert Coveyo=
u

--=-MhFOt0s7hIEQwpilLxsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVLuelee/yOyVhhEJAQoIKw/+P1ZyfL4Z0sAKPQ+lnj4VuefsCDO9aAA7
DALD1T2aZ8lhhdK+RbBhSOYzXSLRzsLfwfQlJIxeQjkG8mvsRDhOYn8rlegUdZnd
eg1G5NUWVudwku2TN4wxNIFt8Sbhsds/ITQXGQCi6qTkU/0s8mGP+reCdOBLQymK
ASsd1stuKDbZ9ZRs9ojY21DujEs+uqLrEwPD9ocdG2HU08ieskQOmHmI+wlz+x/B
yBpswestAP4YGgFm/taSEWAW5Acf2Kj9M79DDYvYr+/5S/C8p43oeoO17RP2zfWm
FTa2uf12vmUtrwYokjhj2Z75rqgG20Ir5a4Dk7uesj4LjS2lEc08cVul3WsJDOKd
2cbRW7+BAwejYPEm+5KZbU1kTh9JI4UJCF2I8F7ZE3pIvkjAzn9MKWIRJUouGZYh
kJ8vLi9m+tbq2Q90I0LoEtLwDazq7Szn8LluCL/Be8K036hi6TbbgaG2j/iohDNH
0OLGAcJqY0I6wf6KPyn+fbZ4ugxg4LPfrrJJJl4KV/uQjedHwnmN7N5p4ocsxQ1l
/7RNunDK1onSkfsTOKcrvDT90rjDmJX8VjGeBjt7bbwtVJECtHupzJKKJA9MENzZ
7poqGoOulrvrnV5IDlN2rS8bjLOCrziEqS1IamGhst5NnuY9lpI2MUODD28O4wwy
Mwm9WAlbenY=
=Jbvu
-----END PGP SIGNATURE-----

--=-MhFOt0s7hIEQwpilLxsa--
