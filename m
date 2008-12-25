From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 25 Dec 2008 00:15:22 +0000
Subject: Re: stack usage with libgcc math funcs
Message-Id: <200812241959.56191.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3783702.d1LVfZfcVi"
List-Id: <linux-sh.vger.kernel.org>
References: <200812241257.33701.vapier@gentoo.org>
In-Reply-To: <200812241257.33701.vapier@gentoo.org>
To: linux-sh@vger.kernel.org

--nextPart3783702.d1LVfZfcVi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 24 December 2008 17:57:53 Kaz Kojima wrote:
> Mike Frysinger <vapier@gentoo.org> wrote:
> > i dont know superh assembly, so i cant really check the code myself.=20
> > starting with at gcc-4.1.2 (at least, gcc-3.4.6 doesnt seem to have this
> > issue), a few objects in libgcc.a lack GNU-stack markings.  here is the
> > scanelf output against libgcc.a from gcc-4.3.2.  basically, '!WX' just
> > means that the objects do not have a .note.GNU-stack section.
> > assuming libgcc doesnt actually use the stack to exec code, the attached
> > patch should fix things i think.
>
> Thanks for pointing this out.

i'm guessing that means they're correct :)

> Could you please send your
> patches to gcc-patches or file this issue to gcc bugzilla?

i dont think people like it when i post patches to bugzilla.  they tell me =
to=20
use gcc-patches.

> Unfortunately, now gcc trunk is in stage 4 and any patches
> for non strict regressions can't be accepted temporary.
> I'll schedule these patches for 4.5, then apply them to
> the open branches after 4.5.

well, i would say this is a long standing regression.  gcc-3.4.6 does not=20
result in exec stacks with any of the libgcc.a math functions ... but you'r=
e=20
the gcc expert.
=2Dmike

--nextPart3783702.d1LVfZfcVi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJUtsMAAoJEEFjO5/oN/WBMakQAKhQNxzLxZAwwAjPoyKZyR1l
fHwYzgCJ8Sf1Im0K50eoQJyAvd2j08yKTwSX6W1EG5SMg0E6YbvKH8oR3l46PraF
EsI5XECLKjAkXP/UAmYnEUf5UVHJECP6dZuMxhIIiynDUrFwImc2eRpjBpL6vzWC
g3guwkczE/qzyT/aCknjUaiNJB+cOFXdEv3YucI03FuzTIvzkYjXsUYcY0EfNlKN
JYIYPgb4hPr8Ee4c+4Y1fMitvoIgEZ2qbvWnc96l+Jkd1ZSC1x4WRgyO/a51qQPq
JEX8OGkJsDng5gz8/xRfG79wgUeATVCGpYnQN4F8GmSsUrpGTIqDsw9NELFsyzXC
SYEy41vt7sdFR/XeSc51NEaql1WjabGaWf64bj+eUfkI294WMMJIt5S7JV9wUqOg
FPczPRP/G+Lvy+6dGxzgaVmrXv8epAdWlcsPdq+oO28F23llDwXkC6Val8hEskCg
OoukhG9hyFLzVPOiuGcrrRl5J3olkoiClEIJQCfRag9m2IdN1uMXqmJLaTGZai8J
9BANNHpYR3bcE2/EWPkHLFlqVsCO8T01yGxjT8Rzjk84NqoXs+8vFs/LRAO+A2Mu
qzJlb+n5RnSOfXr/0lS1tYDBfGxUOeujHBbS3ifWQ+iJBcwta361s7CsrZH8hkls
qBrzCKShNy8TlF9X7YL4
=H8T5
-----END PGP SIGNATURE-----

--nextPart3783702.d1LVfZfcVi--
