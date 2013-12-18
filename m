From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 18 Dec 2013 12:15:42 +0000
Subject: Re: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
Message-Id: <20131218121541.GE3314@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aPdhxNJGSeOG9wFI"
List-Id: <linux-sh.vger.kernel.org>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
 <52B1892B.1020806@cogentembedded.com>
 <20131218114351.GD3314@katana>
 <52B18CC9.8090200@cogentembedded.com>
In-Reply-To: <52B18CC9.8090200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Dec 18, 2013 at 03:53:45PM +0400, Sergei Shtylyov wrote:
> On 18-12-2013 15:43, Wolfram Sang wrote:
>=20
> >>>@@ -173,6 +179,10 @@ static struct clk_lookup lookups[] =3D {
> >>>  	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
>=20
> >>>  	/* ICK */
> >>>+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
> >>>+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
> >>>+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
> >>>+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>=20
> >>    These belong to some other place, the group marked by /* ICK */
> >>is only for CLKDEV_ICK_ID().
>=20
> >So, I'll create a /* DEV */ prefix?
>=20
>    I really don't know. Other places have /* MSTP */ comment in this
> case despite all clocks, CLKDEV_DEV_ID() and CLKDEV_ICK_ID() are
> really MSTP clocks. I considered the idea of separating
> CLKDEV_ICK_ID() under /* ICK */ comment silly from the very start
> but Simon didn't listen to me.

I am puzzled, too. ICK is a type of registration and not a clock domain.
Also, there is 'mtu2_fck' which is under ICK as well as MSTP? Looks
wrong. From what I understand now, removing the /* ICK */ comment would
be easiest and proper?


--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsZHtAAoJEBQN5MwUoCm293wP/0EtqobQ1Mfvxeh1ywSj1J0K
ZC5alewm8KxakzToHYybNJdD8DcsceAcASB6Ze3azEp9MvOgaWXnFBuDHvmINnCj
ZYst3iLeRXlwPvCfuwkAsknykO8uXa/ULOD6PprD+I/7vAEKhPas4M7cz0xu3NLK
iVguL4sWhn6hfxKoWMJZypijYnVq7Kg/VQlHzCMpGufp6PxRcqsUWOdYNoOQqBlp
yE7bAbiNu0Wsq6yTmc4nSYi5kurA/lkHNZPmn0NlhOin4BrnOYESb3V4fydjDSUB
nR0twwnYIe2kQx00oJzCHLXeFehV7YJszw9+bmisvO4w1znWyle1juTbODR4U0EU
A5KyyEdisrk5dheks74lCBITQ/PtchHbyvva8lIGM80RwuPbXmE/iXvia4N6LiCq
jvGNACp2iePV0Rf/+jWM1Uci82OhGtRe+DLKi57AWdCiA8pPW/mureeL5EtIofXu
Am1lRwvvVeZU3YmLmCc+fm7t0NditVNFt1iKdDwmgAnN1lRok+Y2vwknFO3Ylrwv
LuFDCmdTyFtec4xj8HsizWLiTVbNg7ChzrfA1Vmnfibo6EvzhzR+nkglK7f0w04Q
U5Sku6KaWtuwcskjpve6JnBkHYEIzITxWVFnXGYVsimtGtEPmQKJcCkNlAtuLoiZ
Ka9MIKwq1Zs4purJmpqp
=IM8q
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
