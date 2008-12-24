From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 24 Dec 2008 17:28:11 +0000
Subject: Re: stack usage with libgcc math funcs
Message-Id: <200812241312.43489.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1908446.chF2DS0dFo"
List-Id: <linux-sh.vger.kernel.org>
References: <200812241257.33701.vapier@gentoo.org>
In-Reply-To: <200812241257.33701.vapier@gentoo.org>
To: linux-sh@vger.kernel.org

--nextPart1908446.chF2DS0dFo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

and linux-atomic.asm needs a similar change
=2D-- gcc/config/sh/linux-atomic.asm
+++ gcc/config/sh/linux-atomic.asm
@@ -138,3 +138,8 @@
 ATOMIC_FETCH_AND_COMBOP(nand,and,not,4,l,mov)
=20
 #endif /* ! __SH5__ */
+
+#if defined(__ELF__) && defined(__linux__)
+.section .note.GNU-stack,"",%progbits
+.previous
+#endif

as a note, without these changes, the execstack markings bubble up into som=
e=20
of the glibc libs as those are built with -static-libgcc ... i can see this=
=20
with glibc-2.9 for sure.
=2Dmike

--nextPart1908446.chF2DS0dFo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJUnubAAoJEEFjO5/oN/WB3SEQAKdMmljqfbHL6DemdoYRV/16
/tOuLOsWrCx7Y9An4PbM83EyVmEOdBbEATHt97GMuu8cYpci16Uf+Vs/VuJANiuo
slNLB8npSlWiK3pAlruZKsIj+2rWgyoc0V0PVd3N21c5aTPF8DAYLovWs7y5Kw8c
mm95Sm1n2z/hR20lu0k+96t9VR1473i+o+8FMfxRB27Em5jCgzip6yGaITqJ9Yi+
o1tal971BRHrgFyA4M4ncXqLm4Gx0BFT6mzRnSXmGqGHJOdk0ShakxHHlx4azaH4
VMB/BrkTKbyBfqNf8k6PX/xFlCufI8DAXmRt1WQDh42QsL4zjE0RZ9cCH+w1PTwL
FL4WaDtciKhpYAyPIBAeHcc7mxnnr8uHylKfs1ezMqBDTXoLkCNNrS4mMjA57hyP
BANfA1z3I9E9YHI3IRhKoC2FdqgxrGbkjpGjqo305avOOyxP2MG0qJPYXOtj8R2q
fX0nceU6K7aKutWr32g5Q3YWLNePFWXNkwxU9vdPOdRDFNPcBs2Y5ZtISqhyt7ny
9c8xMgLiJ698ZjRvYxQDLntHJL7mkrGVoGZBxmPnSkziT3lfKjRxUyuCWghWbG7d
f7snefw3u2v1P4FK+460xaoee8yNjzh5Vm7ud3MoCp9QKuOaw/wSJMwXlLRc+snC
J4Rb2w+2BtRgU7D0ItWm
=HR3Q
-----END PGP SIGNATURE-----

--nextPart1908446.chF2DS0dFo--
