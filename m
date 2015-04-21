From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 21 Apr 2015 18:47:01 +0000
Subject: Re: [RFC V2 4/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <20150421184701.GA9573@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
List-Id: <linux-sh.vger.kernel.org>
References: <1426576524-22315-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426576524-22315-5-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Thanks for your input!
>=20
> You're welcome. I'm afraid it has mostly been destructive input, I don't =
have=20
> any good solution to the problem for now :-(

Well, actually, I have another version based on OF_DYNAMIC mostly ready.
It is not capable of keeping the I2C clients between an IP core switch,
but it is MUCH closer to the driver model. Could be good enough for our
use-case. Tests so far have been promising, but I get an OOPS when the
platform_devices should get destroyed. This looks like an OF_DYNAMIC
problem to me and I haven't got feedback from Pantelis yet.


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNpslAAoJEBQN5MwUoCm2G7wQALUeneeS1ofy4oRij56iotb0
CcQuFmN1Fvqke2wg+RjE5z51D5A//u8UffMPxabDr3Q4YsHP8RqgZhU/yKpjJG3S
U4AlC7m/WAQr2HYwCwyrakrO8Ngj1HexRGSRgty0SUyHa4kNQA05Gu9h2E8O+6+1
uxjvuaNjiFB23lNGQB0CI2YtMFiXw4GK6c8qavLKbSO4Exzxy6dkCP2pv9sxn7ka
LcT757U3Rdw/MoHiqCcbZZzsiFyl1Yq7ddObsvlr6sKAzFKvut7gcRnDX/cSWuwU
pt/8SZSmLVqNdkC/pTw32l7/QBZr1fBBjRzd6eb0Fl3KxiluQTHJvsy9FMLBHbFq
V+WcIBlA5KcirKClDcThSUr2zHSyAqbuMcRrsCbK8X6+A9ihMbA56cgM9I+9mxB7
SPeDOH+1KN+wPNPQHZjbkkPHZCI48WfaT9G6L/0/hBrTK+kN1NAeTYq11Y1O8tBq
sm831gSdrZ58lFnDzO+6n923p2GyV1ikdNaYEx2SnW6tTaHQ3N0/X/tv9aQCpxwi
K1teqEJfsbUK/H40Wrwz7pUyHQoK2MPuu2e7wXePSkCl5tObEdMK0gdW/9hbcKw0
1YZYYMxpSYPoac5Sie9zIjSlbIusKmn3P6IanT66LEo+iSr0hdrBxJ0mO1x93ain
AOEsGLvXJaloJLniPnVv
=FfmV
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
