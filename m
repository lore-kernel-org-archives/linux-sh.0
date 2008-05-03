From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 03 May 2008 23:40:17 +0000
Subject: Re: initramfs /init freeze
Message-Id: <200805031940.18758.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1234604.Z6PypWWSeH"
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0804281204l7bf2f9e8me942dfc0628f30@mail.gmail.com>
In-Reply-To: <7b5883fc0804281204l7bf2f9e8me942dfc0628f30@mail.gmail.com>
To: linux-sh@vger.kernel.org

--nextPart1234604.Z6PypWWSeH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 02 May 2008, Roni Feldman wrote:
> I tried generating an sh4-softfloat-linux-gnu toolchain (gcc 4.1.2 libc
> 2.7) with crossdev but I failed.
> I'm probably missing something obvious, but I didn't work on it for too
> long...

ive only ever attempted softfloat on arm targets and with gcc-3.4.x.  i'd=20
suggest you do a quicktest and see if gcc 3.4.x works with=20
sh4-softfloat-linux-gnu ... if it doesnt, then something needs a little=20
TLC ...
=2Dmike

--nextPart1234604.Z6PypWWSeH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUASBz34kFjO5/oN/WBAQLOAA//RM1g6of4ndxGlhox/6hKb50OaiDfx7Ov
4/Jyb8fcRAL18rqfYSPpkcSvD3D6GTp3VpnMu6uQhHZ5gDXP3X0SCAr8G6BsnyNh
YMLjmsWCNjqCbjH8VKCF+SozD5M0HpIDeUvfWMTJNjqP4i25Q2edOdcziXKuBXcm
qxYzLAdLO3u3cfTLk/+yO7ag6saM/l/tOVD59hYT0f+nD9Ep9aAvukzh7cseMpfH
a1/W7Ypcws3mVQ07VIkm70TJe1GJZG7CPsnUi9n3F47xTec+T1T4iOnL/kYNAcZK
2mQrkUwgfuWXsD29Tb89wU/hhDFWllwk9AUi74vXdbZPgLsP5NDyF4aBGdy6g12c
0GEXoosj7Vxyl6DNtQM3GezNiZ3wNDE+vyvaWcuPgScxLBL54UkeilxcYPPhKipY
oeutOBVdyOoVDULutjB+iKFszXdcub+A4QWAN5XeoXFQJHFbQjPo3mZjCNrXK8u5
0YKrYDA00KzELKQGup8Plg94ZP2Q8b++jgfFnyDwIS3N4cmvX//UVHpeUZ4utvS0
p1MuNw+iYzONn+a0qqhpPcJBZJayfDmhqK456AxF7RZ/5QEwN5Mbrs3mURa+AX88
G49ZY5fPOlgJclr/zSOX1YGHkRgB40HIebkAoPqfC+KnchtOrsnhNQcSDtkoa8eE
lRnJxkt6Srg=
=jgZD
-----END PGP SIGNATURE-----

--nextPart1234604.Z6PypWWSeH--
