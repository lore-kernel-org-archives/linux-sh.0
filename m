From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Sep 2015 20:55:59 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <20150903205558.GC1574@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z4+8/lEcDcG5Ke9S"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <5464456.UnsMOS3MTx@avalon>
 <20150903204000.GB1574@katana>
 <3091262.bFRErFxuqq@avalon>
In-Reply-To: <3091262.bFRErFxuqq@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I meant without polling. Does the hardware design prevent from using I2C =
in=20
> interrupt mode in a race-free way ?

Yes, when we get a NACK after address phase. HW automatically creates a
STOP condition after a NACK. After this STOP, if we haven't been fast
enough to clear the ESG bit (which started the address phase), then it
will be still set and a new message will be created.


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6LPeAAoJEBQN5MwUoCm24UsQAJgU+ndroceeATa330jpzAvB
dQl1LIh8uZWZNi+IlrTXcHFvpZxssqvoGrqLnX0vNuQ3aYfTejoNRGDAv2jEzqKx
yg8rYFx+hK91VxV1XutlTlDOXKpxdIytC83d0tCA9yUsDXVRMeyEUmGaBuW+aIDb
bc57PS331iMyfbZoFGXC9nqp5Im+o2oqyT87TNjoFRXlQ7ZPlMI1MQIkLeh8cj06
mlLDZrYUm+YRVkAkaFw4Dzy6vzxO26AxXQGRbhgoe/GX/bEOIwr50UyhvD3G61JI
OQdX/nmx+AYsMmLMSh/iceqi07TBV6eaX5mygbAVWTOQlsFKyK1DTMJJhI0U11nr
/ww6M6s8Hvs2Q8t27Q2j9EAyn+KxntQ0TKkajwRLH9qJ/LNCAtzPpYD8hQGMI+rF
WpvuqtYsdTQPVogKz7ToiWaEVfjBoPX2GpEYP2Cq3DcDVDNqpxvAXCVzsxEaxk08
SLENB1kqxKiFnnMMT/zMPIriLVk0SqgnpzWsiFtkoUMsGIfGZYuSa3uXqLwLASKO
QGVzQMJ5o94WXvzUrECaYfRsnq0XuVt0wB5eBG5N8Bcsp4XXrytg6oUABTe64IPy
RRb4m/iPPYyB/NXSAkJnxLKqYxj0jIT1ASHPK/8GJNXuaHoWkFvnBSpNbU/ou87g
75dj78JKUiEtuS+p3VP5
=PtyH
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
