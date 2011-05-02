From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 02 May 2011 09:53:15 +0000
Subject: Re: [PATCH 2/2] dmaengine: shdma: add runtime- and system-level
Message-Id: <Pine.LNX.4.64.1105021117060.13244@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104291901200.17813@axis700.grange> 
 <Pine.LNX.4.64.1104291908090.17813@axis700.grange>  <1304323391.1589.9.camel@vkoul-udesk3>
  <Pine.LNX.4.64.1105021056231.13244@axis700.grange> <1304325486.1589.15.camel@vkoul-udesk3>
In-Reply-To: <1304325486.1589.15.camel@vkoul-udesk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>

On Mon, 2 May 2011, Koul, Vinod wrote:

> On Mon, 2011-05-02 at 11:04 +0200, Guennadi Liakhovetski wrote:
> > On Mon, 2 May 2011, Koul, Vinod wrote:
> > 
> > > On Fri, 2011-04-29 at 19:09 +0200, Guennadi Liakhovetski wrote:
> > > > This patch extends and fixes runtime power management in the shdma
> > > > driver to support powering down the DMA controller and adds support
> > > > for system-level suspend and resume.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > ---
> > > >  drivers/dma/shdma.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/dma/shdma.h |    1 +
> > > >  2 files changed, 69 insertions(+), 0 deletions(-)
> > > > 
> > > 
> > > >  
> > > > +static int sh_dmae_runtime_suspend(struct device *dev)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > Don't you need to initialize you device on resume...????
> > 
> > Hm, yes, but this is suspend... Resume is below. Sorry, I probably don't 
> > understand your question.
> Opps, my question was for empty suspend. Dont you need to power off you
> device.

Powering down and up is performed by platform / domain hooks. I only need 
to reset the hardware on wakeup. An empty .runtime_suspend() is needed by 
the sh-mobile specific rtpm, at least by the version, that I have, because 
otherwise the device status will not be changed and the resume will not be 
called.

> > > > +
> > > > +static int sh_dmae_runtime_resume(struct device *dev)
> > > > +{
> > > > +	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
> > > > +
> > > > +	return sh_dmae_rst(shdev);
> > > > +}
> > > > +
> > > > +#ifdef CONFIG_PM
> > > This should be removed...
> > 
> > You mean, these functions just won't be called, but this way we save a 
> > couple of bytes if PM is not set, don't we?
> I meant you dont need to have this, PM is usually part of core options
> which ppl enable nowadays. Do you run with PM disabled?

I actually do, but maybe that's not a very important argument. So, if the 
only difference is a couple of kilobytes in the kernel size, then maybe we 
can just keep it always enabled. There are no other side-efects to it, 
right?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
