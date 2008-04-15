From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 15 Apr 2008 18:25:18 +0000
Subject: Re: [PATCH] input: support maple controller on SEGA Dreamcast
Message-Id: <20080415141746.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1203862726.6474.18.camel@localhost.localdomain> <1204057817.6388.5.camel@localhost.localdomain>
In-Reply-To: <1204057817.6388.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Adrian,

On Tue, Feb 26, 2008 at 08:30:17PM +0000, Adrian McMenamin wrote:
> This adds support for the maple controller (as a joystick) on the SEGA
> Dreamcast.
> 
> I've adjusted the polling rate for the controller in comparison to
> earlier patches and the high rate of polling was locking out hotplugging
> updates.
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

Sorry for sittign on the patches for so long, just catching up with
my long backlog... Several comments:

> +
> +struct dc_pad {
> +	struct input_dev *dev;
> +	struct maple_device *mdev;
> +	int open;

I don't see "open" being used.

> +	for (i = 0; i < 32; i++)
> +		if (data & (1<<i) && btn_bit[i] >= 0)
> +			pad->dev->keybit[BIT_WORD(BTN_JOYSTICK)] |= BIT_MASK(btn_bit[i]);
> +
> +	if (pad->dev->keybit[BTN_JOYSTICK/32])
> +		pad->dev->evbit[0] |= BIT_MASK(EV_KEY);
> +
> +	for (i = 0; i < 32; i++)
> +		if (data & (1<<i) && abs_bit[i] >= 0)
> +			pad->dev->absbit[0] |= BIT_MASK(abs_bit[i]);
> +
> +	if (pad->dev->absbit[0])
> +		pad->dev->evbit[0] |= BIT_MASK(EV_ABS);
> +

Just use dev->.. instead of pad->dev->.., it will save a few bytes.

> +	for (i = ABS_X; i <= ABS_BRAKE; i++) {
> +		pad->dev->absmax[i] = 255;
> +		pad->dev->absmin[i] = 0;
> +		pad->dev->absfuzz[i] = 0;
> +		pad->dev->absflat[i] = 0;
> +	}
> +

I like input_set_abs_params(...), it is more concise and you don't need a
separate loop to set up absbits.

> +	for (i = ABS_HAT0X; i <= ABS_HAT3Y; i++) {
> +		pad->dev->absmax[i] = 1;
> +		pad->dev->absmin[i] = -1;
> +		pad->dev->absfuzz[i] = 0;
> +		pad->dev->absflat[i] = 0;
> +	}
> +
> +	pad->dev->private = pad;
> +	pad->dev->event = NULL;
> +	pad->dev->dev.parent = &mdev->dev;
> +	pad->dev->name = mdev->product_name;
> +	pad->dev->id.bustype = BUS_HOST;
> +	input_set_drvdata(dev, pad);
> +
> +	error = input_register_device(pad->dev);
> +	if (error)
> +		goto fail_register;
> +
> +	maple_getcond_callback(mdev, dc_pad_callback, HZ/10,
> +		MAPLE_FUNC_CONTROLLER);
> +	

May I recommend creating maple_open and maple_close and start polling from
there? This way we only poll if we have users.

> +	return error;
> +
> +fail_register:
> +	input_free_device(pad->dev);
> +fail_nomem_2:
> +	kfree(pad);
> +fail_nomem_1:
> +	return -error;
> +}
> +
> +static void dc_pad_disconnect(struct maple_device *mdev)
> +{
> +	struct dc_pad *pad = mdev->private_data;
> +
> +	mdev->callback = NULL;
> +	input_unregister_device(pad->dev);
> +	kfree(pad);
> +}
> +
> +/* allow the controller to be used */
> +static int probe_maple_controller(struct device *dev)
> +{
> +	struct maple_device *mdev = to_maple_dev(dev);
> +	struct maple_driver *mdrv = to_maple_driver(dev->driver);
> +	int error;
> +
> +	error = dc_pad_connect(mdev);
> +	if (error)
> +		return error;
> +
> +	mdev->driver = mdrv;
> +
> +	return 0;
> +}
> +
> +static int remove_maple_controller(struct device *dev)
> +{
> +	struct maple_device *mdev = to_maple_dev(dev);
> +
> +	dc_pad_disconnect(mdev);
> +	return 0;
> +}
> +
> +static struct maple_driver dc_pad_driver = {
> +	.function =	MAPLE_FUNC_CONTROLLER,
> +	.connect =	dc_pad_connect,
> +	.disconnect =	dc_pad_disconnect,
> +	.drv = {
> +		.name = "Dreamcast_controller",
> +		.probe = probe_maple_controller,
> +		.remove = remove_maple_controller,
> +	},
> +};
> +
> +static int unplug_maple_control(struct device *dev, void *ignored)
> +{
> +	/* Please DO NOT really unplug your controller */
> +	struct maple_device *mdev;
> +
> +	mdev = to_maple_dev(dev);
> +	if ((mdev->function & MAPLE_FUNC_CONTROLLER)
> +		&& (mdev->driver = &dc_pad_driver))
> +		remove_maple_controller(dev);
> +
> +	return 0;
> +}
> +
> +static int __init dc_pad_init(void)
> +{
> +	return 	maple_driver_register(&dc_pad_driver.drv);
> +}
> +
> +static void __exit dc_pad_exit(void)
> +{
> +	bus_for_each_dev(&maple_bus_type, NULL, NULL, unplug_maple_control);

Why is this needed? As far as I know most driver core will automatically
disconnect devices form driver upon driver unregistration, so manually
iteracting through all devices on bus is not needed.

> +	driver_unregister(&dc_pad_driver.drv);
> +}
> +
> +module_init(dc_pad_init);
> +module_exit(dc_pad_exit);
> 
> 

Thank you.


-- 
Dmitry
