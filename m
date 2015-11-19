From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 19 Nov 2015 20:16:36 +0000
Subject: [PATCH] sh: Fix clearing of thread info fault code
Message-Id: <20151119211636.048c4aa5@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/8TT1_9j4O=91JK+cn3hX2jD"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>

--Sig_/8TT1_9j4O=91JK+cn3hX2jD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The expression (~0 >> x) will always yield all-ones, because the right
shift is an arithmetic right shift that will always shift ones in.
Hence the old fault code bits will not be cleared before being ORed
with the new fault code.

Fix this by forcing a logical right shift instead of an arithmetic
right shift by using an unsigned long constant.

Reported-by: Ilia Mirkin <imirkin@alum.mit.edu>
Signed-off-by: Michael Buesch <m@bues.ch>

---

The code also assumes sizeof(ti->flags) =3D=3D 4. But that probably is ok
for this arch.

This patch is untested, because I do not have the hardware.

Resend: Patch was originally sent on Wed, 18 Jun 2015.



Index: linux/arch/sh/include/asm/thread_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/sh/include/asm/thread_info.h
+++ linux/arch/sh/include/asm/thread_info.h
@@ -172,7 +172,7 @@ static inline void set_restore_sigmask(v
 static inline void set_thread_fault_code(unsigned int val)
 {
 	struct thread_info *ti =3D current_thread_info();
-	ti->flags =3D (ti->flags & (~0 >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
+	ti->flags =3D (ti->flags & (~0UL >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
 		| (val << TI_FLAG_FAULT_CODE_SHIFT);
 }
=20

--Sig_/8TT1_9j4O=91JK+cn3hX2jD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWTi4kAAoJEPUyvh2QjYsOZOcP/0nwiUQnQDWN1DCcDOJ+elWE
h9OgFcXFAxEIc07nUNptjDGizBj2+5CnoYChlA1gBvV+VnM5z7WHZ2+t/2tRENPR
FqiOvWWHkTk8Vf0/doUha9tnozE03DVrZbmNxoymJu4nORiX3pBPM1IdH2IezLHL
UlL4rIeI11fPbGtDRQKjveNuWY4oUtn1nZ69OxroFX2xVXmKLIFuffZ3M8mFjaVH
SLxbiNIVaWMiyD3wgPzuqsvKzHa2qhN2QMhCyMf2dUDN6MuNo8BGJWhLZsfHNrgY
FJIjPJxMfMWU9cgJZV4L8sRjMD4NmeuQg8IioI3k0QJOIg0MR/wuqr/gaLgHxYk4
B+ioOqt7vnBikp8EwUD2BS+fPWw0h5KjMBTRRPKl8KgnGfzahwUvyaPtijBDQ2Wp
6X2Q3e6QbQ/cFGGlc9AE0tS7el3rahuAtW3B0H3HjOKwl94VWOUNxsdOO3ZtkrQL
CSUNUMNBJbLrnkMtO6s3oewKfVjorxwNEzGF0Nz5yd1BltD5p6YIJ31jrzMZTf3l
IrS5uSr2f+ubRyn+nKsX3BGCSV6S7qHRkx7CM93/9G7lk4MztazJHpth1rASmaVC
kgPjE1MXWLIHajEdrdCwu3VZlVu2+zf+O5oKQgnoACE0CxoGEr3Tnmq3732gwDRw
BVjTxjik+OHeLcDkahWY
=H98d
-----END PGP SIGNATURE-----

--Sig_/8TT1_9j4O=91JK+cn3hX2jD--
