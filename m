From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 31 Jan 2009 17:35:21 +0000
Subject: Re: [PATCH] fix build failure w. gcc-4.3.3
Message-Id: <200901311235.24122.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4358775.JtzMnWYTiD"
List-Id: <linux-sh.vger.kernel.org>
References: <20090130102854.GA13640@roarinelk.homelinux.net>
In-Reply-To: <20090130102854.GA13640@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

--nextPart4358775.JtzMnWYTiD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 31 January 2009 12:13:26 Manuel Lauss wrote:
> On Sat, 31 Jan 2009 11:56:05 -0500 Mike Frysinger wrote:
> > On Saturday 31 January 2009 03:46:05 Manuel Lauss wrote:
> > > On Fri, 30 Jan 2009 11:28:54 +0100 Manuel Lauss wrote:
> > > > gcc-4.3.3 likes to have printf() and related functions to have
> > > > at least 2 arguments when the format string is not a constant:
> > > >
> > > > cc1: warnings being treated as error
> > > > arch/sh/kernel/setup.c: In function 'early_parse_mem':
> > > > arch/sh/kernel/setup.c:111: error: format not a string literal and =
no
> > > > format arguments
> > >
> > > Please disregard this patch:  turns out that Gentoo applied a patch
> > > which unconditionally enables -Wformat-security and produces this
> > > message.
> >
> > that's incorrect.  the patch sets format-security on by default, not
> > unconditionally.  having the common kernel itself build with -Wno-forma=
t-
> > security probably is worthwhile.
>
> Well, at least here -Wno-format-security doesn't work, neither on x86,
> sh nor mips.  Otherwise I would have sent a patch doing exactly that.

works fine for me.  not that it matters as the kernel already can handle th=
is:
KBUILD_CFLAGS +=3D $(call cc-option,-Wno-format-security,)

also, this isnt a Gentoo specific issue.  other distros are enabling this f=
lag=20
by default as well.  they just dont make cross-compiler generation as easy =
as=20
Gentoo ;).
=2Dmike

--nextPart4358775.JtzMnWYTiD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJhIvcAAoJEEFjO5/oN/WBWyUQAL4qYM4r1kh6Cu36F49B1N1+
jfMYVKM4224vTr/frxslaxva7w04kO1itlse1/gf9IgDO5dqAQvYXwULPqj2blH4
wwLwYE5tlMHiierwHpXWV2FWpqMgMMi2fC7t4Zm58PwbodvQS93wn/Ug9kaaCHk5
RriGtVjmIlyWnA2+yDAPYIqLbyFPYia0aJ41R7JSsDQqNq55VBbYgAsQzPi9Hwff
/Kx90papYOttHPYUruBzjgBQfoag0iVM+y5w2MtMQdmfN4CRQOD5IEBuG+r2eWzQ
7mbzi2nwFYutpZSSpX5wZ+SkChjo3QZn322fJuDqDYo8O92ct27D+MshV19fo2DP
LeVAlxqGZZOnCQOuzlzcRuFHf9H0nYSGUUE9ieT+tIQR4W2rY4T00OBrjbSoOemt
7RgFdo2Vlp+YKzNALQZYaHS4UHRqUcnloqM3N/tJ4oqrvpC5JQgdDKiat8yGEnTX
RkiI31bBfCXdLQkQyfdU9hn4+2WTaIRQFQbWcUwDd35S5QxrutptCUpwiLMjK+u+
a76Eu7yovY7XHE3QBh9voqYJ2mguvoVKPXSCHrBHFE9rwVu9lxnWCtSthGtG3UJ6
j0Vy+L68EB4U0uQx8XGAkisRf4cYm216lELP9BE9ctKBlRhPiWb+pZY8UzILbvEy
ZO4rsLYNxeBZvMyhUbKg
=Xj56
-----END PGP SIGNATURE-----

--nextPart4358775.JtzMnWYTiD--
