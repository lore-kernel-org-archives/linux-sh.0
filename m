From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Feb 2015 18:03:43 +0000
Subject: Re: [alsa-devel] Can we remove un-used Sound driver ?
Message-Id: <20150205180343.GB21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dwEMFekL2ACHCuYf"
List-Id: <linux-sh.vger.kernel.org>
References: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
 <87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>


--dwEMFekL2ACHCuYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2015 at 07:10:49AM +0000, Kuninori Morimoto wrote:

> These patches remove Renesas SuperH base un-used sound drivers.
> Maybe, these had been used from out-of-tree (?). But ...
>  - these are for very old SoC / platform
>  - these are not used/enabled from upstreamed platform
>  - maintenance cost is not zero
>  - we can't test/check these drivers since we don't have these board.
>=20
> I'm very sad, but...
> Good bye migor
> Good bye sh7760
> Good bye ssi
> Good bye siu
> Good bye hac

Hrm.  At least migor was active relatively recently, Guennadi was
working on it in 2012 which isn't *that* long ago and there may well be
systems still in the field.  There's also still board code for migor in
arch/sh so it's an upstream platform.  Some of the others like SSI and
HAC are definitely not showing any signs of anyone being interested
though and I'd not be surprised if they'd been broken at some point.

Manuel, Guennadi - what do you think about this?

--dwEMFekL2ACHCuYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07B+AAoJECTWi3JdVIfQ6hIH/0xWWDiwgfEbJkE2MGceSmID
ItCz0xLkx9sgX6ZVlpAArm8DApoD8Io1BDVONwN+o4keGrw593G/zEs7L0+Cdjnh
2rNaM+mAVp5k69Y9lTSsL1RKVPspDfa/CVoEAh8J03Lfqgz6a2cFIMWfRkIercl4
mwsrEkxaBiZ4JUG1fYitpSUnUmL0BvDv+NQXF4PfXmKGu9+c77rhC9eO9sT1V0nb
Mex1cUNRE0EDPRbFuR3ftTtc9DmzPdq3/2eWVMxTu2n6wdo+AdZpUHlIPLGLNSE9
6Ch2sDuDtMDh3Gyr+XhV/hJB6qLNa1Y1NiHfZKG6kIP0mmrvJXTRrPhC5bfsw2M=
=gG8t
-----END PGP SIGNATURE-----

--dwEMFekL2ACHCuYf--
