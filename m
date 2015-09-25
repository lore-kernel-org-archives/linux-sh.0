From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Sep 2015 20:24:46 +0000
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Message-Id: <CAPDyKFqt3AygyfXG5M-jTVqdvLi0CxWuyUmPFjg+A0dmz+o7qA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
In-Reply-To: <1513691.2yatcrs42i@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>

On 24 September 2015 at 01:58, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> There seems  to be no sense in the runtime PM calls when the actual register
> read is suppressed by the TMIO_MMC_WRPROTECT_DISABLE flag.  Check that flag
> before trying to read the register and  thus doing the runtime PM dance...
>
> While at it, kill useless local variable and add empty line after declarations.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.
>
>  drivers/mmc/host/tmio_mmc_pio.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
> =================================> --- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
> +++ mmc/drivers/mmc/host/tmio_mmc_pio.c
> @@ -988,14 +988,16 @@ static void tmio_mmc_set_ios(struct mmc_
>  static int tmio_mmc_get_ro(struct mmc_host *mmc)
>  {
>         struct tmio_mmc_host *host = mmc_priv(mmc);
> -       struct tmio_mmc_data *pdata = host->pdata;
>         int ret = mmc_gpio_get_ro(mmc);
> +
>         if (ret >= 0)
>                 return ret;
>
> +       if (host->pdata->flags & TMIO_MMC_WRPROTECT_DISABLE)
> +               return 0;
> +
>         pm_runtime_get_sync(mmc_dev(mmc));
> -       ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
> -               (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
> +       ret = !(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT);
>         pm_runtime_mark_last_busy(mmc_dev(mmc));
>         pm_runtime_put_autosuspend(mmc_dev(mmc));
>

Actually this change won't have the desired effect, as the mmc core
already done a pm_runtime_get_sync() since it has claimed the mmc
host[1].

I do realize that most drivers are still maintaining the
pm_runtime_get|put() calls, but in most cases that's not needed any
more.

[1]
commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host devices")

Kind regards
Uffe
