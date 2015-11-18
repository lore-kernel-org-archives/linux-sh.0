From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 18 Nov 2015 08:07:36 +0000
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Message-Id: <20151118080736.GA1528@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <1447338715-9955-6-git-send-email-wsa@the-dreams.de>
 <2420286.JI0i0lloO0@avalon>
 <20151117070053.GA952@tetsubishi>
 <CANqRtoS0tFtjNcB=gP5xKNzMW2_41rxAydOcZM1+fOSjfCaM7w@mail.gmail.com>
In-Reply-To: <CANqRtoS0tFtjNcB=gP5xKNzMW2_41rxAydOcZM1+fOSjfCaM7w@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> On Lager it seems that the GP5_5/GP_6 pins with the I2C2 bus for the
> ADV7511 chip has more flexible configuration, so using either IIC or
> I2C should be possible. You can sample those pins on EXIO_A with the
> ZEBAX break out adapter.

Yes, that's what I basically did here for developing the whole patch
series and for the recent testing. A simple 's/iic2/i2c2/g' on the Lager
DTS does the trick.


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTDHIAAoJEBQN5MwUoCm2zs8P/iCy437lwf9/JoQDBvWsNmiL
Cx7/RWC6XG504FVzrhGdgzDsmLhDXKZsi2+Tntnjja9Zhl6AlGEDjVpyiAU8xbNi
2nglKMtiOEkrJtbGhXyJksH05A62zVrb4VBXfBA0KHtQvfPULJxqm/UMraq/2N0P
yaLC184IeS/Ti0ewP6nuM4fqCIQRJupQKmnbnrJ3NnY4TUxG3Vyceaon+VyTk8O7
GnxNK683UHpYUahsaNPtRylVw9WsxJV2EXvJd83OlGx/meHRbaSSRxrbbgFoFDmg
lOzVxuHpk01bvS2n8gbRhUUxjVXBDFN8W7HonQC0XkWVazXl2Xd0FCFroBB59U1i
IN6y+7aTVzFi79V6HYcZC+NoA0fNJvVSaUmQe5SYeMZbJEalIUAY1RvFbGfQYJIg
annsY5n7IYeUvMTcCaY5BVx83A1gFtSvtldB2QYq3UTsZrwO2DDxOd9Auof6X2FQ
jMkuG3EkhIeFQeK692R1Rd4lAj6Q5NP2hE04t5qf5QMYJ8yKtgzEExVOvS56wPPm
WiN2PSfySJfdrLyhGpvLd8FVw+aiVCtNZiMIHUZ8CBmAG/UtBqM59z0sED+uenTc
yAAn4+z65VKr+P4sI7uOyGLu9FNWT1Gxr5YfikGKRngB28XznDFuVSxAOgBUs1Dn
UVDt3xCebqZsPyDG0pz1
=ISsI
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
