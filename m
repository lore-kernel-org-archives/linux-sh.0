From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Mar 2015 05:02:28 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <20150325050227.GB31311@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
To: linux-sh@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 05:54:31AM +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 25, 2015 at 1:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> > I attached the kernel bootlogs files of Koelsch and Lager.

> Thanks!

> Looking at the logs, the Lager seems to use systemd, the Koelsch doesn't?
> Could this be the reason?

Given the area of code that was changed I'm thinking it's likely to be
some timing thing so that seems entirely plausible.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEkFjAAoJECTWi3JdVIfQ5CgH/1VHF0fNv26cSNi1/+tPB0Gu
sH8zmIMThhEzpW4NgUv+VvoDu6Gd7gtoqNKERsUCvWVpVFgOgCK5so3rPGoMALiN
J2hc9dxZfzPIQz8MabFFa3n0duvu9iNU4nOfMWwmPIobvjYqvQHFnbHEHg4ZWQCn
k/Yfg23RY6lxAY8VpS654X0J1iyW05IY95DopGLY/WZSn/i0CCW/HLgyQpay0Xci
a3DIGgqPW1ys5BDKZecZ2bYY/egtc3RePmLroYPXuRDJUv44mIfBkcQCpqd8ZVlV
FXtOruFNXhQpgBkVhWxgQgc6e846Zcmczp8ZmcmasBKK+PGFTfJ4Nki/SOEexRE=
=vWaJ
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
