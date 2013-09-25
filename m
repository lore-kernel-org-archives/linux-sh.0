From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 25 Sep 2013 13:02:11 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <5242DED3.1090303@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/24/2013 07:54 PM, Guennadi Liakhovetski wrote:
> Hi Valentine,
>

Hi Guennadi,

> On Tue, 24 Sep 2013, Valentine Barshak wrote:
>
>> This adds ADV7611/ADV7612 Dual Port Xpressview
>> 225 MHz HDMI Receiver support.
>>
>> The code is based on the ADV7604 driver, and ADV7612 patch
>> by Shinobu Uehara <shinobu.uehara.xc@renesas.com>
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>
> IIRC, Laurent is reviewing all new media I2C drivers, I added him to cc. A
> couple of minor comments from me too, while at it.

Thanks!

>
>> ---
>>   drivers/media/i2c/Kconfig   |   11 +
>>   drivers/media/i2c/Makefile  |    1 +
>>   drivers/media/i2c/adv761x.c | 1060 +++++++++++++++++++++++++++++++++++++++++++
>>   include/media/adv761x.h     |   28 ++
>>   4 files changed, 1100 insertions(+)
>>   create mode 100644 drivers/media/i2c/adv761x.c
>>   create mode 100644 include/media/adv761x.h
>>
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index d18be19..8eede00 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -206,6 +206,17 @@ config VIDEO_ADV7604
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called adv7604.
>>
>> +config VIDEO_ADV761X
>> +	tristate "Analog Devices ADV761X decoder"
>> +	depends on VIDEO_V4L2 && I2C
>> +	---help---
>> +	  Support for the Analog Devices ADV7611/ADV7612 video decoder.
>> +
>> +	  This is an Analog Devices Dual Port Xpressview HDMI Receiver.
>
> Are you sure this driver can handle all adv761x devices? One of the
> differences even between 7611 and 7612 is, that only 7612 is dual-port,
> 7611 is single-port. What about 7619?

It doesn't claim to support 7619. The help message says that only 
7611/7612 are supported. The driver doesn't support port B of the 7612
as it is not used on the h/w I have -- Just like the 7604 driver, this 
one is based on. This is a preliminary ADV761x support, and more 
functionality could be added later if needed (including 7619).

>
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called adv761x.
>> +
>>   config VIDEO_ADV7842
>>   	tristate "Analog Devices ADV7842 decoder"
>>   	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
>> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
>> index 9f462df..393eb0c 100644
>> --- a/drivers/media/i2c/Makefile
>> +++ b/drivers/media/i2c/Makefile
>> @@ -26,6 +26,7 @@ obj-$(CONFIG_VIDEO_ADV7183) += adv7183.o
>>   obj-$(CONFIG_VIDEO_ADV7343) += adv7343.o
>>   obj-$(CONFIG_VIDEO_ADV7393) += adv7393.o
>>   obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
>> +obj-$(CONFIG_VIDEO_ADV761X) += adv761x.o
>>   obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
>>   obj-$(CONFIG_VIDEO_AD9389B) += ad9389b.o
>>   obj-$(CONFIG_VIDEO_ADV7511) += adv7511.o
>> diff --git a/drivers/media/i2c/adv761x.c b/drivers/media/i2c/adv761x.c
>> new file mode 100644
>> index 0000000..bc3dfc3
>> --- /dev/null
>> +++ b/drivers/media/i2c/adv761x.c
>> @@ -0,0 +1,1060 @@
>> +/*
>> + * adv761x Analog Devices ADV761X HDMI receiver driver
>> + *
>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>> + * Copyright (C) 2013 Renesas Electronics Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/videodev2.h>
>> +#include <media/adv761x.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-ioctl.h>
>> +
>> +#define ADV761X_DRIVER_NAME "adv761x"
>> +
>> +/* VERT_FILTER_LOCKED and DE_REGEN_FILTER_LOCKED flags */
>> +#define ADV761X_HDMI_F_LOCKED(v)	(((v) & 0xa0) = 0xa0)
>> +
>> +/* Maximum supported resolution */
>> +#define ADV761X_MAX_WIDTH		1920
>> +#define ADV761X_MAX_HEIGHT		1080
>> +
>> +static int debug;
>> +module_param(debug, int, 0644);
>> +MODULE_PARM_DESC(debug, "debug level (0-2)");
>> +
>> +/* I2C map addresses */
>> +static u8 i2c_cec = 0x40;
>> +module_param(i2c_cec, byte, 0644);
>> +MODULE_PARM_DESC(i2c_cec, "CEC map 7-bit I2C address (default: 0x40)");
>> +
>> +static u8 i2c_inf = 0x3e;
>> +module_param(i2c_inf, byte, 0644);
>> +MODULE_PARM_DESC(i2c_inf, "InfoFrame map 7-bit I2C address (default: 0x3e)");
>> +
>> +static u8 i2c_dpll = 0x26;
>> +module_param(i2c_dpll, byte, 0644);
>> +MODULE_PARM_DESC(i2c_dpll, "DPLL map 7-bit I2C address (default: 0x20)");
>> +
>> +static u8 i2c_rep = 0x32;
>> +module_param(i2c_rep, byte, 0644);
>> +MODULE_PARM_DESC(i2c_rep, "Repeater map 7-bit I2C address (default: 0x32)");
>> +
>> +static u8 i2c_edid = 0x36;
>> +module_param(i2c_edid, byte, 0644);
>> +MODULE_PARM_DESC(i2c_edid, "EDID map 7-bit I2C address (default: 0x36)");
>> +
>> +static u8 i2c_hdmi = 0x34;
>> +module_param(i2c_hdmi, byte, 0644);
>> +MODULE_PARM_DESC(i2c_hdmi, "HDMI map 7-bit I2C address (default: 0x34)");
>> +
>> +static u8 i2c_cp = 0x22;
>> +module_param(i2c_cp, byte, 0644);
>> +MODULE_PARM_DESC(i2c_cp, "CP map 7-bit I2C address (default: 0x22)");
>
> Using module parameters has a disadvantage, that all instances of this
> driver will get the same values, and it is quite possible to have several
> HDMI receivers in a system, I believe? Wouldn't it be better to pass these
> addresses from the platform data / DT?

