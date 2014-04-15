From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Apr 2014 11:24:12 +0000
Subject: Re: [PATCH v3 2/7] adv7180: add of match table
Message-Id: <534D16DC.5010808@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 14-04-2014 14:36, Ben Dooks wrote:

> Add a proper of match id for use when the device is being bound via
> device tree, to avoid having to use the i2c old-style binding of the
> device.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/media/i2c/adv7180.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index 215afa0..687d97b 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
[...]
> @@ -695,11 +696,21 @@ static SIMPLE_DEV_PM_OPS(adv7180_pm_ops, adv7180_suspend, adv7180_resume);
>
>   MODULE_DEVICE_TABLE(i2c, adv7180_id);
>
> +#ifdef CONFIG_OF

    Don't think it's worth using #ifdef.

> +static const struct of_device_id adv7180_of_id[] = {
> +	{ .compatible = "adi,adv7180", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adv7180_of_id)
> +#endif

WBR, Sergei

