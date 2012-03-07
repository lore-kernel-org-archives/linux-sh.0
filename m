From: Thomas Schwinge <thomas@codesourcery.com>
Date: Wed, 07 Mar 2012 10:15:48 +0000
Subject: Migo-R (SH7722) vs. NUMA
Message-Id: <8762egpvhn.fsf@schwinge.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I've been working on upgrading the kernel for our Migo-R (SH7722) board
From=20ancient 2.6.30.6 to something more modern, 3.2.  But, based on
migor_defconfig, it wouldn't boot, and instead just hang after the boot
loader.  I bisected this to commit
19d8f84f86af867abee174be8bf1e4941a59143d (2010-05-10).  (To build this
tree, you need to cherry-pick 06225c08ec2ad0f0dec063df7f08773a8358db12
and apply the equivalent of c77b29db74a0ea4fdce0564a63b8876798625d64 to
arch/sh/kernel/setup.c.)

By chance I figured out that disabling NUMA support (which is enabled for
migor_defconfig) would make it work again for this tree, as well as later
versions, such as the 3.2 release.  I guess this should be fixed
properly?


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPVzVUAAoJENuKOtuXzphJfK8IALw6CdeBcoPnXFU3vIyP+CGU
dwTSVLyVRaWOehZtVWyc3lNEJ4DnSAMH+F68UhFrsVhxbPQBuDAmyu6esJfPfvJR
pRqO6kqZJyN4SveFET0f87JhQypiL08MexpyPooTxG2acW2v0jnRSqhad/r3aCkS
JE1vEMiNql3ovdKtTTW3bsnjpA3fI5vMpIbJiWe8OtitNExfvr/lh5NWMwFsbpJB
FTfazmka18GuDMOb1I5yNQXPyldgrhyOJSlNes6oxCrMOzZWsC1w3QpYqLSXzIjq
4lDEIKahNMD+Jyh51w/TcegzAMxp1GwysFGAN3Zjc5TX9LQuEve8V17AfeoQD/s=
=qe/1
-----END PGP SIGNATURE-----
--=-=-=--
