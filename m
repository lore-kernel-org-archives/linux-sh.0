From: Felipe Balbi <balbi@ti.com>
Date: Tue, 28 Apr 2015 16:50:09 +0000
Subject: Re: [PATCH] usb: phy: Remove the phy-rcar-gen2-usb driver
Message-Id: <20150428165009.GI18263@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GlnCQLZWzqLRJED8"
List-Id: <linux-sh.vger.kernel.org>
References: <1430222647-1845-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430222647-1845-1-git-send-email-geert+renesas@glider.be>
To: linux-sh@vger.kernel.org

--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2015 at 02:04:07PM +0200, Geert Uytterhoeven wrote:
> The phy-rcar-gen2-usb driver, which supports legacy platform data only,
> is no longer used since commit a483dcbfa21f919c ("ARM: shmobile: lager:
> Remove legacy board support").
>=20
> This driver was superseded by the DT-only phy-rcar-gen2 driver, which
> was introduced in commit 1233f59f745b237d ("phy: Renesas R-Car Gen2 PHY
> driver").
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/usb/phy/Kconfig                         |  13 --
>  drivers/usb/phy/Makefile                        |   1 -
>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 246 ------------------=
------
>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ---
>  4 files changed, 282 deletions(-)
>  delete mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>  delete mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>=20
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 2175678e674ebf44..3cd3bee54ca6f9b3 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -186,19 +186,6 @@ config USB_RCAR_PHY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called phy-rcar-usb.
> =20
> -config USB_RCAR_GEN2_PHY

$ git grep -e USB_RCAR_GEN2_PHY
arch/arm/configs/multi_v7_defconfig:448:CONFIG_USB_RCAR_GEN2_PHY=3Dm
arch/arm/configs/shmobile_defconfig:163:CONFIG_USB_RCAR_GEN2_PHY=3Dy

Are you sending patches to fix both defconfigs ?

--=20
balbi

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVP7pBAAoJEIaOsuA1yqRE6PwP/jyV8V9kP0at7D30U+tg3xJs
Wo1NTNxpP/6/srfD8f4eyi7gZ4pMxfu1Eh9BKEsyynl+8HKlFexZgpm3N0UjYq2Y
M/0S7LGENMrDPgmZrqAtv05fO8uO/TZYExnOvfIN0ge43g38tpj2GQKMneoSjjuM
seIjWQQ86SRPdkx97FvNHtLztgHRy0DShgfNLSJ7NfjCLd2MjJM6YJVmawen6KfG
vqNqXAtYt/XdIU9hgbXetfEaTmRblfUI0hwSkB2lf3iDHgetZu+04e7GlHOHuGrt
MZR55jeIlUTgAKGYaqNV9S9/cn4biC0nvg+iYMxx7cHSu64PAQzD1yBTu+I8tS7H
Lr1HHeTr/3wJqWgShTQCQOINI/RbT1eU8o9GXE+t7gDSz43vf2qrpvHetWm0KBvC
zgY4rcrKZbkZhbRt24EjfozCLmsnpCVKNNuoHGOVLDqECJBjRaRfgy684eW5zel2
302nFaVDB7XaCQOOdSH83TP0o1yhOsz7f0Oo4Zy5R1WsMaBR8D9muzzp/CwBRvbL
PNRpeWQUrS/Vi1c9EZrnkhpVdWCpsn4PwAl4hdbv/mc+Mr6rLLLGwg6zX5uXf0ln
1YzvCdqM0m++YJ12g5siWnssQ6PCdnbdw1jkQDlbU7Zk0n3+ERl3H3hchQ6zE7S3
tlPPGagr+K/yU+kNEeqH
=smV3
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
