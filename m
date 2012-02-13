From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Mon, 13 Feb 2012 13:41:55 +0000
Subject: Re: [PATCH v2 0/7] SH Mobile sh_flctl driver brush up
Message-Id: <1329140515.22240.145.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-JHzTCu//G6JlmVgoQz9W"
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-JHzTCu//G6JlmVgoQz9W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-02-11 at 12:44 +0100, Bastian Hecht wrote:
> This patch series brushs up the sh_flctl.c a bit to make it work with
> the mackerel board. The hardware has changed and this needed to be
> reflected in the NAND host driver.
> On the road some minor enhancements have been incorporated.

I cannot even compile-test this patch because I get the following error:


sh4-linux-gcc: error: command line option '-m4-nofpu' is not supported
by this configuration


with the cross-compiler downloaded from here:

http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.0/x86_64-gcc-4.6=
.0-nolibc_sh4-linux.tar.bz2

Could you please describe how could I compile-test it?

--=20
Best Regards,
Artem Bityutskiy

--=-JHzTCu//G6JlmVgoQz9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPORMjAAoJECmIfjd9wqK0l7wP/00MVUTfzqyD7GtD+XVhZdL/
N1+jmB+l9x6rZa2dfWiK3DFrYa0ARVHPZ6e5gUInyt4Sz9NHyKTisNc9WCVc+DsO
x+4/Hp41O8+3UleRlNZpalIuOP1/aePfUfyanUBILemUfk3NONyi0qFgH+ph6goy
CAMLVikc0m2j+yB00kCKBhNmYykfCHN3otcX6BjbJWg5GfNs2U9p4DtoDPOx+ivR
V/nE41+3b4mGMfe92pHCaBMt5ICJ22PCYnjqzfa+AAHqCyvZXP73eSu5USsUTjwW
U4E730buU8OQL1TiGg/6QvSeocdngBGxE3/3J/BZXGQoap+DiU3j5muakhABOSdD
WwD5CdjIYZjpG72pOFRNMcIz0+NUs67obwSPySrISfQd4PL3hQojMyvOTCBcB4yf
D07XQwdB/8rYYIiL6WzV01bhnXCSy7imJgDdkC3SZ5ujgIVcKQPBC8Rqyy3qjymm
kkeGobZjH76bFH/EJrqv9PJlR8FlBQP8uJCtYS5WasUI60HiYZ+AmTD/J6CjkJPL
RLBGmSkiBglagbFuf6yIqZMy6XQaMDcOWxH0wHH58A7nhEVaVzNUdG15LpH+swTA
WfAYZp0gokCrDrRFNxFZR/fAaXJjbqpULc32IRVlTgTndRLFTrHUXvjT7NNZMYLw
/0Mrt1eHiIJGweSTfoq6
=0Cvo
-----END PGP SIGNATURE-----

--=-JHzTCu//G6JlmVgoQz9W--

