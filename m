From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 13 Jul 2014 13:43:57 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: lager: use iic cores instead of i2c
Message-Id: <20140713134357.GB2729@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qcHopEYAB45HaUaB"
List-Id: <linux-sh.vger.kernel.org>
References: <1404989456-2716-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404989456-2716-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I have queued this up for v3.17 rather than v3.16 as I do not believe
> there are any i2c (or iic) nodes present or scheduled for inclusion in
> this file in v3.16: I checked v3.16-rc4.

In case the i2c char driver is activated, the nodes in /dev will change
=66rom i2c-{0-3} to i2c-{4-7}, too. I'll let you decide about the
importance of it :)


--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTwo0dAAoJEBQN5MwUoCm2UaoQAJSFymII49EJfZxOnTeoA7Fu
bHweTHLFyk6AkYQMMcodZOM7QQbYTnNDBnn9e3tRNUxEAqkKiHavBjwGYhbLUqY8
7u/RKXTm6y8KQSlHTty/jpTXEoiLiJWCrqe0A9eypc/wbQEXJQVfdxjB0KtLKMAw
uTOOH176+G2QRljAsfaIr+pcoOIuskhtg5LnQxzYWBRTUOQqS/0k2Q0p2PlXEKuV
8q9r+n6bKAtX2BtHc9rIGjYkoFVJuwBOqYe/FYtP2fY4fxCAKkVUIB38T9j+lwzK
KHjaln2ldy+8DqR6D2zyv0to0VeI8L1gN9DaMH9XTV2Rrz0ICF4/vxGLmcnxvxGm
X6YElEPDgeYr3R2rSaKlrwqS7uR9rR5JChVUU6sDi8g/sWGjNEDC3W+GeRjfloIx
H99+I8b/F4m3ROCDtjPbDdd4HLGiJ+qZWBolhb79/+H+LGl2d836GtCDWv3hj5Nw
cz+LHAR28Qh+ucl+hhxcc48NyTKIO802X9vUoBjrWX14lNKF1OKooDuoA5BaGppZ
0H2ow9WgE6Do+XZjlMzn/Yyf+xoW/YEFKeguseL18n8+QzFUFaFqJl7ky5aNa08P
pe6lPWmUeYDHWpGfeNmreFNUBSAOvXrXACY+3OzR2zy75Qc6hPpFrxu5qmIJKj8g
NW0MUUs8OBBw1u1ikwOR
=KHgT
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
