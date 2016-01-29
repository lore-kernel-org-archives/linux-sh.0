From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 29 Jan 2016 11:41:04 +0000
Subject: Re: [PATCH] mmc: mmcif: don't depend on MMC_BLOCK
Message-Id: <CAPDyKFocgEkGpuv=gtYhfaCCx427iy++1jTu0XYwUQVTY8edWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453749554-2149-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453749554-2149-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

On 25 January 2016 at 20:19, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I don't see a reason why a host driver should depend on the card driver.
> It also prevents that we can use the mmc_test driver. So, remove it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index dd1499bd218b16..51919634c3a2ef 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -673,7 +673,7 @@ config MMC_DW_ROCKCHIP
>
>  config MMC_SH_MMCIF
>         tristate "SuperH Internal MMCIF support"
> -       depends on MMC_BLOCK && HAS_DMA
> +       depends on HAS_DMA
>         depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>         help
>           This selects the MMC Host Interface controller (MMCIF).
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
