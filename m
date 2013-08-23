From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 23 Aug 2013 02:11:11 +0000
Subject: Re: SHMobile Compatibility String Inconsistencies
Message-Id: <20130823021111.GA2792@voom.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
List-Id: <linux-sh.vger.kernel.org>
References: <20130822054639.GE11086@verge.net.au>
In-Reply-To: <20130822054639.GE11086@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2013 at 02:46:40PM +0900, Simon Horman wrote:
> Hi Laurent, Hi Guennadi, Hi All,
>=20
> Olof has brought to my attention that there is some inconsistency
> in the way that compatibility strings for SHMobile are named and he
> has asked us to clean things up for v3.12.
>=20
> Looking through arch/arm/boot/dts/ I see that we have:
>=20
> 1. {gpio,pfc}-r8aXXXX and;
> 2. r8aXXXX-sdhi
>=20
> The inconsistency that Olof has asked us to resolve is that we
> should either use r8aXXXX- or -r8aXXXX. Not both.
>=20
> It seems to me that neither option is inherently better than the other
> so we should just choose the path of least resistance to make things
> consistent.
>=20
> Laurent, Guennadi, do you have any opinions on if it would
> be easier to change the GPIO and PFC compatibility strings;
> or to change the SDHI compatibility strings?
>=20
> Ideally I would like you to come to some sort of consensus and send
> patches.

So, by all means clean this up in the dts.

BUT, in keeping with the recent discussions on improving the DT
process, the corresponding drivers must continue to recognize both
forms, so that old DTs will still work correctly.

It's probably also worth putting a note about the deprecated form into
the binding description, too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSFsS/AAoJEGw4ysog2bOSctUP/1v/hIIuRRaE2qFsK7JgERbU
8NCRyhkRXNeqRn9mm4+NTLfE0IYfhpa7o3U5UdLv7hRzJed1IFoLqyI6+WIRbYhF
8V8TrCms1x7rOrsJmJJUymHVM12t2orPxALYBAHExlwO+5E7KvwLdJ/SoT27+HW6
CzkDy0YcwMer95f8Uek66C3td95+9jaRT13AJJ5IkJCm5c63GNPx9aG7angUH4gx
5eAAAipJxkimy2tZYQ8F3S0eikqr6SzVIWxLmZyGBPlH/BtRsKv6eJl00FaGgDcw
S0OfpdVN2/Qzc/RgAi0SEXWwoLmYe9lH7ig0LI2RdkncV0S8TRqHNWVhwKeA6Lww
yS4ryJH+zpiKKCCIfdkuGpxFA7Ao9bXoGs22f5Jt2cSWrGrClZBss/ZrAczl+auH
Y/giRmPi00fghh6nwNbHlwrGks780CdP37l0opKxnB98tK/q9e3gKbFuk7YCOyje
BPnB464mhlMUmR5bLopHIprgdXE2ZNFiuwpigDRtNmYlX+8i3MpHOQkXff74OI+c
IibXKkNAl0lf4+Y8JQB081gpKuEfrjn01ObZFTtCV6C1/IT761VuufcpDmUCbLzu
IIZGHlu17LY7/AM5NZFUdPg1LvvX7IMxEc5ONcc7ldFHIQGkVKS+RCx7U59NZ90u
cx/qgScEr0MPSS4Wmgwh
=xlPp
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
