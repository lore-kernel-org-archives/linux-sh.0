From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jul 2015 15:09:52 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703150951.GC19284@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/Uq4LBwYP4y1W6pO"
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
In-Reply-To: <alpine.DEB.2.11.1507031640060.3916@nanos>
To: linux-arm-kernel@lists.infradead.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Ok. So it's unrelated to deep idle states. Any chance of poking with
> JTAG at the frozen box? If not, are there GPIOs which you could use to
> monitor certain state?

No JTAGger here at the moment. And no manual/schematics for this board
:(

I'll ask around...


--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlqW/AAoJEBQN5MwUoCm2Wr0P/jOyLDp68V9mpaBboqymKJb+
9JmlXcI39XjyqqqLeTzz1qhRPABjutiR+FVp7kEec2FKXPdLJSwWCXBsp0QEBDz+
JY7mSaA5SNhJoMMrQpF43oxonLCFAZk02GVSf1k/jSZNZmtlgGccSbTQeeE9nbgi
aOkgUA84OGY2yQlvavoAMWYBIXqIX5XINJKUBW3p7mD/7H0pElesffHaVFXvib56
pu4mFlzsjR0KH06XIk0f95iicprGZXlv6pr3SkXZFm/j/0fxGXhwOa8Ty54y8IzZ
SAR5qeX8e2GIlqf0qECp68Ee0/DUVEZ7Z2D4E07t8wZfUGQWdNJj++ecR/9JZeTi
mPQq20TZrrns6WxiJPMo09nq7S1KEc83q+iaJIKwntf54TN7Zy4xDXAHIU8oNBTk
SA/ZjE4VAUn3hVOsYZrqhc7jPSScOAOMTEE7yJiFTk9+02W3+vy2XLEigYpglKq7
nTOkObwxzluzlzGeYzsRXXIkhhFqXaoss9d4+hjYB/2ZbNymIDyWNMmlOBWTXBid
56vbOogrUCGY4c6p1bw8iUrlGVcoZrarDEOP9A4s6iSstpOdF/RAMTQK81ErSUOP
cZYLX7C5bEw52NZiwY0jcAngBrbHszD/QvuOxaYYBQ+foM5/2S8RsqxGs5lUPCEg
+MqFtE2jDFs/pnYjK+JQ
=U+fQ
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
