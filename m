From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Sep 2013 10:21:04 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <1968602.ie7TDIZtkL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Thank you for the patch.

Please see below for a couple of comments (in addition to Hans' and Guennadi's 
comments).

On Tuesday 24 September 2013 17:38:34 Valentine Barshak wrote:
> This adds ADV7611/ADV7612 Dual Port Xpressview
> 225 MHz HDMI Receiver support.
> 
> The code is based on the ADV7604 driver, and ADV7612 patch
> by Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/media/i2c/Kconfig   |   11 +
>  drivers/media/i2c/Makefile  |    1 +
>  drivers/media/i2c/adv761x.c | 1060 ++++++++++++++++++++++++++++++++++++++++
>  include/media/adv761x.h     |   28 ++
>  4 files changed, 1100 insertions(+)
>  create mode 100644 drivers/media/i2c/adv761x.c
>  create mode 100644 include/media/adv761x.h

[snip]

> diff --git a/drivers/media/i2c/adv761x.c b/drivers/media/i2c/adv761x.c
> new file mode 100644
> index 0000000..bc3dfc3
> --- /dev/null
> +++ b/drivers/media/i2c/adv761x.c

[snip]

> +/* Supported color format list */
> +static const struct adv761x_color_format adv761x_cfmts[] = {
> +	{
> +		.code		= V4L2_MBUS_FMT_RGB888_1X24,
> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> +	},
> +};

Do you plan to add support for more formats later ?

[snip]

> +static inline int edid_write_block(struct v4l2_subdev *sd,
> +					unsigned len, const u8 *val)

I would pass a pointer to adv761x_state to the internal functions instead of 
getting it from the subdev pointer each time, but that's up to you.

> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> +	struct adv761x_state *state = to_state(sd);
> +	int ret = 0;
> +	int i;

i is used as an unsigned number, please make it unsigned int. Same comment for 
all the locations below where i is used as unsigned.

> +
> +	v4l2_dbg(2, debug, sd, "writing EDID block (%d bytes)\n", len);
> +
> +	v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)0);

This means that the master V4L2 driver will need to handle ADV761x-specific 
events, which doesn't sound very good. What do you use the event for ? Could 
you create a standard interface for this ?

> +	/* Disable I2C access to internal EDID ram from DDC port */
> +	rep_write(sd, 0x74, 0x0);

Could you #define constants for register addresses and values instead of 
hardcoding them ?

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

I haven't checked the datasheet, but can't the chip generate an interrupt that 
could replace the busy-loop ?

> +	}
> +
> +	v4l_err(client, "error enabling edid\n");
> +	return -EIO;
> +}

[snip]

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

Stupid question, what are the use cases for setting EDID on an HDMI receiver ? 
Isn't that something that should just be read from the device ?

> +
> +	return ret;
> +}

[snip]

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

I would propose a fixed default value instead of the current format to make 
the driver behaviour more reproducible.

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

You should select a default format instead of returning an error. The format 
try and set operations should adjust the requested input parameters, not 
return errors.

> +
> +	/* Get video information */
> +	ret = adv761x_get_vid_info(sd, &progressive, &width, &height);
> +	if (ret < 0) {

Is this really a recoverable error that can be ignored silently ?

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

[snip]

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

If you end up removing the retry loops in the read and write functions, don't 
forget to switch to smbus_read_word_data() where applicable.

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

Don't you need to check for errors ? You should in that case put the default 
values in an array to simplify the code.

> +	rep_write(sd, 0x40, 0x81);	/* Disable HDCP 1.1 features */
> +	rep_write(sd, 0x74, 0x00);	/* Disable the Internal EDID */
> +					/* for all ports */
> +
> +	return v4l2_ctrl_handler_setup(sd->ctrl_handler);
> +}

[snip]

> +static int adv761x_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +
> +	/* Initializes ADV761X to its default values */
> +	return adv761x_core_init(sd);

Don't you also need to restore the sub-devices I2C addresses here ?

> +}

[snip]

-- 
Regards,

Laurent Pinchart

