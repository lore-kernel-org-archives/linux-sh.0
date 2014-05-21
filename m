From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 21 May 2014 10:44:57 +0000
Subject: Re: [PATCH v2 00/10] i2c: sh_mobile: cleanups & bugfixes
Message-Id: <20140521104456.GN2708@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MSd2ShuMixI0uVaZ"
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 09:15:06PM +0200, Wolfram Sang wrote:
> Some cleanups and bugfixes for i2c-sh_mobile. Tested on top of
> renesas-devel-v3.15-rc3-20140429 and with a lager board. Branch is at
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sh_mo=
bile-cleanup
>=20
> Changes since V1:
> * added patches to make bus speed calculation more robust
> * added patch to fix bus speed calculation for rcar-gen2 SoCs
> * added tags from Geert to patches
>=20
>=20
> Wolfram Sang (10):
>   i2c: sh_mobile: replace magic hex values with constants
>   i2c: sh_mobile: improve error handling
>   i2c: sh_mobile: honor DT bus speed settings
>   i2c: sh_mobile: add devicetree documentation
>   i2c: sh_mobile: devm conversion, low hanging fruits
>   i2c: sh_mobile: devm conversion, irq setup
>   i2c: sh_mobile: remove superfluous offset parameter
>   i2c: sh_mobile: bail out on errors when initializing
>   i2c: sh_mobile: check timing parameters for valid range
>   i2c: sh_mobile: fix clock calculation for newer SoCs

Applied this series to for-next.


--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfIOoAAoJEBQN5MwUoCm28KAP/11iuNAU9AEYQMyyOsf8HaCj
jaP0eA3F4b4tPkRGl9VFqiNLmWOAoV1rxPJ2ig812YqIvtRjWwTNWUOpuG16EkEE
OOjTDQRQSEX6rAKuM3gFwk0FkiG8+mfByg8ppG9SuamrfaKd65AZfVBCawsVuoMR
ViBqO7yG5bErXPmEeLvW8+6flMKwiXSbjIfefb20E+wa1CJLZDCcAEjDCv2xP6P9
CFZ/6AsJmASb6TxRxLdpFbgzb1oCZR1NP5MolCxGlaU8LoZ98Qld1Z5+Q41VMDl0
4x8/dt3jVif93hqXnGgImpJFT8wg8Fhow7q/VLXKgG1XcRFUYqoKl3l7bRqXVUW1
kkAhafNWgOxlZmfMSIDzp1YMKNLJT9jvOkYYptucLCde5+GhhH3T6d4acQU3ce1u
1ITKbB6/O3TLZXHqyqSjp2QPybjqy10IDZORFT6XQnTzHdLg32PEZxw43KHa86yj
w0XECjOG20/y3V7a0HxyQpowsljDh37eHpGpTlphQwz/nzG9ZJd+7zvX/3/ENTev
XlQiXIeXss5emdNoxVBJsr4NrHDCT2gngvC0tqZmgU6FZrqz2OWc6/6spBPxsia1
47uLLoUz6F6/w2DA9O93wr64YVn8ORBrP0lHJXlyXRY0c5HPK+VWXZuBzVLCjjo/
TGDYHTpYIn3K04CunkFH
=xU+W
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--
