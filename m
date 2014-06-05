From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 05 Jun 2014 23:03:53 +0000
Subject: Re: [PATCH v3 2/7] adv7180: add of match table
Message-Id: <5390F759.300@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/14/2014 02:36 PM, Ben Dooks wrote:

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
> +static const struct of_device_id adv7180_of_id[] = {
> +	{ .compatible = "adi,adv7180", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adv7180_of_id)
> +#endif
> +
>   static struct i2c_driver adv7180_driver = {
>   	.driver = {
>   		   .owner = THIS_MODULE,
>   		   .name = KBUILD_MODNAME,
>   		   .pm = ADV7180_PM_OPS,
> +		   .of_match = of_match_ptr(adv7180_of_id),

    Duh, this doesn't even compile: the field is called 'of_match_table' actually.

WBR, Sergei

