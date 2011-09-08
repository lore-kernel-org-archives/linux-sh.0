From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 08 Sep 2011 01:21:20 +0000
Subject: Re: [PATCH] serial: sh-sci: don't filter on DMA device, use only channel ID
Message-Id: <20110908012119.GJ22142@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1109051002400.1112@axis700.grange> <1315228408.26251.75.camel@vkoul-udesk3> <Pine.LNX.4.64.1109051532220.1112@axis700.grange> <1315233788.26251.163.camel@vkoul-udesk3> <Pine.LNX.4.64.1109051700030.1112@axis700.grange> <1315235335.26251.194.camel@vkoul-udesk3> <Pine.LNX.4.64.1109051716530.1112@axis700.grange> <438BB0150E931F4B9CE701519A4463010871804A4B@bgsmsx502.gar.corp.intel.com> <alpine.DEB.2.00.1109072048310.30407@axis700.grange> <438BB0150E931F4B9CE701519A4463010871804A4F@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A4F@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "g.liakhovetski@gmx.de" <g.liakhovetski@gmx.de>, "Williams, Dan J" <dan.j.williams@intel.com>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "damm@opensource.se" <damm@opensource.se>

On Thu, Sep 08, 2011 at 03:07:53AM +0530, Koul, Vinod wrote:
> On Wed, 2011-09-07 at 22:01 +0200, Guennadi Liakhovetski wrote:
> > On Thu, 8 Sep 2011, Koul, Vinod wrote:
> > You're seriously suggesting to export and use an additional shdma private 
> > function, bypassing the dmaengine API?... That really doesn't sound like a 
> > good idea to me, sorry. How about using .device_control(DMA_SLAVE_CONFIG) 
> > from the filter function directly to verify channel suitability?
> Yes see stedma40, coh90138 drivers
> .device_control is not right place as channel is already allocated.
> 

No, that's not going to happen either. Many of these drivers are used in
different CPUs with different DMACs. The dmaengine driver in question
only applies to a subset, so the driver bits need to be wholly generic.
In short, if the dmaengine API can't handle this sort of stuff then it's
the dmaengine API that needs to be extended, we won't be working around
dmaengine shortcomings in drivers that simply want a sensible DMA API to
plug in to.
