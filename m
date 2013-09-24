From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 24 Sep 2013 14:17:18 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <201309241617.18563.hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Tue 24 September 2013 15:38:34 Valentine Barshak wrote:
> This adds ADV7611/ADV7612 Dual Port Xpressview
> 225 MHz HDMI Receiver support.
> 
> The code is based on the ADV7604 driver, and ADV7612 patch
> by Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Thanks for the patch!

I have a few review comments below:

> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/media/i2c/Kconfig   |   11 +
>  drivers/media/i2c/Makefile  |    1 +
>  drivers/media/i2c/adv761x.c | 1060 +++++++++++++++++++++++++++++++++++++++++++
>  include/media/adv761x.h     |   28 ++
>  4 files changed, 1100 insertions(+)
>  create mode 100644 drivers/media/i2c/adv761x.c
>  create mode 100644 include/media/adv761x.h
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index d18be19..8eede00 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -206,6 +206,17 @@ config VIDEO_ADV7604
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adv7604.
>  
> +config VIDEO_ADV761X
> +	tristate "Analog Devices ADV761X decoder"
> +	depends on VIDEO_V4L2 && I2C
> +	---help---
> +	  Support for the Analog Devices ADV7611/ADV7612 video decoder.
> +
> +	  This is an Analog Devices Dual Port Xpressview HDMI Receiver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adv761x.
> +
>  config VIDEO_ADV7842
>  	tristate "Analog Devices ADV7842 decoder"
>  	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> index 9f462df..393eb0c 100644
> --- a/drivers/media/i2c/Makefile
> +++ b/drivers/media/i2c/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_VIDEO_ADV7183) += adv7183.o
>  obj-$(CONFIG_VIDEO_ADV7343) += adv7343.o
>  obj-$(CONFIG_VIDEO_ADV7393) += adv7393.o
>  obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
> +obj-$(CONFIG_VIDEO_ADV761X) += adv761x.o
>  obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
>  obj-$(CONFIG_VIDEO_AD9389B) += ad9389b.o
>  obj-$(CONFIG_VIDEO_ADV7511) += adv7511.o
> diff --git a/drivers/media/i2c/adv761x.c b/drivers/media/i2c/adv761x.c
> new file mode 100644
> index 0000000..bc3dfc3
> --- /dev/null
> +++ b/drivers/media/i2c/adv761x.c
> @@ -0,0 +1,1060 @@
> +/*
> + * adv761x Analog Devices ADV761X HDMI receiver driver
> + *
> + * Copyright (C) 2013 Cogent Embedded, Inc.
> + * Copyright (C) 2013 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/videodev2.h>
> +#include <media/adv761x.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +
> +#define ADV761X_DRIVER_NAME "adv761x"
> +
> +/* VERT_FILTER_LOCKED and DE_REGEN_FILTER_LOCKED flags */
> +#define ADV761X_HDMI_F_LOCKED(v)	(((v) & 0xa0) = 0xa0)
> +
> +/* Maximum supported resolution */
> +#define ADV761X_MAX_WIDTH		1920
> +#define ADV761X_MAX_HEIGHT		1080
> +
> +static int debug;
> +module_param(debug, int, 0644);
> +MODULE_PARM_DESC(debug, "debug level (0-2)");
> +
> +/* I2C map addresses */
> +static u8 i2c_cec = 0x40;
> +module_param(i2c_cec, byte, 0644);
> +MODULE_PARM_DESC(i2c_cec, "CEC map 7-bit I2C address (default: 0x40)");
> +
> +static u8 i2c_inf = 0x3e;
> +module_param(i2c_inf, byte, 0644);
> +MODULE_PARM_DESC(i2c_inf, "InfoFrame map 7-bit I2C address (default: 0x3e)");
> +
> +static u8 i2c_dpll = 0x26;
> +module_param(i2c_dpll, byte, 0644);
> +MODULE_PARM_DESC(i2c_dpll, "DPLL map 7-bit I2C address (default: 0x20)");
> +
> +static u8 i2c_rep = 0x32;
> +module_param(i2c_rep, byte, 0644);
> +MODULE_PARM_DESC(i2c_rep, "Repeater map 7-bit I2C address (default: 0x32)");
> +
> +static u8 i2c_edid = 0x36;
> +module_param(i2c_edid, byte, 0644);
> +MODULE_PARM_DESC(i2c_edid, "EDID map 7-bit I2C address (default: 0x36)");
> +
> +static u8 i2c_hdmi = 0x34;
> +module_param(i2c_hdmi, byte, 0644);
> +MODULE_PARM_DESC(i2c_hdmi, "HDMI map 7-bit I2C address (default: 0x34)");
> +
> +static u8 i2c_cp = 0x22;
> +module_param(i2c_cp, byte, 0644);
> +MODULE_PARM_DESC(i2c_cp, "CP map 7-bit I2C address (default: 0x22)");

