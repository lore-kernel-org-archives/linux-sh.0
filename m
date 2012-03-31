From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 31 Mar 2012 06:15:20 +0000
Subject: Re: [PATCH] input: st1232 device tree support
Message-Id: <20120331061520.GA20406@core.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20120330084749.19624.84121.sendpatchset@w520>
In-Reply-To: <20120330084749.19624.84121.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, rjw@sisk.pl, lethal@linux-sh.org

Hi Magnus,

On Fri, Mar 30, 2012 at 05:47:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch enables DT support for the st1232 driver
> which is primarily used on the sh7372 Mackerel board.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/input/touchscreen/st1232.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- 0001/drivers/input/touchscreen/st1232.c
> +++ work/drivers/input/touchscreen/st1232.c	2012-03-29 14:43:13.000000000 +0900
> @@ -255,6 +255,12 @@ static const struct i2c_device_id st1232
>  };
>  MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
>  
> +static const struct of_device_id st1232_ts_dt_ids[] __devinitconst = {
> +	{ .compatible = "sitronix,st1232", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
> +

Should it be guarder with "#ifdef CONFIG_OF" and then we'd do

	.of_match_table = of_match_ptr(st1232_ts_dt_ids);

?

Thanks.

>  static struct i2c_driver st1232_ts_driver = {
>  	.probe		= st1232_ts_probe,
>  	.remove		= __devexit_p(st1232_ts_remove),
> @@ -262,6 +268,7 @@ static struct i2c_driver st1232_ts_drive
>  	.driver = {
>  		.name	= ST1232_TS_NAME,
>  		.owner	= THIS_MODULE,
> +		.of_match_table = st1232_ts_dt_ids,
>  #ifdef CONFIG_PM
>  		.pm	= &st1232_ts_pm_ops,
>  #endif

-- 
Dmitry
