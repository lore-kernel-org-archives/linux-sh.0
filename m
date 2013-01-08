From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Tue, 08 Jan 2013 14:52:21 +0000
Subject: Re: [PATCH 1/6 v4] media: V4L2: support asynchronous subdevice registration
Message-Id: <50EC32A5.6010306@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1356544151-6313-1-git-send-email-g.liakhovetski@gmx.de> <1356544151-6313-2-git-send-email-g.liakhovetski@gmx.de> <Pine.LNX.4.64.1301071121280.23972@axis700.grange> <2418280.Sa45Lqe0AC@avalon>
In-Reply-To: <2418280.Sa45Lqe0AC@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

Hi,

On 01/08/2013 09:10 AM, Laurent Pinchart wrote:
>> +/*
>> + * If subdevice probing fails any time after v4l2_async_subdev_bind(), no
>> + * clean up must be called. This function is only a message of intention.
>> + */
>> +int v4l2_async_subdev_bind(struct v4l2_async_subdev_list *asdl);
>> +int v4l2_async_subdev_bound(struct v4l2_async_subdev_list *asdl);
>
> Could you please explain why you need both a bind notifier and a bound
> notifier ? I was expecting a single v4l2_async_subdev_register() call in
> subdev drivers (and, thinking about it, I would probably name it
> v4l2_subdev_register()).

I expected it to be done this way too, and I also used 
v4l2_subdev_register()
name in my early version of the subdev registration code where subdevs
were registering themselves to the v4l2 core.

BTW, this might not be most important thing here, but do we need separate
file, i.e. v4l2-async.c, instead of for example putting it in 
v4l2-device.c ?

>> +void v4l2_async_subdev_unbind(struct v4l2_async_subdev_list *asdl);
>> +#endif

--

Regards,
Sylwester
