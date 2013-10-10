From: Felipe Balbi <balbi@ti.com>
Date: Thu, 10 Oct 2013 15:23:40 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <20131010152340.GE28375@radagast>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q8BnQc91gJZX4vDc"
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2013 at 02:14:45AM +0400, Valentine Barshak wrote:
> This adds RCAR Gen2 USB phy support. The driver configures
> USB channels 0/2 which are shared between PCI USB hosts and
> USBHS/USBSS devices. It also controls internal USBHS phy.
>=20
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/usb/phy/Kconfig                         |  13 ++
>  drivers/usb/phy/Makefile                        |   1 +
>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 248 ++++++++++++++++++=
++++++
>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 +++
>  4 files changed, 284 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>  create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>=20
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index d5589f9..bba7d29 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -214,6 +214,19 @@ config USB_RCAR_PHY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called phy-rcar-usb.
> =20
> +config USB_RCAR_GEN2_PHY
> +	tristate "Renesas R-Car Gen2 USB PHY support"
> +	depends on ARCH_R8A7790 || ARCH_R8A7791 || (ARM && COMPILE_TEST)

see my question on other thread, why the forced ARM dependency ?

--=20
balbi

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVsZ8AAoJEIaOsuA1yqREpUIP/RH1JF6f8ATFS4DoJn31j4tC
ueicWuFcBu2WTWL2+q9qhelRfFWWcu1Usf2yXVp5bVcbdEPkL1JyEW+Kw6QKaYjp
PqcBbu890jffdAyPMvF3WbbOXri57vMcJ7l4H6UYxBQvoBkG2w8cPgpUzMycdczF
X/Ay3c0fyCaGekAvubg9bULvfm4p0sIiSS0VdeZduwREqslDc/XpbDd4P5M1CQ6r
yITSUhYuyXy0Z7W2an0kkyXyLRpwS9aVx359IFZv7tO0yRRQHuT1Aya5q3XorPCP
u+Ud2jwD6sLiUHTZbYnS+BAwYQ0SgNWDuraQPug9AQP5Us6fmXI5Qq1rbb16bPLk
1znjZ2XyFrKG0xTdYbVDoyjYhftMyeLhHyMtfbPPfGBq59ymg8LjL17ORyKXcznE
H4QfC7OvtHLOg/p1oXoQZgtiUxUWtQjkzS5M3vmhSkuGinEVPrNACtNls3H6LGIV
PiQooSQ+sHuSUaRiwdYeGuKMO/t8S334kgscLg75BGxWc0Rnnvc/Rf3UWsyczS93
yD+QBKNEEqnFEFItMNThWd8budugUD9UTUhv+lM2zC4EZ0e4Nu617Nnc5QQBV3rL
mc96C5dMU0B2b7/eVkAZTyYzBs2F2azH+eNMaSthqyqkPMOn89EZswGVLjOJRnaK
6zPoe6Rea80TWfhyrEBC
=H7CH
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
