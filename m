From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 27 Feb 2014 16:06:04 +0000
Subject: Re: [PATCH] phy-rcar-gen2-usb: add device tree support
Message-Id: <530F626C.5020900@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201402270312.51588.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402270312.51588.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-sh@vger.kernel.org, valentine.barshak@cogentembedded.com, rob@landley.net, linux-doc@vger.kernel.org

On 27/02/14 00:12, Sergei Shtylyov wrote:
> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
> documenting the device tree binding as necessary.

You've popped in some fixes for the driver probe in here as well.

Could you do the fixes as a patch and send those before the devicetree
code is done?

> +
>   static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>   	struct rcar_gen2_phy_platform_data *pdata;
>   	struct rcar_gen2_usb_phy_priv *priv;
>   	struct resource *res;
> @@ -177,13 +210,19 @@ static int rcar_gen2_usb_phy_probe(struc
>   	struct clk *clk;
>   	int retval;
>
> -	pdata = dev_get_platdata(dev);
> +	if (np)
> +		pdata = rcar_gen2_usb_phy_parse_dt(dev);
> +	else
> +		pdata = dev_get_platdata(dev);
>   	if (!pdata) {
>   		dev_err(dev, "No platform data\n");
>   		return -EINVAL;
>   	}
>
> -	clk = devm_clk_get(dev, "usbhs");
> +	if (np)
> +		clk = of_clk_get_by_name(np, "usbhs");
> +	else
> +		clk = clk_get(dev, "usbhs");

Can be removed, just add a clock-name of usbhs in the device node.

>   	if (IS_ERR(clk)) {
>   		dev_err(dev, "Can't get the clock\n");
>   		return PTR_ERR(clk);
> @@ -191,13 +230,16 @@ static int rcar_gen2_usb_phy_probe(struc
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	if (IS_ERR(base)) {
> +		retval = PTR_ERR(base);
> +		goto error;
> +	}
>
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv) {
>   		dev_err(dev, "Memory allocation failed\n");
> -		return -ENOMEM;
> +		retval = -ENOMEM;
> +		goto error;
>   	}

Probably should be separate patch to fix probe issues.


>
>   	spin_lock_init(&priv->lock);
> @@ -216,12 +258,16 @@ static int rcar_gen2_usb_phy_probe(struc
>   	retval = usb_add_phy_dev(&priv->phy);
>   	if (retval < 0) {
>   		dev_err(dev, "Failed to add USB phy\n");
> -		return retval;
> +		goto error;
>   	}
>
>   	platform_set_drvdata(pdev, priv);
>
>   	return retval;
> +
> +error:
> +	clk_put(clk);
> +	return retval;
>   }

Again, should have been rolled into fix patch.



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
