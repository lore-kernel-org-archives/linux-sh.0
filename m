From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 11 Feb 2008 16:19:22 +0000
Subject: Re: [PATCH 1/2] SH/Dreamcast - joystick (Control pad)
Message-Id: <200802111119.23841.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5009716.3X8OWOap2R"
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain> <200802101922.29214.vapier@gentoo.org> <15561.85.118.17.158.1202739603.squirrel@newgolddream.dyndns.info>
In-Reply-To: <15561.85.118.17.158.1202739603.squirrel@newgolddream.dyndns.info>
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: dtor@insightbb.com, Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--nextPart5009716.3X8OWOap2R
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 February 2008, Adrian McMenamin wrote:
> On Mon, February 11, 2008 12:22 am, Mike Frysinger wrote:
> > no remove function ?  looks like the probe() forces a connect, but
> > there's no remove() to force a disconnect ...
>
> Removing these devices (or any other plugged directly into the maple
> ports) is a quick way to destroy your Dreamcast: hence they were never
> implemented I guess. But there is no convincing reason for the software
> not doing so, I suppose. I can just put in comments about it.

and not allow the driver to be built as a module until the comments become=
=20
code ...
=2Dmike

--nextPart5009716.3X8OWOap2R
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR7B1i0FjO5/oN/WBAQLYOxAArM49XymmM75twU8GipLDQtGuiZ+0WFdM
ixM5yJ++MpyoxW2lS1I7a1C08CDDWrAaLu9jkQiQSf5HnnUBfif8l8Yo0wSFC3wg
8xZyOe3ZoOInID5eI3FakCoOj9jB2l2EbbQK7OtfI9x/BtVxnCG4ZjttNgG7AbwW
6hPaV1dkEbWClN26U4NLI96c0FH3udM6APMNvc/he1cFe2wJSy1Bb35rKiQIIjqo
yc4fDuwFpwUH/B7tniGbAbE+aJmIqi0qUkspVbWmkom+284wVTMrnn/6/7NSbplL
811sdDKW0kPllFbUlnVjItVNHdKxJiBFBSlBtx49kGXDBsWS06m2dg5RtQ1x8IEC
hnJKD8R0z2F4Flvb6r4HPYF7of+A6fNVXkJlGwKFUHsYfB9sl9DyDzaT5zRVNdmE
DhRptIBWgoQ2ztwghTAAvz+vv3Vf1mk3DcjjWQ7d+Vm/ywalj3yDJUbt4V14d6SY
qCBQZkmqfG3L08VaKsqHzIfAmhOGu0adt/V3Crdwoto4S4L5FiSEOqPYCgwkkcF4
fMrF8gzp0WBwB3Jczr8fZCffKYNrCNpjPJnrFjO8noko9lNeSfqLZKPqu1euQvDp
w6mhsetfUoXuJ8eCTNuYz8EQvmXgNgJ4noXaeMJ6BGkchhYZxNIT8uceAepkl71Z
zv1o+cMtn+s=
=mcbu
-----END PGP SIGNATURE-----

--nextPart5009716.3X8OWOap2R--
