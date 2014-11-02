From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 02 Nov 2014 21:53:59 +0000
Subject: Re: [RFC 0/3] i2c: sh_mobile: add DMA support
Message-Id: <20141102215359.GA1278@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
 <21770791.t5tSlWMt1c@avalon>
In-Reply-To: <21770791.t5tSlWMt1c@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Here is my RFC to support DMA with the i2c-sh_mobile core. DMA works ni=
cely
> > with my tests so far and we save 1 interrupt per transferred byte, yay!
>=20
> Do we have an idea of how much power (or CPU time ?) DMA support could sa=
ve ?

I have some numbers from the function tracer, but I don't trust them.
According to them, DMA is always better (50us per interrupt vs. 23us for
DMA setup). This is why I say the threshold is still under test.


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUVqf3AAoJEBQN5MwUoCm2umsQAK1STsWyrmIz7ktNrJgCB+mn
pKsBs2wV+8v6uQU7BUbByc4kLq7WVgoIgTKrSVuGXPoC0shuL0SCXMzshg90VyUk
+ZRuQADtylTPmzznVobDIzCsOElaY/x03Yo9Mvl2G6feu/d9XESueu7HPhOdYrLL
mrdZAfMpwvD7atzvILhpSHhP56outoiddj3lKgE2qCHCc3iOdHBvYU64if4u0QmA
/l+cx+OJLEBO+XdthbpHQCbydDAVNbkadz38ih+z3a91OmNtfUTdiHTPk+gK5WfK
SmxyEo8uHC7FtbGSm9a+pimAIIthzSN/AQ6b5dVbKvpf0bR+1zMw7rlO3s4Wzufp
eYZISE3qmGJ9ih471pwZG6xbLHcU0u5JJq3c9U4oCs2eYVSguAWwdT65J6ETD63X
mXh6wvsfZGOtxsy9AkOcWPCCtX3oVq8BsrBS3t/OodiDB+6xaZmzgKwG6Ji2dzQs
ISyrnAP9wXUd0/Bl3GJxabW9QuXMtjK2FbwXmjvMItHxBGFuZ/bETxcU2lTBnz94
iKNVtIir0X80PnpTK3ErayAbWkaKJhWrAMGt8fGxETGKiLaYkmoTaQUb2ytoN706
slMTZ4W2aZBeR9w0L/JH8UU84FKgyDGNY/DZJI87QnhLIhi7V1rjs1MSdlveZzve
6q22XjIlIKC1BsGtS3wu
=a316
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
