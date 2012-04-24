From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 24 Apr 2012 10:57:43 +0000
Subject: Re: [alsa-devel] ASoC: sh: fsi: Build proble in 3.4-rc4
Message-Id: <20120424105742.GB12063@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xXmbgvnjoT4axfJE"
List-Id: <linux-sh.vger.kernel.org>
References: <201204230001.41270.rjw@sisk.pl>
 <87fwbv9v47.wl%kuninori.morimoto.gx@renesas.com>
 <201204232202.58584.rjw@sisk.pl>
In-Reply-To: <201204232202.58584.rjw@sisk.pl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2012 at 10:02:58PM +0200, Rafael J. Wysocki wrote:
> On Monday, April 23, 2012, kuninori.morimoto.gx@renesas.com wrote:

> > Thank you about this patch.
> > But this issue was solved by below patch on Mark's/for-3.4 branch

> OK, thanks.

The patch should make -rc5 - there was some miscommunication about which
tree it'd be applies on when it was originally posted (I'd thought Paul
had already applied it) and then I was very busy and didn't get round to
sending a pull request in time for -rc4.

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlocfAAoJEBus8iNuMP3dq3gP/2y1TZZbTNHAA1muTRtPGAJp
djDDTfeMj/BSAEDUE1IE5k44OdvON0+m1pUVVQVAdlLsS7sBcqr/gIgvhp5aQL/F
WYMmlWNp2IL4p/hUf6ONIS00AqL7pQKzMbfF5NdO4bBaC6zKVBK26JP6+kDWhwFs
3xtXFP7WeERzM5FjtWzrgk8Ifw5HaaZoIozv/JbuJlTcHSjgA1uKtoY6K3G/I47V
9UbST3rjxfRz8buU+y22fVPgoP77xIKqJGbPuFHq6HAVWL//pCaoueUTcckmci/V
bEGj3L1O7mccg+mnM2DYnR2AQQcb1CxsZeCCkXoH+fqtFGCYgOvr6d990JF4bqmr
mnUqrLLApRNI/T1J6WOCSYoXaNj76fb1m6W76lfBLFFDggYsZOGvCHRm2Xmt9VME
gqXXpATsP1FgpXXoF0JPT5XhvNii/mIAFl1uKnkukYJVC4ZxLTLNqFsIBAAQh9qY
ybU1wSKuccELaYO+6Gxpr6u/05J5LSiC8JNi5fala8prRReXtCbpqIS6IT0RzJwi
5yd3BqDKMYN48RHeYKbROKPYDUg22dCDECag0YcR3Y1zVvYycmpBb3cIZTBcT+NW
xJQYQ/RoJd6DguoZOT7MbEL3xfAPSr2J7MORduQVPNe6qIiFhonWB5j1Ll7wGntj
JYRFKbrajFWaJgLxM4zH
=QL1t
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
