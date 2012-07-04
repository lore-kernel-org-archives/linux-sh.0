From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 04 Jul 2012 14:29:13 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120704142912.GD4111@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wbs6g7essDTrqL3S"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--wbs6g7essDTrqL3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2012 at 07:58:15PM +0900, Magnus Damm wrote:
> On Wed, Jul 4, 2012 at 7:48 PM, Mark Brown

> > If the power on defaults for the system weren't suitable for whatever is
> > being done you'd still have an issue even with the stubs but a lot of
> > the time the main effect of the API is to allow drivers to do additional
> > power optimisations.

> I may misunderstand the situation, but I believe the issue here is
> that the REGULATOR=n case works fine on the boards with smsc911x, but
> it stops "working" whenever REGULATOR=y is turned on and
> REGULATOR_DRIVER_FOOBAR=n. People probably enable regulators because
> they want to use the PMIC (that most likely isn't hooked up to the
> SMSC chip), but they get surprised to see the following SMSC error
> message:

Yes, of course, but then there's not really much else we can do here
except for ignore errors which isn't awesome.

--wbs6g7essDTrqL3S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9FMyAAoJEBus8iNuMP3dIqYP/08i5Y5r+bmn9ydToY7QvCYf
zZVTLJc0sUPyxoYMfZRr8oCmtvKqzFm/2xu8+m0n2u9d+v+mZZTpvR3AWytnbmpn
MxWYPkV26fpMR0yzUbqD0UjbK7ssk4bREsjqExM7/y8st00JFkllg+jl/C/FkvWl
KSTn4G3JxZVB/fcHaRI1gD3dHR+FeP9T7TrxeQjFWtnzmFa9XJXql8PhYlUbkDei
SmACb/nLqSNLHYAckwfyTd6qFfRW0zkh6SvXS/YqnlbiQqf+XxDSz8roukOo6/Iv
OMvK18ZFoPpR48EiVTlAoQ1oP9CjICZEiEw3SIDj7lbfOtIQphHa3GvfR1JspqvB
Pbge/aGCs7FX74zX+fnw3pitOjzv4dQ1sewvyioMtEQ8JYrI07hmf7RfmV1/R2mG
QHj30Ab59kVpl2modG2ynEmCRe71Wc5jNkd/HxLRj3wP6d+pam0kJGZg2KnPXXuC
HE/ep+hGWqDUJzvWgjwJrXOKPbPHW4nO1QQKouTi6ZJMpvhdl94XLJTpPCD5BcQr
73gBNud3tRVlhiA4aJSw9IyYxSjp+DBZknoC32Ym5s0SK0k+JLFq9Ve4JJOk3An4
1AYUEO6lJktPIvJZO9I9h2D7qgo3yZPIxp11qJZdXRFkE30fMBkKU2oZ3r8KYpCD
wB1QF8JJaGJC2jsT5ovc
=HMlJ
-----END PGP SIGNATURE-----

--wbs6g7essDTrqL3S--
