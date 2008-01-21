From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 21 Jan 2008 08:08:08 +0000
Subject: Re: Hi, all,
Message-Id: <200801210308.08818.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart17163698.TZXjbgFkZ6"
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
To: linux-sh@vger.kernel.org

--nextPart17163698.TZXjbgFkZ6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 21 January 2008, Carmelo AMOROSO wrote:
> Mike Frysinger wrote:
> > On Sunday 20 January 2008, Mike Frysinger wrote:
> >> On Sunday 20 January 2008, Fabio Giovagnini wrote:
> >>> I have such a problem with.
> >>> sh-uclibc-g++ 3.4.6
> >>>
> >>> /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw=
2-
> >>>fd e- glibc.c:291: undefined reference to `dl_iterate_phdr'
> >>>
> >>> How can I solve.
> >>> Any suggestion will be appreciated.
> >>
> >> a one line error isnt exactly useful ... you didnt say what version of
> >> uClibc you're using or what you're using for a build system.
> >
> > and more importantly, what exactly are you doing
> > -mike
>
> I think that Fabio is trying to linking statically a C++ application
> against uClibc. If so, (Fabio please clarify), the problem is extactly
> the same
> I posted on uClibc list last week (mmove _dl_iterate_phdr from libdl.a
> to libc.a).

there are other ways to hit the failure, so i wanted to see what he was=20
attempting before suggesting a workaround.
=2Dmike

--nextPart17163698.TZXjbgFkZ6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR5RS6EFjO5/oN/WBAQLuJQ/+PYm7t9KS0DGE8ppkm+I5qhCi9F5NyGP4
+PscIB8bYXx8ja3783Eg+lQF6Z1sKsjyAyOnledd5bFNcdUdGHGgUIRpaAnlEQ3T
pj1AjpvrApe2oDSv6rzvNfZV1ASZaAeQSzqS/Olr9MYuB5I/JIOGM7453Ziyusrz
8iW0acE7b4MuegRAy3/mSO/CF5TAWWyRu0tcQWzYxkhtvqXaDEDxxvDUBB5IYx/L
PmLn+ZcjsGfpPGwFCeaZCXjn71wuvZmLhcRma6LVKgKK1rmTwaA6G0iPh2QZIOVJ
DGp6PSC1VczzIy1MEiR54/ZFdF5lsOoHNaWPKp1gvSU5lzFeznyE1hC9CSfH6H7v
o37mRPdFaDYgkU1pQRQGTkVwjd95ay7UxoSARzpI6elJwUX48zcR7flb9TeaDAKr
TcP1v9tcGaoYS71B5wYi3+gD1vovWDJ4ulCBqZoK9VdjMAos53FG9zbFV+HQpavk
Rh/SHqI+bnbQYl7v+vXKOmSjIusIqpYVhlOa8ptcRTcYs9lX1caPXWh8/byXEWqj
CVspYVUq4JqLrPP6gLovdDx1CW8iFk01vJ39+SLP2lO2OikUusso/eJNZXQ33Kwx
ubqSaVXqSZ0xsW/rW9zdRp5WU7A4uFGP2vE3GOFboQXLZPtKAmuwuK0NOCLTS2lm
TPIFZEUkQKE=
=LlOa
-----END PGP SIGNATURE-----

--nextPart17163698.TZXjbgFkZ6--
