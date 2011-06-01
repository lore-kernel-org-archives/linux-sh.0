From: Wolfram Sang <w.sang@pengutronix.de>
Date: Wed, 01 Jun 2011 18:16:03 +0000
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-Id: <20110601181603.GA454@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
List-Id: <linux-sh.vger.kernel.org>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 12:29:23AM +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
>=20
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
>  arch/arm/configs/davinci_all_defconfig     |    2 +-
>  arch/arm/configs/mxs_defconfig             |    2 +-
>  arch/arm/configs/netx_defconfig            |    2 +-
>  arch/arm/configs/viper_defconfig           |    2 +-
>  arch/arm/configs/xcep_defconfig            |    2 +-
>  arch/arm/configs/zeus_defconfig            |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>  arch/blackfin/configs/CM-BF548_defconfig   |    2 +-
>  arch/mips/configs/mtx1_defconfig           |    2 +-
>  arch/powerpc/configs/52xx/pcm030_defconfig |    2 +-
>  arch/powerpc/configs/ps3_defconfig         |    2 +-
>  arch/sh/configs/titan_defconfig            |    2 +-
>  arch/unicore32/configs/debug_defconfig     |    2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)

The mxs-part has already been sent by Shawn Guo (shouldn't harm).

Thanks for doing tree-wide:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3mgeMACgkQD27XaX1/VRtALACgwWNkKN3MYtyEJ3UIFNG7P/jx
oygAoJkolxXXrviVsTRfROYzf65y/N+3
=5o5C
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
