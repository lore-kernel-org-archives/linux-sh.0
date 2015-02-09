From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 09 Feb 2015 15:00:05 +0000
Subject: Re: [PATCH] pinctrl: consumer: use correct retval for placeholder functions
Message-Id: <20150209150005.GB8024@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
List-Id: <linux-sh.vger.kernel.org>
References: <1418723959-10253-1-git-send-email-wsa@the-dreams.de>
 <CACRpkdZi8+6v02kjZrLt3XGeZMdHtZwDyB_FohNeBtbDC8RpsA@mail.gmail.com>
In-Reply-To: <CACRpkdZi8+6v02kjZrLt3XGeZMdHtZwDyB_FohNeBtbDC8RpsA@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > These functions are supposed to return an error pointer, not NULL.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Worried that some driver may depend on this behaviour, but
> patch applied anyway, let's deal with it.

I sent a similar patch to Russell for the clk API and he rightfully
NAKed it. NULL is a valid cookie from clk_get and the whole clk API is
able to deal with NULL. That ensures that for !HAVE_CLK, clk_get is
still successful and won't fail driver_probe while the other clk API
functions don't really do anything. If the gpio API is similar to that,
we should revert my patch.

Sorry for the nuisance,

   Wolfram


--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2Mt1AAoJEBQN5MwUoCm2DvkQAIfebrvWlPhVXdA57DcY9jeI
cBqIMufqllCsUTaDrzlLV7BwJccCdT86NueJZoMfdaFU+wYSQlubCaam689Bd1gS
2yIxksbVrewRjq7KlX44VAUoU7vxq211VN9Ap8ObRpkW3BRp/U8vZbEG6SgOThr7
gv5zVmIryS8s8vUNrAxHJ3VEIN7AWMqvvJqsMxzeK91mwaESoh39uKH9oXz9Hcb2
VmAarB+lt/LNsSlD5MvWS4F5vWnIhB/Nxfcxw5SorPhNXYMRkxnFOegLvwkeqFWJ
gkImmlRF//Q7PbwXqK0/IKPPCSg14fSqhQmyMCe7pcfvEJAIAH9xQagZWUNNhuGi
3iJXSvpH3OVxK4B2DpzuNoghZUTbhR+eVRigksprR8hMXZ9gGtciiEhnAj2ZWwmC
tFptZq4UgKl6IpJbAXYMnSBYzXhi8dtb7MHhVZUMuf4IOv556C/c8pe0aebrYBtv
Ge21HzYrxteyQtgJccJ/G693NXvLy/rdwwak1DkK3rs2iTTQLvqnCl9ADUK6hvzd
yZuUOOoysefi9fDDeoANxWxnM/Yllnwbtc4NEOjtmOObENTsAwKUc6er51lpw3D9
/iJ3etbVZ4oNRRbVm16mzExhcKmysfS9GwNgIgX9xDc/XrP+8qH5RaT4T80qHjgy
torXAIWMu8nIh93VpMpY
=5MTe
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
