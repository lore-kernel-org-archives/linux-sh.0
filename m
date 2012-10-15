From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 15 Oct 2012 06:25:14 +0000
Subject: Re: [PATCH] base: power - use clk_prepare_enable and clk_prepare_disable
Message-Id: <2015319.CVFbHOo6Yt@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1348155576-18881-1-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1348155576-18881-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-sh@vger.kernel.org, cyril@ti.com

On Thursday 20 of September 2012 11:39:36 Murali Karicheri wrote:
> When PM runtime is enabled in DaVinci and the machine migrates to
> common clk framework, the clk_enable() gets called without
> clk_prepare(). This patch is to fix this issue so that PM run
> time can inter work with common clk framework.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

OK.  I'm not seeing people having problems with this patch, so I'll tentatively
queue it up for v3.8.

Thanks,
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
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
