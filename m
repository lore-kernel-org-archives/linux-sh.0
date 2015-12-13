From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 13 Dec 2015 09:09:59 +0000
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Message-Id: <20151213090959.GB1570@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oLBj+sq0vYjzfsbl"
List-Id: <linux-sh.vger.kernel.org>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel> <20151212162057.GA1530@katana>
 <2157023.1Ftpc9ZciN@wuerfel>
In-Reply-To: <2157023.1Ftpc9ZciN@wuerfel>
To: linux-arm-kernel@lists.infradead.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > The slave_cb callback function is supposed to set the 'value'
> > > here,
> >=20
> > Only if a master wants to READ from us.
>=20
> Right, and can this never fail?

Exactly. The slave can stretch the clock if the value to be sent to the
master needs some processing first, but it must deliver something.

> With my current code to turn i2c_slave_event() into an empty inline funct=
ion
> in case of !CONFIG_I2C_SLAVE, the compiler knows that "value" is uninitia=
lized
> at the point where we write it to the register, and warns about it.

I overlooked that your first patch changed this code, sorry. Now I see
the problem.

What about not ifdeffing the inline function and keep the build error
whenever someone uses it without I2C_SLAVE being selected?

Thanks,

   Wolfram


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbTXnAAoJEBQN5MwUoCm2JSUP/3zxkZo5+Uljav7NSKhh2YK1
kg6F0qAVA/fgCKZBZX7tabgTypQns8F4Wyvy+5xhZmw442q220jTAhPuo4N4Jxtn
qHuaYOzF8xrpet23SmXoRuxB9LKTVuqh5KQkz2dvr/Y8O4+KQWKKN1eXflqEelCk
lIaCjTUnTLgQshCC05dCIAnTbLXp8akH12xAx0m+4EbKb+t4a6R+A+TGBKq2QgNx
I5+/I4jtF8shIlvCmLOpObcYAnT9kuubSmUbEjj26JoiIfpwsngMm6/BBkxgGENB
DAMAlUoUWHC/t9ajg4G+Fp8ZIp1e+BmMsB3S97VwtQf8TAugopXXS87V6pjo9jxU
vBwo/CGFpMyPRK0GJNOZIo9gnPiLzSTCEgbjj8zmqNA1wJxcRRBeHouJ2CCkSjKS
MwfNboXFIDm0YYN9M87ajx7fo58e0w1ZuD+0fTnNjDLGY5654sJIr3y7IhwyuYex
Xnoxl5bI5aUunAb92PRIz3msEYEU6p4XbgYZ5m2xeJ8sd5sAVbC6gBm8GNGXEbdF
zk6xL9Rq5bOKrJnSSaER96xslUqFjKd2qlfFLRs0cTxk1AmWWIQg69B8UALm+TOk
lKU2VFXHco0INbTXvPSf3yCZcOLovpNiVq5nnzJ5EZQaRhC9Hjx0fTyZGgy3uDhD
bwGNqwA3LQZu15CNoHXL
=Nep7
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
