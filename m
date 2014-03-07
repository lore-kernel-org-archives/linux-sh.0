From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:47:41 +0000
Subject: Re: [PATCH V3 00/12] CCF support for Renesas r7s72100
Message-Id: <20140307164741.GJ28943@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1ou9v+QBCNysIXaH"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <2368991.bjBJjms8qn@avalon> <20140307162946.GG28943@katana>
 <1552759.qGZNIXqrb1@avalon>
In-Reply-To: <1552759.qGZNIXqrb1@avalon>
To: linux-arm-kernel@lists.infradead.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > That would have saved only 2 lines since we need the workaround anyhow
> > (MTU2) and would break the incremental approach of this series somewhat.
> > I'd like to keep it.
>=20
> It would have saved one patch. If Simon needs to apply CCF support separa=
tely=20
> I'm fine with that approach, but if both changes are applied at the same =
time=20
> the SCIF patches could go in first.

Which one would be saved? We need to workaround anyhow (patch 5) and
some scif cleanup besides the workaround is needed, too (patch 7). No?


--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGfgsAAoJEBQN5MwUoCm2JM4P/2hZSA30HJThKpuB5BFNXIMH
wy/kfc11vPlKNJdIEpLO9zM2nYQs1gTzKkpv5b1W1j7vO87KEARhydGA48i3Ho4L
46Zbdq/81W+eQBE3J3uxQG+rJEgi4xDMxz9FIdSpKP5BJFadFvWPxgKHUmnrjcOO
ZlUlDmQi9LgojuaeRjTZhUimKYPT+d6SYd938qsaviyvYFexiSJPb5JqIc0X62iI
WNNTRIH7FSHPEomYOWr2iIzbDLoDLIdRTe1GkOicVXRpIhKt1AenfpfcWzg41+uN
lEKvzx+NRY80iPU8M4UDs2IVdx4lxRX8xi/ije9y7HCveEVD4WKQ3PABHl3YTkQD
FTh5Y4gL/vagYJF/57pqhmR/H0dQUfspRdzQU0e/7bJoDFJ4yNrHjgS/X3wrYgC6
Olmgp+vTD1DYpGee7zsZFO5SqF2w4Rl0rxnW6/oROurx1U8wcOKFY5Gu8eYipLIF
Gq/qA3EhY1gRIm6Kw30ORpyobiQDdWIJnTaT/2IwXkxoFCKtXDZANuDT7yqmvBQM
8qaJ/tIErpnkAJpekMCoElY0T6seI/OVJirV4P6061nFTT1uEwjr+hdzLwKjp4xq
KmC/nEbUWaobZgO5eiTrvax9RQXYFFA1UVjZVROSdTew0JYy68ZIKYbT6YMyfKNA
brVwy13K48Y42XmgPy2G
=PMtF
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
