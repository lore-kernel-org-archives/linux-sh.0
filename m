From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 23 May 2013 19:12:17 +0000
Subject: Re: [PATCH v2] pwm: renesas-tpu: Add missing pwmchip_remove() call in tpu_remove()
Message-Id: <20130523191217.GB17462@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
List-Id: <linux-sh.vger.kernel.org>
References: <1369057541.11578.1.camel@phoenix>
 <1454213.B1kNpQ6JtX@avalon>
 <20130523013933.GI22608@verge.net.au>
In-Reply-To: <20130523013933.GI22608@verge.net.au>
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2013 at 10:39:34AM +0900, Simon Horman wrote:
> On Mon, May 20, 2013 at 03:46:59PM +0200, Laurent Pinchart wrote:
> > Hi Axel,
> >=20
> > Thank you for the patch.
> >=20
> > On Monday 20 May 2013 21:45:41 Axel Lin wrote:
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >=20
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> Thanks. I have queued this up for v3.11 in the pinmux branch
> of my renesas tree on kernel.org.

I'd rather take this through the PWM tree along with the original driver
patch.

Thierry

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRnmoRAAoJEN0jrNd/PrOhxN0P/07aOzDVB//xE4rRYt2bIUlC
N3rRVCMYaarbHkUz4arEnIWx2jIBEBuE9Ds2p2i61wTKlV4bAGxh6cZzyncDc4u3
s+yBHDqG8sqhpet4amOjiBR0umwwKvwNxwvrV9ELkGk1qcYRsY40MBuhZkixpL0F
o0QKeRDyxahuTsY4xqyTCsAxxnq689EP9jdeSEylQUvUgVSNdGtLKo8zryLoPZhy
5d89AD2QiNsE/5y+uYxPNhbYpOMSKDVa2i5IclLNzqZ2tJP4/aNGA6ElgRok6CJO
+ORm4Mpv7NNeIyVZ24UG4xaaUWfr4wJj0ESI6O4WRXPnDgVLz45a21R8DY0oMNqw
hw+0q4vskAVdnzUlQ2NPPhVAYOKZUOfcm2tzBMiF6hVbRVNNdGJjBLWjzsXWHSM3
d7ogTbpVVeFgSMngAfr+7lXkD0DRybZ+FA/Yf+x5VjX9pyncJV4hA0dYEZ8pyxyW
/2ca23QaaRaOpcL/WoVSsVRCtXqPkBbtviitgYVVWtXorehF8DcLwMwXcZnNUaME
Q9eCaEGMbZ/TZLDtmOWVRnh0RUe/x2je2NmqGtf3nxXN35ATUh6IFZP7hyJIfXzE
WxPVt6In9kDio7kCNZsXU74AlYp/kS2Wc8svD45NLpyPXpPC825yqopfgG4cOzyl
rfOErZoBzlEmSJViRUWi
=91qk
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
