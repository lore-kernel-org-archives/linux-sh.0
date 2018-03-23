From: James Hogan <jhogan@kernel.org>
Date: Fri, 23 Mar 2018 21:08:12 +0000
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-Id: <20180323210811.GD11796@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MAH+hnPXVZWQ5cD/"
List-Id: <linux-sh.vger.kernel.org>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180322222107.GJ13126@saruman>
 <1521777055.1510.9.camel@flygoat.com>
In-Reply-To: <1521777055.1510.9.camel@flygoat.com>
To: linux-arm-kernel@lists.infradead.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 11:50:55AM +0800, Jiaxun Yang wrote:
> =E5=9C=A8 2018-03-22=E5=9B=9B=E7=9A=84 22:21 +0000=EF=BC=8CJames Hogan=E5=
=86=99=E9=81=93=EF=BC=9A
> > Also I think it worth mentioning in the commit message the MIPS
> > configuration you hit this with, presumably a Loongson one? For me
> > decompress_kernel() gets a stack guard on loongson3_defconfig, but
> > not
> > malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive
> > to
> > the compiler inlining stuff into decompress_kernel() or something
> > such
> > that it suddenly qualifies for a stack guard.
>=20
> Have you tested with CONFIG_CC_STACKPROTECTOR_STRONG=3Dy ?

Yes. for malta_defconfig I could only reproduce by adding an array to
decompress_kernel() so that it would get the guard.

Cheers
James

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq1bLsACgkQbAtpk944
dnqRoRAAgQ9jkBNRCrcD5HNMyD7XNnyB4QBm9KgvsYASAFF2b9bzC1qaFsv7ogMe
+yUEgTbXYGvVyBKMRr/D0d0ndlTSPCwVJHwtwgBVp+PizfWmBTF6j1IvbQ1YnQfH
vYfFm72xW0L0awtmXV2tbo/Y/AQopzAaWL09sFhrqSt9tWRmPDnlx0r+DfPp3wVP
I5mA+BftMiVSjqOiwU5QAmj2JVFRpkfKCAftdjG6UFQE0l7aw+4EFHpYiI+8Ai6A
XiFyf+GQu6Bh0GK+mdTSa0pb+UMEhf1Q4Y5BlJca6zThYTdlZKJoAwIPjHh+Pn4M
hsKYqKczPJd0hlDSFG5/LC7tp5ySoRGTP/kFQoodjjOf774FkdTTY73/8JDcHc7n
Jb8UMrMiwWLOPwyqjS9SD2sBcnHVAUZvGhIS5pJHzEiAIKNVVeXpjWYTTwQ2nKiN
r240w2CjnH/l8C4iwUChu2xvoXV/3EYJLibTIaLbAyGu0TTeW8nGQR4m3wRIL3ig
Dg9C3tgQY4NJMaTXWRyJGEf58cezFSkDvHRAmNqO6r4IkXjJ4VXlqCvUj0p+KThw
2oKS6aDj7ZU25DrTAPmb24SCUS9A61Ktwo463YznQdv2WUppc++dRUoBnJ5j89iP
o4ngC6M2GKsRrL2SRphyLz4Pyi+alDWvXm+tQnKD7Uy940M8SF0=
=0EHR
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
