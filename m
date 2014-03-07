From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 07 Mar 2014 16:59:04 +0000
Subject: Re: [PATCH V3 00/12] CCF support for Renesas r7s72100
Message-Id: <1725290.WIBK8uYmkH@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5859945.KQlTq0hEDz"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1552759.qGZNIXqrb1@avalon> <20140307164741.GJ28943@katana>
In-Reply-To: <20140307164741.GJ28943@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart5859945.KQlTq0hEDz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Friday 07 March 2014 17:47:41 Wolfram Sang wrote:
> > > That would have saved only 2 lines since we need the workaround a=
nyhow
> > > (MTU2) and would break the incremental approach of this series so=
mewhat.
> > > I'd like to keep it.
> >=20
> > It would have saved one patch. If Simon needs to apply CCF support
> > separately I'm fine with that approach, but if both changes are app=
lied
> > at the same time the SCIF patches could go in first.
>=20
> Which one would be saved? We need to workaround anyhow (patch 5) and
> some scif cleanup besides the workaround is needed, too (patch 7). No=
?

Indeed, I got it wrong. We can leave it as-is then.

=2D-=20
Regards,

Laurent Pinchart

--nextPart5859945.KQlTq0hEDz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTGfrYAAoJEIkPb2GL7hl1UB4H/jHQA578Js/2IgTMSrPzy3Tq
lLZIoVG9hHNOAJaGfIpmDSebTpdXFcFcaOS78SOTh7gqNjB8f4Ff2PNsf+N1n8UP
M+wgg2L/KyFIvVVtmIg3Leo95Wg1U89J0h5pzWmSBpejzZpxrd+1VWnE5tFbB+Oc
5iHwEiOqz4bK4zyDi8HlUzyjFOGidHbhXyrmfrsrjaMSKiWYA7PSBm/cV+kRGswf
mTqU0vr5ozrnTFVXFPcL97xWgOUW8xtgmyp6qxzZBS7hefY1c1BYAzanp6+gZPxZ
nowmhMS6rriAJ4CEmRFnm8IFAf40qiOJ2QotgJGLHHpX6KpGSZxJY+uI1j5j5Bo=
=Pmqp
-----END PGP SIGNATURE-----

--nextPart5859945.KQlTq0hEDz--

