From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 19 Apr 2012 09:59:59 +0000
Subject: Re: [PATCH 3/6] spi: spi-sh-msiof: do not manage PM clocks manually
Message-Id: <Pine.LNX.4.64.1204191140120.2110@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Thu, 19 Apr 2012, Magnus Damm wrote:

> On Wed, Apr 18, 2012 at 8:28 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On sh-mobile platforms the bus clock frequency for the MSIOF unit is
> > obtained from the same clock, as the one, that runtime power-manages the
> > controller. The MSIOF driver has to access that clock directly,
> > bypassing the runtime PM framework, to get its frequency, but it
> > shouldn't enable or disable it.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Usually I don't say this, but here's a NAK!

You definitely should say this in such cases - especially when the whole 
series is marked as "RFC" exactly for this reason - because I wasn't sure 
whether my problem-interpretation and solutions were right. So, now we 
came to a conclusion, that we do want clocks to be managed from the two 
APIs - runtime PM and clkdev, however ugly that seems to me:-) ATM there 
just doesn't seem to be a better solution available. And we have to fix 
MMCIF and SDHI to also correctly do the same: hold a clock reference for 
as long as a stable clock frequency is required, and re-read the frequency 
every time the clock is switched on.

One more doubt though: in principle just doing pm_runtime_get_sync() (on 
sh-mobile) also guarantees, that the clock frequency will be stable from 
that point on, because internally it does clk_get() too? We just want 
explicit calls for generic cases, where the bus clock is not managed by 
the runtime PM?

> The driver is fine as-is, please don't remove the clk_enable() and
> clk_disable() calls. We want the driver to tell the clock framework
> that it should keep the clock frequency fixed while the clock is
> enabled, so if you remove the clk_enable() and clk_disable() calls you
> also remove this way of notification.
> 
> Cheers,
> 
> / magnus

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
