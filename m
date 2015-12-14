From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Dec 2015 10:00:26 +0000
Subject: Re: [PATCH v2 0/9] i2c: add generic support for timing parameters in DT
Message-Id: <20151214100026.GD1733@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="F8dlzb82+Fcn6AgP"
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2015 at 10:37:44AM +0100, Wolfram Sang wrote:
> Here is a patch series adding better DT support for timing parameters lik=
e the
> raise time or the fall time which are generic for the I2C subsystem. Ther=
e is a
> core function for parsing and an implementation for the RCar driver how t=
o use
> it.
>=20
> I added people of the designware and rk3x driver to CC because they might=
 be
> interested in this new function. They provided the basis for this series,=
 so it
> should be easy to convert them.
>=20
> Please have a look, test, comment...
>=20
> Thanks,
>=20
>     Wolfram

Applied patches 1-5 to for-next with the change Andy suggested, thanks!

Simon, you can pick up patches 6-9 now, I'd think.


--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbpM6AAoJEBQN5MwUoCm2ZZcP/j3t0aqhOPgG3wmatXvYxWVT
PvlxqaDh4/tOZgEe52YVCwDo2G5tkU/fg9Or6oC/xUC0dEsN9hmgJ5FCuqoY4i+W
vfAvFrtmgKXu6w3xKgkmsDsvdCJlBzBDN6jezAKUSxUoWOEUehu3lxeHqriV4t8u
I2iZLIDvBAF9FXXVy7MZK/jnoW+VOUsY0kHmwaQEzXxK+gmoEXXnRfSFO7rk6j6I
5knWpbwTOgInmLfJ0QnWPYsHiAMOsO/YvP6QcqjwFDEbBt+GGkb0jqfT8ouUKjCE
6u6hudd5fID52+egC8w0gZArCVKu9iDsD9hBmtu990tG5CNniWCtDMgu4D6PEzU6
MHdcP6Sydi2df4otWEnExYO6kxZ8XBoCZKr6wLntRYR842UrLRl04gx/iFjTAEtD
zyWTkP55yLLlTixCOW4+ohq5cuY87pUkTiBDIy8nCjfxIAqtOuZWpbItPITtXgLC
sqVOKCVel5fwl39eYlGecWKOPDglCbo8JsEkGLArA8cFW2DAZHF+GF6yycgx09nM
mYULS+1raIgjF3JrEJtUNr2wc3sSLvjkLaNJQIL+DMsPSpMGgW76MumU/2M9JDCf
XHEFIFqTV43WGS/n4RORObfmVxDE2J2B+vkw2b3crLTDt69b6LPLc8rATGa+O7LJ
+so8/w2OqkRFElCd6bgb
=sGc7
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
