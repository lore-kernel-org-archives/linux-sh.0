From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 18 Sep 2012 21:34:08 +0000
Subject: Re: [RFC - PATCH] base:pm: prepare driver for common clock framework
Message-Id: <201209182334.08229.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1347661174-15404-1-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1347661174-15404-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cyril@ti.com, mturquette@linaro.org, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Saturday, September 15, 2012, Murali Karicheri wrote:
> As part of my work to migrate davinci SoC code to
> use common clk framework, I encountered an issue with this driver
> which is calling clk_enable() and clk_disable() without prepare()/
> unprepare(). This change is needed to enable common clock migration
> for davinci SoCs.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

There are other users of this code than davinci.  For example, sh
and ARM/shmobile both use it.  Have you verified that your changes will
work for them too?

Rafael


> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index eb78e96..9d8fde7 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -99,7 +99,7 @@ static void __pm_clk_remove(struct pm_clock_entry *ce)
>  
>  	if (ce->status < PCE_STATUS_ERROR) {
>  		if (ce->status = PCE_STATUS_ENABLED)
> -			clk_disable(ce->clk);
> +			clk_disable_unprepare(ce->clk);
>  
>  		if (ce->status >= PCE_STATUS_ACQUIRED)
>  			clk_put(ce->clk);
> @@ -396,7 +396,7 @@ static void enable_clock(struct device *dev, const char *con_id)
>  
>  	clk = clk_get(dev, con_id);
>  	if (!IS_ERR(clk)) {
> -		clk_enable(clk);
> +		clk_prepare_enable(clk);
>  		clk_put(clk);
>  		dev_info(dev, "Runtime PM disabled, clock forced on.\n");
>  	}
> @@ -413,7 +413,7 @@ static void disable_clock(struct device *dev, const char *con_id)
>  
>  	clk = clk_get(dev, con_id);
>  	if (!IS_ERR(clk)) {
> -		clk_disable(clk);
> +		clk_disable_unprepare(clk);
>  		clk_put(clk);
>  		dev_info(dev, "Runtime PM disabled, clock forced off.\n");
>  	}
> 

