From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Oct 2012 16:00:45 +0000
Subject: Re: [PATCH 05/14] media: add a V4L2 OF parser
Message-Id: <Pine.LNX.4.64.1210081758280.14454@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <201210081653.55984.hverkuil@xs4all.nl>
 <Pine.LNX.4.64.1210081708240.14454@axis700.grange>
 <201210081741.43546.hverkuil@xs4all.nl>
 <Pine.LNX.4.64.1210081748390.14454@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210081748390.14454-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 8 Oct 2012, Guennadi Liakhovetski wrote:

> On Mon, 8 Oct 2012, Hans Verkuil wrote:
> 
> > On Mon October 8 2012 17:15:53 Guennadi Liakhovetski wrote:

[snip]

> > > No, I don't think there is a way to get a device pointer from a DT node.
> > 
> > Not a device pointer, but the i2c bus and i2c address. With that information
> > you can get the i2c_client, and with that you can get the subdev pointer.
> 
> How? How can you get a client pointer from adapter and i2c device address? 
> I haven't found anything suitable in i2c.h.

Ok, you could use of_find_i2c_device_by_node(), but the second argument 
remains - if you need notifiers in one case, I don't think it makes sense 
to implement multiple methods.

Thanks
Guennadi

> > If there is no way to get that information from the proposed V4L2 DT, then
> > it needs to be modified since a bridge driver really needs to know which
> > subdevs it has to register with the v4l2_device struct. That information is
> > also board specific so it should be part of the DT.
> > 
> > > 
> > > > In my view you cannot do a proper initialization unless you have both the
> > > > bridge driver and all subdev drivers loaded and instantiated. They need one
> > > > another. So I am perfectly fine with letting the probe function do next to
> > > > nothing and postponing that until register() is called. I2C and actual probing
> > > > to check if it's the right device is a bad idea in general since you have no
> > > > idea what a hardware access to an unknown i2c device will do. There are still
> > > > some corner cases where that is needed, but I do not think that that is an
> > > > issue here.
> > > > 
> > > > It would simplify things a lot IMHO. Also note that the register() op will
> > > > work with any device, not just i2c. That may be a useful property as well.
> > > 
> > > And what if the subdevice device is not yet instantiated by OF by the time 
> > > your bridge driver probes?
> > 
> > That is where you still need to have a bus notifier mechanism. You have to be
> > able to wait until all dependent drivers are loaded/instantiated,
> 
> No, drivers are not the problem, as you say, you can load them. Devices 
> are the problem. You don't know when they will be registered.
> 
> > or
> > alternatively you have to be able to load them explicitly. But this should
> > be relatively easy to implement in a generic manner.
> 
> So, if you need notifiers anyway, why not use them in all cases instead of 
> mixing multiple methods?
> 
> Thanks
> Guennadi
> 
> > I still think this sucks (excuse my language), but I see no way around it as
> > long as there is no explicit probe order one can rely on.
> > 
> > Regards,
> > 
> > 	Hans
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