Yes, that doesn't look quite right, but I couldn't find a better 
solution ATM.

The problem is that this subdevice is going to be used by a soc_camera 
driver, and the soc_camera interface uses its own platform data for all 
I2C subdevices.
Thus, if I pass the I2C addresses in client->dev.platform_data here (as 
in adv7604), it's doing to be overwritten by the soc_camera_i2c_init() 
function with a soc_camera_subdev_desc data.

Not sure what the correct solution should be. Any suggestions are 
greatly appreciated.

>
>> +
>> +struct adv761x_color_format {
>> +	enum v4l2_mbus_pixelcode code;
>> +	enum v4l2_colorspace colorspace;
>> +};
>> +
>> +/* Supported color format list */
>> +static const struct adv761x_color_format adv761x_cfmts[] = {
>> +	{
>> +		.code		= V4L2_MBUS_FMT_RGB888_1X24,
>> +		.colorspace	= V4L2_COLORSPACE_SRGB,
>> +	},
>> +};
>> +
>> +/* ADV761X descriptor structure */
>> +struct adv761x_state {
>> +	struct v4l2_subdev			sd;
>> +	struct media_pad			pad;
>> +	struct v4l2_ctrl_handler		ctrl_hdl;
>> +
>> +	u8					edid[256];
>> +	unsigned				edid_blocks;
>> +	const struct adv761x_color_format	*cfmt;
>> +	u32					width;
>> +	u32					height;
>> +	enum v4l2_field				scanmode;
>> +
>> +	struct workqueue_struct			*work_queue;
>> +	struct delayed_work			enable_hotplug;
>> +
>> +	/* I2C clients */
>> +	struct i2c_client			*i2c_cec;
>> +	struct i2c_client			*i2c_infoframe;
>> +	struct i2c_client			*i2c_dpll;
>> +	struct i2c_client			*i2c_repeater;
>> +	struct i2c_client			*i2c_edid;
>> +	struct i2c_client			*i2c_hdmi;
>> +	struct i2c_client			*i2c_cp;
>> +};
>> +
>> +static inline struct v4l2_subdev *to_sd(struct v4l2_ctrl *ctrl)
>> +{
>> +	return &container_of(ctrl->handler, struct adv761x_state, ctrl_hdl)->sd;
>> +}
>> +
>> +static inline struct adv761x_state *to_state(struct v4l2_subdev *sd)
>> +{
>> +	return container_of(sd, struct adv761x_state, sd);
>> +}
>> +
>> +/* I2C I/O operations */
>> +static s32 adv_smbus_read_byte_data(struct i2c_client *client, u8 command)
>> +{
>> +	s32 ret, i;
>> +
>> +	for (i = 0; i < 3; i++) {
>> +		ret = i2c_smbus_read_byte_data(client, command);
>
> Uhm, why do you need to do this 3 times?... I see adv7842 does that too...
> but e.g. adv7604 dies this only for writing and not for reading...

Just thought it would be safe to retry in case of a failure.
Other drivers seem to retry I2C I/O as well. This is probably related to 
the possible cable issues. Not sure. Anyways, retrying doesn't seem to 
hurt, does it?

>
>> +		if (ret >= 0)
>> +			return ret;
>> +	}
>> +
>> +	v4l_err(client, "error reading addr:%02x reg:%02x\n",
>> +			client->addr, command);
>> +	return ret;
>> +}
>> +
>> +static s32 adv_smbus_write_byte_data(struct i2c_client *client,
>> +					u8 command, u8 value)
>> +{
>> +	s32 ret, i;
>> +
>> +	for (i = 0; i < 3; i++) {
>> +		ret = i2c_smbus_write_byte_data(client, command, value);
>
> ditto

Please see my comment above,
thanks.

>
>> +		if (!ret)
>> +			return 0;
>> +	}
>> +
>> +	v4l_err(client, "error writing addr:%02x reg:%02x val:%02x\n",
>> +			client->addr, command, value);
>> +	return ret;
>> +}
>
> [snip]
>
>> +static inline int edid_write_block(struct v4l2_subdev *sd,
>> +					unsigned len, const u8 *val)
>> +{
>> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
>> +	struct adv761x_state *state = to_state(sd);
>> +	int ret = 0;
>> +	int i;
>> +
>> +	v4l2_dbg(2, debug, sd, "writing EDID block (%d bytes)\n", len);
>> +
>> +	v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)0);
>> +
>> +	/* Disable I2C access to internal EDID ram from DDC port */
>> +	rep_write(sd, 0x74, 0x0);
>> +
>> +	for (i = 0; !ret && i < len; i += I2C_SMBUS_BLOCK_MAX)
>> +		ret = adv_smbus_write_i2c_block_data(state->i2c_edid, i,
>> +				I2C_SMBUS_BLOCK_MAX, val + i);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* adv761x calculates the checksums and enables I2C access
>> +	 * to internal EDID ram from DDC port.
>> +	 */
>> +	rep_write(sd, 0x74, 0x01);
>> +
>> +	for (i = 0; i < 1000; i++) {
>> +		if (rep_read(sd, 0x76) & 0x1) {
>> +			/* enable hotplug after 100 ms */
>> +			queue_delayed_work(state->work_queue,
>> +				&state->enable_hotplug, HZ / 10);
>> +			return 0;
>> +		}
>> +		schedule();
>
> This doesn't look pretty to me. Other drivers use at least an msleep(1)
> here, which doesn't look particularly exciting, but at least it makes some
> sense. Whereas a call to schedule() here doesn't really do much, I think.

IMHO msleep(1) looks even less pretty. In fact we can't use msleep for 
less than 20mS delays.
This is described in Documentation/timers/timers-howto.txt
On the other hand, schedule() does the exact same thing the msleep(1) 
would. It preempts the current task and gives other tasks a chance to 
run, giving as a small delay before re-reading EDID status.

>
>> +	}
>> +
>> +	v4l_err(client, "error enabling edid\n");
>> +	return -EIO;
>> +}
>
> [snip]
>
>> +static int adv761x_s_mbus_fmt(struct v4l2_subdev *sd,
>> +			  struct v4l2_mbus_framefmt *mf)
>> +{
>> +	struct adv761x_state *state = to_state(sd);
>> +	int i, ret;
>> +	u8 progressive;
>> +	u32 width;
>> +	u32 height;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(adv761x_cfmts); i++) {
>> +		if (mf->code = adv761x_cfmts[i].code) {
>> +			state->cfmt = &adv761x_cfmts[i];
>> +			break;
>> +		}
>> +	}
>> +	if (i >= ARRAY_SIZE(adv761x_cfmts))
>> +		return -EINVAL;
>> +
>> +	/* Get video information */
>> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
>> +	if (ret < 0) {
>> +		width		= ADV761X_MAX_WIDTH;
>> +		height		= ADV761X_MAX_HEIGHT;
>> +		progressive	= 1;
>> +	}
>> +
>> +	state->width = width;
>> +	state->height = height;
>> +	state->scanmode = (progressive) ?
>
> Superfluous parenthesis

