From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Jun 2012 14:28:19 +0000
Subject: Re: [PATCH 01/13 v3] sh: ecovec: switch MMC power control to regulators
Message-Id: <Pine.LNX.4.64.1206281626550.1877@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1206281223500.31813@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206281223500.31813@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 28 Jun 2012, Paul Mundt wrote:

> On Thu, Jun 28, 2012 at 12:29:46PM +0200, Guennadi Liakhovetski wrote:
> > Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
> > which makes it possible to use the fixed voltage regulator driver to switch
> > card power on and off.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Applied now,

Thanks

> though you still didn't make the dev_name() changes for
> gpio_request().

I can submit that as a separate patch, though, that doesn't change much - 
those functions will disappear anyway as soon as the MMC drivers are 
updated to use regulators.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
