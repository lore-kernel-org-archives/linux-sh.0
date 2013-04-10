From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 09:04:25 +0000
Subject: Re: [PATCH 1/4] rcar-phy: add R8A7778 support
Message-Id: <20130410090425.GQ7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lt3WynA+XK9Fj6D4"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100250.19197.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100250.19197.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--lt3WynA+XK9Fj6D4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 02:50:18AM +0400, Sergei Shtylyov wrote:
> The driver currently only supports R8A7779 SoC. Compared to it, R8A7778 U=
SB-PHY
> has extra register range containing two high-speed signal quality charact=
eristic
> control registers which should be set up  during USB-PHY  startup dependi=
ng on
> whether a ferrite bead is in use or not.  So, we now handle an optional s=
econd
> memory range in the driver's probe method, add the 'ferrite_bead' field t=
o the
> driver's platform data, and add an extra (optional) step to the USB-PHY s=
tartup
> routine which sets up the extended registers.
>=20
> Also mark in the driver's Kconfig section  that R8A7778 is  now supported=
 and
> generally clarify that section, uppercasing the word "phy", while at it..=
=2E=20
>=20
> The patch has been tested on the Marzen and BOCK-W boards.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Felipe Balbi <balbi@ti.com>

Note the conflicts due to rename.

--=20
balbi

--lt3WynA+XK9Fj6D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSsZAAoJEIaOsuA1yqREQxwP/Am1K+NChlAJjV7Cn1GwIwh3
g58xMxo1ykBNWZIABnUstc3Xui/2RohgPRyo8Vcg4RA4N3N71mYafJV9VYDPir7b
Pqe05ri0lMIHn+hJWDrc19OTkcTcrHe2iz19joCVM+4WLwnjXYh/whgoSDis9cQx
Han3ccwpwToFTEO90hRjVPLJ9N69zWCy24Zq52phMxWnuzOW71IKGXEWaJiC/tSt
W9iLYz0SMiGls7mpMcTaBK0RO2/dZA7s9mewwzxY/sDGwFmcrzQiXcrwbvm4WrwI
RyJLxRS1rFQ2ZXtvpLHJyirUgcMPYBTB1WDLGVxkJ2dC8bqWK/uUoNA52hz0PsuU
L5/aSJ9COChZdC4mDBxaqfLOCMyf+LvjpE44K4BA6ezUFu5NtPpprTnnjNo+XWs6
hirxQOqJM07BseYrXsoE6+Fo4d7LvO4nmzSOFuShfO7HavLpnePUU1bqAk7soDOb
02Q/9ibLBmuo8IBF1wli8jwW5V9M3K80uT73lHbCrVrrBVTcyFofLBB2h8IVU1tg
qoJg7HfbGMEOk5N8dwmzCUCEuaw5IQpKWxjfc2tXlB+XeYu23LhxobrCSw68zDru
NnUCunkqk7khPx63yI3p7gSxreBpb6VyO+yi14Hm2Fc+bmBPEWfgQes9PwFJlq1L
R6hJSzeYmh1a9MxA7v9I
=Gz4D
-----END PGP SIGNATURE-----

--lt3WynA+XK9Fj6D4--
