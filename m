From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 03:27:39 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <87d2ngxx08.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

Thank you for your patch

> +/* Setup USB channels */
> +static void __rcar_gen2_usb_phy_setup(struct rcar_gen2_usb_phy_priv *priv)
> +{
> +	u32 val;
> +
> +	clk_prepare_enable(priv->clk);
> +
> +	/* Set USB channels in the USBHS UGCTRL2 register */
> +	val = ioread32(priv->base);
> +	val &= ~(USBHS_UGCTRL2_USB0_HS | USBHS_UGCTRL2_USB2_SS);
> +	val |= priv->ugctrl2;
> +	iowrite32(val, priv->base);
> +}

From my point of view, if you use clk_enable() on setup(),
then, it is easy to read if it has exit() or similar name function
which calls clk_disable()

> +static int rcar_gen2_usb_phy_set_suspend(struct usb_phy *phy, int suspend)
> +{
> +	struct rcar_gen2_usb_phy_priv *priv = usb_phy_to_priv(phy);
> +	unsigned long flags;
> +	int retval;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (suspend) {
> +		/* Suspend USBHS internal phy */
> +		retval = __rcar_gen2_usbhs_phy_disable(priv->base);
> +		/*
> +		 * If nothing else is using USB channel 0/2
> +		 * disable the clocks as well
> +		 */
> +		if (priv->usecount = 1) {
> +			clk_disable_unprepare(priv->clk);
> +			priv->usecount--;
> +		}
> +	} else {
> +		/*
> +		 * Enable the clock and setup USB channels
> +		 * if needed.
> +		 */
> +		if (!priv->usecount) {
> +			priv->usecount++;
> +			__rcar_gen2_usb_phy_setup(priv);
> +		}
> +		/* Resume USBHS internal phy */
> +		retval = __rcar_gen2_usbhs_phy_enable(priv->base);
> +	}

Are these usecount++/usecount-- position correct ?

> +static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rcar_gen2_phy_platform_data *pdata;
> +	struct rcar_gen2_usb_phy_priv *priv;
> +	struct resource *res;
> +	void __iomem *base;
> +	struct clk *clk;
> +	int retval;
> +
> +	pdata = dev_get_platdata(&pdev->dev);
> +	if (!pdata) {
> +		dev_err(dev, "No platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	clk = devm_clk_get(&pdev->dev, "usbhs");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Can't get the clock\n");
> +		return PTR_ERR(clk);
> +	}

This case (if you use usb_phy_rcar_gen2 driver),
you can use pm_runtime_xxx instead of clk_get/enable/disable()

