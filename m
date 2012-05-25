From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 May 2012 10:59:44 +0000
Subject: Re: [PATCH 1/9 v3] dmaengine: add an shdma-base library
Message-Id: <Pine.LNX.4.64.1205251255310.13353@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de> 
 <1336576161-27082-2-git-send-email-g.liakhovetski@gmx.de> 
 <1337055734.16185.5360.camel@vkoul-udesk3>  <Pine.LNX.4.64.1205171912140.10086@axis700.grange>
 <1337933737.1580.8.camel@vkoul-udesk3> <4FBF5EA9.704@nvidia.com>
In-Reply-To: <4FBF5EA9.704@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Mundt <lethal@linux-sh.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

Hi Laxman

On Fri, 25 May 2012, Laxman Dewangan wrote:

> On Friday 25 May 2012 01:45 PM, Vinod Koul wrote:
> > On Fri, 2012-05-18 at 10:21 +0200, Guennadi Liakhovetski wrote:
> 
> > +/*
> > > > > + * Drivers, using this library are expected to embed struct
> > > > > shdma_dev,
> > > > > + * struct shdma_chan, struct shdma_desc, and struct shdma_slave
> > > > > + * in their respective device, channel, descriptor and slave objects.
> > > > > + */
> > > > > +
> > > > > +struct shdma_slave {
> > > > > +	unsigned int slave_id;
> > > > this should be moved to struct dma_slave_config
> > > Again, this would be a functional change. And struct dma_slave_config
> > > doesn't have a slave-ID field in it, which is the only thing we need for
> > > now. Instead it has a bunch of other fields, of which none is so far used
> > > by this driver.
> > > 
> 
> In Nvidia's tegra SOC also require to pass the slave id from client to dma
> driver. I have pushed the change to make it part of struct dma_slave_config
> on the patch
> [PATCH V4 1/2] dma: dmaengine: add slave req id in slave_config
> 
> So hope you can use the same if that patch get merged.

Thanks for letting me know. After both our series get merged, when working 
on removal of .private use, switching to your new .slave_id will really be 
the way to go for us.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
