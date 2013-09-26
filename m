From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Sep 2013 09:36:19 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <7160350.b3VDEo9zXc@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Hans,

On Thursday 26 September 2013 08:57:43 Hans Verkuil wrote:
> On 09/25/2013 12:21 PM, Laurent Pinchart wrote:
> > Hi Valentine,
> > 
> > Thank you for the patch.
> > 
> > Please see below for a couple of comments (in addition to Hans' and
> > Guennadi's comments).
> > 
> > On Tuesday 24 September 2013 17:38:34 Valentine Barshak wrote:
> >> This adds ADV7611/ADV7612 Dual Port Xpressview
> >> 225 MHz HDMI Receiver support.
> >> 
> >> The code is based on the ADV7604 driver, and ADV7612 patch
> >> by Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> >> 
> >> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >> ---
> >> 
> >>  drivers/media/i2c/Kconfig   |   11 +
> >>  drivers/media/i2c/Makefile  |    1 +
> >>  drivers/media/i2c/adv761x.c | 1060
> >>  ++++++++++++++++++++++++++++++++++++++++
> >>  include/media/adv761x.h     |   28 ++
> >>  4 files changed, 1100 insertions(+)
> >>  create mode 100644 drivers/media/i2c/adv761x.c
> >>  create mode 100644 include/media/adv761x.h
> > 
> > [snip]
> > 
> >> diff --git a/drivers/media/i2c/adv761x.c b/drivers/media/i2c/adv761x.c
> >> new file mode 100644
> >> index 0000000..bc3dfc3
> >> --- /dev/null
> >> +++ b/drivers/media/i2c/adv761x.c
> > 
> > [snip]
> > 
> >> +/* Supported color format list */
> >> +static const struct adv761x_color_format adv761x_cfmts[] = {
> >> +	{
> >> +		.code		= V4L2_MBUS_FMT_RGB888_1X24,
> >> +		.colorspace	= V4L2_COLORSPACE_SRGB,
> >> +	},
> >> +};
> > 
> > Do you plan to add support for more formats later ?
> > 
> > [snip]
> > 
> >> +static inline int edid_write_block(struct v4l2_subdev *sd,
> >> +					unsigned len, const u8 *val)
> > 
> > I would pass a pointer to adv761x_state to the internal functions instead
> > of getting it from the subdev pointer each time, but that's up to you.
> >
> >> +{
> >> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> >> +	struct adv761x_state *state = to_state(sd);
> >> +	int ret = 0;
> >> +	int i;
> > 
> > i is used as an unsigned number, please make it unsigned int. Same comment
> > for all the locations below where i is used as unsigned.
> > 
> >> +
> >> +	v4l2_dbg(2, debug, sd, "writing EDID block (%d bytes)\n", len);
> >> +
> >> +	v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)0);
> > 
> > This means that the master V4L2 driver will need to handle
> > ADV761x-specific
> > events, which doesn't sound very good. What do you use the event for ?
> > Could you create a standard interface for this ?
> > 
> >> +	/* Disable I2C access to internal EDID ram from DDC port */
> >> +	rep_write(sd, 0x74, 0x0);
> > 
> > Could you #define constants for register addresses and values instead of
> > hardcoding them ?
> 
> These days I would probably use the regmap API instead.

That's a good idea.

> That said, I've always hated using defines for register addresses since all
> the datasheets are always organized around addresses, not names. Using
> defines means I need to do a double-lookup: from define to address, from
> address to the right database page that documents it.

Using #defines usually saves you from looking up the register completely in 
the datasheet, and is especially important when the datasheet is not publicly 
available. When reasonably familiar with the chip, proper #defines will tell 
you what register is modified and how. Hardcoded values are never readable.

> I'd rather see a useful comment.
> 
> >> +	for (i = 0; !ret && i < len; i += I2C_SMBUS_BLOCK_MAX)
> >> +		ret = adv_smbus_write_i2c_block_data(state->i2c_edid, i,
> >> +				I2C_SMBUS_BLOCK_MAX, val + i);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* adv761x calculates the checksums and enables I2C access
> >> +	 * to internal EDID ram from DDC port.
> >> +	 */
> >> +	rep_write(sd, 0x74, 0x01);
> >> +
> >> +	for (i = 0; i < 1000; i++) {
> >> +		if (rep_read(sd, 0x76) & 0x1) {
> >> +			/* enable hotplug after 100 ms */
> >> +			queue_delayed_work(state->work_queue,
> >> +				&state->enable_hotplug, HZ / 10);
> >> +			return 0;
> >> +		}
> >> +		schedule();
> > 
> > I haven't checked the datasheet, but can't the chip generate an interrupt
> > that could replace the busy-loop ?
> 
> There isn't one in the adv7604, so I assume it's the same for this chip.
> 
> >> +	}
> >> +
> >> +	v4l_err(client, "error enabling edid\n");
> >> +	return -EIO;
> >> +}

-- 
Regards,

Laurent Pinchart

