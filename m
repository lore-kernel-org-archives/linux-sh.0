From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 16 Jan 2018 11:45:47 +0000
Subject: Re: [PATCH v5 6/9] media: i2c: ov772x: Remove soc_camera dependencies
Message-Id: <3160666.n1yGRyzbCt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1515765849-10345-1-git-send-email-jacopo+renesas@jmondi.org> <1515765849-10345-7-git-send-email-jacopo+renesas@jmondi.org> <d0249577-ebd5-aa4d-b017-c11fae9c612a@xs4all.nl>
In-Reply-To: <d0249577-ebd5-aa4d-b017-c11fae9c612a-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Hans,

On Tuesday, 16 January 2018 12:08:17 EET Hans Verkuil wrote:
> On 01/12/2018 03:04 PM, Jacopo Mondi wrote:
> > Remove soc_camera framework dependencies from ov772x sensor driver.
> > - Handle clock and gpios
> > - Register async subdevice
> > - Remove soc_camera specific g/s_mbus_config operations
> > - Change image format colorspace from JPEG to SRGB as the two use the
> > 
> >   same colorspace information but JPEG makes assumptions on color
> >   components quantization that do not apply to the sensor
> > 
> > - Remove sizes crop from get_selection as driver can't scale
> > - Add kernel doc to driver interface header file
> > - Adjust build system
> > 
> > This commit does not remove the original soc_camera based driver as long
> > as other platforms depends on soc_camera-based CEU driver.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  drivers/media/i2c/Kconfig  |  11 +++
> >  drivers/media/i2c/Makefile |   1 +
> >  drivers/media/i2c/ov772x.c | 177 ++++++++++++++++++++++++++++------------
> >  include/media/i2c/ov772x.h |   6 +-
> >  4 files changed, 133 insertions(+), 62 deletions(-)

[snip]

> > diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
> > index 8063835..df2516c 100644
> > --- a/drivers/media/i2c/ov772x.c
> > +++ b/drivers/media/i2c/ov772x.c

[snip]

> > @@ -1038,12 +1074,11 @@ static int ov772x_probe(struct i2c_client *client,
> >  			const struct i2c_device_id *did)
> >  {
> >  	struct ov772x_priv	*priv;
> > -	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
> > -	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
> > +	struct i2c_adapter	*adapter = client->adapter;
> >  	int			ret;
> > 
> > -	if (!ssdd || !ssdd->drv_priv) {
> > -		dev_err(&client->dev, "OV772X: missing platform data!\n");
> > +	if (!client->dev.platform_data) {
> > +		dev_err(&client->dev, "Missing OV7725 platform data\n");
> 
> Nitpick: I'd prefer lowercase in this string: ov7725. It also should be
> ov772x.

Agreed.

> >  		return -EINVAL;
> >  	
> >  	}

[snip]

> > @@ -1119,6 +1176,6 @@ static struct i2c_driver ov772x_i2c_driver = {
> > 
> >  module_i2c_driver(ov772x_i2c_driver);
> > 
> > -MODULE_DESCRIPTION("SoC Camera driver for ov772x");
> > +MODULE_DESCRIPTION("V4L2 driver for OV772x image sensor");
> 
> Ditto: lower case ov772x.

I'd keep that uppercase. The usual practice (unless I'm mistaken) is to use 
uppercase for chip names and lowercase for driver names. The description 
clearly refers to the chip, so uppercase seems better to me.

> >  MODULE_AUTHOR("Kuninori Morimoto");
> >  MODULE_LICENSE("GPL v2");
> 
> Hmm, shouldn't there be a struct of_device_id as well? So this can be
> used in the device tree?
> 
> I see this sensor was only tested with a non-dt platform. Is it possible
> to test this sensor with the GR-Peach platform (which I gather uses the
> device tree)?
> 
> Making this driver DT compliant can be done as a follow-up patch.

I think it's a good idea, but I'd prefer having that in a separate patch. We 
will also need DT bindings, it's a bit out of scope for this series.

Jacopo, you can keep my ack after addressing Hans' comments.

-- 
Regards,

Laurent Pinchart

