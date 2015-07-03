From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jul 2015 14:37:03 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703143703.GB19284@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="H1spWtNR+x+ondvy"
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
In-Reply-To: <alpine.DEB.2.11.1507031612410.3916@nanos>
To: linux-arm-kernel@lists.infradead.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So this is a single core machine and uses the em_sti timer w/o the
> broadcast nonsense. In Simons case it looks like em_sti is used as
> broadcast device.

We use the same board. Just my kernel has SMP=n.

> Though the issues you see in the highres=n case might be the same as
> the ones Simon is observing.

I hope so. One good thing about the issue I see is that it is 100%
reproducable.

> So in that nohz=y highres=n case, does adding idle=poll on the command
> line fix the issue?

Nope, still hangs.

Thanks for assisting!

   Wolfram


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlp4PAAoJEBQN5MwUoCm2SRwP/iJfH4B8voNDd+FCf3hPe29w
iPFrvGk2QNgHdc0bQajcnjiLQCYJtKRmrOvOXlTX014Jk02B6LDIVmFRve9g2ORk
duvSEuWjq/yC+XcwTw39fBHj1VD1M3LGPW7P+nDHKZ1XpxYssBHwM9LUm5C6ByeU
srRVkkZ2oov4ibkWj+cFuhqx4VZI0wsFeM8qgAKoMVTjPRXbBh4ZNhxbb/l8wILJ
g8bIxB9eB6XNBK66MtShyYZiGPcRGxdMeDJRY/otr1HUILWgJosX/PLYdhIZUiew
gCGIkj12WuXgVP7LpbCVRN8CBVyilVklWa8REpGkiyfXQ/pPjYQeZHYI8igzVcrl
TZUEi7yF7lXGP7CYXxLyFxuHwHqjoahdsK/z8a+3YZSF+jTnaUMRtbmKV9yExoY4
bRE4lJeqyMT7QG8bKuJ/4PYpLRc4MC4assavTVCnoeSwJbIMFwqLHfGm96EZgFB7
G4kVpOcDNAHuksremVcxGvRajV6taqD/kAOobyQ2J8GGVuoSYc5ER67PLy/hvqZ7
fKSnmRbKby7QqMnoVFj0i2/j8w5Ge4q6JHeSIfpV0X9bIGScwEhUgnXFZj0Shx8h
pB0SiGI+fYPnH0Wj3ySOT/mJSikutRBfcO8K4GEUJoR8ow9fL2CTdWh6h8b+uvMl
pXlNFIxvi9k4wbANGTza
=JAxF
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
