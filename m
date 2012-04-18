From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 12:36:46 +0000
Subject: Re: [PATCH 2/6] mmc: sh_mmcif: do not manage PM clocks manually
Message-Id: <Pine.LNX.4.64.1204181422280.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204181323290.30514@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204181323290.30514@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 18 Apr 2012, Paul Mundt wrote:

> On Wed, Apr 18, 2012 at 01:28:32PM +0200, Guennadi Liakhovetski wrote:
> > On sh-mobile platforms the MMC clock frequency for the MMCIF unit is
> > obtained from the same clock, as the one, that runtime power-manages the
> > controller. The MMCIF driver has to access that clock directly,
> > bypassing the runtime PM framework, to get its frequency, but it
> > shouldn't enable or disable it.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I don't understand your logic.

The logic is simple: do not manage the same object (clk), using different 
APIs (runtime PM and clkdev).

> clk_get_rate() requires the clock to be
> enabled, the result is undefined otherwise. If you have a case where the
> clock is already enabled and you can read the rate directly that's fine,
> but it's still an API violation without enable/disable pairs.

Then the mmcif patch has to be updated. sh-mmcif is an SH-specific driver, 
and there we know, that on all platforms (so far), the runtime PM switches 
the same clock on and off for us, so, we can use this knowledge and just 
make sure to read out the clock frequency, when the device is awake. OTOH, 
as you say, this is not very clean from the API-conformance standpoint.

Another possibility would be to add a runtime PM call like 
pm_runtime_clk_get_rate(dev, con_id) to safely read out one of runtime PM 
clock's rate. Would this be a better option or should we stay generic and 
use the clkdev API to get the clock rate (turning it on before the reading 
and off afterwards) and the runtime PM API to turn it on and off as 
required for operation?

The MSIOF driver is ok as is - provided we accept, that the clock is 
turned on by runtime PM and its rate is read out using clkdev. The SDHI 
driver has to be fixed in one way or another.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
