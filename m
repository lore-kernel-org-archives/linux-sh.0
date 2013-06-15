From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Sat, 15 Jun 2013 08:51:33 +0000
Subject: Re: [PATCH v11 00/21] V4L2 clock and asynchronous probing
Message-Id: <201306151051.33440.hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1371236911-15131-1-git-send-email-g.liakhovetski@gmx.de> <2342425.VllfyDroN8@avalon> <Pine.LNX.4.64.1306142244310.11221@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306142244310.11221@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Fri June 14 2013 22:45:15 Guennadi Liakhovetski wrote:
> Hi Laurent
> 
> On Fri, 14 Jun 2013, Laurent Pinchart wrote:
> 
> > Hi Guennadi,
> > 
> > Thank you for the patches.
> > 
> > On Friday 14 June 2013 21:08:10 Guennadi Liakhovetski wrote:
> > > v11 of the V4L2 clock helper and asynchronous probing patch set.
> > > Functionally identical to v10, only differences are a couple of comment
> > > lines and one renamed struct field - as requested by respectable
> > > reviewers :)
> > > 
> > > Only patches #15, 16 and 18 changed.
> > 
> > [snip]
> > 
> > >  .../devicetree/bindings/media/sh_mobile_ceu.txt    |   18 +
> > 
> >    Documentation/video4linux/v4l2-framework.txt is missing :-)
> 
> I know. I will add it as soon as these patches are in.

Can you please post a first version earlier? I am hesitant to Ack the series
without knowing that there is at least a first version of the documentation
posted. We have had bad experiences in the past with code being committed and
no documentation.

Regards,

	Hans
