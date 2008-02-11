From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 11 Feb 2008 16:13:55 +0000
Subject: Re: [PATCH 1/2] SH/Dreamcast - joystick (Control pad)
Message-Id: <20080211110202.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain>
In-Reply-To: <1202684222.6237.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Adrian,

On Sun, Feb 10, 2008 at 10:57:01PM +0000, Adrian McMenamin wrote:
> +
> +static int dc_pad_open(struct input_dev *dev)
> +{
> +	struct dc_pad *pad = dev->private;
> +	pad->open++;
> +	return 0;
> +}
> +
> +static void dc_pad_close(struct input_dev *dev)
> +{
> +	struct dc_pad *pad = dev->private;
> +	pad->open--;
> +}

What is the point of the above 2 functions?

> +
> +static int dc_pad_connect(struct maple_device *mdev)
> +{
> +	int i, error;
> +	unsigned long data = be32_to_cpu(mdev->devinfo.function_data[0]);
> +	struct dc_pad *pad;
> +	struct input_dev *dev;
> +
> +	const short btn_bit[32] = {
> +		BTN_C, BTN_B, BTN_A, BTN_START, -1, -1, -1, -1,
> +		BTN_Z, BTN_Y, BTN_X, BTN_SELECT, -1, -1, -1, -1,
> +		-1, -1, -1, -1, -1, -1, -1, -1,
> +		-1, -1, -1, -1, -1, -1, -1, -1,
> +	};
> +
> +	const short abs_bit[32] = {
> +		-1, -1, -1, -1, ABS_HAT0Y, ABS_HAT0Y, ABS_HAT0X, ABS_HAT0X,
> +		-1, -1, -1, -1, ABS_HAT1Y, ABS_HAT1Y, ABS_HAT1X, ABS_HAT1X,
> +		ABS_GAS, ABS_BRAKE, ABS_X, ABS_Y, ABS_RX, ABS_RY, -1, -1,
> +		-1, -1, -1, -1, -1, -1, -1, -1,
> +	};
> +
> +	pad = kzalloc(sizeof(struct dc_pad), GFP_KERNEL);
> +	if (!pad)
> +		return -ENOMEM;
> +
> +	dev = input_allocate_device();
> +	if (!dev) {
> +		kfree(pad);
> +		return -ENOMEM;
> +	}
> +
> +	pad->dev = dev;
> +
> +	mdev->private_data = pad;
> +
> +	for (i = 0; i < 32; i++)
> +		if (data & (1<<i) && btn_bit[i] >= 0)
> +			pad->dev->keybit[BTN_JOYSTICK/32] |= BIT(btn_bit[i]);
> +
> +	if (pad->dev->keybit[BTN_JOYSTICK/32])
> +		pad->dev->evbit[0] |= BIT(EV_KEY);
> +
> +	for (i = 0; i < 32; i++)
> +		if (data&(1<<i) && abs_bit[i] >= 0)
> +			pad->dev->absbit[0] |= BIT(abs_bit[i]);
> +
> +	if (pad->dev->absbit[0])
> +		pad->dev->evbit[0] |= BIT(EV_ABS);
> +
> +	for (i = ABS_X; i <= ABS_BRAKE; i++) {
> +		pad->dev->absmax[i] = 255;
> +		pad->dev->absmin[i] = 0;
> +		pad->dev->absfuzz[i] = 0;
> +		pad->dev->absflat[i] = 0;
> +	}
> +
> +	for (i = ABS_HAT0X; i <= ABS_HAT3Y; i++) {
> +		pad->dev->absmax[i] = 1;
> +		pad->dev->absmin[i] = -1;
> +		pad->dev->absfuzz[i] = 0;
> +		pad->dev->absflat[i] = 0;
> +	}
> +
> +	pad->dev->private = pad;

input_set_drvdata().. Oh, wait, you are doing it below...

> +	pad->dev->open = dc_pad_open;
> +	pad->dev->close = dc_pad_close;
> +	pad->dev->event = NULL;

input_dev is zeroes upon initialization, no need to set unused methods
to NULL. Also please consider using a temp for input_dev, it should
reduce generated code a bit.

> +	pad->dev->dev.parent = &mdev->dev;
> +	pad->dev->name = mdev->product_name;
> +	pad->dev->id.bustype = BUS_HOST;
> +	input_set_capability(pad->dev, EV_ABS, MSC_SCAN);

I did not see the driver reporting MSC_SCAN events. Also, MSC_SCAN is
usually reprted as EV_MSC, not EV_ABS.

> +	input_set_drvdata(dev, pad);
> +
> +	error = input_register_device(pad->dev);
> +	if (error) {
> +		input_free_device(pad->dev);
> +		kfree(pad);
> +		return -ENODEV;

		return error;

There is no reason to "hide" real error reported by input_register_device.

> +	}
> +
> +	maple_getcond_callback(mdev, dc_pad_callback, HZ/50,
> +		MAPLE_FUNC_CONTROLLER);

Hmm, this could probably go into dc_pad_open so we dont poll hardware
if there are no users.

> +
> +	return 0;
> +}
> +
> +static void dc_pad_disconnect(struct maple_device *mdev)
> +{
> +	struct dc_pad *pad = mdev->private_data;
> +

Don't you need to stop polling callback? Either here ot in dc_pad_stop,
depending on where maple_getcond_callback() is.

> +	input_unregister_device(pad->dev);
> +	kfree(pad);
> +}
> +

-- 
Dmitry
