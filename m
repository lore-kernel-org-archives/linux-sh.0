From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 18 Jun 2015 18:45:18 +0000
Subject: [PATCH] m32r: Fix clearing of thread info fault code
Message-Id: <20150618204518.02c852e0@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/g6Fe+gvx959_N887is3nFy4"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ilia Mirkin <imirkin@alum.mit.edu>

--Sig_/g6Fe+gvx959_N887is3nFy4
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

The code also assumes sizeof(ti->flags) =3D=3D 4. But that probably is ok f=
or this arch.

This patch is untested, because I do not have the hardware.


Index: linux/arch/m32r/include/asm/thread_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/m32r/include/asm/thread_info.h
+++ linux/arch/m32r/include/asm/thread_info.h
@@ -77,7 +77,7 @@ static inline struct thread_info *curren
 static inline void set_thread_fault_code(unsigned int val)
 {
 	struct thread_info *ti =3D current_thread_info();
-	ti->flags =3D (ti->flags & (~0 >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
+	ti->flags =3D (ti->flags & (~0UL >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
 		| (val << TI_FLAG_FAULT_CODE_SHIFT);
 }
=20

--Sig_/g6Fe+gvx959_N887is3nFy4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgxG+AAoJEPUyvh2QjYsOHCwP/3T/2ISBE3sFQ28kJdW6pByG
2DPMNgkR7tdvUriPOfzytKygougSODBE4LYj5lQP9eqOe5/NK1o17Uufl2Xk2H78
xm5G9+s0d/6QZLeNAxGb25XwOioLmVMpdNggCLoNbuHL2se2nQW29hlqsa//zwmi
AmsI5Xf2kNHSkGZMwtjnJfAt/XIr8xKhyUot3lCKARNRqYPIjYqIwVy9I2D0ZjWO
k7pxxM/pt5vPan3pAfrVmHRON977o6dtMe3hDqZjR2LrJueTsB9Nti+vq2FpEbyy
zfHt0M1Ako2Eg/ysgxoenbXcbEJXEGGV18F5gIONTX+R9SjmnqOOzxt+8DLFIWwZ
22exhWCkDm9FmLmD825oZwvmpLTx7z95Xi7k9tvdzn1LdDa9UnuJmEhvdd3GY6iI
yMGMTrMTAf0bP61cQd07Jdj4ggN4BtDb+IRSCdlj90GwjG9xtBCqx8KG6EUeVWLc
nfv0/a1icCPWE8d8jdT/b4UsiIEOXpjmx51NCatIYIvcuCVeiNYMkB67W02Mm4Eq
eR2GL24kfyL9pOfLN0s0kN1EWEZbSVJryDgVaDce7WGc+gHHV4ojwTLpQ0zT43ZE
LZ42hJnHjouPIGL8P+CgZI1dWNSQtPSOjB+ZZ4b4+4nqZwCw2HaqHgJpMM1xSTnc
lDeWqYHzAGiColj6QU2D
=NkqY
-----END PGP SIGNATURE-----

--Sig_/g6Fe+gvx959_N887is3nFy4--
