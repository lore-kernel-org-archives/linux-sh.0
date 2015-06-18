From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 18 Jun 2015 18:45:24 +0000
Subject: [PATCH] sh: Fix clearing of thread info fault code
Message-Id: <20150618204524.3694abb9@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/lSGH+8gC5FdODa7q2LBa.1s"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ilia Mirkin <imirkin@alum.mit.edu>

--Sig_/lSGH+8gC5FdODa7q2LBa.1s
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

--Sig_/lSGH+8gC5FdODa7q2LBa.1s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgxHEAAoJEPUyvh2QjYsOS/4P/iOkswvJy1T4rFtKUqWTbYuy
2Ur6BUFzfT3mdgI/dkGjJKUf0JrxSGjCiufD2XWkI0rUQ4oV5OlOpgCKKhsRH3hA
Ewclz9hlI/gK6oQd1SUgPX5B9t7v4KPkgmdReUTPq9EQ31mr6cvZbK+SKL9Y2IO2
GI9i9+6v2RshqEZhAbpOO7eU1dGLJuLMRSbGhLaAkiNzESFFHPUkW+6SFzkDeOCJ
za4WY5VivOUlnUCNMEkyqV8RawAvl+Pmk0ethck2s3bWB3seafTO0XRKe+UjCuc0
Nldfk9k5XM++vZLo8aILp0NnYB0CxqHuRrHNkonzUce2xt2GnWXWZSCO3UfEzJ1+
0C3WHBViv3KsPAqdkoJer1Pq1PcCrcRknGmmzZE1DIGPe2WDG+OZhex/NWC1RYnG
cAXxc7UH2oSlWNw7ssjHRiGK8TN5f7CdN/3jq1A+YfW3VB6q9Ksdblm48mPHtULT
Ub7g3HntJt51Dx+G5MCcbRmlmAbaQY77rjKCMx/tIYr6jOtIHgF3nKKcDMRokwMz
99MnklHP2cpXz3TJe0xT8cUVP7rTDvYlHFDwvqNrzzsfdx7OqQO4488ThExcQ8J6
/r0UI7kHM73HXhJezJCd0Oz+OhBh42fYdmEsmrMPc2WPD4ox/E75iRnPcsMRxHV1
CDnjlB3bSqUUoE7Cys3h
=DEoO
-----END PGP SIGNATURE-----

--Sig_/lSGH+8gC5FdODa7q2LBa.1s--
