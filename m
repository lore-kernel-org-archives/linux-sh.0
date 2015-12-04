From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 04 Dec 2015 08:41:40 +0000
Subject: Re: [PATCH 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <20151204084140.GD1526@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tEFtbjk+mNEviIIX"
List-Id: <linux-sh.vger.kernel.org>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
 <1449157899-6572-3-git-send-email-wsa@the-dreams.de>
 <20151204083428.GC1593@lahna.fi.intel.com>
In-Reply-To: <20151204083428.GC1593@lahna.fi.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +void of_i2c_parse_timings(struct device_node *node, struct i2c_timings=
 *t, bool use_defaults)
> > +{
> > +	memset(t, 0, sizeof(*t));
> > +
> > +	if (of_property_read_u32(node, "clock-frequency", &t->bus_freq_hz) &&=
 use_defaults)
> > +		t->bus_freq_hz =3D 100000;
>=20
> Why not create device_i2c_parse_timings() instead and use unified device
> properties API?

Sure, just missed it.


--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYVHDAAoJEBQN5MwUoCm2ubwP/2bS6k18AIBEpg9z550wPBNf
riLNEudioyjnxEpkidwWeV0nYaa7efLAxjagYqTDvXytRSTxvO3b+S2Z125kh0t1
7cspDpfcuSTrLHJGabQmTUmd/HB7j9QZSyIaJUXgLF+5C7P0Iz8NRHIyTTJS0xCO
DETYHvm5J9nNkeef88Fp/eBfTY26ev5gZzk1HaoY89+UfEIRDJGExN97v29Y0yIr
Kv7s7HYVw5pZKf3kN2XZC4c1MM2YBMBKOJ3yqjpdD+5URME2HrFppdQTYdp+Vrlm
IhecvpCD1VZxVJSBIkaMc38oYSCoq6VfEr0HFJPr9E88BzQQcWq56Ut1zsiOxNRv
IDoQymkpw02QqaaQyjkoYTc2AhH5v6zdGxnOSIZXQC9WILBOOeu0Pr0D2PRauJZa
m5bL6wF6IrQ6iolclHn1bRAmPMIZuqSCvM1nDwZyNHrlRmnfMLgsYRS/nR837kAR
fItnAynX3U8JDHtmd+IbtvdGQ+C3w3JSEZ98vpo/iKYncyR9KphNMKoB82fCRwNk
S4/igFaU29seVvYR7Ku2kJWEekTOkneQflnaNQEC4BJpLbIaH2Iw3S3rD0MASXV8
LgwdG0jClcSJ3GVSoY2uIkiCoUfZn7crZ8nnzY/GLwFut3xo04WdRj72/Xvb956m
6gzRrchtKp4xY8riNOSJ
=fSXZ
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
