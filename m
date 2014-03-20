From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 20 Mar 2014 17:59:29 +0000
Subject: Re: [PATCH] drivers/sh: pm_runtime implementation needs to suspend and resume devices
Message-Id: <1518762.GDi4YJCJPb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395334473-27600-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1395334473-27600-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Thursday 20 March 2014 17:54:33 Ben Dooks wrote:
> If we override the platform bus calls for pm_runtime then we end up
> with the calls to the devices' suspend and resume methods ignored
> in favour of the bus ones.
> 
> Change to calling the pm_runtime calls to suspend and resume the
> devices specifically in the drivers/sh/pm_runtime.c implementation
> to allow any device that may want to run power management to do so.
> 
> Note, all the current sh driver implementations do not use their
> own power management code so this is not a major implementation
> issues.
> 
> This also brings the implementation into line with the versions
> used by the Davinci and Keystone PM domain code, so once fully
> tested these implementations could be merged together.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/sh/pm_runtime.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
> index f4f8851..ced5307 100644
> --- a/drivers/sh/pm_runtime.c
> +++ b/drivers/sh/pm_runtime.c
> @@ -21,10 +21,43 @@
>  #include <linux/slab.h>
> 
>  #ifdef CONFIG_PM_RUNTIME
> +static int sh_pm_runtime_suspend(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = pm_generic_runtime_suspend(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to suspend device\n");
> +		return ret;
> +	}
> +
> +	ret = pm_clk_suspend(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to suspend clock\n");

Despite their return type, pm_clk_suspend and pm_clk_resume never fail (in 
their current implementation). I'm thus wondering if the dev_err calls are 
really worth it, especially given that the other implementations you mention 
in the commit message don't have any error logging.

> +		pm_generic_runtime_resume(dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sh_pm_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = pm_clk_resume(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to resume clock\n");
> +		return ret;
> +	}
> +
> +	return pm_generic_runtime_resume(dev);

If you want to keep the error messages you should probably add one here as 
well.

> +}
> +
>  static struct dev_pm_domain default_pm_domain = {
>  	.ops = {
> -		.runtime_suspend = pm_clk_suspend,
> -		.runtime_resume = pm_clk_resume,
> +		.runtime_suspend = sh_pm_runtime_suspend,
> +		.runtime_resume = sh_pm_runtime_resume,
>  		USE_PLATFORM_PM_SLEEP_OPS
>  	},
>  };

-- 
Regards,

Laurent Pinchart

