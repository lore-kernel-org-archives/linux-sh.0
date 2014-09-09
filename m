From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 09 Sep 2014 07:23:55 +0000
Subject: Re: [PATCH 2/6 v4] mmc: use .multi_io_quirk on tmio_mmc
Message-Id: <20140909072355.GG30307@lee--X1>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
 <87ha0h70n1.wl%kuninori.morimoto.gx@gmail.com>
 <878ult6zry.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <878ult6zry.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, 09 Sep 2014, Kuninori Morimoto wrote:

> Hi Lee
>=20
> I forgot to add you on this patch.
> Can you please check this patch from "mfd" point ?
>=20
> ------------------------------
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Now, tmio_mmc can use .multi_io_quirk callback
> instead of MMC_CAP2_NO_MULTI_READ flags.
> let's use it.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
>=20
>  - remove un-needed header
>=20
>  drivers/mmc/host/tmio_mmc_pio.c |   13 +++++++++++++
>  include/linux/mfd/tmio.h        |    3 +++

For the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_=
pio.c
> index ba45413..ff5ff0f 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -970,12 +970,25 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
>  	return ret;
>  }
> =20
> +static int tmio_multi_io_quirk(struct mmc_card *card,
> +			       unsigned int direction, int blk_size)
> +{
> +	struct tmio_mmc_host *host =3D mmc_priv(card->host);
> +	struct tmio_mmc_data *pdata =3D host->pdata;
> +
> +	if (pdata->multi_io_quirk)
> +		return pdata->multi_io_quirk(card, direction, blk_size);
> +
> +	return blk_size;
> +}
> +
>  static const struct mmc_host_ops tmio_mmc_ops =3D {
>  	.request	=3D tmio_mmc_request,
>  	.set_ios	=3D tmio_mmc_set_ios,
>  	.get_ro         =3D tmio_mmc_get_ro,
>  	.get_cd		=3D mmc_gpio_get_cd,
>  	.enable_sdio_irq =3D tmio_mmc_enable_sdio_irq,
> +	.multi_io_quirk	=3D tmio_multi_io_quirk,
>  };
> =20
>  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 90436d5..5738817 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -5,6 +5,7 @@
>  #include <linux/fb.h>
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
> +#include <linux/mmc/card.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> =20
> @@ -142,6 +143,8 @@ struct tmio_mmc_data {
>  	/* clock management callbacks */
>  	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>  	void (*clk_disable)(struct platform_device *pdev);
> +	int (*multi_io_quirk)(struct mmc_card *card,
> +			      unsigned int direction, int blk_size);
>  };
> =20
>  /*

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
