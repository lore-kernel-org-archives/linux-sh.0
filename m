From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 30 Nov 2015 13:27:21 +0000
Subject: Re: [PATCH v3 00/11] i2c: rcar: tackle race conditions in the driver
Message-Id: <20151130132721.GA1513@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2015 at 04:56:40PM +0100, Wolfram Sang wrote:
> Hello RCar Fans!
>=20
> So, here is V3 of this series. After a debugging session with Laurent, we
> finally fixed his issue for good. It was not board dependent as we though=
t, but
> toolchain dependent! Hidden by a macro, the driver used a compound assign=
emt
> with a function call as the rvalue. After patch 6, this function also cha=
nged the
> flags which were to be changed by the compound assignment. Basically (aft=
er macro):
>=20
> 	priv->flags |=3D i_change_priv_flags(priv);
>=20
> Which is undefined behaviour, I guess. However, after my refactoring, the
> called functions always returned 0, so we can simply do:
>=20
> 	i_change_priv_flags(priv);
>=20
> Nasty one, but finally issue gone, for all toolchains and optimization se=
ttings.
> Furthermore, patch 11 has been added because HW engineers wanted it.
>=20
> The branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rcar-=
i2c-rework-v3
>=20
> Please test, test, test :)
>=20
>    Wolfram

Applied to for-next, thanks!


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXE65AAoJEBQN5MwUoCm2jBEP/R1XjnMHlhQTgtMDrW7MDdeX
cel8qmh6kiwIWIweLKWi3r2SgY94fFEQ7R6XGxzQGcs9m+kemQhPdlmqc9pB08JQ
+7VIn81ypDD9HOgx8iLsjsSxK3dxer/vLDkmBuYKIkCFWDTK6+09wwpvCMA9gPCD
pnQvnXFxPc9tzXTd5SlF+/5HRkjpMv3QZCViSGqlYGIP571CErSoT8BgbPqM/DL0
x/33SvNMmK+g/3APi79aFAO0Aht5X1I24rYhWCGHkLPUvYSRxlr66V335LgbRstE
daUJVLw1ZePAmBBCiuvqJEZ2vaSxcasCa5ky6nQKOjYRjF/XPDlK2IYo4tuRHsrp
vDKKArNQHX4cksxPwcDeJw38YY4JhgQeuN+8X7MQLHaFxC3uHcNHhALyl12vIbtG
4tDSqp2HoB4ktMi+3zTrUmflm+oaC9YCqnA8NNi1mRmx1g71ygHMgak9qunKuZBu
kU68mUQpJTZ9xhdniSJ2YsQBWl1/gDzM7vp3du5PctjVX77SSopm5s6Q+YTSIGIz
OBH0LTRUbZieZpi9yH2URduxwshF0NPpqPfI5TkSTvYvCl128MVYN6BxCR/vA5xh
ImdUWLl5LxY2KaV+xEdo7YoGLJ1y2aF7Q3UHhxqVQgdPnUgczpbMcX+E0p6OcNQ+
zmKO4/YLGSJwV9Ebuwsi
=TiV7
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
