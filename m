From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 07 Jul 2015 08:38:49 +0000
Subject: RE: [PATCH v2] phy: rcar-gen2 usb: Add Host/Function switching for USB0
Message-Id: <SIXPR06MB06394AED5D183C15C5A66BCEF5920@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435824347-22732-1-git-send-email-phil.edworthy@renesas.com>
 <SG2PR06MB0919835888EBD162D4B86C24D8930@SG2PR06MB0919.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB0919835888EBD162D4B86C24D8930@SG2PR06MB0919.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>

Hi Shimoda-san,

On 06 July 2015 08:18, Shimoda-san wrote:
> Hi Phil-san,
> 
> Thank you very much for the patch!
> 
> > Sent: Thursday, July 02, 2015 5:06 PM
> < snip >
> > +/* VBUS change IRQ handler */
> > +static irqreturn_t gpio_vbus_irq(int irq, void *data)
> > +{
> > +	struct rcar_gen2_channel *channel = data;
> > +
> > +	/* Wait 20ms before doing anything as VBUS needs to settle */
> > +	schedule_delayed_work(&channel->work, msecs_to_jiffies(20));
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int probe_otg(struct platform_device *pdev,
> > +	struct rcar_gen2_phy_driver *drv)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct rcar_gen2_channel *ch = drv->channels;
> > +	int irq;
> > +	int ret;
> > +
> > +	/* GPIOs for Host/Fn switching */
> > +	ch->gpio_id = of_get_named_gpio_flags(dev->of_node,
> > +				"renesas,id-gpio", 0, NULL);
> > +	ch->gpio_vbus = of_get_named_gpio_flags(dev->of_node,
> > +				"renesas,vbus-gpio", 0, NULL);
> > +
> > +	/* Need valid ID and VBUS gpios for Host/Fn switching */
> > +	if (gpio_is_valid(ch->gpio_id) && gpio_is_valid(ch->gpio_vbus)) {
> > +		ch->use_otg = 1;
> > +
> > +		/* GPIO for ID input */
> > +		ret = devm_gpio_request_one(dev, ch->gpio_id, GPIOF_IN,
> "id");
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* GPIO for VBUS input */
> > +		ret = devm_gpio_request_one(dev, ch->gpio_vbus, GPIOF_IN,
> "vbus");
> 
> According to the checkpatch.pl, "line over 80 characters".
As I understand it, the 80 chars is not a hard rule. One reason for the
80 char guideline is to avoid overly complex code, but I don't think
that can be said of the above line!

> > +		if (ret)
> > +			return ret;
> > +
> > +		irq = gpio_to_irq(ch->gpio_vbus);
> > +		ret = devm_request_irq(dev, irq, gpio_vbus_irq,
> VBUS_IRQ_FLAGS,
> > +				"vbus_detect", ch);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Optional GPIO for VBUS power */
> > +		ch->gpio_vbus_pwr = of_get_named_gpio_flags(dev->of_node,
> > +						"renesas,vbus-pwr-gpio", 0,
> NULL);
> 
> Same above.
Since this code was already split over two lines, I agree with you here.

> 
> > +		if (gpio_is_valid(ch->gpio_id)) {
> > +			ret = devm_gpio_request_one(dev, ch->gpio_vbus_pwr,
> > +					GPIOF_OUT_INIT_LOW, "vbus-pwr");
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +	} else if (gpio_is_valid(ch->gpio_id)) {
> > +		dev_err(dev, "Failed to get VBUS gpio\n");
> > +		return ch->gpio_vbus;
> > +	} else if (gpio_is_valid(ch->gpio_vbus)) {
> > +		dev_err(dev, "Failed to get ID gpio\n");
> > +		return ch->gpio_id;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* bind/unbind the peripheral controller */
> > +static int rcar_gen2_usb_set_peripheral(struct usb_otg *otg,
> > +					struct usb_gadget *gadget)
> > +{
> > +	otg->gadget = gadget;
> > +	if (!gadget) {
> > +		usb_gadget_vbus_disconnect(otg->gadget);
> 
> Since the otg->gadget is NULL, this driver should not call this function here.
Ah, yes you are correct!

> > +		otg->state = OTG_STATE_UNDEFINED;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int rcar_gen2_phy_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> < snip >
> > @@ -323,6 +540,14 @@ static int rcar_gen2_phy_probe(struct platform_device
> *pdev)
> >
> >  	dev_set_drvdata(dev, drv);
> >
> > +	/*
> > +	 * If we already have something plugged into USB0, we won't get an edge
> > +	 * on VBUS, so we have to manually schedule work to look at the VBUS
> > +	 * and ID signals.
> > +	 */
> > +	if (drv->channels->use_otg)
> > +		schedule_delayed_work(&drv->channels->work,
> msecs_to_jiffies(100));
> 
> This line is also "line over 80 characters".
I don't think it is necessary to force this into the 80 char recommendation.

> Best regards,
> Yoshihiro Shimoda
> 
> > +
> >  	return 0;
> >  }
> >
> > --
> > 1.9.1

Best regards
Phil
