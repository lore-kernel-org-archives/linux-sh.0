From: "Koul, Vinod" <vinod.koul@intel.com>
Date: Mon, 02 May 2011 10:17:47 +0000
Subject: Re: [PATCH 2/2] dmaengine: shdma: add runtime- and system-level
Message-Id: <1304330747.1589.23.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104291901200.17813@axis700.grange>
	 <Pine.LNX.4.64.1104291908090.17813@axis700.grange>
	 <1304323391.1589.9.camel@vkoul-udesk3>
	 <Pine.LNX.4.64.1105021056231.13244@axis700.grange>
	 <1304325486.1589.15.camel@vkoul-udesk3>
	 <Pine.LNX.4.64.1105021117060.13244@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105021117060.13244@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>

On Mon, 2011-05-02 at 11:53 +0200, Guennadi Liakhovetski wrote:
> On Mon, 2 May 2011, Koul, Vinod wrote:
> 
> > On Mon, 2011-05-02 at 11:04 +0200, Guennadi Liakhovetski wrote:
> > > On Mon, 2 May 2011, Koul, Vinod wrote:
> > > 
> > > > On Fri, 2011-04-29 at 19:09 +0200, Guennadi Liakhovetski wrote:
> > > > > This patch extends and fixes runtime power management in the shdma
> > > > > driver to support powering down the DMA controller and adds support
> > > > > for system-level suspend and resume.
> > > > > 
> > > > > +
> > > > > +static int sh_dmae_runtime_resume(struct device *dev)
> > > > > +{
> > > > > +	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
> > > > > +
> > > > > +	return sh_dmae_rst(shdev);
> > > > > +}
> > > > > +
> > > > > +#ifdef CONFIG_PM
> > > > This should be removed...
> > > 
> > > You mean, these functions just won't be called, but this way we save a 
> > > couple of bytes if PM is not set, don't we?
> > I meant you dont need to have this, PM is usually part of core options
> > which ppl enable nowadays. Do you run with PM disabled?
> 
> I actually do, but maybe that's not a very important argument. So, if the 
> only difference is a couple of kilobytes in the kernel size, then maybe we 
> can just keep it always enabled. There are no other side-efects to it, 
> right?
Yes, other driver currently do this...

-- 
~Vinod

