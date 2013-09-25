From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Sep 2013 22:04:49 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <1554521.JFkDCxSPn1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 25 September 2013 12:21:04 Laurent Pinchart wrote:
> Hi Valentine,
> 
> Thank you for the patch.
> 
> Please see below for a couple of comments (in addition to Hans' and
> Guennadi's comments).
> 
> On Tuesday 24 September 2013 17:38:34 Valentine Barshak wrote:
> > This adds ADV7611/ADV7612 Dual Port Xpressview
> > 225 MHz HDMI Receiver support.
> > 
> > The code is based on the ADV7604 driver, and ADV7612 patch
> > by Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > 
> > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > ---

[snip]

> > +static int adv761x_set_edid(struct v4l2_subdev *sd,
> > +				struct v4l2_subdev_edid *edid)
> > +{
> > +	struct adv761x_state *state = to_state(sd);
> > +	int ret;
> > +
> > +	if (edid->pad != 0)
> > +		return -EINVAL;
> > +
> > +	if (edid->start_block != 0)
> > +		return -EINVAL;
> > +
> > +	if (edid->blocks = 0) {
> > +		/* Pull down the hotplug pin */
> > +		v4l2_subdev_notify(sd, ADV761X_HOTPLUG, (void *)0);
> > +		/* Disables I2C access to internal EDID ram from DDC port */
> > +		rep_write(sd, 0x74, 0x0);
> > +		state->edid_blocks = 0;
> > +		return 0;
> > +	}
> > +
> > +	if (edid->blocks > 2)
> > +		return -E2BIG;
> > +
> > +	if (!edid->edid)
> > +		return -EINVAL;
> > +
> > +	memcpy(state->edid, edid->edid, 128 * edid->blocks);
> > +	state->edid_blocks = edid->blocks;
> > +
> > +	ret = edid_write_block(sd, 128 * edid->blocks, state->edid);
> > +	if (ret < 0)
> > +		v4l2_err(sd, "error %d writing edid\n", ret);
> 
> Stupid question, what are the use cases for setting EDID on an HDMI receiver
> ? Isn't that something that should just be read from the device ?

My bad, scratch this, I got the chip mixed with an HDMI transmitter.

> > +
> > +	return ret;
> > +}

-- 
Regards,

Laurent Pinchart

