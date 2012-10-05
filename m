From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Oct 2012 11:35:03 +0000
Subject: Re: [PATCH 05/14] media: add a V4L2 OF parser
Message-Id: <Pine.LNX.4.64.1210051333020.13761@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <201210051241.52205.hverkuil@xs4all.nl> <Pine.LNX.4.64.1210051250210.13761@axis700.grange>
 <201210051323.45571.hverkuil@xs4all.nl>
In-Reply-To: <201210051323.45571.hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-media@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

On Fri, 5 Oct 2012, Hans Verkuil wrote:

> On Fri October 5 2012 12:58:21 Guennadi Liakhovetski wrote:
> > On Fri, 5 Oct 2012, Hans Verkuil wrote:

[snip]

> > > One area that I do not yet completely understand is the i2c bus notifications
> > > (or asynchronous loading or i2c modules).
> > > 
> > > I would have expected that using OF the i2c devices are still initialized
> > > before the host/bridge driver is initialized. But I gather that's not the
> > > case?
> > 
> > No, it's not. I'm not sure, whether it depends on the order of devices in 
> > the .dts, but, I think, it's better to not have to mandate a certain order 
> > and I also seem to have seen devices being registered in different order 
> > with the same DT, but I'm not 100% sure about that.
> > 
> > > If this deferred probing is a general problem, then I think we need a general
> > > solution as well that's part of the v4l2 core.
> > 
> > That can be done, perhaps. But we can do it as a next step. As soon as 
> > we're happy with the OF implementation as such, we can commit that, 
> > possibly leaving soc-camera patches out for now, then we can think where 
> > to put async I2C handling.
> 
> It would be good to have a number of 'Reviewed-by's or 'Acked-by's for the
> DT binding documentation at least before it is merged.

Definitely, I'm sure you'll be honoured to be the first one in the list;-)

> I think the soc_camera patches should be left out for now. I suspect that
> by adding core support for async i2c handling first, the soc_camera patches
> will become a lot easier to understand.

Ok, we can do this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
