From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 28 Jan 2012 13:02:57 +0000
Subject: Re: [PATCH 1/2] mmc: tmio_mmc: use PM QoS instead of delayed clock gating for PM
Message-Id: <201201281402.57207.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201191631210.12537@axis700.grange> <Pine.LNX.4.64.1201191714070.12537@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201191714070.12537@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org

Hi,

On Thursday, January 19, 2012, Guennadi Liakhovetski wrote:
> Using delayed clock gating to prevent too frequent gating of the clock
> is simple and efficient, but too inflexible.

I'd mention that you're addressing an undesirable effect of commit
597dd9d79cfbbb1636d00a7fd0880355d9b20c41 here.

> We use PM QoS instead to
> let the runtime PM subsystem decide, which power states can be entered
> at any specific time, depending on the currently active governor.

Do I think correctly that this is going to work because tmio_mmc_set_ios()
calls pm_runtime_get_sync() if power_mode is MMC_POWER_ON and
pm_runtime_put() otherwise?

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> An exact resend of the yesterday's patch
> 
> http://article.gmane.org/gmane.linux.kernel.mmc/12270
> 
>  drivers/mmc/host/tmio_mmc.h     |    2 ++
>  drivers/mmc/host/tmio_mmc_pio.c |   21 ++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index b4519bf..8afaf4f 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -20,6 +20,7 @@
>  #include <linux/mmc/tmio.h>
>  #include <linux/mutex.h>
>  #include <linux/pagemap.h>
> +#include <linux/pm_qos.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
>  
> @@ -50,6 +51,7 @@ struct tmio_mmc_host {
>  
>  	/* Controller power state */
>  	bool			power;

My version of struct tmio_mmc_host (current mainline) doesn't include the
power member.  Perhaps the patch should be rebased on top of 3.3-rc?

> +	struct dev_pm_qos_request pm_qos;
>  
>  	/* Callbacks for clock / power control */
>  	void (*set_pwr)(struct platform_device *host, int state);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 0e72f1a..576baf5 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -40,6 +40,7 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
> @@ -853,11 +854,27 @@ static int tmio_mmc_get_cd(struct mmc_host *mmc)
>  		return pdata->get_cd(host->pdev);
>  }
>  
> +static int tmio_mmc_enable(struct mmc_host *mmc)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +	dev_pm_qos_add_request(mmc->parent, &host->pm_qos, 100);

Why does it add the request for the parent?

> +	return 0;
> +}
> +
> +static int tmio_mmc_disable(struct mmc_host *mmc, int lazy)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +	dev_pm_qos_remove_request(&host->pm_qos);
> +	return 0;
> +}
> +
>  static const struct mmc_host_ops tmio_mmc_ops = {
>  	.request	= tmio_mmc_request,
>  	.set_ios	= tmio_mmc_set_ios,
>  	.get_ro         = tmio_mmc_get_ro,
>  	.get_cd		= tmio_mmc_get_cd,
> +	.enable		= tmio_mmc_enable,
> +	.disable	= tmio_mmc_disable,
>  	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
>  };
>  
> @@ -879,6 +896,8 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
>  	if (!mmc)
>  		return -ENOMEM;
>  
> +	/* disable delayed clock gating, we use PM QoS for precise PM */
> +	mmc->clkgate_delay = 0;

I don't think this is sufficient, because user space can change that value at
any time.  You'd need a mechanism to completely disable the delay regardless
of the user space setting.

>  	pdata->dev = &pdev->dev;
>  	_host = mmc_priv(mmc);
>  	_host->pdata = pdata;
> @@ -899,7 +918,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
>  	}
>  
>  	mmc->ops = &tmio_mmc_ops;
> -	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
> +	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_DISABLE | pdata->capabilities;
>  	if (pdata->get_clk_rate)
>  		mmc->f_max = pdata->get_clk_rate(pdev);
>  	else

Thanks,
Rafael
