From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Apr 2013 10:53:44 +0000
Subject: Re: [PATCH v6 3/7] media: soc-camera: switch I2C subdevice drivers to use v4l2-clk
Message-Id: <Pine.LNX.4.64.1304081250200.29945@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1363382873-20077-1-git-send-email-g.liakhovetski@gmx.de>
 <1363382873-20077-4-git-send-email-g.liakhovetski@gmx.de> <3250836.ovo27np6Xb@avalon>
In-Reply-To: <3250836.ovo27np6Xb@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

On Wed, 27 Mar 2013, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> Thanks for the patch.
> 
> On Friday 15 March 2013 22:27:49 Guennadi Liakhovetski wrote:
> > Instead of centrally enabling and disabling subdevice master clocks in
> > soc-camera core, let subdevice drivers do that themselves, using the
> > V4L2 clock API and soc-camera convenience wrappers.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> [snip]
> 
> > diff --git a/drivers/media/platform/soc_camera/soc_camera.c
> > b/drivers/media/platform/soc_camera/soc_camera.c index 4e626a6..01cd5a0
> > 100644
> > --- a/drivers/media/platform/soc_camera/soc_camera.c
> > +++ b/drivers/media/platform/soc_camera/soc_camera.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/vmalloc.h>
> > 
> >  #include <media/soc_camera.h>
> > +#include <media/v4l2-clk.h>
> >  #include <media/v4l2-common.h>
> >  #include <media/v4l2-ioctl.h>
> >  #include <media/v4l2-dev.h>
> > @@ -50,13 +51,19 @@ static LIST_HEAD(hosts);
> >  static LIST_HEAD(devices);
> >  static DEFINE_MUTEX(list_lock);		/* Protects the list of hosts */
> > 
> > -int soc_camera_power_on(struct device *dev, struct soc_camera_subdev_desc
> > *ssdd)
> > +int soc_camera_power_on(struct device *dev, struct soc_camera_subdev_desc
> > *ssdd,
> > +			struct v4l2_clk *clk)
> >  {
> > -	int ret = regulator_bulk_enable(ssdd->num_regulators,
> > +	int ret = clk ? v4l2_clk_enable(clk) : 0;
> > +	if (ret < 0) {
> > +		dev_err(dev, "Cannot enable clock\n");
> > +		return ret;
> > +	}
> 
> Will that work for all devices ? Aren't there devices that would need the 
> clock to be turned on after the power supply is stable ?

Swapping the order would be a functionality change. Let's not do that 
unless proven to be needed.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
