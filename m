From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 05:24:21 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
Message-Id: <20141107052420.GA1278@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:52:06PM +0100, Geert Uytterhoeven wrote:
> On sh73a0/kzm9g-legacy, probing of the i2c masters fails with:
>=20
>     i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=3D0x20=
8/0x1bf
>     sh_mobile: probe of i2c-sh_mobile.0 failed with error -22

Yay, so the warning I added found another bug \o/

>=20
> According to the datasheet, the transfer rate is derived from the HP
> clock (which runs at 104 MHz) divided by two. Hence
> i2c_sh_mobile_platform_data.clks_per_count should be set to two.
>=20
> Now probing succeeds, and i2c works:
>=20
>     i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz=
 (L/H=3D0x104/0xe0)
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> ---
> Note that the L/H values still differ from the Transfer Rate Settings
> example in Table 19.3 of the datasheet, which suggests 0x121/0xe7.

Is the formula different or is it rounding errors?

Thanks,

   Wolfram

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXFeEAAoJEBQN5MwUoCm2x1gQAJ2pkFcl8Bl/nKbxIQvn5usj
7TrdEOIA58sxiEt49u3E6Ys7LTnsMoqAda8U1zktpF9NWFokIy5NEVo5dXP2Ztdr
f+O+mK96ieIUKRRUckIWLxCJ2bXD/RfXj6xAEazcfR7RBCVl2dwMvrqpH/sar61G
U1K0jyBXMG+pHhsYD1l3PK4oFgJmy3i1zI6H4QYkTcSRlK1TeQV1JtTk9ZYrbArU
k1D4nLwWkwuTmH4CveR8AmK9a8ED7KGeisqImHhf2ytSNyZ8EOKjFd6WcHxOxYll
WHUFyv0tne/W/x0F5ggd5jziKCu47gOK6SXNNv0TbYfTUD0OftC5u4May17ZDcEb
YasgmMF8QCspXXbE82hQ28LHdJs9cmd4tqC//ukSLs/nVY8mYvPIRFQx1AaikvLU
zqIqGCnv3VekbFfRVm+aPwciDNqo552RJxWtPsbeDcONE3x22XWjY77KY27/zsQv
hy6q/J7attdTg/RhyacLqepjVGdDi1HFhBjnjNSRr3wQw034iNP2F84HkUk+GB9J
Ma/OGVuiSbgfN24TuZj9UkBlwQYgaY9AT04+pRPgiRS6vCJUyyQRsvf0X9U5rRe2
Me/U2LYm6DTmN0Vh9wFclRRZj/qMexg9TxS4loqT/tzU+qOMXT7PgtdcQ29E3TFq
wHGe5iuywHsArmZEmY1g
=AYwA
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
