From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Feb 2015 09:54:41 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <13683715.SQ3ktnuEDS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sunday 01 February 2015 15:47:54 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Add basic support for an RCLK watchdog found in at least all RCar-Gen2
> based SoCs from Renesas. It probably works even for the "Secure
> watchdog" of some of those SoCs according to the specs I have. Setting a
> timeout value is not implemented yet, I didn't need it. A restart
> handler is in place, though.

This looks good, I just have three small comments.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/Kconfig         |   8 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/sh_mobile_wdt.c | 182 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 191 insertions(+)
>  create mode 100644 drivers/watchdog/sh_mobile_wdt.c

[snip]

> diff --git a/drivers/watchdog/sh_mobile_wdt.c
> b/drivers/watchdog/sh_mobile_wdt.c new file mode 100644
> index 000000000000..35016c147f33
> --- /dev/null
> +++ b/drivers/watchdog/sh_mobile_wdt.c

[snip]

> +static int sh_mobile_wdt_restart_handler(struct notifier_block *nb,
> +					 unsigned long mode, void *cmd)
> +{
> +	struct sh_wdt_priv *priv = container_of(nb, struct sh_wdt_priv,
> +						restart_handler);
> +
> +	sh_wdt_start(&priv->wdev);
> +	sh_wdt_write(priv, 0xfff0, RWTCNT);

Is there a reason to set the counter to 0xfff0 instead of 0xffff ?

> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int sh_wdt_probe(struct platform_device *pdev)
> +{
> +	struct sh_wdt_priv *priv;
> +	struct resource *res;
> +	u8 val;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	clk_prepare_enable(priv->clk);
> +	val = readb_relaxed(priv->base + RWTCSRA);
> +	clk_disable_unprepare(priv->clk);
> +
> +	priv->wdev.bootstatus = (val & RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
> +	priv->wdev.info = &sh_wdt_ident,
> +	priv->wdev.ops = &sh_wdt_ops,
> +
> +	platform_set_drvdata(pdev, priv);
> +	watchdog_set_drvdata(&priv->wdev, priv);
> +	watchdog_set_nowayout(&priv->wdev, nowayout);
> +
> +	ret = watchdog_register_device(&priv->wdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "cannot register watchdog device\n");
> +		return ret;
> +	}
> +
> +	priv->restart_handler.notifier_call = sh_mobile_wdt_restart_handler;
> +	priv->restart_handler.priority = 192;

Just for my information, how did you choose 192 for the priority ?

> +	ret = register_restart_handler(&priv->restart_handler);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to register restart handler (err = 
%d)\n",
> ret); +
> +	return 0;
> +}
> +
> +static int sh_wdt_remove(struct platform_device *pdev)
> +{
> +	struct sh_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	unregister_restart_handler(&priv->restart_handler);
> +	watchdog_unregister_device(&priv->wdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id sh_mobile_wdt_ids[] = {
> +	{ .compatible = "renesas,rwdt-rcar", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sh_mobile_wdt_ids);
> +
> +static struct platform_driver sh_wdt_driver = {
> +	.driver = {
> +		.name = "sh_mobile_wdt",
> +		.of_match_table = sh_mobile_wdt_ids,
> +	},
> +	.probe = sh_wdt_probe,
> +	.remove = sh_wdt_remove,
> +};

How about PM (system and runtime) support ? How does the watchdog behave 
during system suspend ? You could then replace the clk_prepare_enable() and 
clk_disable_unprepare() calls with pm_runtime_get_sync() and pm_runtime_put().

> +module_platform_driver(sh_wdt_driver);
> +
> +MODULE_DESCRIPTION("SH Mobile Watchdog Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");

-- 
Regards,

Laurent Pinchart

