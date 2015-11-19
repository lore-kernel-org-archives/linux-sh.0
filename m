From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 19 Nov 2015 20:12:28 +0000
Subject: [PATCH] m32r: Fix clearing of thread info fault code
Message-Id: <20151119211228.396fd228@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/S9V7nTxLEjVfjm5ZZ9NDql3"
List-Id: <linux-sh.vger.kernel.org>
References: <20150618204518.02c852e0@wiggum>
In-Reply-To: <20150618204518.02c852e0@wiggum>
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>

--Sig_/S9V7nTxLEjVfjm5ZZ9NDql3
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



--Sig_/S9V7nTxLEjVfjm5ZZ9NDql3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWTi0sAAoJEPUyvh2QjYsOiM4QAJ2n0diUjamrG4fjNZaRrs7e
sZ+eSSyoPGqisnXZUR84jQC2ydesrkapqcBmiprY17eIm2v5r3Oa+RtyxpEJOhgJ
k8mc4fqDrgVRAJ0To6Q+UiUkq80S3tR2W6LGSlfAPKZmGiaOJuQLCoFNOf88+fqW
pk3/Y87klRrGpyuIRVFs1Zmp+ugfWeqpyVsX0D6PnGeEYMGP9rt+bgcQ1E/Rpa4y
e5nNv4XVT2IgJ6X1ETPw8Qb3VFupKpUG+I2+GM3qrHAEhlRYePUaKz5K0pQ5uPJl
vyVo44qHPRIb9Jw/2c1NdvPqY6fW2yqb87ivKhwKyVSZVKS5nej4GKWKI8y2sGIS
iIAuG2YYYDqGG90Y4NJeexKESOv7WoohX6pK0Sv2SGCivRW2zw5yySLLTjah3Whi
Nu9PRzasGruTV24r4uywbiP39fyqvoAafyH0ioZFhR42Kgq2RKTCPN6SuFCkcYPc
7Em629PfhRWTsKhP17Qipz8jMRQJtqt25O+AW9we6C/8OpTUeKXvJxLYnG9u4gAb
3E/ljgpa70bC0GS6xVGgIux+Yvz0XEZ/nuC6ddVckiR5tnY/E4JZ8rHy628Do+nC
wVmF5u0fja06pXieRbvXGzRAQTI4LxksZj1Lm3/XBacDISUtBRCi6lYAw8R2DBNt
iUkW8xqW4FBHV8Q8OzKf
=cq+K
-----END PGP SIGNATURE-----

--Sig_/S9V7nTxLEjVfjm5ZZ9NDql3--
