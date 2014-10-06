From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 06 Oct 2014 06:03:47 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: Add early debugging support using SCIF(A)
Message-Id: <20141006060347.GB1266@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
List-Id: <linux-sh.vger.kernel.org>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon>
In-Reply-To: <2257006.dpJJ6zLgnP@avalon>
To: linux-arm-kernel@lists.infradead.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >   - While the serial console on r8a7790 was switched from SCIF0 to
> >     SCIFA0 recently, I believe r8a7990 still needs to use SCIF0 instead
> >     of SCIFA0, as that's what the bootloader has configured.
>=20
> Good point. Wolfram, any opinion about this ?

IMO we should only use SCIFA if it uses the same wires as SCIF. This
is the case for Lager (7790). Dunno about other boards.


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMjDDAAoJEBQN5MwUoCm24csQAIzMaVJ6nNGPcVAqaRXx4A+S
PYnk0zNOlltdL/K6qrLzg/8AMSCBP3MiGAJYE/1Petoewqpb4hFloEUkSpPX8YmQ
zQkl5BdK9TLDHN7+j6vcmLmu2n2Xe7EzFh1u+qKK9ppmY0KPlQZ1WdpkIm2Zhja5
jY3Rl0dTVZx3HKWLepnX8lnzPKk+jSE9c9e0P1Qdn5NyxLoY/AaS2yauEarwyz4X
WsTJoh830KJsynYDimfjqzvEOexUeskH44JAnhgLz04Onku30LFkapZ8ZoAXshhg
e3npVer3BwQRJTW/pQOb8wBqJiWTwkPmyjKcbB00cBQXYZdyzXv0Ele81xjXmbfj
67Rskcrf/4PIUB3hM3cguDdvU2JvrN5HHfCFSnf43vkWsxuYZ4or5JzxVA8BQ+Jf
Yq2QhK80jEuUVbv6eiZmRcYO4QHGTQrApqDWu5dVvucNyHMRd//T1Vkp2zmPdLNX
/UQMr2bnYcMkKW+rjlIG7/rDt2JbDYfoU1l6pqzJi/DOVlfmj4uHHba49/cH9KJ5
v9w6mtOsoTRSQJx+YAlrSEqDA+AEDv4Hyv0/y05RSw3q3i62jkV+JXkYliUAKaVo
G504JZ8TCcG6SkPCAYsjAyNIKe17fl4WgtcTQwrO10KR8jOcysaz4cTEC8Tb1Pj/
jODd1e9lfODcBJmtwdnY
=9bRg
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
