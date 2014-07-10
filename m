From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Jul 2014 11:56:48 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140710115647.GF2728@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4VrXvz3cwkc87Wze"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 02:32:25PM +0530, Vinod Koul wrote:
> On Thu, Jul 03, 2014 at 10:48:34AM +0200, Wolfram Sang wrote:
> > Hi,
> >=20
> > > With dynamic debug, these flags dont make much sense unless you want =
something
> > > to be printed *always* during boot.
> >=20
> > Yes, this was exactly what I wanted. So, for consistency reasons I
> > copied the existing mechanism over to sh. If it turns out that the
> > desired default is something different, I'll send patches for that.
>=20
> Ah good, and while at it, Please *do* mention this in changelog!
>=20
> also fix the subsystem name to dmaengine in patch title

So, I assume you are okay with the change now that I gave the reason?
But should I fix the other subdirs, too? Or keep the change minimal
(=3D only for sh)?


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvn9/AAoJEBQN5MwUoCm2AVYP+wWYAJ8XBvpeiLR+/2bDgk3P
6YOIq0TfS5KuNS+krqj2FJ/b3Zd0H1i3Qyd8jHlrueufLtaTglyzruwIGcqKlzN7
LP3oBDNAiShXTotpxLP9NK2J5wnyGLIkxP7xAyRSopZ0LZH63orgwzA1CoCUTM3a
OWaTLQg4SCY6FpdXyVB2m4Yo6T89Q530IBM/Dop0DujDkJJdOc29yYSXrphhLu6e
UgZyUkBWH7lhmGsTga+yxesGgTpZ2Q/PIz+XOavT7teO27P52QzOIUSHRXqf6fjn
sqT5mLBBDntxX/yMQOW8M3+mv0bSHHEqcjGa/ql7Hk+QH+LaQfcOJqL7lRxLi1+2
s27IT3m9cSutFw8rXaGA5aaTl856RiwO9Ch5EmFn6t4t2DjIMR8UUhsq2bNuJWkR
hyViQZfjoD8tiht+rz1V1bZCk57dmoD/UDGDjFDjcftW60gR6HMhciKShVEz4XKM
Qs2Tb6VQBKiQSUya3f1z7pYKOYqDtWO+Sm0ga/W2++5o+I8mLY30erSIEbUkZ4t6
gMbsLB4agFSOhSRMx1Px5nRBVXY4/kSP3mnWR1V35b7wxuqWVmJqpQ4bKoavCIKL
/qkcGBfwSEqBffPZ9ReTSBtN+i+fsVbWGffo/Jquk8xhE0YNOCqmwmpBNV8/VA6X
eW6ma3M4oulF1RLHqWkD
=LxpC
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
