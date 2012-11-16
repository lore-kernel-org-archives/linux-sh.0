From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 16 Nov 2012 10:07:43 +0000
Subject: Re: [PATCH 2.6.34-rc2] sh: Fix FDPIC binary loader
Message-Id: <877gpl3low.fsf@kepler.schwinge.homeip.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <4BAC849A.9090403@codesourcery.com>
In-Reply-To: <4BAC849A.9090403@codesourcery.com>
To: linux-sh@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, 29 Mar 2010 12:15:23 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Mar 26, 2010 at 09:55:38AM +0000, Andrew Stubbs wrote:
> > Ensure that the aux table is properly initialized, even when optional=20
> > features are missing. Without this, the FDPIC loader did not work.

Andrew's patch became commit d5ab780305bb6d60a7b5a74f18cf84eb6ad153b1.

> This was whitespace damaged and didn't apply, so I did it by hand.

Unfortunately, in Paul's manual application, one part of the patch was
lost, and that happened to be the functional part.  I'm attaching a patch
to address that.  The patch is for 3.5.2, but likewise applies to the
current master branch.


If you add that patch to, for example, =C2=BBSH7269 Linux BSP=C2=AB,
<https://oss.renesas.com/modules/download/index.php?cid=3D80&lid=3D231>, you
can re-enable dynamic linking, and can remove the following note from its
readme.txt:

| 1. The toolchain used can only be used with static builds. Do not use thi=
s with
|    dynamically loaded shared libraries.


Gr=C3=BC=C3=9Fe,
 Thomas



--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=0001-sh-Fix-FDPIC-binary-loader.patch
Content-Transfer-Encoding: quoted-printable

From=2023dc6096a678259662224de60470fababed35d2d Mon Sep 17 00:00:00 2001
From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 16 Nov 2012 10:46:20 +0100
Subject: [PATCH] sh: Fix FDPIC binary loader

Ensure that the aux table is properly initialized, even when optional featu=
res
are missing.  Without this, the FDPIC loader did not work.  This was meant =
to
be included in commit d5ab780305bb6d60a7b5a74f18cf84eb6ad153b1.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
=2D--
 arch/sh/include/asm/elf.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/elf.h b/arch/sh/include/asm/elf.h
index f38112b..978b7fd 100644
=2D-- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -202,9 +202,9 @@ extern void __kernel_vsyscall;
 	if (vdso_enabled)					\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_BASE);	\
 	else							\
=2D		NEW_AUX_ENT(AT_IGNORE, 0);
+		NEW_AUX_ENT(AT_IGNORE, 0)
 #else
=2D#define VSYSCALL_AUX_ENT
+#define VSYSCALL_AUX_ENT	NEW_AUX_ENT(AT_IGNORE, 0)
 #endif /* CONFIG_VSYSCALL */
=20
 #ifdef CONFIG_SH_FPU
=2D-=20
1.7.4.1


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJQphBvAAoJEGe3hdm9kOiid08H/RLOjM7g/qKufDpzeXNB9R3W
No59yEYDRySEPW0xUi8TOAbxOJ8ORUDdYC6vUuQAGmzAcdSzizcGvTOCoKihCxXY
HI4rZ70s/yqM5tQPpSAjg/gWBdV7tXGYiLhOm7kmGXyzZ2JsYZoW6i9sGJ4l4Lzt
xz2VgHyVqrjCvucIIlb9nqnSTV4P1/LBcoI+wngklUkF3mQPiqEUlV8Al1Xlr5+t
0PCFR86HojxIW7m9vQm1Z3v0XzDZZZgUIuwdFmf1P5lvLhxMQ/pow8ccEkklh6B5
atA/36ntnrjRtXe171Ymc/UimBTJoVaQooNIRuwalQubVesQmlSUe2jKZQ4fOBA=
=M8r7
-----END PGP SIGNATURE-----
--==-=-=--
