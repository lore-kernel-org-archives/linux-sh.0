From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Sep 2010 12:35:09 +0000
Subject: Re: [PATCH 0/5] fix SIU and Migo-R sound for 2.6.37
Message-Id: <Pine.LNX.4.64.1009171433270.4988@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <20100917121931.GC4322@rakim.wolfsonmicro.main>
In-Reply-To: <20100917121931.GC4322@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, 17 Sep 2010, Mark Brown wrote:

> On Fri, Sep 17, 2010 at 12:29:41PM +0200, Guennadi Liakhovetski wrote:
> 
> > Conversion to the multi-component design has broken the SIU driver and its 
> > users. This patch series fixes the breakages. All patches against 
> > next/master, but one of them (#4) shall also go into 2.6.36.
> 
> Please don't do this.  If you want a patch to go to Linus send it
> separately.  If you do feel the need to include the patch in another
> series not for Linus for some reason then please include it at the start
> of the series so that it can be easily split out.

Ok, sorry, but in fact this patch and the rest of the series are 
independent, so, it should be no problem just to pick it up from here, or 
do I have to re-send anything?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
