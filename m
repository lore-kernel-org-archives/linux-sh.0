From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 20 Nov 2008 16:29:07 +0000
Subject: Concerning HP Jornada 600-series bug
Message-Id: <20081120182945.28a69839.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__20_Nov_2008_18_29_45_+0100_Yd1R_6n8ocxm7APq"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Thu__20_Nov_2008_18_29_45_+0100_Yd1R_6n8ocxm7APq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I reverted the 5093c9a4e41518425d42c0bb5bb92f514ec77b1d
commit and tried v2.6.27 and still no cigar.

So there must be an additional bug somewhere.

Going to do bisecting again and this time focus
on the cold reboot.

--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__20_Nov_2008_18_29_45_+0100_Yd1R_6n8ocxm7APq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklnokACgkQPQls10ERAGf0uQCg5v9qjG+fcTbjAgc5fs8qKb9c
4TwAoKkfsdLuF3WzUFVwVCyDgpHkO8Hq
=vMh2
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Nov_2008_18_29_45_+0100_Yd1R_6n8ocxm7APq--
