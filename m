From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Oct 2012 08:37:32 +0000
Subject: Re: [PATCH 10/14] media: soc-camera: support OF cameras
Message-Id: <Pine.LNX.4.64.1210081028270.11034@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1348754853-28619-11-git-send-email-g.liakhovetski@gmx.de> <506F30E8.10206@gmail.com>
In-Reply-To: <506F30E8.10206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: linux-media@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Hi Sylwester

On Fri, 5 Oct 2012, Sylwester Nawrocki wrote:

> On 09/27/2012 04:07 PM, Guennadi Liakhovetski wrote:
> > With OF we aren't getting platform data any more. To minimise changes we
> > create all the missing data ourselves, including compulsory struct
> > soc_camera_link objects. Host-client linking is now done, based on the OF
> > data. Media bus numbers also have to be assigned dynamically.
> > 
> > Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> > ---
> ...
> >   static int soc_camera_i2c_notify(struct notifier_block *nb,
> >   				 unsigned long action, void *data)
> >   {
> > @@ -1203,13 +1434,20 @@ static int soc_camera_i2c_notify(struct
> > notifier_block *nb,
> >   	struct v4l2_subdev *subdev;
> >   	int ret;
> > 
> > -	if (client->addr != icl->board_info->addr ||
> > -	    client->adapter->nr != icl->i2c_adapter_id)
> > +	dev_dbg(dev, "%s(%lu): %x on %u\n", __func__, action,
> > +		client->addr, client->adapter->nr);
> > +
> > +	if (!soc_camera_i2c_client_match(icl, client))
> >   		return NOTIFY_DONE;
> > 
> >   	switch (action) {
> >   	case BUS_NOTIFY_BIND_DRIVER:
> >   		client->dev.platform_data = icl;
> > +		if (icl->of_link) {
> > +			struct soc_camera_of_client *sofc > > container_of(icl->of_link,
> > +						struct soc_camera_of_client,
> > of_link);
> > +			soc_camera_of_i2c_ifill(sofc, client);
> > +		}
> > 
> >   		return NOTIFY_OK;
> >   	case BUS_NOTIFY_BOUND_DRIVER:
> 
> There is no need for different handling of this event as well ?

There is. The former is entered before the sensor I2C probe method is 
called and prepares the data for probing, the latter is entered after a 
successful sensor I2C probing.

> Further, there is code like:
> 
> 	adap = i2c_get_adapter(icl->i2c_adapter_id);
> 
> which is clearly not going to work in OF case.

It does work. See the call to soc_camera_of_i2c_ifill() under 
BUS_NOTIFY_BIND_DRIVER above. In it

	icl->i2c_adapter_id = client->adapter->nr;

> Could you clarify how it is supposed to work ?

It is not only supposed to work, it actually does work. Does the above 
explain it sufficiently?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
