From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 May 2014 06:05:23 +0000
Subject: Re: [RFC/PATCH 5/6] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <20140501060523.GB15507@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 30, 2014 at 06:21:47PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 30 April 2014 10:29:23 Simon Horman wrote:
> > On Wed, Apr 30, 2014 at 03:02:20AM +0200, Laurent Pinchart wrote:
> > > On Wednesday 30 April 2014 09:59:56 Simon Horman wrote:
> > > > On Wed, Apr 30, 2014 at 02:31:45AM +0200, Laurent Pinchart wrote:
> > > > > SCIF0 and SCIF1 are used as debug serial ports. Enable them and
> > > > > configure pinmuxing appropriately. We can now remove the clkdev
> > > > > registration hack for SCIF devices from the Lager reference board
> > > > > file.
> > > > > 
> > > > > As a side effect of switching to DT-based serial port instantiation,
> > > > > ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
> > > > > source if now shared between lager and lager-reference, we need to
> > > > > update the serial ports in C code as well.
> > > > 
> > > > I believe the second paragraph is no longer correct.
> > > 
> > > Oops, you're right. If no other problem is found with the series, could
> > > you please just drop that paragraph ?
> > 
> > Yes. But could you look at my other comment below?
> 
> Oops, I've missed that.
> 
> > I'm unsure why the clock workaround is no longer needed.
> > 
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > ---
> > > > > 
> > > > >  arch/arm/boot/dts/r8a7790-lager.dts            | 21 ++++++++++++++++-
> > > > >  arch/arm/mach-shmobile/board-lager-reference.c | 10 ----------
> > > > >  arch/arm/mach-shmobile/setup-r8a7790.c         | 10 +++++-----
> > > > >  3 files changed, 25 insertions(+), 16 deletions(-)
> 
> [snip]
> 
> > > > > diff --git a/arch/arm/mach-shmobile/board-lager-reference.c
> > > > > b/arch/arm/mach-shmobile/board-lager-reference.c index
> > > > > 1eb48cf..013c42b
> > > > > 100644
> > > > > --- a/arch/arm/mach-shmobile/board-lager-reference.c
> > > > > +++ b/arch/arm/mach-shmobile/board-lager-reference.c
> > > > > @@ -91,16 +91,6 @@ static void __init lager_add_du_device(void)
> > > > >   */
> > > > >  static const struct clk_name clk_names[] __initconst = {
> > > > >  	{ "cmt0", NULL, "sh_cmt.0" },
> > > > > -	{ "scifa0", NULL, "sh-sci.0" },
> > > > > -	{ "scifa1", NULL, "sh-sci.1" },
> > > > > -	{ "scifb0", NULL, "sh-sci.2" },
> > > > > -	{ "scifb1", NULL, "sh-sci.3" },
> > > > > -	{ "scifb2", NULL, "sh-sci.4" },
> > > > > -	{ "scifa2", NULL, "sh-sci.5" },
> > > > > -	{ "scif0", NULL, "sh-sci.6" },
> > > > > -	{ "scif1", NULL, "sh-sci.7" },
> > > > > -	{ "hscif0", NULL, "sh-sci.8" },
> > > > > -	{ "hscif1", NULL, "sh-sci.9" },
> > > > >  	{ "du0", "du.0", "rcar-du-r8a7790" },
> > > > >  	{ "du1", "du.1", "rcar-du-r8a7790" },
> > > > >  	{ "du2", "du.2", "rcar-du-r8a7790" },
> > > > 
> > > > Is this correct. Magnus seemed to think otherwise for a slightly
> > > > different change I proposed for Marzen.
> 
> The clk_names array workaround is only needed to expose DT-defined clocks to 
> non-DT devices. Now that the SCIF devices are instantiated from DT, we don't 
> need SCIF entries in the array anymore.
> 
> The clk_enables array workaround is needed for drivers that don't enable the 
> device clock(s) manually and instead rely on runtime PM to do so. As the sh-
> sci driver enables the clock manually there's no need to add SCIF entries to 
> the clk_enables array.

Thanks for the clarification.

I will update my marzen patch to follow the pattern above.
