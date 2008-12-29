From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 29 Dec 2008 22:19:42 +0000
Subject: Re: [PATCH] sh: maple: add support for the Maple mouse on the SEGA Dreamcast
Message-Id: <200812291719.47754.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1844194.ARYGyQ4zTa"
List-Id: <linux-sh.vger.kernel.org>
References: <1230578246.6496.25.camel@localhost.localdomain> <20081229214634.GA27064@uranus.ravnborg.org> <1230589073.6496.30.camel@localhost.localdomain>
In-Reply-To: <1230589073.6496.30.camel@localhost.localdomain>
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

--nextPart1844194.ARYGyQ4zTa
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 29 December 2008 17:17:53 Adrian McMenamin wrote:
> On Mon, 2008-12-29 at 22:46 +0100, Sam Ravnborg wrote:
> > Look for an increase in section mismatch warning or try to
> > build with:
> > make CONFIG_DEBUG_SECTION_MISMATCH=3Dy
>
> Just rebuilt the whole thing from scratch with that turned on and no
> extra warnings at all.

regardless, please add the aforementioned wrapping.  this comes up from tim=
e=20
to time in various configurations.
=2Dmike

--nextPart1844194.ARYGyQ4zTa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJWU0DAAoJEEFjO5/oN/WB/jEQAMPltsi2yYhWiIs+RL/Vn7o6
Zxf5aAMX1SkKCou7qErrPMvYJKZTXuIUXBKBTLFIdDsMALsiH6vy+Ju+FpWTk8RR
V5QuskwMe3rrxgF3Mece/zWmPZl33L1o9OpW0MJZhQnz3mFCl/KsU3wQiENKMeDr
8/bcjZuVEwRid+xzJzA5KREEytA5slnGOQ4exuN50UYXHkVcpD1J/XeW7UWjY3dk
IrgWpTdSJCyrbpW2gNmOKXEeMh05VvwKz66u59r+KMDAMKbyHhYl0Bc3bOpZXVvR
Ytvy7fxG1qUO9Yu+iM0MS5ZIsNMEqgRvKIF87eOYlGKYN3X0XwRVBpeDpNfI3nS+
Q3cKkM1ucRB3Yi5snpmquVO6JAYe2br0p/Hk+P+DQMIVMKmlWjf9mfQGOww0+MmM
Fpa4sQu/feeY7MRqmMl+N6KIBzcxRQoiZDAIa3W45WIwAaYljBXjtFzBg58P2aMS
cvSIhoRnR/6Yqb79ALbXdVTq0OUwlCu432GanQhGdx2v3IDvMQHIfKmT89+8DK8A
Yq3kH2z22sn1u4Z0oNWBF66M6Cjaz+Qs8vZRmyBN8rzaGkrP/DO++JgjsWYfBGK8
jSKFfV6w+Tz7iXfiCRxYgmBR/eJk1X/tDt8ry3hYZtPvs27l9j9bRkl0W9XaDLBx
F15Om2/dhBjCpe9+Ik+0
=Js/w
-----END PGP SIGNATURE-----

--nextPart1844194.ARYGyQ4zTa--
