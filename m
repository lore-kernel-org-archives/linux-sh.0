From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 11 Nov 2015 08:26:06 +0000
Subject: Re: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <20151111082606.GA24344@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
List-Id: <linux-sh.vger.kernel.org>
References: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
 <87io5pgrcr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io5pgrcr.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morimoto-san,

> > +	pm_runtime_enable(dev);
> > +	pm_runtime_get_sync(dev);
> >  	rcar_i2c_init(priv);
> > +	pm_runtime_put(dev);
>=20
> Please correct me if I'm misunderstanding, but in my experience,
> above rcar_i2c_init() result can be removed if SoC has power-off feature,
> and if IP doesn't keep register value power-off case ?
> This case register doesn't keep myfunc_A's setting,
> because it calls pm_runtime_put()
>=20
>      pm_runtime_get_sync()
>      myfunc_A()
>      pm_runtime_put()
>      ...
>      pm_runtime_get_sync()
>      myfunc_B()
>      pm_runtime_put()
>=20
> It should be this ?
>=20
>      pm_runtime_get_sync()
>      myfunc_A()
>      myfunc_B()
>      pm_runtime_put()

This is for power-off case, right? Wouldn't it be clearer then to add a
resume function to pm_ops of the I2C driver which reinit the registers?
Doing it before every transfer might be simpler but is also a bit
implicit or subtle, I'd think.

And for completeness: The above is only for the power-off case. In
module-standby (MSTP bits), register values are always retained.
Correct?

Regards,

   Wolfram


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQvueAAoJEBQN5MwUoCm2nZ0P+QGMmRvsmQ2h2IM6rTpcuqfg
WMk8fNfSb4qjOcA/a9ma4SgR8u6wpR1Q4smxJ7u8o/Myn0XnghlEhc9/BG2lnuIi
3sEPlZEeBGpqzr8gTzX+N2h4rEWksJcy6ohFbSaxIHjGZS389rh0CcaNvHXnFtXN
sBS6aQIW40N7ehtBo8iAeOIXxbDYRgFKOQ0z4xXWJp+r62RMu3Jr+JeFSOR4C+Kj
d1lMGUm6pooCZG4H8W1I2/7bumROsUhnE7WzAwxR61vPcXH8pFfo3bZOF/7ewkmF
KfHfI8rdblwynG9dQCa/RXVCWyjpjztm3tu7IcZi8/rC3m3k5XrrN8bIDnugHaPt
MQQIa1u5I9I5OXToi7d3yxrIoMLnGBR7fk+xGAnOUXJYHjGvZqMw1MTEAqGrDPHm
xZ/CdoRi9a/TlKkb8YVoZ4BKGmuV48mRxYcAN5YfWWBqlnLTDay9wP6S11RGXLYE
8qAbrNpAIdeZc3/gb/KWsj4FukDeW3u9ypUETA6xyh0y2Y1OggwxTG/RIhYku1aY
KRrWmFwUH4geaDdlxdWm6j5vMTnKuGu3LsCnahtve4RkptoV2eLC1m+1y+gDK9i9
u+hI9YZqe2JsfPMJTQvw/H8LXD0Z+f5XLXukxXvgV97Dl51ra62Q7t00y0R1vntM
SO1wj7sFkVpTFV+WJQJ/
=uFlq
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
