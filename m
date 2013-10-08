From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 08 Oct 2013 07:47:08 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <5253B87C.9070004@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/08/2013 07:27 AM, Kuninori Morimoto wrote:
>
> Hi Valentine

Hi Morimoto-san,

>
> Thank you for your patch

Thanks for looking at it.

>
>> +/* Setup USB channels */
>> +static void __rcar_gen2_usb_phy_setup(struct rcar_gen2_usb_phy_priv *priv)
>> +{
>> +	u32 val;
>> +
>> +	clk_prepare_enable(priv->clk);
>> +
>> +	/* Set USB channels in the USBHS UGCTRL2 register */
>> +	val = ioread32(priv->base);
>> +	val &= ~(USBHS_UGCTRL2_USB0_HS | USBHS_UGCTRL2_USB2_SS);
>> +	val |= priv->ugctrl2;
>> +	iowrite32(val, priv->base);
>> +}
>
>  From my point of view, if you use clk_enable() on setup(),
> then, it is easy to read if it has exit() or similar name function
> which calls clk_disable()

Since in this case all is needed is to disable the clocks, I've decided 
not to put it in a separate exit function. I'll add one for better 
readability.

>
>> +static int rcar_gen2_usb_phy_set_suspend(struct usb_phy *phy, int suspend)
>> +{
>> +	struct rcar_gen2_usb_phy_priv *priv = usb_phy_to_priv(phy);
>> +	unsigned long flags;
>> +	int retval;
>> +
>> +	spin_lock_irqsave(&priv->lock, flags);
>> +	if (suspend) {
>> +		/* Suspend USBHS internal phy */
>> +		retval = __rcar_gen2_usbhs_phy_disable(priv->base);
>> +		/*
>> +		 * If nothing else is using USB channel 0/2
>> +		 * disable the clocks as well
>> +		 */
>> +		if (priv->usecount = 1) {
>> +			clk_disable_unprepare(priv->clk);
>> +			priv->usecount--;
>> +		}
>> +	} else {
>> +		/*
>> +		 * Enable the clock and setup USB channels
>> +		 * if needed.
>> +		 */
>> +		if (!priv->usecount) {
>> +			priv->usecount++;
>> +			__rcar_gen2_usb_phy_setup(priv);
>> +		}
>> +		/* Resume USBHS internal phy */
>> +		retval = __rcar_gen2_usbhs_phy_enable(priv->base);
>> +	}
>
> Are these usecount++/usecount-- position correct ?

The idea was to disable the clocks here if the phy is not used by other 
drivers (PCI USB host or USBSS), so that suspending the gadget would 
disable USBHS clocks. However, this needs phy enabled before the 
shutdown is called. I guess I'll drop the clock handling here and leave 
it solely to init/shutdown callbacks.

>
>> +static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rcar_gen2_phy_platform_data *pdata;
>> +	struct rcar_gen2_usb_phy_priv *priv;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	int retval;
>> +
>> +	pdata = dev_get_platdata(&pdev->dev);
>> +	if (!pdata) {
>> +		dev_err(dev, "No platform data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	clk = devm_clk_get(&pdev->dev, "usbhs");
>> +	if (IS_ERR(clk)) {
>> +		dev_err(&pdev->dev, "Can't get the clock\n");
>> +		return PTR_ERR(clk);
>> +	}
>
> This case (if you use usb_phy_rcar_gen2 driver),
> you can use pm_runtime_xxx instead of clk_get/enable/disable()
>

Yes, I could. The reason I did not is that I'm not sure that a phy 
driver should use runtime PM, since it is actually mastered by other 
drivers which are supposed to control its power via init/shutdown and 
set_suspend callbacks. Thus, looks like the phy driver can't really 
auto-suspend and doesn't really support runtime PM.

I think that handling clocks in the init/shutdown is a bit cleaner.
It gives us more control over the phy power, where pm_runtime_xxx will 
do nothing if CONFIG_PM_RUNTIME is disabled.

Thanks,
Val.
