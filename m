From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 25 Sep 2013 12:33:25 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <5242D815.8060406@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/24/2013 06:17 PM, Hans Verkuil wrote:
> Hi Valentine,
>

Hi Hans,

> On Tue 24 September 2013 15:38:34 Valentine Barshak wrote:
>> This adds ADV7611/ADV7612 Dual Port Xpressview
>> 225 MHz HDMI Receiver support.
>>
>> The code is based on the ADV7604 driver, and ADV7612 patch
>> by Shinobu Uehara <shinobu.uehara.xc@renesas.com>
>
> Thanks for the patch!
>
> I have a few review comments below:
>

Thanks for taking the time to look at it!

>>

[]

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
> Don't use module options for the i2c addresses. Instead use platform_data.
> Boards may have multiple adv761x devices behind e.g. a i2c muxer, so
> relying on module options isn't the right method.
>

Yes, that doesn't look quite right, but I couldn't find a better 
solution ATM.

The problem is that this subdevice is going to be used by a soc_camera 
driver and the soc_camera interface uses its own platform data for all 
I2C subdevices.
Thus, if I pass the I2C addresses in client->dev.platform_data here (as 
in adv7604), It's doing to be overwritten by the soc_camera_i2c_init() 
function with a soc_camera_subdev_desc data.

Not sure what the correct solution should be. Any suggestions are 
greatly appreciated.

>> +
>> +struct adv761x_color_format {
>> +	enum v4l2_mbus_pixelcode code;
>> +	enum v4l2_colorspace colorspace;
>> +};
>> +

[]

>> +static int adv761x_g_input_status(struct v4l2_subdev *sd, u32 *status)
>> +{
>> +	int ret;
>> +
>> +	ret = hdmi_read(sd, 0x07);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*status = ADV761X_HDMI_F_LOCKED(ret) ? 0 : V4L2_IN_ST_NO_SIGNAL;
>> +	return 0;
>> +}
>> +
>> +static int adv761x_cropcap(struct v4l2_subdev *sd, struct v4l2_cropcap *a)
>> +{
>> +	u8 progressive;
>> +	u32 width;
>> +	u32 height;
>> +	int ret;
>> +
>> +	/* cropping limits */
>> +	a->bounds.left			= 0;
>> +	a->bounds.top			= 0;
>> +
>> +	/* get video information */
>> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
>> +	if (ret < 0) {
>> +		a->bounds.width		= ADV761X_MAX_WIDTH;
>> +		a->bounds.height	= ADV761X_MAX_HEIGHT;
>> +	} else {
>> +		a->bounds.width		= width;
>> +		a->bounds.height	= height;
>> +	}
>> +
>> +	/* default cropping rectangle */
>> +	a->defrect			= a->bounds;
>> +
>> +	/* does not support scaling */
>> +	a->pixelaspect.numerator	= 1;
>> +	a->pixelaspect.denominator	= 1;
>> +	a->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int adv761x_g_crop(struct v4l2_subdev *sd, struct v4l2_crop *a)
>> +{
>> +	u8 progressive;
>> +	u32 width;
>> +	u32 height;
>> +	int ret;
>> +
>> +	a->c.left	= 0;
>> +	a->c.top	= 0;
>> +
>> +	/* Get video information */
>> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
>> +	if (ret < 0) {
>> +		a->c.width	= ADV761X_MAX_WIDTH;
>> +		a->c.height	= ADV761X_MAX_HEIGHT;
>> +	} else {
>> +		a->c.width	= width;
>> +		a->c.height	= height;
>> +	}
>> +
>> +	a->type		= V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +
>> +	return 0;
>> +}
>
> Why are cropcap and g_crop implemented if there is no actual cropping
> supported?

Yes, looks like this can be dropped.

>
>> +
>> +static int adv761x_g_mbus_fmt(struct v4l2_subdev *sd,
>> +			  struct v4l2_mbus_framefmt *mf)
>> +{
>> +	struct adv761x_state *state = to_state(sd);
>> +
>> +	mf->width = state->width;
>> +	mf->height = state->height;
>> +	mf->code = state->cfmt->code;
>> +	mf->field = state->scanmode;
>> +	mf->colorspace = state->cfmt->colorspace;
>> +
>> +	return 0;
>> +}
>> +
>> +static int adv761x_try_mbus_fmt(struct v4l2_subdev *sd,
>> +			  struct v4l2_mbus_framefmt *mf)
>> +{
>> +	struct adv761x_state *state = to_state(sd);
>> +	int i, ret;
>> +	u8 progressive;
>> +	u32 width;
>> +	u32 height;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(adv761x_cfmts); i++) {
>> +		if (mf->code = adv761x_cfmts[i].code)
>> +			break;
>> +	}
>> +
>> +	if (i = ARRAY_SIZE(adv761x_cfmts)) {
>> +		/* Unsupported format requested. Propose the current one */
>> +		mf->colorspace = state->cfmt->colorspace;
>> +		mf->code = state->cfmt->code;
>> +	} else {
>> +		/* Also return the colorspace */
>> +		mf->colorspace	= adv761x_cfmts[i].colorspace;
>> +	}
>> +
>> +	/* Get video information */
>> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
>> +	if (ret < 0) {
>> +		width		= ADV761X_MAX_WIDTH;
>> +		height		= ADV761X_MAX_HEIGHT;
>> +		progressive	= 1;
>> +	}
>> +
>> +	mf->width = width;
>> +	mf->height = height;
>> +	mf->field = (progressive) ? V4L2_FIELD_NONE : V4L2_FIELD_INTERLACED;
>> +
>> +	return 0;
>> +}
>> +
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
> None of the mbus_fmt functions should ever attempt to detect the current
> video format, instead they should just use the specified/last set formats.
>
> To properly handle HDTV formats you need to implement the dv_timings ops
> instead.

