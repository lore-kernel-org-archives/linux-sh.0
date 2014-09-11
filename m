From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 11 Sep 2014 14:12:58 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <20140911141257.GC5149@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1ccMZA6j1vT5UqiK"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1410274470-12712-5-git-send-email-wsa@the-dreams.de>
 <16809905.2REViph6WO@fb07-iapwap2>
In-Reply-To: <16809905.2REViph6WO@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2014 at 02:17:16PM +0200, Marc Dietrich wrote:
> cc'ing: devicetree

Thanks, I forgot that!

> > -&iic1	{
> > +&i2c1	{
> >  	status =3D "ok";
> > -	pinctrl-0 =3D <&iic1_pins>;
> > +	pinctrl-0 =3D <&i2c1_pins>;
> >  	pinctrl-names =3D "default";
> > +
> > +	eeprom@64 {
> > +		compatible =3D "slave-24c02";
>=20
> a "real" compatible value should have vendor,device syntax.

I know. This is maybe a grey line between "configuration" and "hardware
description". If we want an I2C slave, we need to things:

a) HW support in the I2C master driver
b) SW support by giving the slave callback some functionality (like my
   eeprom simulator)

a) should be compiled in with the master driver and does not need any DT
binding, so this is easy.

b) could be seen as a configuration thing since the functionality
backend could be changed at runtime even. Think of being a usb-gadget
here. However, since I2C is multi-master and not hot-pluggable, some
other master might be depending on what I2C slave is actually used.
So, it could be seen as hardware description, too? Not entirely sure.
The drawback you also noticed is that there is no vendor for these
functionalities. Maybe "wsa" since I did the functionality driver :)

To be honest, the above DT snipplet was done to get easily started. If
DT maintainers think this is more configuration, not much is lost. The
only difference is that the userspace instantiation method should be
used then:

# echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-0/new_device

>=20
> > +		reg =3D <0x64>;
>=20
> we had some discussions in the past how to represent i2c master devices i=
n=20
> device tree. The outcome was to use to a special representation to distin=
guish=20
> them from slave devices, e.g. something like reg =3D <0x1 0x64>, where th=
e 0x1=20
> would mean "master" device (0x0 -> slave). If nothing is added, then it's=
 also=20
> slave. The adapter address cell would also need to be changed if this=20
> extension is used.

Please don't change the reg-layout which is around since forever.
It will break all existing devicetrees. NAK.

> An alternative would be to use a special property (e.g. slave address), b=
ut=20
> that would encode the same value twice (or even three times).

As said, if all breaks we handle it at runtime.

Thanks,

   Wolfram


--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEa3pAAoJEBQN5MwUoCm2qwoQAJ+o11//qRzqLox+NtJLC6Mw
sXvgtyEq8CUw9FRf2akdPvxXhiY8gxHPpbL07Ek/u/CHbf+5VeQ2cKGkHmXX4xaN
eYUDIIaQRfiEBJmyyZZGKsfFVkYHU2dCjo8XMyIVLyP/fdRTDkZ/O34N9OmGwWO0
32edSAVWFGUOMD3PsxOpeZRax8RqRiE4lIos1ipxHzeA3eZrhuXJKARZMFBjHRnh
/pMfLFk91cIPSowHc5Os7hFYahpOb9vHS6bO0WjwAyi6sHZfMsDZGGfBdHvPV4pw
OXa2pjXKaiV9nvt8HbO0gCa44jTsD/kHl/KBV6T26pi8snQc6wvxfGhn/HyiGVUX
qpW9ZP6CKTJK29Cxc2dkTXyotniOdSIJaO5w7wSnqsFgMrg/q8fzyH3u5gYUMC5O
Ab5ahgghTJxYOgKP6h9VZbh6q7Fr4bh80A4TQCytSpYcpZrxT5Q1kZFW8ILN3IHD
DyNgwqBvvyXndpENUcNDdNh/a8YaZRcqFWKHORy3Jr+sX3ypUyVlwlB0D3kALJwm
x142V2B/Kk4f5hYB4GsZ++FWKbdajkrTYsQR1ZcuuKyr12s+WRzBCgLxq0peW/oB
NEwUV0dusPUzdGfsEELnj4KYGrapYCMNmH1GgiCb/+pc2K1p5sE+aFwjnHwpGYet
srJ3BZ94mCByFk2ZTRWO
=Fzhd
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
