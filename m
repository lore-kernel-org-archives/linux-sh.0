From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 30 Apr 2014 08:05:16 +0000
Subject: Re: [PATCH] ARM: shmobile: dts: Move interrupt-parent property to root node
Message-Id: <20140430080516.GA4378@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
List-Id: <linux-sh.vger.kernel.org>
References: <1398818488-6591-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398818488-6591-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 02:41:28AM +0200, Laurent Pinchart wrote:
> There's no need to duplicate the interrupt-parent property in all DT
> nodes as the kernel automatically walks parent nodes to find the
> property. Specify it once in the root node only.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTYK68AAoJEBQN5MwUoCm24s4QAIuSU9TaxY/DsSZ7swFI2BQI
5oLo7QIKH8/4I4TncO+V06hFXAOaIhv4bo1nkTLnih5Sc+L8E28P1KNgRVq89drf
yjGR4uixzyVUJw0rbvgo8Ly3je6JHN7wJM8qcKv9ixdcf+utii9cenbd2hFCz6zD
t5tmMQtSpjZBuNVdEgXiyMUjlIN2DvDO6+/wjO0QambTDFd51c2biGREwQKejeh1
+YfkxD/dMOsoZ20/q/R2bpYPSv6soVmaWz+jDz6qhrbzw2qTIEvNudzM3/ZH7FWX
s2momAuRg3e7dMyxWA1a59k+3yozJE6J6kyUVU0MFQCmVki5+JNffsp95hsGQAAy
vkoAR3F5nByh8afKESewbonHp3i5g4nLvK497QWBcgygLdJ0GlXedAtenX3nDgiJ
V3ijQR+rksNryCzXMRxRWiIYvAxrxI0rDL6zpltABgzuIPYp0wZHQxAPd8mocwIt
HmAyRC9FuAAqglbFDJPg3ex9bV6bKpK/y9My5HkN8NR2D0yuLiCDrSf3CrReL16s
ja27ZdeUci/m0o+4jfHIv2xGaw+NtGPTse3ZEhXLowvt+N7cIFpwEI0jRsAUTVCB
T8D4LvIeh7MTfdgHDsvnJKb43znVeQkKFk4XZcIlCj0U+mv+AgWh5SdP/qfqDy+g
bm1/vw/GfxHYYDS1RBSw
=sMu1
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
