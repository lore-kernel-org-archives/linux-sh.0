From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 May 2012 08:33:42 +0000
Subject: Re: [PATCH 06/29] regulator: export a function to check if regulator can change status
Message-Id: <Pine.LNX.4.64.1205181030550.23140@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
 <20120503152558.GL3955@opensource.wolfsonmicro.com>
In-Reply-To: <20120503152558.GL3955@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Mark

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:35PM +0200, Guennadi Liakhovetski wrote:
> > Some consumers, e.g., the mmc subsystem, can benefit from an ability to
> > check, whether a regulator can switch power on and off.
> 
> You're going to have to expand a lot more on why this is a good idea...

I want to use this call in mmc to decide whether or not to set the 
MMC_CAP_POWER_OFF_CARD mmc capability flag. This flag is used with SDIO 
cards to decide whether or not to enable runtime PM for them.

> Bear in mind that the regulator may be shared by other users so even if
> the regulator is flagged as potentially being able to change status that
> doesn't mean that it actually can change status.

Yes, I think, that's ok. We just need to know, that the card can in 
principle be powered off. We don't need a guarantee, that we can power it 
down at any time, when we think we need it.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
