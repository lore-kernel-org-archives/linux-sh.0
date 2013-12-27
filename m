From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 27 Dec 2013 04:27:47 +0000
Subject: Re: [PATCH V2 3/5] arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
Message-Id: <20131227042747.GB6161@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1387402321-21866-4-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 10:31:59PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> I decided to put the pinmuxing into the dtsi file since there is only
> one pinmux posiibility which one probably wants to have when using the
> bus.
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Magnus Damm <damm@opensource.se>

Simon, I think you could pull in these patches, too. My series does not
really depend on the pinctrl stuff. I2C pins are function group 1 and
thus activated by default if the bootloader doesn't do weird things.
Actually, I coded the PFC stuff after the driver was finished :)


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSvQHDAAoJEBQN5MwUoCm2YyUP/3HIgyhvn0UXF+KD5lxmkGPQ
g8Jkn/xeEMLGXPJfEr9z3IZpyUGHzcYbYWnUypW3MpTaWyJnWYESTbH4ueenaeWt
WrT/SkBMtUWeDoMsgQmIOTL3J224lNVV9d1nCLYH4+20S1Qvn3+5Wmg+eN50n8vY
sUSsBnT1jbxwBetsnopKNhQiNv18OAlpfGS+Of+ZzMetfAn6AjNGk1xYj+X/tP31
BIRseh/UguBcDg9boJw7pNlU1Gi+kEE+Dz9ZmCbrTfr/caKbgjzu5liTQcoc4uyH
kFxkJuJ9RXfAdzOa9c8R1qtJPITglrjsBy/fSeGVWbjOmBSRtoxjMfuP3LzCqfdh
o637t4sLb845GlWMr1ktxGeSAW0vg6cuUFOk8VPEmNN/4huOWC3LrndE6Fvom4mx
s+o5tRiEOPkDZiquN3Wcl/p4uIVrle8sWP+IuZhaYrJM2tDwYHryXVGO0PSmpOai
/oPrcE0RTIikWjXic96z/VxOPR5Yke2iwzedM1jIKGM36I5juNHBwZip6nz/DIK7
OlS0vUQ/wdTa6cOwVe7O4fDxmWWkczOTKBFZxvfsI7hNKsYF+AJ+si0I6KjWyqOD
GeF+GZRmQPAVVHDFWx/Rfx66ZKTrOd3dJ1lUxvOlprLms9s/PvGh8NTLoQNFVLN0
G9ayCG21MV8wmn82rhFq
=QBzm
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
