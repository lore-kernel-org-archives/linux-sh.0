From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Jul 2014 12:48:19 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140710124819.GH2728@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6cMF9JLEeZkfJjkP"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > With dynamic debug, these flags dont make much sense unless you want
> > > something to be printed *always* during boot.
> >=20
> > Yes, this was exactly what I wanted.
>=20
> Why is that ? My understanding is that the purpose of the=20
> CONFIG_DMADEVICES_DEBUG option is to enable debug messages for debugging.=
 As=20
> it requires recompiling the kernel, wouldn't dynamic printk be a better=
=20
> alternative ?

I didn't mind recompiling once for the prize of a smaller kernel image
(only the debug strings I wanted are included).

But let's just drop this patch, it is not worth all this discussion.


--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvouTAAoJEBQN5MwUoCm2QYQQAJY/EQeVtcXDhaWJ+MIqZLHX
BQFO70rFl33x0vgF20sYROtWhwIAczcK8051yyxswc2A2ZxdJ7fPR8Zc3uguFj1k
qQR+4heFDtYz4c+YIJ63L4cQiCH/YOHKtJsReDP3J4Ew4hUXy0kcrSUT7e2fb7/r
qoptJN1Ucu7xpdaIHtgu/8KL8zw7ykWUsWVypC65Oid9O3A7sVGz9/9WTTRPOraZ
/ipPhn6jVHsb35sOhAoVII4DB0ffcIhZv9vHEjV+IFLvjHI5k/m4FzBFUBp0Rtn0
GSeWkZl6quESmOFIZbQx/E2XP2TdUXLpcFhclDy0zlEADolvG+MxLgihf7HKl0bO
/H0wz5luyxSRro189FO6cDqnk7j3b1q8kJRydUbHTh3un7icpHjGbmJlUEg7F9U7
qRLF+Qn4JcIhzVTKXkJSGXxgJ5IWlvBhoieE06TvnexsMZNy6Cs0Aw2aSwxaF0uh
HszrTJ6utIQvh2Ds/t71jOWsul7E88TOr+uXp5d9IqqzAlQ478sVrkOoDrDoQIlf
B9e1tqcBXJXlPGPdaCVmVKtjSg5Wvoe5D0HjCl4TyfhQKaB90WnonwduvVYHDa9m
KQBv2lP4idb5FelM7VaVFPFFfV9Oe+GgL54lYpd6BIowtthO4ZDMdFhYhWWB3hKb
dhvICcFTUbNLWqZxNkXW
=d2TS
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