Don't use module options for the i2c addresses. Instead use platform_data.
Boards may have multiple adv761x devices behind e.g. a i2c muxer, so
relying on module options isn't the right method.

> +
> +struct adv761x_color_format {
> +	enum v4l2_mbus_pixelcode code;
> +	enum v4l2_colorspace colorspace;
> +};
> +
> +/* Supported color format list */
> +static const struct adv761x_color_format adv761x_cfmts[] = {
> +	{
> +		.code		= V4L2_MBUS_FMT_RGB888_1X24,
> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> +	},
> +};
> +
> +/* ADV761X descriptor structure */
> +struct adv761x_state {
> +	struct v4l2_subdev			sd;
> +	struct media_pad			pad;
> +	struct v4l2_ctrl_handler		ctrl_hdl;
> +
> +	u8					edid[256];
> +	unsigned				edid_blocks;
> +	const struct adv761x_color_format	*cfmt;
> +	u32					width;
> +	u32					height;
> +	enum v4l2_field				scanmode;
> +
> +	struct workqueue_struct			*work_queue;
> +	struct delayed_work			enable_hotplug;
> +
> +	/* I2C clients */
> +	struct i2c_client			*i2c_cec;
> +	struct i2c_client			*i2c_infoframe;
> +	struct i2c_client			*i2c_dpll;
> +	struct i2c_client			*i2c_repeater;
> +	struct i2c_client			*i2c_edid;
> +	struct i2c_client			*i2c_hdmi;
> +	struct i2c_client			*i2c_cp;
> +};
> +
> +static inline struct v4l2_subdev *to_sd(struct v4l2_ctrl *ctrl)
> +{
> +	return &container_of(ctrl->handler, struct adv761x_state, ctrl_hdl)->sd;
> +}
> +
> +static inline struct adv761x_state *to_state(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct adv761x_state, sd);
> +}
> +
> +/* I2C I/O operations */
> +static s32 adv_smbus_read_byte_data(struct i2c_client *client, u8 command)
> +{
> +	s32 ret, i;
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = i2c_smbus_read_byte_data(client, command);
> +		if (ret >= 0)
> +			return ret;
> +	}
> +
> +	v4l_err(client, "error reading addr:%02x reg:%02x\n",
> +			client->addr, command);
> +	return ret;
> +}
> +
> +static s32 adv_smbus_write_byte_data(struct i2c_client *client,
> +					u8 command, u8 value)
> +{
> +	s32 ret, i;
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = i2c_smbus_write_byte_data(client, command, value);
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	v4l_err(client, "error writing addr:%02x reg:%02x val:%02x\n",
> +			client->addr, command, value);
> +	return ret;
> +}
> +
> +static s32 adv_smbus_write_i2c_block_data(struct i2c_client *client,
> +				       u8 command, u8 length, const u8 *values)
> +{
> +	s32 ret, i;
> +
> +	ret = i2c_smbus_write_i2c_block_data(client, command, length, values);
> +	if (!ret)
> +		return 0;
> +
> +	for (i = 0; i < length; i++) {
> +		ret = adv_smbus_write_byte_data(client, command + i, values[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int io_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> +
> +	return adv_smbus_read_byte_data(client, reg);
> +}
> +
> +static inline int io_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> +
> +	return adv_smbus_write_byte_data(client, reg, val);
> +}
> +
> +static inline int cec_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_cec, reg);
> +}
> +
> +static inline int cec_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_cec, reg, val);
> +}
> +
> +static inline int infoframe_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_infoframe, reg);
> +}
> +
> +static inline int infoframe_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_infoframe, reg, val);
> +}
> +
> +static inline int dpll_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_dpll, reg);
> +}
> +
> +static inline int dpll_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_dpll, reg, val);
> +}
> +
> +static inline int rep_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_repeater, reg);
> +}
> +
> +static inline int rep_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_repeater, reg, val);
> +}
> +
> +static inline int edid_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_edid, reg);
> +}
> +
> +static inline int edid_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_edid, reg, val);
> +}
> +
> +static inline int edid_write_block(struct v4l2_subdev *sd,
> +					unsigned len, const u8 *val)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> +	struct adv761x_state *state = to_state(sd);
> +	int ret = 0;
> +	int i;
> +
> +	v4l2_dbg(2, debug, sd, "writing EDID block (%d bytes)\n", len);
> +
> +	v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)0);
> +
> +	/* Disable I2C access to internal EDID ram from DDC port */
> +	rep_write(sd, 0x74, 0x0);
> +
> +	for (i = 0; !ret && i < len; i += I2C_SMBUS_BLOCK_MAX)
> +		ret = adv_smbus_write_i2c_block_data(state->i2c_edid, i,
> +				I2C_SMBUS_BLOCK_MAX, val + i);
> +	if (ret)
> +		return ret;
> +
> +	/* adv761x calculates the checksums and enables I2C access
> +	 * to internal EDID ram from DDC port.
> +	 */
> +	rep_write(sd, 0x74, 0x01);
> +
> +	for (i = 0; i < 1000; i++) {
> +		if (rep_read(sd, 0x76) & 0x1) {
> +			/* enable hotplug after 100 ms */
> +			queue_delayed_work(state->work_queue,
> +				&state->enable_hotplug, HZ / 10);
> +			return 0;
> +		}
> +		schedule();
> +	}
> +
> +	v4l_err(client, "error enabling edid\n");
> +	return -EIO;
> +}
> +
> +static inline int hdmi_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_hdmi, reg);
> +}
> +
> +static inline int hdmi_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_hdmi, reg, val);
> +}
> +
> +static inline int cp_read(struct v4l2_subdev *sd, u8 reg)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_read_byte_data(state->i2c_cp, reg);
> +}
> +
> +static inline int cp_write(struct v4l2_subdev *sd, u8 reg, u8 val)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	return adv_smbus_write_byte_data(state->i2c_cp, reg, val);
> +}
> +
> +/* Hotplug work */
> +static void adv761x_enable_hotplug(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct adv761x_state *state = container_of(dwork, struct adv761x_state,
> +						enable_hotplug);
> +	struct v4l2_subdev *sd = &state->sd;
> +
> +	v4l2_dbg(2, debug, sd, "%s: enable hotplug\n", __func__);
> +
> +	v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)1);
> +}
> +
> +/* v4l2_subdev_pad_ops */
> +static int adv761x_get_edid(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_edid *edid)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	if (edid->pad != 0)
> +		return -EINVAL;
> +
> +	if (edid->blocks = 0)
> +		return -EINVAL;
> +
> +	if (edid->start_block >= state->edid_blocks)
> +		return -EINVAL;
> +
> +	if (edid->start_block + edid->blocks > state->edid_blocks)
> +		edid->blocks = state->edid_blocks - edid->start_block;
> +	if (!edid->edid)
> +		return -EINVAL;
> +
> +	memcpy(edid->edid + edid->start_block * 128,
> +	       state->edid + edid->start_block * 128,
> +	       edid->blocks * 128);
> +	return 0;
> +}
> +
> +static int adv761x_set_edid(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_edid *edid)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +	int ret;
> +
> +	if (edid->pad != 0)
> +		return -EINVAL;
> +
> +	if (edid->start_block != 0)
> +		return -EINVAL;
> +
> +	if (edid->blocks = 0) {
> +		/* Pull down the hotplug pin */
> +		v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)0);
> +		/* Disables I2C access to internal EDID ram from DDC port */
> +		rep_write(sd, 0x74, 0x0);
> +		state->edid_blocks = 0;
> +		return 0;
> +	}
> +
> +	if (edid->blocks > 2)
> +		return -E2BIG;
> +
> +	if (!edid->edid)
> +		return -EINVAL;
> +
> +	memcpy(state->edid, edid->edid, 128 * edid->blocks);
> +	state->edid_blocks = edid->blocks;
> +
> +	ret = edid_write_block(sd, 128 * edid->blocks, state->edid);
> +	if (ret < 0)
> +		v4l2_err(sd, "error %d writing edid\n", ret);
> +
> +	return ret;
> +}
> +
> +/* v4l2_subdev_core_ops */
> +#ifdef CONFIG_VIDEO_ADV_DEBUG
> +static void adv761x_inv_register(struct v4l2_subdev *sd)
> +{
> +	v4l2_info(sd, "0x000-0x0ff: IO Map\n");
> +	v4l2_info(sd, "0x100-0x1ff: CEC Map\n");
> +	v4l2_info(sd, "0x200-0x2ff: InfoFrame Map\n");
> +	v4l2_info(sd, "0x300-0x3ff: DPLL Map\n");
> +	v4l2_info(sd, "0x400-0x4ff: Repeater Map\n");
> +	v4l2_info(sd, "0x500-0x5ff: EDID Map\n");
> +	v4l2_info(sd, "0x600-0x6ff: HDMI Map\n");
> +	v4l2_info(sd, "0x700-0x7ff: CP Map\n");
> +}
> +
> +static int adv761x_g_register(struct v4l2_subdev *sd,
> +					struct v4l2_dbg_register *reg)
> +{
> +	reg->size = 1;
> +	switch (reg->reg >> 8) {
> +	case 0:
> +		reg->val = io_read(sd, reg->reg & 0xff);
> +		break;
> +	case 1:
> +		reg->val = cec_read(sd, reg->reg & 0xff);
> +		break;
> +	case 2:
> +		reg->val = infoframe_read(sd, reg->reg & 0xff);
> +		break;
> +	case 3:
> +		reg->val = dpll_read(sd, reg->reg & 0xff);
> +		break;
> +	case 4:
> +		reg->val = rep_read(sd, reg->reg & 0xff);
> +		break;
> +	case 5:
> +		reg->val = edid_read(sd, reg->reg & 0xff);
> +		break;
> +	case 6:
> +		reg->val = hdmi_read(sd, reg->reg & 0xff);
> +		break;
> +	case 7:
> +		reg->val = cp_read(sd, reg->reg & 0xff);
> +		break;
> +	default:
> +		v4l2_info(sd, "Register %03llx not supported\n", reg->reg);
> +		adv761x_inv_register(sd);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int adv761x_s_register(struct v4l2_subdev *sd,
> +					const struct v4l2_dbg_register *reg)
> +{
> +	switch (reg->reg >> 8) {
> +	case 0:
> +		io_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 1:
> +		cec_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 2:
> +		infoframe_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 3:
> +		dpll_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 4:
> +		rep_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 5:
> +		edid_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 6:
> +		hdmi_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	case 7:
> +		cp_write(sd, reg->reg & 0xff, reg->val & 0xff);
> +		break;
> +	default:
> +		v4l2_info(sd, "Register %03llx not supported\n", reg->reg);
> +		adv761x_inv_register(sd);
> +		break;
> +	}
> +	return 0;
> +}
> +#endif	/* CONFIG_VIDEO_ADV_DEBUG */
> +
> +/* v4l2_subdev_video_ops */
> +static int adv761x_get_vid_info(struct v4l2_subdev *sd, u8 *progressive,
> +				u32 *width, u32 *height)
> +{
> +	int msb, val;
> +
> +	/* line width */
> +	msb = hdmi_read(sd, 0x07);
> +	if (msb < 0)
> +		return msb;
> +
> +	if (!ADV761X_HDMI_F_LOCKED(msb)) {
> +		v4l2_dbg(2, debug, sd, "No HDMI video input signal detected\n");
> +		return -EAGAIN;
> +	}
> +
> +	/* interlaced or progressive */
> +	val = hdmi_read(sd, 0x0b);
> +	if (val < 0)
> +		return val;
> +
> +	*progressive = (val & 0x20) ? 0 : 1;
> +
> +	val = hdmi_read(sd, 0x08);
> +	if (val < 0)
> +		return val;
> +
> +	val |= (msb & 0x1f) << 8;
> +	*width = val;
> +
> +	/* lines per frame */
> +	msb = hdmi_read(sd, 0x09);
> +	if (msb < 0)
> +		return msb;
> +
> +	val = hdmi_read(sd, 0x0a);
> +	if (val < 0)
> +		return val;
> +
> +	val |= (msb & 0x1f) << 8;
> +	*height = *progressive ? val : val << 1;
> +
> +	if (*width = 0 || *height = 0)
> +		return -EIO;
> +
> +	v4l2_dbg(2, debug, sd, "Detected HDMI video input signal (%ux%u%c)\n",
> +		*width, *height, *progressive ? 'p' : 'i');
> +
> +	return 0;
> +}
> +
> +static int adv761x_g_input_status(struct v4l2_subdev *sd, u32 *status)
> +{
> +	int ret;
> +
> +	ret = hdmi_read(sd, 0x07);
> +	if (ret < 0)
> +		return ret;
> +
> +	*status = ADV761X_HDMI_F_LOCKED(ret) ? 0 : V4L2_IN_ST_NO_SIGNAL;
> +	return 0;
> +}
> +
> +static int adv761x_cropcap(struct v4l2_subdev *sd, struct v4l2_cropcap *a)
> +{
> +	u8 progressive;
> +	u32 width;
> +	u32 height;
> +	int ret;
> +
> +	/* cropping limits */
> +	a->bounds.left			= 0;
> +	a->bounds.top			= 0;
> +
> +	/* get video information */
> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
> +	if (ret < 0) {
> +		a->bounds.width		= ADV761X_MAX_WIDTH;
> +		a->bounds.height	= ADV761X_MAX_HEIGHT;
> +	} else {
> +		a->bounds.width		= width;
> +		a->bounds.height	= height;
> +	}
> +
> +	/* default cropping rectangle */
> +	a->defrect			= a->bounds;
> +
> +	/* does not support scaling */
> +	a->pixelaspect.numerator	= 1;
> +	a->pixelaspect.denominator	= 1;
> +	a->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +
> +	return 0;
> +}
> +
> +static int adv761x_g_crop(struct v4l2_subdev *sd, struct v4l2_crop *a)
> +{
> +	u8 progressive;
> +	u32 width;
> +	u32 height;
> +	int ret;
> +
> +	a->c.left	= 0;
> +	a->c.top	= 0;
> +
> +	/* Get video information */
> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
> +	if (ret < 0) {
> +		a->c.width	= ADV761X_MAX_WIDTH;
> +		a->c.height	= ADV761X_MAX_HEIGHT;
> +	} else {
> +		a->c.width	= width;
> +		a->c.height	= height;
> +	}
> +
> +	a->type		= V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +
> +	return 0;
> +}

Why are cropcap and g_crop implemented if there is no actual cropping
supported?

> +
> +static int adv761x_g_mbus_fmt(struct v4l2_subdev *sd,
> +			  struct v4l2_mbus_framefmt *mf)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +
> +	mf->width = state->width;
> +	mf->height = state->height;
> +	mf->code = state->cfmt->code;
> +	mf->field = state->scanmode;
> +	mf->colorspace = state->cfmt->colorspace;
> +
> +	return 0;
> +}
> +
> +static int adv761x_try_mbus_fmt(struct v4l2_subdev *sd,
> +			  struct v4l2_mbus_framefmt *mf)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +	int i, ret;
> +	u8 progressive;
> +	u32 width;
> +	u32 height;
> +
> +	for (i = 0; i < ARRAY_SIZE(adv761x_cfmts); i++) {
> +		if (mf->code = adv761x_cfmts[i].code)
> +			break;
> +	}
> +
> +	if (i = ARRAY_SIZE(adv761x_cfmts)) {
> +		/* Unsupported format requested. Propose the current one */
> +		mf->colorspace = state->cfmt->colorspace;
> +		mf->code = state->cfmt->code;
> +	} else {
> +		/* Also return the colorspace */
> +		mf->colorspace	= adv761x_cfmts[i].colorspace;
> +	}
> +
> +	/* Get video information */
> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
> +	if (ret < 0) {
> +		width		= ADV761X_MAX_WIDTH;
> +		height		= ADV761X_MAX_HEIGHT;
> +		progressive	= 1;
> +	}
> +
> +	mf->width = width;
> +	mf->height = height;
> +	mf->field = (progressive) ? V4L2_FIELD_NONE : V4L2_FIELD_INTERLACED;
> +
> +	return 0;
> +}
> +
> +static int adv761x_s_mbus_fmt(struct v4l2_subdev *sd,
> +			  struct v4l2_mbus_framefmt *mf)
> +{
> +	struct adv761x_state *state = to_state(sd);
> +	int i, ret;
> +	u8 progressive;
> +	u32 width;
> +	u32 height;
> +
> +	for (i = 0; i < ARRAY_SIZE(adv761x_cfmts); i++) {
> +		if (mf->code = adv761x_cfmts[i].code) {
> +			state->cfmt = &adv761x_cfmts[i];
> +			break;
> +		}
> +	}
> +	if (i >= ARRAY_SIZE(adv761x_cfmts))
> +		return -EINVAL;
> +
> +	/* Get video information */
> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
> +	if (ret < 0) {
> +		width		= ADV761X_MAX_WIDTH;
> +		height		= ADV761X_MAX_HEIGHT;
> +		progressive	= 1;
> +	}
> +
> +	state->width = width;
> +	state->height = height;
> +	state->scanmode = (progressive) ?
> +			V4L2_FIELD_NONE : V4L2_FIELD_INTERLACED;
> +
> +	mf->width = state->width;
> +	mf->height = state->height;
> +	mf->code = state->cfmt->code;
> +	mf->field = state->scanmode;
> +	mf->colorspace = state->cfmt->colorspace;
> +
> +	return 0;
> +}

