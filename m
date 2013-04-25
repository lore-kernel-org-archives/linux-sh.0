From: Simon Horman <horms@verge.net.au>
Date: Thu, 25 Apr 2013 13:03:31 +0000
Subject: Re: [PATCH v2 0/4] sh73a0: Expose the PFC-controller SDHI power gate as a regulator
Message-Id: <20130425130331.GA5121@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Laurent,

I should be able to add them tomorrow.

On Thu, Apr 25, 2013 at 02:34:32PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> Could you please apply those patches ? For your convenience I've added Mark's 
> ack to 2/4 and pushed the result to
> 
> 	git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/sh73a0
> 
> On Thursday 25 April 2013 00:00:24 Laurent Pinchart wrote:
> > Hello,
> > 
> > The sh73a0 has an internal power gate on the VCCQ power supply for the SDHI0
> > device that is controlled (for some strange reason) by a bit in a PFC
> > register.
> > 
> > This patch set exposes the power gate as a regulator. As the only currently
> > supported board (kzm9g) has the VCCQ_MC0 pins directly connected to an
> > always on 3.3V supply, the code assumes that the external VCCQ power supply
> > can't be controlled. This could be fixed later by setting the regulator
> > supply name.
> > 
> > As this series turns the power off when not needed it might bring additional
> > power saving, but this hasn't been measured. If the patches are considered
> > too complex a simpler approach would be to turn the power gate on when the
> > SDHI function is selected.
> > 
> > The patches are based on tags/renesas-next-20130422. They have been tested
> > on kzm9g. They are available in my git tree at
> > 
> > 	git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/sh73a0
> > 
> > Changes compared to v1:
> > 
> > - Renamed __sh73a0_vccq_mc0_enable to sh73a0_vccq_mc0_endisable
> > - Fix the reported voltage value (3.3V instead of 1.8V)
> > - Make patch 2/4 commit message more explicit
> > 
> > Laurent Pinchart (4):
> >   sh-pfc: Add support for SoC-specific initialization
> >   sh-pfc: sh73a0: Add VCCQ MC0 regulator
> >   ARM: shmobile: kzm9g: Remove the VCCQ MC0 function GPIO
> >   ARM: shmobile: kzm9g-reference: Remove the VCCQ MC0 function GPIO
> > 
> >  arch/arm/mach-shmobile/board-kzm9g-reference.c |   1 -
> >  arch/arm/mach-shmobile/board-kzm9g.c           |   3 -
> >  drivers/pinctrl/sh-pfc/Kconfig                 |   1 +
> >  drivers/pinctrl/sh-pfc/core.c                  |  16 ++-
> >  drivers/pinctrl/sh-pfc/core.h                  |   1 +
> >  drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 134 ++++++++++++++++++++++
> >  drivers/pinctrl/sh-pfc/sh_pfc.h                |   2 +
> >  7 files changed, 153 insertions(+), 5 deletions(-)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
