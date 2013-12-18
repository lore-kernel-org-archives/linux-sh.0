From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 18 Dec 2013 11:43:51 +0000
Subject: Re: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
Message-Id: <20131218114351.GD3314@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="X3gaHHMYHkYqP6yf"
List-Id: <linux-sh.vger.kernel.org>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
 <52B1892B.1020806@cogentembedded.com>
In-Reply-To: <52B1892B.1020806@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >@@ -173,6 +179,10 @@ static struct clk_lookup lookups[] =3D {
> >  	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
> >
> >  	/* ICK */
> >+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
> >+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
> >+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
> >+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>=20
>    These belong to some other place, the group marked by /* ICK */
> is only for CLKDEV_ICK_ID().

So, I'll create a /* DEV */ prefix?


--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsYp3AAoJEBQN5MwUoCm2HgcQAIP+HmSC++wJZEzIIgswyERG
e9IhI3B1oo22km/V9wYlD0iWJYXbjJigYYRF3oVPjKlR0cM7OSFPdLxL1vinqzxi
n+V1qNRE7NtE9mfQcqtYExdnm3BeNVOjIv2RjovQaEIz8t07C1E8JV1hPKj+qOtQ
cSDAIaLNYObkw9x9njCKktid2ZmyS5JJqo/nWLowk7HCRGOri24CzNOT8SDsEN2K
DgQnoFADpydtu1YXUA/wPrrSFm/byV/K+hkL8fCU3f8S6cge/7yulAbxKN9XYu7f
mqTLymxcnrf69pi3c5n/9z5OrNfXC7yQp0b6k2NK8xjaVVMRR399tguaX7yInbJC
5R6vi4PWuuLEvPFWLtLfudpbGucwOTm87cCacGq18VJid36zE2JnuLWuWeHLDzkN
FFlTK/MOaWCUPcZF8g0f0ZV641R+LQox+yvdvdDbKUUoy1sVnK8cP6ICsfwEkdsa
EQBe9fxQm9EM3C4v+G4/egIryll9z4UuYKVqdlmO8qhLdxJ87FgoTJ1ts6WIk1qm
OkWsVjKcypEX3WBY6CXoaTJdRhk6UdbS/rTsWnvpw0dwvV5gn3zhgFMsdNk8gXXm
anDZ8bUccnb0aHFfyI4RFUd3aJ17PuyI/FKp6Vb51UElp1Mvr2oE9cyTM5mSFloP
VjGnX/QkSF595w3i1fDt
=DurW
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
