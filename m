From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 02 Dec 2015 10:02:38 +0000
Subject: Re: [PATCH] i2c: emev2: add slave support
Message-Id: <20151202100238.GE1555@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KuLpqunXa7jZSBt+"
List-Id: <linux-sh.vger.kernel.org>
References: <1448842558-18654-1-git-send-email-niklas.soderlund@ragnatech.se>
In-Reply-To: <1448842558-18654-1-git-send-email-niklas.soderlund@ragnatech.se>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-i2c@vger.kernel.org, ian.molton@codethink.co.uk, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, linux-sh@vger.kernel.org


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 01:15:57AM +0100, Niklas S=C3=B6derlund wrote:
> Add i2c slave support to EMEV2.
>=20
> Tested using a EMEV2, BeagleBone Black and a 24c02 eeprom. While the
> EMEV2 provided a emulated eeprom on iic0 using slave-24c02 iic0 the Bone
> could talk to both the physical and the emulated eeprom. The EMEV2 could
> talk to the physical eeprom while still provide the emulated eeprom.

Yay, good testing here.

Which board did you use? KZM9D? Do you have pin descriptions for the
connectors, if so? I am looking for these for quite some time.

Thanks,

   Wolfram


--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXsG+AAoJEBQN5MwUoCm2Mn0P/jScuSHBbUvYv56zuyIgutJu
/obWSCGRW+spywrQv7ErQsDnYj0Dbp0EV2YOARIJBzDmZbEhM/xw1hCScGhNOWzm
TVnvm3jxITwhgm5x4Q7BAMNWeC5A/hN3dDPo+kcr6D9CrNXzQ4ldq/TVneJt8i8n
HeAbeim5ceNl0YpNwnKONIplo1/98HzYJwEUuphZPKmKKQX3BT2OltKAv0idYncL
Bjm4hYf+XPJb3j+yPlYAox3wt2vT4expC3G5i0SKht8mh8v4wDQ2iXFZ7bMU+Ge7
PNdCq4XfeUNWKLabgPxpG4EByYb7XlLwgLmaRYpesWoexa+JlFLeDaRyOvRoLWd5
ijF51IeBIDS6uyIssfVHy4OXk0Dxlu3+gmzlZOUK9TqJOFnI27VIlya2q5AAfrS3
nEf1P2V+rZ5WbmM+v/xuwtBRGfmxlivVmTEKSrhg5MY2MiH0r49Di2OAUv/Jx5KD
dqAwcdpihkD7sfdB0EWGpF/RDk6mWHoXSKg1oQRrrj5PUJd+ApqA3eIeCxuwNreR
4RFyY/qfozs+0swFWW3jZ+mP10nlknt3qT5e7RWIiyNqZO8Sg0TbZifYCXrc6703
5mADdg5vYnKTiiGel434MH0U9e0nJWaaaSYrqlXGIO0dWhTJuAqv4NAN9MkRzPwp
U4NmdjhEW8Z/hR6bBEnv
=FfcG
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
