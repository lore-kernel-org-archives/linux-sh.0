From: Mark Brown <broonie@kernel.org>
Date: Tue, 11 Mar 2014 10:42:38 +0000
Subject: Re: [PATCH v3 resend] spi: hs-spi: Improve bindings
Message-Id: <20140311104238.GL28112@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Bmt9nG8I+kxQNpDu"
List-Id: <linux-sh.vger.kernel.org>
References: <1394530851-20244-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394530851-20244-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>


--Bmt9nG8I+kxQNpDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 10:40:51AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
>   - Add future-proof "renesas,hspi-<soctype>" compatible values,
>   - Add missing "interrupt-parent", "#address-cells", and "#size-cells"
>     properties,
>   - Add reference to pinctrl documentation,
>   - Add example bindings.

Applied, thanks.

--Bmt9nG8I+kxQNpDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHuibAAoJELSic+t+oim9ZlQP/3jxyCoTzY2djVSNOUs2LK8N
zNbaGUb/INdm+qA3Of78Sv0S+s2C6lh5UwDyX5q4h2JJiNJgVEEmndZeyj//WzXj
+PqywinI3W9pg9eGMo2mTKindsugaly2o0RS6J27ar/Q0ae4WWSAt+Dkmybhfa6d
0bBc6MMWoVU4mEZvw9BSVlZ2ZFvjQ5TCN89AiXLdsVxhLUrh6WWM3Dubj/5U3/81
KZWKKgTWbMVnQBwJw0RuYEYWqwrT0BvDxdy2fVaBrNoEee14epCRoVgNag7VOIep
b9vRyu88sEIRsp6UNurze0i5JnxyYdRAwH0ML6y/pEl59OQBoFyuehR8vG8Ai1Ld
VnvrZ2N18HnA0dCtPCrBJ8v7YQVlR6TLMYwQF8rFlWaRo8VkKlZc/evLVAeNNHAj
vSJVZ5gszclMqwr2AnaG3ZQ5FOB/7O/4oX3tEsQJ7OjAjasanSl9DvR96kCHjOJ1
iEVoAPmxnAkPlgtX0EYWM4x+OPuay5LXoNLfHhiNdoJllVqW6876HSzJbRI46b1B
YDNsXZD554Bt91l55d7JXz86eWgxcx+PtyKjmlWWUrhMHIfxtwOGRbMMR6m1UtuT
jhpIXq/Tfyvg9Ay+zlwD9Bd8ff35t9E+onXItrrBMBGIDOyf94ihp5WfvmJkFMiP
y7gHlKDVYmEnyf9aAAbh
=hF9s
-----END PGP SIGNATURE-----

--Bmt9nG8I+kxQNpDu--
