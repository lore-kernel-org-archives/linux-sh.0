From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Dec 2014 06:58:14 +0000
Subject: Re: [PATCH] i2c: sh_mobile: I2C_SH_MOBILE should depend on HAS_DMA
Message-Id: <20141217065814.GB1018@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
List-Id: <linux-sh.vger.kernel.org>
References: <1418650624-28174-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1418650624-28174-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2014 at 02:37:04PM +0100, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
> drivers/built-in.o: In function `sh_mobile_i2c_dma_unmap':
> i2c-sh_mobile.c:(.text+0x60de42): undefined reference to `dma_unmap_singl=
e'
> drivers/built-in.o: In function `sh_mobile_i2c_xfer_dma':
> i2c-sh_mobile.c:(.text+0x60df22): undefined reference to `dma_map_single'
> i2c-sh_mobile.c:(.text+0x60df2e): undefined reference to `dma_mapping_err=
or'
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for spotting this. However, since DMA is opt-in, isn't this
dependency too much? I can't think of anything better than #ifdeffing
the code, though.

> ---
>  drivers/i2c/busses/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index c1351d9fb35bbc8d..f08dd20f625c184d 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -753,6 +753,7 @@ config I2C_SH7760
> =20
>  config I2C_SH_MOBILE
>  	tristate "SuperH Mobile I2C Controller"
> +	depends on HAS_DMA
>  	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>  	help
>  	  If you say yes to this option, support will be included for the
> --=20
> 1.9.1
>=20

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkSmGAAoJEBQN5MwUoCm2xHsP/js2TUgYoioEwKyqVFe5DaFY
7vmdGM9QXQIvlS+hMBhdMeVbN8tb5CUF+G24XEyiqrDgbrG7PiHb84ud+XziGsfW
h7q7r2mSDYWWEkIFJhJ/EPO4P9SSkdkbXwTM9Q978nRc85UA7Zq000WLfXT7+iO1
t2ymXpIDyHldywsVeA2jalTJ0oe9KDHQ0Sob2Hp7ZJinYbndFwYqxnr5Ppepphke
f20jM+gmPNZc00kzOLc16AfiZ5rurVPPPu9YdeuyyH6g38LjUMSqv6TyzojIVXhj
93lbaLRKg+TM1B/txu9aZqKQRBDeFouGBalSPPFFQNdO6CHH3vusuqsTxobyeNCB
Cge/xnG5LqJcPRToKusXg0sVoEyvEFAShKJ1AEJqQk3PHzMCDdrAIa0edp6EswDq
TXejkg/mD/cBldVaQuKIF3HNP3tu27L7EKKOiLKfRtQzvajsb/Sa6Wp8L4kNKCVw
2ZHL47jXiYd222/SyJc/uGtw9CHy6AxrQPlCgdyyyMYYB1B78dCqdu6CE3UeoYPD
4V+8A+sA5zYw8LoyMgPh/JOX/jhnWQe2WwjgQ8b1G5ojb2RmQPs9waMKzpWSQCL9
sRm2ebnytWMmS8b/0Rrc8U4U234lNXmMoMGwv/EKIF5hCJSbL9iXrEEqgmWllh50
ZPoHxD1VZO4k2Qcc73q4
=zwWr
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
