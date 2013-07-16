From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Jul 2013 05:06:25 +0000
Subject: Re: [PATCH v7 00/19] SH Mobile pinctrl DT support
Message-Id: <20130716050623.GA8431@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372961852-28490-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372961852-28490-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 05, 2013 at 01:11:38PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 05 July 2013 09:13:14 Simon Horman wrote:
> > On Thu, Jul 04, 2013 at 08:17:13PM +0200, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > Here's the seventh version of the SH Mobile pin controllers (PFC) DT
> > > support patch set.
> > > 
> > > The patches depend on the v3.11-rc pinctrl core. Linus Torvald has merged
> > > the pinctrl tree into his master branch, so I've based this series on a
> > > merge of Linus' master and tags/renesas-next-20130704v3 from Simon's tree
> > > (git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git). The
> > > result is available in my tree at
> > > 
> > >         git://linuxtv.org/pinchartl/fbdev.git pinmux/3.11/dt
> > > 
> > > The series is pretty self-explanatory. The patches gradually move SoC code
> > > and board code over to the device tree for the armadilla800eva-reference,
> > > kzm9g-reference and marzen-reference boards. The code has been tested on
> > > the three boards, but armadillo800eva has received less testing as it
> > > can't be booted all the way to userspace with network support due to
> > > missing DT bindings.
> > > 
> > > As the patches only touch the SH Mobile architecture they can all be
> > > merged through Simon's tree. Simon, will you rebase your tree on v3.11-rc1
> > > when it will be tagged ?
> > 
> > In general I like to rebase once the renesas code that was accepted into
> > the arm-soc tree has been accepted into Linus's tree.
> > 
> > It appears that is already the case, except for some late fixes
> > (renesas-fixes2-for-v3.11), as of the current (pre v3.11-rc1) master branch
> > of Linus's tree. So yes, I plan to rebase once v3.11-rc1 is tagged.
> 
> Great, thanks.

I have now rebased.  Accordingly, this series is now queued up for v3.12 in
the pinmux branch. That branch is based directly on  v3.11-rc1. This
is available in renesas-devel-20130716.
