From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 07 Mar 2014 16:36:25 +0000
Subject: Re: [PATCH V3 00/12] CCF support for Renesas r7s72100
Message-Id: <1552759.qGZNIXqrb1@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1971137.3Xe0itulrT"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <2368991.bjBJjms8qn@avalon> <20140307162946.GG28943@katana>
In-Reply-To: <20140307162946.GG28943@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart1971137.3Xe0itulrT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Friday 07 March 2014 17:29:47 Wolfram Sang wrote:
> Hi Laurent,
>=20
> > Beside the comment to patch 06/12, I would have moved patches 06/12=
 to
> > 08/12 to the beginning of the series, in order to avoid adding a cl=
ock
> > workaround for the serial clock only to remove it a couple of patch=
es
> > later.
>=20
> That would have saved only 2 lines since we need the workaround anyho=
w
> (MTU2) and would break the incremental approach of this series somewh=
at.
> I'd like to keep it.

It would have saved one patch. If Simon needs to apply CCF support sepa=
rately=20
I'm fine with that approach, but if both changes are applied at the sam=
e time=20
the SCIF patches could go in first.

> > Oh, and one might ask you to fix the 80 columns checkpatch warnings=
 for
> > patch 01/12 :-)
>=20
> Broken intentionally for the sake of readability :)

=2D-=20
Regards,

Laurent Pinchart

--nextPart1971137.3Xe0itulrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTGfWcAAoJEIkPb2GL7hl1yEgIAIM6KpxtTCni5n7MngqOMF7W
FzHjdVrbM6LP2zUqTs2Af07+zSPlBe6ZAUjCwDJWY1lKeY9v1iDlo1YWac1gL5Y9
nsXi7zIRkOUU6CTGtPNzLu924iQaCj38DrkdwFAC5S+wlUacDcMctn9vigqe1waD
aCFxTCCRwWQmzqKDqoZymr+eQfOAjs4q2N7pbuoxHYLoWHurt3k+tgats+MiohGV
1H6KEuesMJ43qsfC+BSwyqK1CCMrGn8waq4PAtb40OSyeJf7jN+5mcG7nQfE+Nla
sh75ZJWR2Sy6b+5MwfM7RS8EAdQVNMBgtebYDNlFR+2pMEVj1Y90jFHTqIBFoZY=
=aJlR
-----END PGP SIGNATURE-----

--nextPart1971137.3Xe0itulrT--