None of the mbus_fmt functions should ever attempt to detect the current
video format, instead they should just use the specified/last set formats.

To properly handle HDTV formats you need to implement the dv_timings ops
instead.

> +
> +static int adv761x_enum_mbus_fmt(struct v4l2_subdev *sd, unsigned int index,
> +			   enum v4l2_mbus_pixelcode *code)
> +{
> +	/* Check requested format index is within range */
> +	if (index >= ARRAY_SIZE(adv761x_cfmts))
> +		return -EINVAL;
> +
> +	*code = adv761x_cfmts[index].code;
> +
> +	return 0;
> +}
> +
> +static int adv761x_g_mbus_config(struct v4l2_subdev *sd,
> +					struct v4l2_mbus_config *cfg)
> +{
> +	cfg->flags = V4L2_MBUS_PCLK_SAMPLE_RISING | V4L2_MBUS_MASTER |
> +		V4L2_MBUS_VSYNC_ACTIVE_LOW | V4L2_MBUS_HSYNC_ACTIVE_LOW |
> +		V4L2_MBUS_DATA_ACTIVE_HIGH;
> +	cfg->type = V4L2_MBUS_PARALLEL;
> +
> +	return 0;
> +}
> +
> +/* v4l2_ctrl_ops */
> +static int adv761x_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct v4l2_subdev *sd = to_sd(ctrl);
> +	u8 val = ctrl->val;
> +	int ret;
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_BRIGHTNESS:
> +		ret = cp_write(sd, 0x3c, val);
> +		break;
> +	case V4L2_CID_CONTRAST:
> +		ret = cp_write(sd, 0x3a, val);
> +		break;
> +	case V4L2_CID_SATURATION:
> +		ret = cp_write(sd, 0x3b, val);
> +		break;
> +	case V4L2_CID_HUE:
> +		ret = cp_write(sd, 0x3d, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/* V4L structures */
> +static const struct v4l2_subdev_core_ops adv761x_core_ops = {
> +	.queryctrl	= v4l2_subdev_queryctrl,
> +	.g_ctrl		= v4l2_subdev_g_ctrl,
> +	.s_ctrl		= v4l2_subdev_s_ctrl,
> +	.g_ext_ctrls	= v4l2_subdev_g_ext_ctrls,
> +	.s_ext_ctrls	= v4l2_subdev_s_ext_ctrls,
> +	.try_ext_ctrls	= v4l2_subdev_try_ext_ctrls,
> +	.querymenu	= v4l2_subdev_querymenu,

No need to specify these subdev control helpers. Those are only
needed for legacy bridge drivers that are not yet converted to the
control framework. Since this driver won't be used with any of those
old drivers, you can just drop them.

> +#ifdef CONFIG_VIDEO_ADV_DEBUG
> +	.g_register	= adv761x_g_register,
> +	.s_register	= adv761x_s_register,
> +#endif
> +};
> +
> +static const struct v4l2_subdev_video_ops adv761x_video_ops = {
> +	.g_input_status = adv761x_g_input_status,
> +	.cropcap	= adv761x_cropcap,
> +	.g_crop		= adv761x_g_crop,
> +	.enum_mbus_fmt	= adv761x_enum_mbus_fmt,
> +	.g_mbus_fmt	= adv761x_g_mbus_fmt,
> +	.try_mbus_fmt	= adv761x_try_mbus_fmt,
> +	.s_mbus_fmt	= adv761x_s_mbus_fmt,
> +	.g_mbus_config	= adv761x_g_mbus_config,
> +};
> +
> +static const struct v4l2_subdev_pad_ops adv761x_pad_ops = {
> +	.get_edid = adv761x_get_edid,
> +	.set_edid = adv761x_set_edid,
> +};
> +
> +static const struct v4l2_subdev_ops adv761x_ops = {
> +	.core = &adv761x_core_ops,
> +	.video = &adv761x_video_ops,
> +	.pad = &adv761x_pad_ops,
> +};
> +
> +static const struct v4l2_ctrl_ops adv761x_ctrl_ops = {
> +	.s_ctrl = adv761x_s_ctrl,
> +};
> +
> +/* Device initialization and clean-up */
> +static void adv761x_unregister_clients(struct adv761x_state *state)
> +{
> +	if (state->i2c_cec)
> +		i2c_unregister_device(state->i2c_cec);
> +	if (state->i2c_infoframe)
> +		i2c_unregister_device(state->i2c_infoframe);
> +	if (state->i2c_dpll)
> +		i2c_unregister_device(state->i2c_dpll);
> +	if (state->i2c_repeater)
> +		i2c_unregister_device(state->i2c_repeater);
> +	if (state->i2c_edid)
> +		i2c_unregister_device(state->i2c_edid);
> +	if (state->i2c_hdmi)
> +		i2c_unregister_device(state->i2c_hdmi);
> +	if (state->i2c_cp)
> +		i2c_unregister_device(state->i2c_cp);
> +}
> +
> +static struct i2c_client *adv761x_dummy_client(struct v4l2_subdev *sd,
> +							u8 addr, u8 io_reg)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> +
> +	io_write(sd, io_reg, addr << 1);
> +
> +	return i2c_new_dummy(client->adapter, io_read(sd, io_reg) >> 1);
> +}
> +
> +static inline int adv761x_check_rev(struct i2c_client *client)
> +{
> +	int msb, rev;
> +
> +	msb = adv_smbus_read_byte_data(client, 0xea);
> +	if (msb < 0)
> +		return msb;
> +
> +	rev = adv_smbus_read_byte_data(client, 0xeb);
> +	if (rev < 0)
> +		return rev;
> +
> +	rev |= msb << 8;
> +
> +	switch (rev) {
> +	case 0x2051:
> +		return 7611;
> +	case 0x2041:
> +		return 7612;
> +	default:
> +		break;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int adv761x_core_init(struct v4l2_subdev *sd)
> +{
> +	io_write(sd, 0x01, 0x06);	/* V-FREQ = 60Hz */
> +					/* Prim_Mode = HDMI-GR */
> +	io_write(sd, 0x02, 0xf2);	/* Auto CSC, RGB out */
> +					/* Disable op_656 bit */
> +	io_write(sd, 0x03, 0x42);	/* 36 bit SDR 444 Mode 0 */
> +	io_write(sd, 0x05, 0x28);	/* AV Codes Off */
> +	io_write(sd, 0x0b, 0x44);	/* Power up part */
> +	io_write(sd, 0x0c, 0x42);	/* Power up part */
> +	io_write(sd, 0x14, 0x7f);	/* Max Drive Strength */
> +	io_write(sd, 0x15, 0x80);	/* Disable Tristate of Pins */
> +					/*  (Audio output pins active) */
> +	io_write(sd, 0x19, 0x83);	/* LLC DLL phase */
> +	io_write(sd, 0x33, 0x40);	/* LLC DLL enable */
> +
> +	cp_write(sd, 0xba, 0x01);	/* Set HDMI FreeRun */
> +	cp_write(sd, 0x3e, 0x80);	/* Enable color adjustments */
> +
> +	hdmi_write(sd, 0x9b, 0x03);	/* ADI recommended setting */
> +	hdmi_write(sd, 0x00, 0x08);	/* Set HDMI Input Port A */
> +					/*  (BG_MEAS_PORT_SEL = 001b) */
> +	hdmi_write(sd, 0x02, 0x03);	/* Enable Ports A & B in */
> +					/* background mode */
> +	hdmi_write(sd, 0x6d, 0x80);	/* Enable TDM mode */
> +	hdmi_write(sd, 0x03, 0x18);	/* I2C mode 24 bits */
> +	hdmi_write(sd, 0x83, 0xfc);	/* Enable clock terminators */
> +					/* for port A & B */
> +	hdmi_write(sd, 0x6f, 0x0c);	/* ADI recommended setting */
> +	hdmi_write(sd, 0x85, 0x1f);	/* ADI recommended setting */
> +	hdmi_write(sd, 0x87, 0x70);	/* ADI recommended setting */
> +	hdmi_write(sd, 0x8d, 0x04);	/* LFG Port A */
> +	hdmi_write(sd, 0x8e, 0x1e);	/* HFG Port A */
> +	hdmi_write(sd, 0x1a, 0x8a);	/* unmute audio */
> +	hdmi_write(sd, 0x57, 0xda);	/* ADI recommended setting */
> +	hdmi_write(sd, 0x58, 0x01);	/* ADI recommended setting */
> +	hdmi_write(sd, 0x75, 0x10);	/* DDC drive strength */
> +	hdmi_write(sd, 0x90, 0x04);	/* LFG Port B */
> +	hdmi_write(sd, 0x91, 0x1e);	/* HFG Port B */
> +	hdmi_write(sd, 0x04, 0x03);
> +	hdmi_write(sd, 0x14, 0x00);
> +	hdmi_write(sd, 0x15, 0x00);
> +	hdmi_write(sd, 0x16, 0x00);
> +
> +	rep_write(sd, 0x40, 0x81);	/* Disable HDCP 1.1 features */
> +	rep_write(sd, 0x74, 0x00);	/* Disable the Internal EDID */
> +					/* for all ports */
> +
> +	return v4l2_ctrl_handler_setup(sd->ctrl_handler);
> +}
> +
> +static int adv761x_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct adv761x_state *state;
> +	struct v4l2_ctrl_handler *ctrl_hdl;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	/* Check if the adapter supports the needed features */
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;
> +
> +	/* Check chip revision */
> +	ret = adv761x_check_rev(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	v4l_info(client, "chip found @ 0x%02x (adv%d)\n", client->addr, ret);
> +
> +	state = devm_kzalloc(&client->dev, sizeof(*state), GFP_KERNEL);
> +	if (state = NULL)
> +		return -ENOMEM;
> +
> +	state->cfmt		= &adv761x_cfmts[0];
> +	state->width		= ADV761X_MAX_WIDTH;
> +	state->height		= ADV761X_MAX_HEIGHT;
> +	state->scanmode		= V4L2_FIELD_NONE;
> +
> +	sd = &state->sd;
> +	v4l2_i2c_subdev_init(sd, client, &adv761x_ops);
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +
> +	/* control handlers */
> +	ctrl_hdl = &state->ctrl_hdl;
> +	v4l2_ctrl_handler_init(ctrl_hdl, 4);
> +	v4l2_ctrl_new_std(ctrl_hdl, &adv761x_ctrl_ops,
> +			  V4L2_CID_BRIGHTNESS, -128, 127, 1, 0);
> +	v4l2_ctrl_new_std(ctrl_hdl, &adv761x_ctrl_ops,
> +			  V4L2_CID_CONTRAST, 0, 255, 1, 128);
> +	v4l2_ctrl_new_std(ctrl_hdl, &adv761x_ctrl_ops,
> +			  V4L2_CID_SATURATION, 0, 255, 1, 128);
> +	v4l2_ctrl_new_std(ctrl_hdl, &adv761x_ctrl_ops,
> +			  V4L2_CID_HUE, 0, 255, 1, 0);
> +	sd->ctrl_handler = ctrl_hdl;
> +	if (ctrl_hdl->error) {
> +		ret = ctrl_hdl->error;
> +		goto err_hdl;
> +	}
> +
> +	/* I2C clients */
> +	state->i2c_cec = adv761x_dummy_client(sd, i2c_cec, 0xf4);
> +	state->i2c_infoframe = adv761x_dummy_client(sd, i2c_inf, 0xf5);
> +	state->i2c_dpll = adv761x_dummy_client(sd, i2c_dpll, 0xf7);
> +	state->i2c_repeater = adv761x_dummy_client(sd, i2c_rep, 0xf9);
> +	state->i2c_edid = adv761x_dummy_client(sd, i2c_edid, 0xfa);
> +	state->i2c_hdmi = adv761x_dummy_client(sd, i2c_hdmi, 0xfb);
> +	state->i2c_cp = adv761x_dummy_client(sd, i2c_cp, 0xfd);
> +	if (!state->i2c_cec || !state->i2c_infoframe ||
> +	    !state->i2c_dpll || !state->i2c_repeater ||
> +	    !state->i2c_edid || !state->i2c_hdmi || !state->i2c_cp) {
> +		ret = -ENODEV;
> +		v4l2_err(sd, "Failed to create all I2C clients\n");
> +		goto err_i2c;
> +	}
> +
> +	/* work queue */
> +	state->work_queue = create_singlethread_workqueue(client->name);
> +	if (!state->work_queue) {
> +		v4l2_err(sd, "Could not create work queue\n");
> +		ret = -ENOMEM;
> +		goto err_i2c;
> +	}
> +
> +	INIT_DELAYED_WORK(&state->enable_hotplug, adv761x_enable_hotplug);
> +
> +	state->pad.flags = MEDIA_PAD_FL_SOURCE;
> +	ret = media_entity_init(&sd->entity, 1, &state->pad, 0);
> +	if (ret)
> +		goto err_work_queue;
> +
> +	ret = adv761x_core_init(sd);
> +	if (ret < 0)
> +		goto err_entity;
> +
> +	return 0;
> +
> +err_entity:
> +	media_entity_cleanup(&sd->entity);
> +err_work_queue:
> +	cancel_delayed_work(&state->enable_hotplug);
> +	destroy_workqueue(state->work_queue);
> +err_i2c:
> +	adv761x_unregister_clients(state);
> +err_hdl:
> +	v4l2_ctrl_handler_free(ctrl_hdl);
> +	return ret;
> +}
> +
> +static int adv761x_remove(struct i2c_client *client)
> +{
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct adv761x_state *state = to_state(sd);
> +
> +	cancel_delayed_work(&state->enable_hotplug);
> +	destroy_workqueue(state->work_queue);
> +	v4l2_device_unregister_subdev(sd);
> +	media_entity_cleanup(&sd->entity);
> +	v4l2_ctrl_handler_free(sd->ctrl_handler);
> +	adv761x_unregister_clients(state);
> +	return 0;
> +}
> +
> +/* Power management operations */
> +#ifdef CONFIG_PM_SLEEP
> +static int adv761x_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +
> +	/* Power off */
> +	return io_write(sd, 0x0c, 0x62);
> +}
> +
> +static int adv761x_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +
> +	/* Initializes ADV761X to its default values */
> +	return adv761x_core_init(sd);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(adv761x_pm_ops, adv761x_suspend, adv761x_resume);
> +#define ADV761X_PM_OPS (&adv761x_pm_ops)
> +#else	/* CONFIG_PM_SLEEP */
> +#define ADV761X_PM_OPS NULL
> +#endif	/* CONFIG_PM_SLEEP */
> +
> +static const struct i2c_device_id adv761x_id[] = {
> +	{ ADV761X_DRIVER_NAME, 0 },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, adv761x_id);
> +
> +static struct i2c_driver adv761x_driver = {
> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= ADV761X_DRIVER_NAME,
> +		.pm	= ADV761X_PM_OPS,
> +	},
> +	.probe		= adv761x_probe,
> +	.remove		= adv761x_remove,
> +	.id_table	= adv761x_id,
> +};
> +
> +module_i2c_driver(adv761x_driver);
> +
> +MODULE_DESCRIPTION("HDMI Receiver ADV761X video decoder driver");
> +MODULE_LICENSE("GPL v2");

Shouldn't the interrupt_service_routine() op be implemented as well?
Usually these drivers will generate interrupts if e.g. the format changes.

> diff --git a/include/media/adv761x.h b/include/media/adv761x.h
> new file mode 100644
> index 0000000..e6e6aea
> --- /dev/null
> +++ b/include/media/adv761x.h
> @@ -0,0 +1,28 @@
> +/*
> + * adv761x Analog Devices ADV761X HDMI receiver driver
> + *
> + * Copyright (C) 2013 Cogent Embedded, Inc.
> + * Copyright (C) 2013 Renesas Electronics Corporation
> + *
> + * This program is free software; you may redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + */
> +
> +#ifndef _ADV761X_H_
> +#define _ADV761X_H_
> +
> +/* notify events */
> +#define ADV761X_HOTPLUG		1
> +
> +#endif	/* _ADV761X_H_ */
> 

Regards,

	Hans