OK, thanks. I'll have to take a closer look at the dv_timings ops.

>
>> +
>> +static int adv761x_enum_mbus_fmt(struct v4l2_subdev *sd, unsigned int index,
>> +			   enum v4l2_mbus_pixelcode *code)
>> +{
>> +	/* Check requested format index is within range */
>> +	if (index >= ARRAY_SIZE(adv761x_cfmts))
>> +		return -EINVAL;
>> +
>> +	*code = adv761x_cfmts[index].code;
>> +
>> +	return 0;
>> +}
>> +
>> +static int adv761x_g_mbus_config(struct v4l2_subdev *sd,
>> +					struct v4l2_mbus_config *cfg)
>> +{
>> +	cfg->flags = V4L2_MBUS_PCLK_SAMPLE_RISING | V4L2_MBUS_MASTER |
>> +		V4L2_MBUS_VSYNC_ACTIVE_LOW | V4L2_MBUS_HSYNC_ACTIVE_LOW |
>> +		V4L2_MBUS_DATA_ACTIVE_HIGH;
>> +	cfg->type = V4L2_MBUS_PARALLEL;
>> +
>> +	return 0;
>> +}
>> +
>> +/* v4l2_ctrl_ops */
>> +static int adv761x_s_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +	struct v4l2_subdev *sd = to_sd(ctrl);
>> +	u8 val = ctrl->val;
>> +	int ret;
>> +
>> +	switch (ctrl->id) {
>> +	case V4L2_CID_BRIGHTNESS:
>> +		ret = cp_write(sd, 0x3c, val);
>> +		break;
>> +	case V4L2_CID_CONTRAST:
>> +		ret = cp_write(sd, 0x3a, val);
>> +		break;
>> +	case V4L2_CID_SATURATION:
>> +		ret = cp_write(sd, 0x3b, val);
>> +		break;
>> +	case V4L2_CID_HUE:
>> +		ret = cp_write(sd, 0x3d, val);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/* V4L structures */
>> +static const struct v4l2_subdev_core_ops adv761x_core_ops = {
>> +	.queryctrl	= v4l2_subdev_queryctrl,
>> +	.g_ctrl		= v4l2_subdev_g_ctrl,
>> +	.s_ctrl		= v4l2_subdev_s_ctrl,
>> +	.g_ext_ctrls	= v4l2_subdev_g_ext_ctrls,
>> +	.s_ext_ctrls	= v4l2_subdev_s_ext_ctrls,
>> +	.try_ext_ctrls	= v4l2_subdev_try_ext_ctrls,
>> +	.querymenu	= v4l2_subdev_querymenu,
>
> No need to specify these subdev control helpers. Those are only
> needed for legacy bridge drivers that are not yet converted to the
> control framework. Since this driver won't be used with any of those
> old drivers, you can just drop them.

Indeed, thanks!

>
>> +#ifdef CONFIG_VIDEO_ADV_DEBUG
>> +	.g_register	= adv761x_g_register,
>> +	.s_register	= adv761x_s_register,
>> +#endif
>> +};

[]

>> +
>> +static int adv761x_remove(struct i2c_client *client)
>> +{
>> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>> +	struct adv761x_state *state = to_state(sd);
>> +
>> +	cancel_delayed_work(&state->enable_hotplug);
>> +	destroy_workqueue(state->work_queue);
>> +	v4l2_device_unregister_subdev(sd);
>> +	media_entity_cleanup(&sd->entity);
>> +	v4l2_ctrl_handler_free(sd->ctrl_handler);
>> +	adv761x_unregister_clients(state);
>> +	return 0;
>> +}
>> +
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
>
> Shouldn't the interrupt_service_routine() op be implemented as well?
> Usually these drivers will generate interrupts if e.g. the format changes.

The interrupt is supposed to be routed to a GPIO pin on Lager. I'm not 
sure if it works though. IIUC, the IRQ number should be passed via the 
platform data, which is a bit of a problem if the decoder is used with a 
soc_camera device for the same reason the I2C addresses are not passed 
via platform data here.

I just hoped we could start with no ISR and probably add it later.
Do you think there's no way to use it with no IRQ handler?

>
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
>> +
>> +#endif	/* _ADV761X_H_ */
>>
>
> Regards,
>
> 	Hans
>

Thanks,
Val,