Indeed, thanks!

>
>> +			V4L2_FIELD_NONE : V4L2_FIELD_INTERLACED;
>> +
>> +	mf->width = state->width;
>> +	mf->height = state->height;
>> +	mf->code = state->cfmt->code;
>> +	mf->field = state->scanmode;
>> +	mf->colorspace = state->cfmt->colorspace;
>> +
>> +	return 0;
>> +}
>
> [snip]
>
>> +static struct i2c_client *adv761x_dummy_client(struct v4l2_subdev *sd,
>> +							u8 addr, u8 io_reg)
>> +{
>> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
>> +
>> +	io_write(sd, io_reg, addr << 1);
>> +
>> +	return i2c_new_dummy(client->adapter, io_read(sd, io_reg) >> 1);
>
> Do you really have to re-read? Cannot you just use addr?

I can. don't see much of a difference, though, since it's only done once 
at start-up.

>
>> +}
>
> [snip]
>
>> +/* Power management operations */
>> +#ifdef CONFIG_PM_SLEEP
>> +static int adv761x_suspend(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>> +
>> +	/* Power off */
>> +	return io_write(sd, 0x0c, 0x62);
>> +}
>> +
>> +static int adv761x_resume(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>> +
>> +	/* Initializes ADV761X to its default values */
>> +	return adv761x_core_init(sd);
>
> What if a system was suspended during capture? Is this enough to resume it
> automatically?

Is it needed to auto-resume capture?
IIUC, adv7810 doesn't seem to do that in its resume callback.

Since not many decoder drivers seem to implement PM, we probably could 
drop it altogether for now (in case capture auto-resume is needed).

>
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(adv761x_pm_ops, adv761x_suspend, adv761x_resume);
>> +#define ADV761X_PM_OPS (&adv761x_pm_ops)
>> +#else	/* CONFIG_PM_SLEEP */
>> +#define ADV761X_PM_OPS NULL
>> +#endif	/* CONFIG_PM_SLEEP */
>> +
>> +static const struct i2c_device_id adv761x_id[] = {
>> +	{ ADV761X_DRIVER_NAME, 0 },
>> +	{},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, adv761x_id);
>> +
>> +static struct i2c_driver adv761x_driver = {
>> +	.driver = {
>> +		.owner	= THIS_MODULE,
>> +		.name	= ADV761X_DRIVER_NAME,
>> +		.pm	= ADV761X_PM_OPS,
>> +	},
>> +	.probe		= adv761x_probe,
>> +	.remove		= adv761x_remove,
>> +	.id_table	= adv761x_id,
>> +};
>> +
>> +module_i2c_driver(adv761x_driver);
>> +
>> +MODULE_DESCRIPTION("HDMI Receiver ADV761X video decoder driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/media/adv761x.h b/include/media/adv761x.h
>> new file mode 100644
>> index 0000000..e6e6aea
>> --- /dev/null
>> +++ b/include/media/adv761x.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * adv761x Analog Devices ADV761X HDMI receiver driver
>> + *
>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>> + * Copyright (C) 2013 Renesas Electronics Corporation
>> + *
>> + * This program is free software; you may redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> + * SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef _ADV761X_H_
>> +#define _ADV761X_H_
>> +
>> +/* notify events */
>> +#define ADV761X_HOTPLUG		1
>
> Is this header needed at all and - if so - does it have to be exported
> under include/ or would it be enough to put it under drivers/media/?

Well, the ADV761X_HOTPLUG is supposed to be used by a camera driver for 
hotplug notification events (as in adv7604). If we find a way to use 
platform data with soc_camera, it should go into this header as well.

>
>> +
>> +#endif	/* _ADV761X_H_ */
>> --
>> 1.8.3.1
>>
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>

Thanks,
Val.
