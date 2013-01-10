From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Jan 2013 01:30:56 +0000
Subject: Re: [PATCH v2 00/29] SH pinctrl and pinmux implementation
Message-Id: <20130110013056.GA14282@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 09, 2013 at 10:34:42AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 09 January 2013 16:08:01 Simon Horman wrote:
> > On Wed, Jan 09, 2013 at 04:06:01PM +0900, Simon Horman wrote:
> > > On Wed, Jan 09, 2013 at 11:36:38AM +0900, Simon Horman wrote:
> > > > On Wed, Jan 09, 2013 at 01:52:20AM +0100, Laurent Pinchart wrote:
> > > > > Hello,
> > > > > 
> > > > > Here's the second version of the SuperH and SH Mobile pin controllers
> > > > > (PFC) pinctrl and pinmux support patches. The patches are based on my
> > > > > previous PFC patch series ("[PATCH v4 00/81] SH pin control and GPIO
> > > > > rework") and are available from my git tree at
> > > > > 
> > > > >         git://linuxtv.org/pinchartl/fbdev.git pinmux-pinctrl
> > > > > 
> > > > > The series depends on three patches from Linus Walleij that implement
> > > > > default pinmux configuration in the device core. This solves the
> > > > > bonito board issue mentioned in v1. Those patches are included in
> > > > > this set for convenience.
> > > > 
> > > > Is "ARM: shmobile: bonito: Register pinctrl mappings for LCDC0"
> > > > the only patch in the series that depends on Linus's patches?
> > > > 
> > > > > As the two dependencies will go to mainline through separate trees we
> > > > > will need coordination to push this set. It would probably be easier
> > > > > if it went through the mach-shmobile tree, in which case Linus'
> > > > > patches should go in early during the merge window. Linus, would that
> > > > > be fine with you ? Are your three patches included in this series
> > > > > ready for mainline ? If so, can you provide a stable branch that you
> > > > > will push ?
> > > > 
> > > > The first patch "pinctrl: fix comment mistak" seems to be
> > > > in Linus's tree, post-3.8-rc2.
> > > 
> > > In the mean time I have applied the first 3 patches to a pinmux
> > > branch in the renesas tree. This is intended as a temporary solution
> > > to provide the dependency for the rest of the series. I am happy
> > > to rebase on v3.8-rc3 when it is released, which should include the
> > > first patch, and use this as a more permanent solution if Linus is happy
> > > with it.
> 
> If Linus can provide a stable branch that will be pushed to mainline we could 
> rebase the code on top of that. How can we ensure that his pull request will 
> be processed first ?

I am not entirely sure, but I think it can work as follows:

1. Linus provides a stable branch
2. I rebase on top of that branch and send a pull request to arm-soc
3. arm-soc pulls my tree

The result is that Linus's branch is pulled by arm-soc.
If it is also pulled via another channel that should be fine as
the commit id should be stable and git should work things out.

I think.

> > > I have also applied the remaining patches in the series.
> > > 
> > > patch 1: pfc3 branch
> > > patch 2, 4, 5, 8, 8: boards branch
> > > patch 3, 6: soc2 branch
> > 
> > Sorry, the above should read:
> > 
> > patch 4-21: pfc3
> > patch 22, 23, 26, 27: boards
> > patch 23, 28: pfc4
> 
> I assume you mean 24 and 28 here.

Yes.

> > patch 25, 29: soc3
> 
> Looks good to me.
> 
> > > The next branch is a merge of branch and should include this entire
> > > series,
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
