From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Feb 2013 02:26:41 +0000
Subject: Re: [PATCH] i2c: sh_mobile: Don't start transfers when suspending
Message-Id: <20130216022641.GD11628@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360862257-10807-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1360862257-10807-1-git-send-email-hechtb+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastian Hecht <hechtb+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Thu, Feb 14, 2013 at 11:17:37AM -0600, Bastian Hecht wrote:
> Currently we provoke i2c timeouts by allowing transfers when
> suspending. This patch adds awareness to suspending and fixes these
> issues.
> The patch follows the style used in i2c-tegra.c - thanks.

Hi,

at this stage I do not expect this code to go through the renesas tree.
However, in order to provide a basis for work on renesas SoCs I have added
this patch to the topic/i2c topic branch in the reneas tree on
kernel.org and merged it into topic/all+next.

In other words, I am not picking this patch up to merge it or add it to
linux-next, rather I am storing it for reference.

> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  drivers/i2c/busses/i2c-sh_mobile.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index b6e7a83..da28164 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -132,6 +132,7 @@ struct sh_mobile_i2c_data {
>  	struct i2c_msg *msg;
>  	int pos;
>  	int sr;
> +	bool is_suspended;
>  };
>  
>  #define IIC_FLAG_HAS_ICIC67	(1 << 0)
> @@ -511,6 +512,9 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>  	u_int8_t val;
>  	int i, k, retry_count;
>  
> +	if (pd->is_suspended)
> +		return -EBUSY;
> +
>  	activate_ch(pd);
>  
>  	/* Process all messages */
> @@ -753,9 +757,33 @@ static int sh_mobile_i2c_runtime_nop(struct device *dev)
>  	return 0;
>  }
>  
> +static int sh_mobile_i2c_suspend(struct device *dev)
> +{
> +	struct sh_mobile_i2c_data *pd = dev_get_drvdata(dev);
> +
> +	i2c_lock_adapter(&pd->adap);
> +	pd->is_suspended = true;
> +	i2c_unlock_adapter(&pd->adap);
> +
> +	return 0;
> +}
> +
> +static int sh_mobile_i2c_resume(struct device *dev)
> +{
> +	struct sh_mobile_i2c_data *pd = dev_get_drvdata(dev);
> +
> +	i2c_lock_adapter(&pd->adap);
> +	pd->is_suspended = false;
> +	i2c_unlock_adapter(&pd->adap);
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
>  	.runtime_suspend = sh_mobile_i2c_runtime_nop,
>  	.runtime_resume = sh_mobile_i2c_runtime_nop,
> +	.suspend = sh_mobile_i2c_suspend,
> +	.resume = sh_mobile_i2c_resume,
>  };
>  
>  static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
