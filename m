From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 09 May 2012 11:37:02 +0000
Subject: Re: [PATCH] ASoC: sh: fix migor.c compilation
Message-Id: <20120509113701.GK3955@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fUvfsPTz/SzOZDdw"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1205091255190.8599@axis700.grange>
 <20120509111701.GI3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205091334210.8599@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1205091334210.8599@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 01:35:37PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 9 May 2012, Mark Brown wrote:

> > On Wed, May 09, 2012 at 12:57:05PM +0200, Guennadi Liakhovetski wrote:
> > > Fix a recent compilation breakage, caused by a change in SH clock API.
> >=20
> > How recent - when and where was the API changed?

> Between 3.3 and 3.4-rc1:

> commit 84c36ffd7c580e1a63d7284e318670b082260118
>     sh: remove clk_ops

> commit e34828298ec542294f4b798606ee73e462d322f5
>     sh: introduce sh_clk_ops in parallel with clk_ops

> So, no need for stable.

But it is needed for Linus' tree...  Applied, thanks.

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqlbSAAoJEBus8iNuMP3d5foP/1pH7k55Tratx0TDU0B5Im3M
PuJAHAm7zHiFLIsiSOZQSFKqhJTrdbP+petAB4yaUHHRGVduX2wU4g1alWtn2UQk
n3U60O9d7uv0FiNPRqHEl6cz8PFmLOQvnlS3Bq6RkPeOxsr87WL4FmONuqMcAYEW
LepoEajpMNskADimSqoIL6cTiNItKOrVwrw91wueOfpgVilw2LjwHiH/dWT3vbMn
lX2eG43FR9mVsUcnazybY96E8SYdZ+XQUwrabulRxjxTOZNqv+8vrJ4c3ICS1wzl
5bvMxQ9dIle3A0IAAg+wLThE2ICaGbtfU29MDVS++ZUSvooefCpFfK55X4doDjgg
ijKQheKFUMeAeZB0zj1oxaQA/Hs+30mUJvlBBGzuL0yHdPhuueExRepojK4hmLPf
UqZ2PTpDwEfGMFFgbL3O07kVmYDsegZRqVwR0jLVHqjLF6Ikx1HH6maDMhcyhgcK
498JzndQQpHLCgj0L93biAF7zrd+3b7OAZLW4XMPFBDIkVtmXlme9tZfsNFS2emW
85ktRpzGOMZStLpdGWvYHW+WuFohTQeqQRhBFetu6LXXF+f6vg79MCdKQe9xGOUO
EMbRV4iS6EbTXzrynziytzvRT9xvd/LeQL42sjA1HeZvY5idHp8W71lkDlgafF0M
7A8RHzbvtiDRIfPn9Ghm
=lQTR
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--
