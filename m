From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 02 Jul 2015 12:45:37 +0000
Subject: RE: [PATCH 2/3] phy: rcar-gen2 usb: Add Host/Function switching for USB0
Message-Id: <SIXPR06MB063948BDAB85B90A13EA8818F5970@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434984151-27274-1-git-send-email-phil.edworthy@renesas.com>
 <1434984151-27274-3-git-send-email-phil.edworthy@renesas.com>
 <5594F4C4.2030700@ti.com>
In-Reply-To: <5594F4C4.2030700@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Kishon,

On 02 July 2015 09:22, Kishon wrote:
> Hi,
> 
> On Monday 22 June 2015 08:12 PM, Phil Edworthy wrote:
> > Instead of statically selecting the PHY connection to either the
> > USBHS (Function) or PCI0 (Host) IP blocks, this change allows the
> > dts to specifiy gpio pins for the vbus and id signals. Additional
> > gpio pins are used to control power to an external OTG device and
> > an override to turn vbus on/off.
> >
> > Note: the R-Car USB PHY only allows this Host/Function switching
> > on channel 0.
> >
> > This has been tested on a r8a7791 based Koelsch board, which uses
> > a MAX3355 device to supply vbus power when needed.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  drivers/phy/phy-rcar-gen2.c | 269
> ++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 247 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
> > index 97d45f4..8564e7d 100644
> > --- a/drivers/phy/phy-rcar-gen2.c
> > +++ b/drivers/phy/phy-rcar-gen2.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Renesas R-Car Gen2 PHY driver
> > + * Renesas R-Car Gen2 USB PHY driver
> >   *
> >   * Copyright (C) 2014 Renesas Solutions Corp.
> >   * Copyright (C) 2014 Cogent Embedded, Inc.
> > @@ -12,11 +12,16 @@
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/usb/gadget.h>
> > +#include <linux/usb/otg.h>
> > +#include <linux/workqueue.h>
> >
> >  #include <asm/cmpxchg.h>
> >
> > @@ -58,6 +63,18 @@ struct rcar_gen2_channel {
> >  	struct rcar_gen2_phy phys[PHYS_PER_CHANNEL];
> >  	int selected_phy;
> >  	u32 select_mask;
> > +
> > +	/* external power enable pin */
> > +	int			gpio_pwr;
> > +
> > +	/* Host/Function switching */
> > +	struct delayed_work	work;
> > +	int			use_otg;
> > +	int			gpio_vbus;
> > +	int			gpio_id;
> > +	int			gpio_vbus_pwr;
> > +	struct usb_phy		*usbphy;
> 
> Using usb_phy is a step backwards IMO. We should rather try to get the missing
> functionality adding in Generic PHY.
Ok, that will take quite a bit more work. Do you know if anyone is working on this?

> Thanks
> Kishon
> 
> > +	struct usb_otg		*otg;
> >  };
> >
> >  struct rcar_gen2_phy_driver {
> > @@ -68,31 +85,50 @@ struct rcar_gen2_phy_driver {
> >  	struct rcar_gen2_channel *channels;
> >  };
> >
> > -static int rcar_gen2_phy_init(struct phy *p)
> > +static void rcar_gen2_phy_switch(struct rcar_gen2_channel *channel,
> > +	u32 select_value)
> >  {
> > -	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
> > -	struct rcar_gen2_channel *channel = phy->channel;
> >  	struct rcar_gen2_phy_driver *drv = channel->drv;
> >  	unsigned long flags;
> >  	u32 ugctrl2;
> >
> > -	/*
> > -	 * Try to acquire exclusive access to PHY.  The first driver calling
> > -	 * phy_init()  on a given channel wins, and all attempts  to use another
> > -	 * PHY on this channel will fail until phy_exit() is called by the first
> > -	 * driver.   Achieving this with cmpxcgh() should be SMP-safe.
> > -	 */
> > -	if (cmpxchg(&channel->selected_phy, -1, phy->number) != -1)
> > -		return -EBUSY;
> > -
> > -	clk_prepare_enable(drv->clk);
> > -
> >  	spin_lock_irqsave(&drv->lock, flags);
> >  	ugctrl2 = readl(drv->base + USBHS_UGCTRL2);
> >  	ugctrl2 &= ~channel->select_mask;
> > -	ugctrl2 |= phy->select_value;
> > +	ugctrl2 |= select_value;
> >  	writel(ugctrl2, drv->base + USBHS_UGCTRL2);
> >  	spin_unlock_irqrestore(&drv->lock, flags);
> > +}
> > +
> > +static int rcar_gen2_phy_init(struct phy *p)
> > +{
> > +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
> > +	struct rcar_gen2_channel *channel = phy->channel;
> > +	struct rcar_gen2_phy_driver *drv = channel->drv;
> > +
> > +	if (!channel->use_otg) {
> > +		/*
> > +		 * Static Host/Function role.
> > +		 * Try to acquire exclusive access to PHY. The first driver
> > +		 * calling phy_init() on a given channel wins, and all attempts
> > +		 * to use another PHY on this channel will fail until
> > +		 * phy_exit() is called by the first driver. Achieving this
> > +		 * with cmpxcgh() should be SMP-safe.
> > +		 */
> > +		if (cmpxchg(&channel->selected_phy, -1, phy->number) != -1)
> > +			return -EBUSY;
> > +
> > +		clk_prepare_enable(drv->clk);
> > +		rcar_gen2_phy_switch(channel, phy->select_value);
> > +	} else {
> > +		/*
> > +		 * Using Host/Function switching, so schedule work to determine
> > +		 * which role to use.
> > +		 */
> > +		clk_prepare_enable(drv->clk);
> > +		schedule_delayed_work(&channel->work, 100);
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -117,9 +153,9 @@ static int rcar_gen2_phy_power_on(struct phy *p)
> >  	u32 value;
> >  	int err = 0, i;
> >
> > -	/* Skip if it's not USBHS */
> > -	if (phy->select_value != USBHS_UGCTRL2_USB0SEL_HS_USB)
> > -		return 0;
> > +	/* Optional external power pin */
> > +	if (gpio_is_valid(phy->channel->gpio_pwr))
> > +		gpio_direction_output(phy->channel->gpio_pwr, 1);
> >
> >  	spin_lock_irqsave(&drv->lock, flags);
> >
> > @@ -160,9 +196,9 @@ static int rcar_gen2_phy_power_off(struct phy *p)
> >  	unsigned long flags;
> >  	u32 value;
> >
> > -	/* Skip if it's not USBHS */
> > -	if (phy->select_value != USBHS_UGCTRL2_USB0SEL_HS_USB)
> > -		return 0;
> > +	/* External power pin */
> > +	if (gpio_is_valid(phy->channel->gpio_pwr))
> > +		gpio_direction_output(phy->channel->gpio_pwr, 0);
> >
> >  	spin_lock_irqsave(&drv->lock, flags);
> >
> > @@ -236,6 +272,132 @@ static const u32 select_value[][PHYS_PER_CHANNEL]
> = {
> >  	[2]	= { USBHS_UGCTRL2_USB2SEL_PCI,
> USBHS_UGCTRL2_USB2SEL_USB30 },
> >  };
> >
> > +
> > +#define VBUS_IRQ_FLAGS \
> > +	(IRQF_SHARED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)
> > +
> > +static void gpio_vbus_work(struct work_struct *work)
> > +{
> > +	struct rcar_gen2_channel *channel = container_of(work,
> > +					struct rcar_gen2_channel, work.work);
> > +	struct usb_phy *usbphy = channel->usbphy;
> > +	int status, vbus, id;
> > +
> > +	vbus = !!gpio_get_value(channel->gpio_vbus);
> > +	id = !!gpio_get_value(channel->gpio_id);
> > +
> > +	/* Switch the PHY over */
> > +	if (id)
> > +		rcar_gen2_phy_switch(channel,
> USBHS_UGCTRL2_USB0SEL_HS_USB);
> > +	else
> > +		rcar_gen2_phy_switch(channel,
> USBHS_UGCTRL2_USB0SEL_PCI);
> > +
> > +	/* If VBUS is powered and we are not the initial Host, turn off VBUS */
> > +	if (gpio_is_valid(channel->gpio_vbus_pwr))
> > +		gpio_direction_output(channel->gpio_vbus_pwr, !(id && vbus));
> > +
> > +	if (!channel->otg->gadget)
> > +		return;
> > +
> > +	/* Function handling: vbus=1 when initially plugged into a Host */
> > +	if (vbus) {
> > +		status = USB_EVENT_VBUS;
> > +		usbphy->otg->state = OTG_STATE_B_PERIPHERAL;
> > +		usbphy->last_event = status;
> > +		usb_gadget_vbus_connect(usbphy->otg->gadget);
> > +
> > +		atomic_notifier_call_chain(&usbphy->notifier,
> > +					   status, usbphy->otg->gadget);
> > +	} else {
> > +		usb_gadget_vbus_disconnect(usbphy->otg->gadget);
> > +		status = USB_EVENT_NONE;
> > +		usbphy->otg->state = OTG_STATE_B_IDLE;
> > +		usbphy->last_event = status;
> > +
> > +		atomic_notifier_call_chain(&usbphy->notifier,
> > +					   status, usbphy->otg->gadget);
> > +	}
> > +}
> > +
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
> > +	ch->gpio_id = of_get_named_gpio_flags(dev->of_node, "renesas,id",
> > +				0, NULL);
> > +	ch->gpio_vbus = of_get_named_gpio_flags(dev->of_node,
> "renesas,vbus",
> > +				0, NULL);
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
> > +						"renesas,vbus-pwr", 0, NULL);
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
> > +		otg->state = OTG_STATE_UNDEFINED;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int rcar_gen2_phy_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -245,7 +407,9 @@ static int rcar_gen2_phy_probe(struct platform_device
> *pdev)
> >  	struct resource *res;
> >  	void __iomem *base;
> >  	struct clk *clk;
> > +	struct usb_otg *otg;
> >  	int i = 0;
> > +	int err;
> >
> >  	if (!dev->of_node) {
> >  		dev_err(dev,
> > @@ -280,6 +444,57 @@ static int rcar_gen2_phy_probe(struct platform_device
> *pdev)
> >  	if (!drv->channels)
> >  		return -ENOMEM;
> >
> > +	/* USB0 optional GPIO power pin for external devices */
> > +	drv->channels->gpio_pwr = of_get_named_gpio_flags(dev->of_node,
> > +						"renesas,pwr", 0, NULL);
> > +	if (drv->channels->gpio_pwr = -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> > +	if (gpio_is_valid(drv->channels->gpio_pwr)) {
> > +		err = devm_gpio_request(dev, drv->channels->gpio_pwr,
> "pwr");
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	/* USB0 Host/Function switching info */
> > +	err = probe_otg(pdev, drv);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * The PHY connected to channel 0 can be used to steer signals to the
> > +	 * USB Host IP that stils behind a PCI bridge (pci0), or the USB Func
> > +	 * IP (hsusb). We can dynamically switch this based on VBUS and ID
> > +	 * signals connected to gpios, to get something approaching OTG.
> > +	 */
> > +	if (drv->channels->use_otg) {
> > +		struct usb_phy *usbphy;
> > +
> > +		usbphy = devm_kzalloc(dev, sizeof(*usbphy), GFP_KERNEL);
> > +		if (!usbphy)
> > +			return -ENOMEM;
> > +
> > +		otg = devm_kzalloc(dev, sizeof(*otg), GFP_KERNEL);
> > +		if (!otg)
> > +			return -ENOMEM;
> > +
> > +		usbphy->dev		= dev;
> > +		usbphy->otg		= otg;
> > +
> > +		otg->usb_phy		= usbphy;
> > +		otg->state		= OTG_STATE_UNDEFINED;
> > +		otg->set_peripheral	= rcar_gen2_usb_set_peripheral;
> > +
> > +		drv->channels->otg	= otg;
> > +		drv->channels->usbphy	= usbphy;
> > +
> > +		ATOMIC_INIT_NOTIFIER_HEAD(&usbphy->notifier);
> > +
> > +		INIT_DELAYED_WORK(&drv->channels->work, gpio_vbus_work);
> > +
> > +		usb_add_phy_dev(usbphy);
> > +	}
> > +
> >  	for_each_child_of_node(dev->of_node, np) {
> >  		struct rcar_gen2_channel *channel = drv->channels + i;
> >  		u32 channel_num;
> > @@ -288,6 +503,8 @@ static int rcar_gen2_phy_probe(struct platform_device
> *pdev)
> >  		channel->of_node = np;
> >  		channel->drv = drv;
> >  		channel->selected_phy = -1;
> > +		if (i != 0)
> > +			channel->gpio_pwr = -ENOENT;
> >
> >  		error = of_property_read_u32(np, "reg", &channel_num);
> >  		if (error || channel_num > 2) {
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
> > +
> >  	return 0;
> >  }

Thanks
Phil
