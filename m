From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 19 Nov 2015 20:13:19 +0000
Subject: [PATCH] m32r: Fix clearing of thread info fault code
Message-Id: <20151119211319.784149af@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_//nu_16UNKyVpbr0mkNMw5Zw"
List-Id: <linux-sh.vger.kernel.org>
References: <20150618204518.02c852e0@wiggum>
In-Reply-To: <20150618204518.02c852e0@wiggum>
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>

--Sig_//nu_16UNKyVpbr0mkNMw5Zw
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

(Sorry, hit the send button early, so here goes the actual patch.)


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

--Sig_//nu_16UNKyVpbr0mkNMw5Zw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWTi1fAAoJEPUyvh2QjYsO8dMP/jcBfs6VPhffo0YMIwi7iK2l
KFNzFCbUfI2AZEfTVZwRDJTx2SyAr9wUTga5j6uyMSqk1YG4LSNkKPOquCAYDJmQ
gt95RvfQsi1UxoTA3Xo1m/WzLrfFqWFRegEfn6bDjVQw5TE3F9txC+50hgT0VOkU
y1CMk3vIprgoqkCuzg8U/+IgL81LlsxKgyhE0wuIWF1G1LnGqtXurTtWdlH04Nbe
rVn+ZPWvz7Fa9osjOmez3dWCxhRcurH/erd6rnAFu5F75pI+5Uz65107x3wXt+uD
JwsHNhqVgmWkOUlvSqlyVUyv4Ugw2V8kquxOxCUmuw7c+gXuEDE5diY9r4n4qXg3
9Nq06O3oOm5/LEOw/0PPQcbm36ZJhnlo6mbSpF7E9gIIIyvwuS/CU4at3VIb71JY
sk8gp56+qdevZ+ppCHYJOIbElICP18nKlcMNGvUB/Dzq5CsWindGVBs62xpIaVJH
gQIMOqQz8jDKEZOE0zLvm2GWMukW44CMsBOwqAaUhNfh/G9S+MTSh5cZgn7K+C/Z
//42dotf6BnEfgjvZAALKSaF8lMrzeKKp+UIgJFB+n+DySgqXbzLKQ4GXODqHuk5
Pw2BcUkGt/ZpRAeI4L9gG/YhpSqsKjgCFsgphuDR+cxOFOvspeyby2a+dAADnqj/
ssJ0HCbvXfR3GpZUyXfm
=WQZo
-----END PGP SIGNATURE-----

--Sig_//nu_16UNKyVpbr0mkNMw5Zw--
