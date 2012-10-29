From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 29 Oct 2012 07:52:19 +0000
Subject: Re: [PATCH 2/2] media: V4L2: support asynchronous subdevice registration
Message-Id: <Pine.LNX.4.64.1210290841200.17869@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210200007580.28993@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210200007580.28993@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, 28 Oct 2012, Sylwester Nawrocki wrote:

> Hi,
> 
> On 10/24/2012 03:54 PM, Guennadi Liakhovetski wrote:
> > On Sat, 20 Oct 2012, Guennadi Liakhovetski wrote:
> > 
> >> Currently bridge device drivers register devices for all subdevices
> >> synchronously, tupically, during their probing. E.g. if an I2C CMOS sensor
> >> is attached to a video bridge device, the bridge driver will create an I2C
> >> device and wait for the respective I2C driver to probe. This makes linking
> >> of devices straight forward, but this approach cannot be used with
> >> intrinsically asynchronous and unordered device registration systems like
> >> the Flattened Device Tree. To support such systems this patch adds an
> >> asynchronous subdevice registration framework to V4L2. To use it respective
> >> (e.g. I2C) subdevice drivers must request deferred probing as long as their
> >> bridge driver hasn't probed. The bridge driver during its probing submits a
> >> an arbitrary number of subdevice descriptor groups to the framework to
> >> manage. After that it can add callbacks to each of those groups to be
> >> called at various stages during subdevice probing, e.g. after completion.
> >> Then the bridge driver can request single groups to be probed, finish its
> >> own probing and continue its video subsystem configuration from its
> >> callbacks.
> >>
> >> Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> > 
> > Sorry, I did indeed forget to include you on CC for this patch as promised
> > in https://lkml.org/lkml/2012/10/17/306. In the patch below just look for
> > the only occurrance of the device_release_driver() / device_attach(). In
> > your mail you said, that only bus drivers should do this. In fact this is
> > indeed what is happening here. A device is attached to two busses:
> > (typically) I2C and "media." And the code below is called when the device
> > is detached from the media bus.
> > 
> > Thanks
> > Guennadi
> > 
> >> ---
> >>
> >> One more thing to note about this patch. Subdevice drivers, supporting
> >> asynchronous probing, and using this framework, need a unified way to
> >> detect, whether their probing should succeed or they should request
> >> deferred probing. I implement this using device platform data. This means,
> >> that all subdevice drivers, wishing to use this API will have to use the
> >> same platform data struct. I don't think this is a major inconvenience,
> >> but if we decide against this, we'll have to add a V4L2 function to verify
> >> "are you ready for me or not." The latter would be inconvenient, because
> >> then we would have to look through all registered subdevice descriptor
> >> groups for this specific subdevice.
> >>
> >>   drivers/media/v4l2-core/Makefile      |    3 +-
> >>   drivers/media/v4l2-core/v4l2-async.c  |  249 +++++++++++++++++++++++++++++++++
> >>   drivers/media/v4l2-core/v4l2-device.c |    2 +
> >>   include/media/v4l2-async.h            |   88 ++++++++++++
> >>   include/media/v4l2-device.h           |    6 +
> >>   include/media/v4l2-subdev.h           |   16 ++
> >>   6 files changed, 363 insertions(+), 1 deletions(-)
> >>   create mode 100644 drivers/media/v4l2-core/v4l2-async.c
> >>   create mode 100644 include/media/v4l2-async.h
> >>
> >> diff --git a/drivers/media/v4l2-core/Makefile b/drivers/media/v4l2-core/Makefile
> >> index cb5fede..074e01c 100644
> >> --- a/drivers/media/v4l2-core/Makefile
> >> +++ b/drivers/media/v4l2-core/Makefile
> >> @@ -5,7 +5,8 @@
> >>   tuner-objs	:=	tuner-core.o
> >>
> >>   videodev-objs	:=	v4l2-dev.o v4l2-ioctl.o v4l2-device.o v4l2-fh.o \
> >> -			v4l2-event.o v4l2-ctrls.o v4l2-subdev.o v4l2-clk.o
> >> +			v4l2-event.o v4l2-ctrls.o v4l2-subdev.o v4l2-clk.o \
> >> +			v4l2-async.o
> >>   ifeq ($(CONFIG_COMPAT),y)
> >>     videodev-objs += v4l2-compat-ioctl32.o
> >>   endif
> >> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> >> new file mode 100644
> >> index 0000000..871f116
> >> --- /dev/null
> >> +++ b/drivers/media/v4l2-core/v4l2-async.c
> >> @@ -0,0 +1,249 @@
> >> +/*
> >> + * V4L2 asynchronous subdevice registration API
> >> + *
> >> + * Copyright (C) 2012, Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +#include<linux/device.h>
> >> +#include<linux/err.h>
> >> +#include<linux/i2c.h>
> >> +#include<linux/list.h>
> >> +#include<linux/module.h>
> >> +#include<linux/mutex.h>
> >> +#include<linux/notifier.h>
> >> +#include<linux/platform_device.h>
> >> +#include<linux/slab.h>
> >> +#include<linux/types.h>
> >> +
> >> +#include<media/v4l2-async.h>
> >> +#include<media/v4l2-device.h>
> >> +#include<media/v4l2-subdev.h>
> >> +
> >> +static bool match_i2c(struct device *dev, struct v4l2_async_hw_device *hw_dev)
> >> +{
> >> +	struct i2c_client *client = to_i2c_client(dev);
> >> +	return hw_dev->bus_type = V4L2_ASYNC_BUS_I2C&&
> >> +		hw_dev->match.i2c.adapter_id = client->adapter->nr&&
> >> +		hw_dev->match.i2c.address = client->addr;
> >> +}
> >> +
> >> +static bool match_platform(struct device *dev, struct v4l2_async_hw_device *hw_dev)
> >> +{
> >> +	return hw_dev->bus_type = V4L2_ASYNC_BUS_PLATFORM&&
> >> +		!strcmp(hw_dev->match.platform.name, dev_name(dev));
> >> +}
> >> +
> >> +/*
> >> + * I think, notifiers on different busses can run concurrently, so, we have to
> >> + * protect common data, e.g. sub-device lists.
> >> + */
> >> +static int async_notifier_cb(struct v4l2_async_group *group,
> >> +		unsigned long action, struct device *dev,
> >> +		bool (*match)(struct device *, struct v4l2_async_hw_device *))
> >> +{
> >> +	struct v4l2_device *v4l2_dev = group->v4l2_dev;
> >> +	struct v4l2_async_subdev *asd;
> >> +	bool done;
> >> +	int ret;
> >> +
> >> +	if (action != BUS_NOTIFY_BOUND_DRIVER&&
> >> +	    action != BUS_NOTIFY_BIND_DRIVER)
> >> +		return NOTIFY_DONE;
> >> +
> >> +	/* Asynchronous: have to lock */
> >> +	mutex_lock(&v4l2_dev->group_lock);
> >> +
> >> +	list_for_each_entry(asd,&group->group, list) {
> >> +		if (match(dev,&asd->hw))
> >> +			break;
> >> +	}
> >> +
> >> +	if (&asd->list =&group->group) {
> >> +		/* Not our device */
> >> +		mutex_unlock(&v4l2_dev->group_lock);
> >> +		return NOTIFY_DONE;
> >> +	}
> >> +
> >> +	asd->dev = dev;
> >> +
> >> +	if (action = BUS_NOTIFY_BIND_DRIVER) {
> >> +		/*
> >> +		 * Provide platform data to the driver: it can complete probing
> >> +		 * now.
> >> +		 */
> >> +		dev->platform_data =&asd->sdpd;
> >> +		mutex_unlock(&v4l2_dev->group_lock);
> >> +		if (group->bind_cb)
> >> +			group->bind_cb(group, asd);
> >> +		return NOTIFY_OK;
> >> +	}
> >> +
> >> +	/* BUS_NOTIFY_BOUND_DRIVER */
> >> +	if (asd->hw.bus_type = V4L2_ASYNC_BUS_I2C)
> >> +		asd->sdpd.subdev = i2c_get_clientdata(to_i2c_client(dev));
> >> +	/*
> >> +	 * Non-I2C subdevice drivers should take care to assign their subdevice
> >> +	 * pointers
> >> +	 */
> >> +	ret = v4l2_device_register_subdev(v4l2_dev,
> >> +					  asd->sdpd.subdev);
> >> +	if (ret<  0) {
> >> +		mutex_unlock(&v4l2_dev->group_lock);
> >> +		/* FIXME: error, clean up world? */
> >> +		dev_err(dev, "Failed registering a subdev: %d\n", ret);
> >> +		return NOTIFY_OK;
> >> +	}
> >> +	list_move(&asd->list,&group->done);
> >> +
> >> +	/* Client probed&  all subdev drivers collected */
> >> +	done = list_empty(&group->group);
> >> +
> >> +	mutex_unlock(&v4l2_dev->group_lock);
> >> +
> >> +	if (group->bound_cb)
> >> +		group->bound_cb(group, asd);
> >> +
> >> +	if (done&&  group->complete_cb)
> >> +		group->complete_cb(group);
> >> +
> >> +	return NOTIFY_OK;
> >> +}
> >> +
> >> +static int platform_cb(struct notifier_block *nb,
> >> +		       unsigned long action, void *data)
> >> +{
> >> +	struct device *dev = data;
> >> +	struct v4l2_async_group *group = container_of(nb, struct v4l2_async_group,
> >> +						     platform_notifier);
> >> +
> >> +	return async_notifier_cb(group, action, dev, match_platform);
> >> +}
> >> +
> >> +static int i2c_cb(struct notifier_block *nb,
> >> +		  unsigned long action, void *data)
> >> +{
> >> +	struct device *dev = data;
> >> +	struct v4l2_async_group *group = container_of(nb, struct v4l2_async_group,
> >> +						     i2c_notifier);
> >> +
> >> +	return async_notifier_cb(group, action, dev, match_i2c);
> >> +}
> >> +
> >> +/*
> >> + * Typically this function will be called during bridge driver probing. It
> >> + * installs bus notifiers to handle asynchronously probing subdevice drivers.
> >> + * Once the bridge driver probing completes, subdevice drivers, waiting in
> >> + * EPROBE_DEFER state are re-probed, at which point they get their platform
> >> + * data, which allows them to complete probing.
> >> + */
> >> +int v4l2_async_group_probe(struct v4l2_async_group *group)
> >> +{
> >> +	struct v4l2_async_subdev *asd, *tmp;
> >> +	bool i2c_used = false, platform_used = false;
> >> +	int ret;
> >> +
> >> +	/* This group is inactive so far - no notifiers yet */
> >> +	list_for_each_entry_safe(asd, tmp,&group->group, list) {
> >> +		if (asd->sdpd.subdev) {
> >> +			/* Simulate a BIND event */
> >> +			if (group->bind_cb)
> >> +				group->bind_cb(group, asd);
> >> +
> 
> Still we can't be sure at this moment asd->sdpd.subdev's driver is
> valid and not unloaded, can we ? 
> 
> In the case when a sub-device driver is probed after the host driver
> (a caller of this function) I assume doing
> 
> 	asd->sdpd.subdev = i2c_get_clientdata(to_i2c_client(dev));
> 	...
> 	ret = v4l2_device_register_subdev(v4l2_dev, asd->sdpd.subdev);
> 
> is safe, because it is done in the i2c bus notifier callback itself,
> i.e. under device_lock(dev). 
> 
> But for these already probed sub-devices, how do we prevent races from 
> subdev module unloading ? By not setting CONFIG_MODULE_UNLOAD?... ;)

Right, I also think there's a race there. I have a solution for it - in 
the current mainline version of sh_mobile_ceu_camera.c look at the code 
around the line

		err = bus_register_notifier(&platform_bus_type, &wait.notifier);

sh_mobile_ceu_probe(). I think, that guarantees, that we either lock the 
module _safely_ in memory per try_module_get(dev->driver->owner) or get 
notified, that the module is unavailable. It looks ugly, but I don't have 
a better solution ATM. We could do the same here too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
