From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 17 Oct 2012 03:50:01 +0000
Subject: Re: SH kernel boot up issue
Message-Id: <201210162350.02355.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2094573.H295BiR88c"
List-Id: <linux-sh.vger.kernel.org>
References: <507D5FD5.4050501@gcs-vn.com>
In-Reply-To: <507D5FD5.4050501@gcs-vn.com>
To: linux-sh@vger.kernel.org

--nextPart2094573.H295BiR88c
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 16 October 2012 09:23:33 Tung Pham wrote:
> I have an old working kernel for my SH board and now I'm trying to move
> it to a newer version. The approach is to merge some patches of old
> kernel to new one.
>=20
> Currently I have an issue with boot up new board. The board can be boot
> up successfully but after awhile the board reboot automatically. There's
> nothing inside the dmesg and syslog. I tried to add printk in some
> suspend/shutdown function but nothing logged out.
>=20
> Do you have any idea to fix this issue?

what board/CPU are you using exactly ?

what was the last kernel version that worked ?
=2Dmike

--nextPart2094573.H295BiR88c
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQfirqAAoJEEFjO5/oN/WB+DMQAJnxZc11P1TMEsh95pkUSMVZ
REcupfKcVfBOKhNVjwmGr+joonMMEv+Kn0Th5ahOBUJXakDab9t5iKW1tgmobToO
lXucwL6Y1bnlConrYbQ4rfMpQFY/vrCaK1Wpmr2fNVHDFloSJ5H37idr+7IV9X6/
q2Rzy4QOuYoOwGGTto0+Su03JqW5J0J0AvQa5cjtPq0P3Kt+/+C3OEsD2kUrXnFT
zMRa8WJ9iwTd6BLptS0YFqtLGbiQyZarPC7IYPxKugKcQ+isXUU7WV7VAlI6hb5K
efqwlUVMzr5TZrpHdCue7DcumcyH8TQYgWg7VfHgpAGyrEoji3WNMu78koViRYZW
NzEjmUcAZsJ2WINB2HpGAzrELqnODny3aBB/4REw92a6ko/jZNJwSh+ZZVvB85gw
ZxGfD0BeByuu95xNzryr4oaTMSH152xyFqQKjUCnzrPGYkZanRTLz4avhcOrmnOG
niTyR4BXGduPPnyuYQabAVRzuJg0JZERFceFdA2QLFDud4elfH70L6CCZY2oouwA
bNm4JqEjdifoo3dbF6anMcbrNQhVxoHNpT6Mge7gEv9EinM+dCagQlX8gNaJYEHf
ohLTdhINIO27Q4Wi5xQ2RQWsZf4NikybdFP9M9aF16FWEHnfLQDDlwcJL6vj6udT
dIwN1qsc+xAoHQ9RAZ30
=a3sR
-----END PGP SIGNATURE-----

--nextPart2094573.H295BiR88c--
