From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 09:01:55 +0000
Subject: Re: [PATCH v8 0/7] V4L2 clock and async patches and soc-camera example
Message-Id: <20130409090154.GL18478@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365433538-15975-1-git-send-email-g.liakhovetski@gmx.de>
 <20130409080731.GC18478@verge.net.au>
 <Pine.LNX.4.64.1304091013221.9051@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304091013221.9051@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

On Tue, Apr 09, 2013 at 10:14:08AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Tue, 9 Apr 2013, Simon Horman wrote:
> 
> > On Mon, Apr 08, 2013 at 05:05:31PM +0200, Guennadi Liakhovetski wrote:
> > > Mostly just a re-spin of v7 with minor modifications.
> > > 
> > > Guennadi Liakhovetski (7):
> > >   media: V4L2: add temporary clock helpers
> > >   media: V4L2: support asynchronous subdevice registration
> > >   media: soc-camera: switch I2C subdevice drivers to use v4l2-clk
> > >   soc-camera: add V4L2-async support
> > >   sh_mobile_ceu_camera: add asynchronous subdevice probing support
> > >   imx074: support asynchronous probing
> > >   ARM: shmobile: convert ap4evb to asynchronously register camera
> > >     subdevices
> > 
> > Hi Guennadi,
> > 
> > can the last patch be applied (to my tree) independently
> > of the other patches (applied elsewhere) ?
> 
> No, please, wait. It strongly depends on the whole patch series.

Thanks, understood.
