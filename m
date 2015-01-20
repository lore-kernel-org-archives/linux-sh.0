From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2015 09:12:20 +0000
Subject: Re: [PATCH 06/17] mmc: tmio: tmio_mmc_host has .multi_io_quirk
Message-Id: <CAPDyKFpjYH_Txt1g8AjMFncnXvyT_-E5CKmdY+cDoNk+sC2ujg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<87lhl7uvhx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lhl7uvhx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+ MFD maintainer

On 13 January 2015 at 05:58, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current .multi_io_quirk is implemented under tmio_mmc_data.
> It goes to tmio_mmc_host by this patch.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
>  drivers/mmc/host/tmio_mmc.h       |    2 ++
>  drivers/mmc/host/tmio_mmc_pio.c   |    5 ++---
>  include/linux/mfd/tmio.h          |    3 ---
>  4 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 5e02a6a..c92efe5 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -217,9 +217,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         host->write16_hook      = sh_mobile_sdhi_write16_hook;
>         host->clk_enable        = sh_mobile_sdhi_clk_enable;
>         host->clk_disable       = sh_mobile_sdhi_clk_disable;
> +       host->multi_io_quirk    = sh_mobile_sdhi_multi_io_quirk;
>
>         mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
> -       mmc_data->multi_io_quirk = sh_mobile_sdhi_multi_io_quirk;
>         if (p) {
>                 mmc_data->flags = p->tmio_flags;
>                 mmc_data->ocr_mask = p->tmio_ocr_mask;
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 28234ec..263256c 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -98,6 +98,8 @@ struct tmio_mmc_host {
>         int (*write16_hook)(struct tmio_mmc_host *host, int addr);
>         int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>         void (*clk_disable)(struct platform_device *pdev);
> +       int (*multi_io_quirk)(struct mmc_card *card,
> +                             unsigned int direction, int blk_size);
>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 94fbf4a..67c8182 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1004,10 +1004,9 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
>                                unsigned int direction, int blk_size)
>  {
>         struct tmio_mmc_host *host = mmc_priv(card->host);
> -       struct tmio_mmc_data *pdata = host->pdata;
>
> -       if (pdata->multi_io_quirk)
> -               return pdata->multi_io_quirk(card, direction, blk_size);
> +       if (host->multi_io_quirk)
> +               return host->multi_io_quirk(card, direction, blk_size);
>
>         return blk_size;
>  }
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index a3f78da..3edaa17 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -125,9 +125,6 @@ struct tmio_mmc_data {
>         unsigned int                    cd_gpio;
>         void (*set_pwr)(struct platform_device *host, int state);
>         void (*set_clk_div)(struct platform_device *host, int state);
> -
> -       int (*multi_io_quirk)(struct mmc_card *card,
> -                             unsigned int direction, int blk_size);
>  };
>
>  /*
> --
> 1.7.9.5
>
