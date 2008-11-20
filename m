From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 20 Nov 2008 16:04:09 +0000
Subject: HP Jornada 600-series bug bisected
Message-Id: <20081120180448.8d928982.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__20_Nov_2008_18_04_48_+0100_x7kH/CSKkG/+cw4X"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Thu__20_Nov_2008_18_04_48_+0100_x7kH/CSKkG/+cw4X
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

v2.6.27(-hpc) didn't work at all
v2.6.26(-hpc) worked fine.

I bisected and eventually got down to:
5093c9a4e41518425d42c0bb5bb92f514ec77b1d is first bad commit
commit 5093c9a4e41518425d42c0bb5bb92f514ec77b1d
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Mon Aug 4 14:17:13 2008 +0900

    sh: define GENERIC_HARDIRQS_NO__DO_IRQ.

    We haven't called in to __do_IRQ() in a long time, so it seems like a
    reasonable time to switch this on by default.

    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

:040000 040000 cf3a9f428a81b93dcdc7d8da101ef722b6e0159e 563fcba3d9482fd80e8=
f4f9b02178eb17567bbb7 M  arch

Paul, thoughts about this?

/Kristoffer
--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__20_Nov_2008_18_04_48_+0100_x7kH/CSKkG/+cw4X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklmLAACgkQPQls10ERAGd1dgCdGVjk0+ie/FKtI8C46FnHTlnS
7yEAnAgmJR5zlB1g47K7F9XgAEEfZmx2
=B1MI
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Nov_2008_18_04_48_+0100_x7kH/CSKkG/+cw4X--
