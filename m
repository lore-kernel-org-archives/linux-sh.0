From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 05:25:33 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: sh73a0 dtsi: Add SoC-specific IIC compatible properties
Message-Id: <20141107052533.GB1278@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mojUlQ0s9EVzWg2t"
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-5-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:52:09PM +0100, Geert Uytterhoeven wrote:
> The IIC nodes used the generic compatible properties only.
> This causes the driver to fail when using Standard Speed, as the
> operational clock is driven by the 104 MHz HP clock:
>=20
>     i2c-sh_mobile e6820000.i2c: timing values out of range: L/H=3D0x208/0=
x1bf
>     i2c-sh_mobile: probe of e6820000.i2c failed with error -22
>=20
> Add the SoC-specific compatible property to fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXFfNAAoJEBQN5MwUoCm2jHMP/iiAi09MU17gTYMmC4Equ2Rm
29tQ7INkdrpOIGT5Waw0vzIpMcJd8fB/wQYCdD+tcYDPRyBvZfKc5sNBM0vPmvEh
6vEr9J7TGbXwAlhhxPs1nhrW63RvxHAmmZqFRpRm3Uzzc3ffYkThmUs/L0RDEV2a
uVhAED3D50QYDRg3wJOZvZ9tMt0g2BzfFC71jiKITkT0U86UPMGRdt/y8enUkCyu
RrwjGvAvM2jxBSaokr+/XXWFqfMrHIMxF/W5X/bOkQnzv0uq9iPQ3KCEFGjMwm0v
D9pPzFPp1H+asQaWRQ8EuATfQRe1jIc/MK1Hh5gB9HxPag+3uFSLGN1sBQfBbdl9
DKp/ykyywymsrxnRn4ysS1zHrS8Vfu5dKOoviJMcibL1bkqpMizQai9R7OH2CaLZ
H6Mw6X6P1zj8644FA4XO6XZhig6PbVorfLGEAGL6DZtC9uUJ8V9bK1sWi+tsSq84
35sMfe+dHFWbnbGnPFn+hcodtZpC623iuMzolpQFR0ubRxahHtGgLbJXuNzqZpSS
M4slgX0DS8lu/mk+GdObJeMSwwgIwhDzfzucZHJi3rO5cRNkzW9ewrqB/TUkaSMS
McJbe7mzZ9md/N0goW/gSrkGorkFGgg4kdVI2ehE8JqueoYUfEgbdYpqQ1yPpi+q
DsYWQMGo9eJI09t7cpuu
=2Sbz
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
