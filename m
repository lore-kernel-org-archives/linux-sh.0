From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 11 Mar 2014 16:40:43 +0000
Subject: Re: rcar-i2c: always reads a byte
Message-Id: <20140311164043.GA1179@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
List-Id: <linux-sh.vger.kernel.org>
References: <531F3686.7050808@codethink.co.uk>
In-Reply-To: <531F3686.7050808@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 04:15:02PM +0000, Ben Dooks wrote:
> I have noticed the following behaviour with the i2c-rcar driver
> with the following single i2c_msg structure:
>=20
> 	msg[0].addr =3D 0x12;
> 	msg[0].flags =3D I2C_M_RD;
> 	msg[0].len =3D 0;
> 	msg[0].buf =3D data;
>=20
> The system issues an address transaction followed by a single byte
> read.

This fits to my observation that the rcar driver cannot do SMBUS_QUICK
(e.g. via i2cdetect). I assumed that handling a length of 0 is broken. I
haven't had a deeper look yet, so I can't say much. So, you either go
for it yourself, or you wait until I posted my IIC enablement series for
Lager. Then, you can switch to the IIC core with the sh_mobile driver.
That one does SMBUS_QUICK correctly.

Regards,

   Wolfram


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHzyLAAoJEBQN5MwUoCm2pf8QAIFpqMqaEs9X5YwDs5PbtAr2
UJLVH4DurjiF25P4r+mYnL9WYjCkNImB/SWPxShT8+Fw/pGqZhYYOXwN24/ZF8Md
ELy+6gqAJ+qVYUuHHzGURygNOE3W2a1F8GzSLZSdOGqwgq42Ltt2YYc09q5oW13P
t88GSGJGs/qrOTyV6LbBwzIcWZ89N2r13sJ88IfoTqPLjYjKeL6VYlgZayQ3ohs1
di0+8M5Y3Mc5wmldhtndHAeF+tcavZQilbTM1Hi/HR5yO3eBo6GRbSLrggmK9k8o
5yU7vExLE2QmVOev6x1G84DawH7FZm9zVGb1d7lxjrtMLY6dBrl8JD8HTso/LaUK
uODqRpIRmYRKXCWBqpPKv49LiHCZPVTiZRta3SOGXU5akbHWjJdF/9Xebu9xZuL8
+apY1HW4zQ81h2qmMpTI8UnecyqbSM2geMgjvQjFVzky3Xhn9v5rf6Cdv7hxma3V
CEfM29Fx1bF7pPnzzBSyh9alkpeww2zvyN4Cjrvk7FBQ53Bmjri+YM1qmhH7jmNG
7FR/lMhTQRNrdm0D5C5U0czvpAH3LhJSADCvM1Tz4mpqT6/nVG9E52R8G57JCiLI
PD7O6xaCiEMW/nbIOXIbIh4hSHzzm5+tKc9D/GvzWGWwwGB1aTJTpQ1pXpoulUx+
Pf3IMd9wUo6lgl3SDGdI
=a1kx
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
