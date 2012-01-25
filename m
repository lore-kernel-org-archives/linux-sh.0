From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 25 Jan 2012 10:05:03 +0000
Subject: Re: [PATCH] sh: se7724: fix compile breakage
Message-Id: <Pine.LNX.4.64.1201251102510.18778@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201250909220.18778@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201250909220.18778@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 25 Jan 2012, Paul Mundt wrote:

> On Wed, Jan 25, 2012 at 10:31:26AM +0100, Laurent Pinchart wrote:
> > Hi Guennadi,
> > 
> > Thanks for the patch.
> > 
> > On Wednesday 25 January 2012 09:10:29 Guennadi Liakhovetski wrote:
> > > Fix compilation breakage
> > > 
> > > arch/sh/boards/mach-se/7724/setup.c:182: error: 'V4L2_PIX_FMT_RGB565'
> > > undeclared here (not in a function) make[3]: ***
> > > [arch/sh/boards/mach-se/7724/setup.o] Error 1
> > > 
> > > caused by commit "fbdev: sh_mobile_lcdc: Support FOURCC-based format API"
> > 
> > My bad. The following files also need to include linux/videovdev2.h. Should I 
> > send a separate patch, or do you want to include them in your patch ?
> > 
> > arch/sh/boards/mach-kfr2r09/setup.c
> > arch/sh/boards/mach-ap325rxa/setup.c
> > arch/sh/boards/mach-migor/setup.c
> > arch/sh/boards/mach-ecovec24/setup.c
> > 
> All at once would be nice.

All the above boards include - directly or indirectly - soc_camera.h, 
which then includes videodev2.h, so, they compile fine. Of course, they 
still should include headers explicitly instead, so, they should be fixed 
too, it's just less critical. Anyway, I'll resumbit with all those boards 
included.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
