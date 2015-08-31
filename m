From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 31 Aug 2015 09:55:20 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: Remove legacy leftovers
Message-Id: <11530137.94y0i5q82j@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1440797837-25516-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1440797837-25516-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 31 August 2015 14:27:03 Simon Horman wrote:
> On Sat, Aug 29, 2015 at 12:37:14AM +0300, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch series removes legacy leftovers related to clock and IRQ
> > support in non-multiplatform kernels. Please see individual patches for
> > details.
> > 
> > The series is based on Simon's renesas-devel-20150826-v4.2-rc8 tag.
> 
> This looks nice, but I think it should only be queued up in
> a tree that has support for the last non-multiplatform kernels removed.
> 
> For Linus's tree I anticipate that will be v4.4-rc1 or rc2.
> N.B. 4.4!

No issue with that on my side.

> > Laurent Pinchart (3):
> >   pinctrl: sh-pfc: Remove hardcoded IRQ numbers
> >   ARM: shmobile: Remove legacy mach/irqs.h
> >   ARM: shmobile: Remove legacy clock support leftovers
> >  
> >  arch/arm/mach-shmobile/common.h            |   2 -
> >  arch/arm/mach-shmobile/include/mach/irqs.h |  10 ---
> >  arch/arm/mach-shmobile/irqs.h              |  15 ----
> >  arch/arm/mach-shmobile/r8a7779.h           |   2 -
> >  arch/arm/mach-shmobile/setup-r8a7778.c     |   1 -
> >  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c       | 116 +++++++++++-----------
> >  drivers/pinctrl/sh-pfc/pfc-r8a7740.c       |  68 ++++++++---------
> >  drivers/pinctrl/sh-pfc/pfc-sh73a0.c        |  68 ++++++++---------
> >  drivers/pinctrl/sh-pfc/sh_pfc.h            |   7 +-
> >  9 files changed, 123 insertions(+), 166 deletions(-)
> >  delete mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
> >  delete mode 100644 arch/arm/mach-shmobile/irqs.h

-- 
Regards,

Laurent Pinchart

