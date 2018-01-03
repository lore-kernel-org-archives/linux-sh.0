From: jacopo mondi <jacopo@jmondi.org>
Date: Wed, 03 Jan 2018 15:44:58 +0000
Subject: Re: [PATCH v2 7/9] media: i2c: ov772x: Remove soc_camera dependencies
Message-Id: <20180103154458.GD9493@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1514469681-15602-1-git-send-email-jacopo+renesas@jmondi.org>
 <1514469681-15602-8-git-send-email-jacopo+renesas@jmondi.org>
 <5703631.yJ335LfYLI@avalon>
In-Reply-To: <5703631.yJ335LfYLI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Laurent,

On Tue, Jan 02, 2018 at 05:44:03PM +0200, Laurent Pinchart wrote:
> Hi Jacopo,
>
> Thank you for the patch.
>
> On Thursday, 28 December 2017 16:01:19 EET Jacopo Mondi wrote:
> > Remove soc_camera framework dependencies from ov772x sensor driver.
> > - Handle clock and gpios
> > - Register async subdevice
> > - Remove soc_camera specific g/s_mbus_config operations
> > - Change image format colorspace to SRGB
>
> Could you explain the rationale for this ?

Hans suggested this, and I assume it is beacause COLORSPACE_JPEG =
(COLORSPACE_SRGB + assumptions on quantization ranges) which does not
apply to the sensor.
>
> > - Remove sizes crop from get_selection as driver can't scale
> > - Add kernel doc to driver interface header file
> > - Adjust build system
>
> That's a lot for a single patch. On the other hand I don't think splitting
> this in 7 patches would be a good idea either. If you can find a better
> granularity, go for it, otherwise keep it as-is. Same comment for the tw9910
> driver.

I know.
I would have kept changes down to the minimum required to remove
soc_camera dependencies, but I received comments on other parts of the
driver not directly soc_camera specific. I understand this, since I'm
touching the driver it is maybe worth changing some parts of it that
needs updates..

>
> > This commit does not remove the original soc_camera based driver as long
> > as other platforms depends on soc_camera-based CEU driver.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  drivers/media/i2c/Kconfig  |  11 +++
> >  drivers/media/i2c/Makefile |   1 +
> >  drivers/media/i2c/ov772x.c | 169 ++++++++++++++++++++++++++++-------------
> >  include/media/i2c/ov772x.h |   8 ++-
> >  4 files changed, 130 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > index cb5d7ff..a61d7f4 100644
> > --- a/drivers/media/i2c/Kconfig
> > +++ b/drivers/media/i2c/Kconfig
>
> [snip]
>
> > diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
> > index 8063835..f7b293f 100644
> > --- a/drivers/media/i2c/ov772x.c
> > +++ b/drivers/media/i2c/ov772x.c
> > @@ -1,6 +1,9 @@
>
> [snip]
>
> > @@ -25,8 +26,8 @@
> >  #include <linux/videodev2.h>
> >
> >  #include <media/i2c/ov772x.h>
> > -#include <media/soc_camera.h>
> > -#include <media/v4l2-clk.h>
> > +
> > +#include <media/v4l2-device.h>
> >  #include <media/v4l2-ctrls.h>
>
> I think C comes before D.
>
> >  #include <media/v4l2-subdev.h>
> >  #include <media/v4l2-image-sizes.h>
>
> [snip]
>
> > @@ -650,13 +653,63 @@ static int ov772x_s_register(struct v4l2_subdev *sd,
> >  }
> >  #endif
> >
> > +static int ov772x_power_on(struct ov772x_priv *priv)
> > +{
> > +	struct i2c_client *client = v4l2_get_subdevdata(&priv->subdev);
> > +	int ret;
> > +
> > +	if (priv->info->xclk_rate)
> > +		ret = clk_set_rate(priv->clk, priv->info->xclk_rate);
>
> The return value is then ignored.
>
> I wonder whether the clk_set_rate() call shouldn't be kept in board code as
> it's a board-specific frequency. DT platforms would use the assigned-clock-
> rates property that doesn't require any explicit handling in the driver.
>

DT based platforms won't have any info->xlkc_rate, so they should be
fine. I wonder how could I set rate in board code, as I'm just
registering an alias for the clock there...

> > +	if (priv->clk) {
> > +		ret = clk_prepare_enable(priv->clk);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (priv->pwdn_gpio) {
> > +		gpiod_set_value(priv->pwdn_gpio, 1);
> > +		usleep_range(500, 1000);
> > +	}
> > +
> > +	/* Reset GPIOs are shared in some platforms. */
>
> I'd make this a FIXME comment as this is really a hack.
>
> 	/*
> 	 * FIXME: The reset signal is connected to a shared GPIO on some
> 	 * platforms (namely the SuperH Migo-R). Until a framework becomes
> 	 * available to handle this cleanly, request the GPIO temporarily
> 	 * only to avoid conflicts.
> 	 */
>
> Same for the tw9910 driver.

Ack.

Thanks
    j
