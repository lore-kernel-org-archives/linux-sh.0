From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 24 Dec 2008 17:13:04 +0000
Subject: stack usage with libgcc math funcs
Message-Id: <200812241257.33701.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1299130.J1jeZ2VTp2"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--nextPart1299130.J1jeZ2VTp2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

i dont know superh assembly, so i cant really check the code myself.  start=
ing=20
with at gcc-4.1.2 (at least, gcc-3.4.6 doesnt seem to have this issue), a f=
ew=20
objects in libgcc.a lack GNU-stack markings.  here is the scanelf output=20
against libgcc.a from gcc-4.3.2.  basically, '!WX' just means that the obje=
cts=20
do not have a .note.GNU-stack section.

$ scanelf -qeR .
!WX --- ---  ./4.3.2/_ashiftrt.o
!WX --- ---  ./4.3.2/_ashiftrt_n.o
!WX --- ---  ./4.3.2/_ashiftlt.o
!WX --- ---  ./4.3.2/_lshiftrt.o
!WX --- ---  ./4.3.2/_movmem.o
!WX --- ---  ./4.3.2/_movmem_i4.o
!WX --- ---  ./4.3.2/_mulsi3.o
!WX --- ---  ./4.3.2/_sdivsi3.o
!WX --- ---  ./4.3.2/_sdivsi3_i4.o
!WX --- ---  ./4.3.2/_udivsi3.o
!WX --- ---  ./4.3.2/_udivsi3_i4.o
!WX --- ---  ./4.3.2/_set_fpscr.o
!WX --- ---  ./4.3.2/_div_table.o
!WX --- ---  ./4.3.2/_udiv_qrnnd_16.o
!WX --- ---  ./4.3.2/_ic_invalidate.o
!WX --- ---  ./4.3.2/_ic_invalidate_array.o
!WX --- ---  ./4.3.2/linux-atomic.o

assuming libgcc doesnt actually use the stack to exec code, the attached pa=
tch=20
should fix things i think.
=2Dmike

=2D-- gcc/config/sh/lib1funcs.asm
+++ gcc/config/sh/lib1funcs.asm
@@ -34,6 +34,11 @@
 !! recoded in assembly by Toshiyasu Morita
 !! tm@netcom.com
=20
+#if defined(__ELF__) && defined(__linux__)
+.section .note.GNU-stack,"",%progbits
+.previous
+#endif
+
 /* SH2 optimizations for ___ashrsi3, ___ashlsi3, ___lshrsi3 and
    ELF local label prefixes by J"orn Rennecke
    amylaar@cygnus.com  */

--nextPart1299130.J1jeZ2VTp2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJUngNAAoJEEFjO5/oN/WBSmYQAKKROn3SnYRTH1RkEqqNoxtF
IIEwBLBegx+oBlbKwuaprPGi0GojeY8xXInMkRL/dBTn7GbkwFqkKpRR3nwZ+2HU
A2P34KxfsKPGS4m8CzbK+ZpZ4MRxZAzAlvZzVbm3nmjROVtLkpw/Uwzl+8vCc7ua
YjpRea5ZSSDmsJunAFMOqLDGBo1jcUoz5OCI2aW+hXxMXGRbSQNb2jLGNvRvVvVf
BE7MzrAVmxQrIeRjRu8qO4+kZgAvExW2rXX4WLeO+/D9/s5prQrxwjYXmtuZ1Ndq
H0qOrd4Cxj3BBKMl3nKgvI2exlzgRz/N3Sx0Img+6N27HcTKwyE5s2MHVOLtRdfl
/oZyWqA6MlRyNuonn8/+ALLIV8rLlL0+AlyibqNzl0wFuKKS2gcnz5qLT8L7LGa+
+rU86FMBM2MS0MGoYpvqxFdmcBpkq0ethGV3yyWYoF0SLgHAkpL3VuN0XRkOhIVY
Kk+c6yunyCiocdI8iv+Wcs19HahGk9g4FKarnJrznY0chMlqQpCGDOI4EQV2wSIw
fzONTdtTegIvdbHKaAoYsjitQ4yqWlI6M8w0ea3BvgD2She06EREttjgZAdRrEtE
sQnT3XLQUR3ryFm8rfq1tdxXwK5wQVqr7Ld2SJlWP1rmoZhI1P0NpE6p8yPKQ31X
r5mCYQEwGW7JwdRxj7uC
=Bg/6
-----END PGP SIGNATURE-----

--nextPart1299130.J1jeZ2VTp2--
