From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 15 Jan 2014 19:46:22 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <23964205.83SALtX1Md@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 15 January 2014 08:55:05 Simon Horman wrote:
> On Tue, Jan 14, 2014 at 01:56:16PM +0000, Ben Dooks wrote:
> > If the kernel is built to support multi-arm configurmation with shmobile
> > support built in, then the drivers/sh is not built. This contains drivers
> > that are essential to devices support by that configuration, including the
> > PM runtime code in drivers/sh/pm_runtime.c (which implicitly enables the
> > bus clocks for all devices).
> > 
> > If CONFIG_ARCH_SHMOBILE_MULTI then build the drivers/sh directory,
> > but ensure that bits that may conflict (drivers/sh/clk if the common
> > clock framework is not enabled) are built.
> > 
> > The ARCH_SHMOBILE_MULTI was added by efacfce5f8a ("ARM: shmobile:
> > Introduce ARCH_SHMOBILE_MULTI") but this has only just recently been found
> > due to changes currently only in Simon Horman's tree. This patch is a
> > partial revert of bf98c1eac1d4a6b ("ARM: Rename ARCH_SHMOBILE to
> > ARCH_SHMOBILE_LEGACY") to address the issue of drivers not being built.
> > 
> > It is also possible the drivers/sh/intc will also need to be built
> > however the lack of intc is not causing a number of drivers to fail
> > to properly manage their clocks. This is left as an future patch for
> >that is perfectly fine. someone who understands that part of the code.
> 
> Laurent, what are you feelings on this?

If we end up needing an interrupt controller supported by drivers/sh/intc for 
a multiplatform kernel I would rather like to port the driver to 
drivers/irqchip instead of compiling drivers/sh/intc for the platform.

Regarding drivers/sh/pm_runtime.c, compiling it for ARCH_SHMOBILE_MULTI will 
cause multiplatform kernels running on non-Renesas platforms to add a pm clock 
notifier. We need to at least add a runtime check.

> > Cc: Linus SH list <linux-sh@vger.kernel.org>
> > Cc: laurent.pinchart+renesas@ideasonboard.com
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> > 
> >  drivers/Makefile    | 2 +-
> >  drivers/sh/Makefile | 3 +++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 8e3b8b0..3cc8214 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -118,7 +118,7 @@ obj-$(CONFIG_SGI_SN)		+= sn/
> >  obj-y				+= firmware/
> >  obj-$(CONFIG_CRYPTO)		+= crypto/
> >  obj-$(CONFIG_SUPERH)		+= sh/
> > -obj-$(CONFIG_ARCH_SHMOBILE_LEGACY)	+= sh/
> > +obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
> >  ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
> >  obj-y				+= clocksource/
> >  endif
> > diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
> > index fc67f56..b4d588c 100644
> > --- a/drivers/sh/Makefile
> > +++ b/drivers/sh/Makefile
> > @@ -3,7 +3,10 @@
> >  #
> >  obj-y	:= intc/
> > 
> > +ifneq ($(CONFIG_COMMON_CLK),y)
> >  obj-$(CONFIG_HAVE_CLK)		+= clk/
> > +endif
> > +
> >  obj-$(CONFIG_MAPLE)		+= maple/
> >  obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
-- 
Regards,

Laurent Pinchart
