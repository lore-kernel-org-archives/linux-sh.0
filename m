From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Dec 2015 13:52:06 +0000
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Message-Id: <20151214135206.GA1520@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-sh.vger.kernel.org>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2157023.1Ftpc9ZciN@wuerfel> <20151213090959.GB1570@katana>
 <15285750.UWXWiNJ6YU@wuerfel>
In-Reply-To: <15285750.UWXWiNJ6YU@wuerfel>
To: linux-arm-kernel@lists.infradead.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What about not ifdeffing the inline function and keep the build error
> > whenever someone uses it without I2C_SLAVE being selected?
>=20
> The inline function is only added there for the case that I2C_SLAVE is
> disabled, so that would be pointless.
>=20
> However, what we could do is move the extern declaration outside of
> the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
> check should then ensure that it never actually gets called, and we
> get a link error if some driver gets it wrong.

Yes, that's what I meant: move the whole function (as it was before your
patch) out of the CONFIG_I2C_SLAVE block. We should get a compiler error
even, because for !I2C_SLAVE, the client struct will not have the
slave_cb member.


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbsmFAAoJEBQN5MwUoCm2xtEP/0mD6YVurNOdaUXVoRESooUA
joULgNhMZVrdTCybcH6DK6TJXa2LH3mLMfMK6VD1cvrVbTKPHzPjLTdJb+zPFy4h
tkClokXxU2RJM7w/IlNfdDUsOu/XXqdqLJeFHxW9ScueoGZw/AoUGJRaElRv+c3z
V34R4KpQRaXMj0VeYQvKoEG15VzDjm5TcEu9WBnwyRI3N3NQmI/BpM8XsCCvFByp
MWPLowj9/jQN2NJKsOiwU00tDcNpVOx9x5ky4NvAYcWUSNr5dy+eJuWVkVCq8O6/
DiL6b7UY0IDoB1qcdQdio1qOKZUmOGVssuWy4H4T3h1N2ZusdfGLnn54KrtY8ddJ
KHHCCLq5GxzL1oL0gp98eSeeptXukvXC/nJwhpDoPg/stNNNXLcVh8wvaZI+9yEj
y+yZXAxIeSrfZXi3KY7G430tdCAFbT1tp0/qo5p0IXfSfUID2q0W6ogedXybQijC
4IfoyoguAjkDTl0ia9XNYMfhniTyMZfx/Do2Ht7hBPOzLe52j992LSQaTWbaTNG6
BjQ5VG5bFLfN68oWrjLDqtXEM9kiha5tUmWIbV48XaNWbqKgWyq2fp0pI8TWBv2W
R6czsFmIwKjpQsLvzIS7N6YqcyFOUqRJHDv/YHzIPx2Tsy987GKyxKI5KBg+t7eb
wFlAU4KZZA6raisaEDES
=Dnkw
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
