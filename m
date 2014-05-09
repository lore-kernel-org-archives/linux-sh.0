From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 09 May 2014 05:04:46 +0000
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Message-Id: <20140509050446.GA2624@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
 <536BFF39.40607@cogentembedded.com>
In-Reply-To: <536BFF39.40607-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >-	if (ret < 0)
> >+	if (ret < 0 && ret !=3D -EREMOTEIO)
> >  		dev_err(dev, "error %d : %x\n", ret, priv->flags);
>=20
>    Hm, I'm now getting -EBUSY and -EAGAIN running i2cdetect on
> R8A7791 base Henninger board. Only when I comment out the above 2
> lines, I can get the bus scanned, otherwise I don't see any devices
> at all.

Huh, this is only a printout? Do you get those errors as well if you
remove the printout and add a delay at that place?

And -EAGAIN? This is arbitration lost. Do you have another I2C master on
the bus?


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTbGHuAAoJEBQN5MwUoCm2fT4QAKMdjs3RNvwH2FfO4VamHynI
gnbTVjmCkiNPVmfBXhHVzeGOIDox0n7cEvAwPpLKlCS27j8mjL3+0631zjTkm1BZ
u/v61rWWn4r10J5+6rMbKpvYkji849peeIxXSfqMM2UKjlN5tiJ/L3ZUnD4t9PKI
7v+YKT/14jWzPGy0MQh6HgNjARP3qKV9U3qOiqwik3p3iuQrma0IVSWrRo3uq693
xla2ufBEOgOp3MHOFJC0S1iGlNaGVu/mqz9f90FRziISe9jvG9pvFE2HJ1mhgtN3
D5iInhLNTvoDBLu4l4uHkvP1DEzOvNPCS74i1NsCjgBF6rRdGVBZ5DjSQr16AvGi
KKb1ic7TC0WilR18embFCvjUF7QcTbC9JjT0xqTAxxFRN9E0fszXQ+CeBvQCPnHq
LPpAEjG+k6rVN1LZBG2Lu86Flh4PpJdyKb46ONAvdD8SEzvgQ+HbyZH3O2MvNp/Z
221rlx2z3J/gwYKR4xouaTgrFut1X8ZlkqtJcRpD0TaLcEHSSDIQmX+z3oEzFJX1
QBOmlA/YjwjyrRxotsETRNCbiuXnUEXdK9yUMFn5hLnqAhB8mjAzqkyNDviimvuz
UnkcvDBzhCHfZeA3RdLSpHF6ZOCWVV8jsW6nnXbh3deyc21GbXfV8ImJUao+jhEH
bjZA75PbTUQZ6LRTmVMx
=vshO
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
