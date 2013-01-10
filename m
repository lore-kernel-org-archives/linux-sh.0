From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Jan 2013 01:31:40 +0000
Subject: Re: [PATCH v2 00/29] SH pinctrl and pinmux implementation
Message-Id: <20130110013140.GB14282@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 09, 2013 at 10:29:31AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 09 January 2013 11:36:38 Simon Horman wrote:
> > On Wed, Jan 09, 2013 at 01:52:20AM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > Here's the second version of the SuperH and SH Mobile pin controllers
> > > (PFC) pinctrl and pinmux support patches. The patches are based on my
> > > previous PFC patch series ("[PATCH v4 00/81] SH pin control and GPIO
> > > rework") and are available from my git tree at
> > > 
> > >         git://linuxtv.org/pinchartl/fbdev.git pinmux-pinctrl
> > > 
> > > The series depends on three patches from Linus Walleij that implement
> > > default pinmux configuration in the device core. This solves the bonito
> > > board issue mentioned in v1. Those patches are included in this set for
> > > convenience.
> >
> > Is "ARM: shmobile: bonito: Register pinctrl mappings for LCDC0"
> > the only patch in the series that depends on Linus's patches?
> 
> Unfortunately not. The following patches depend on Linus' patches:
> 
>    ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
>    ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
>    ARM: shmobile: bonito: Register pinctrl mappings for LCDC0

Thanks.

> 
> > > As the two dependencies will go to mainline through separate trees we will
> > > need coordination to push this set. It would probably be easier if it went
> > > through the mach-shmobile tree, in which case Linus' patches should go in
> > > early during the merge window. Linus, would that be fine with you ? Are
> > > your three patches included in this series ready for mainline ? If so,
> > > can you provide a stable branch that you will push ?
> > 
> > The first patch "pinctrl: fix comment mistak" seems to be
> > in Linus's tree, post-3.8-rc2.
> 
> Nice. Only two patches to go then :-)

Indeed.
