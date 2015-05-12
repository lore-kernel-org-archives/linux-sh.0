From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 May 2015 07:29:38 +0000
Subject: Re: [PATCH v2 07/15] ARM: shmobile: Basic r8a7793 SoC support
Message-Id: <20150512072937.GA6549@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, May 12, 2015 at 10:27:51AM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 12 May 2015 16:19:33 Simon Horman wrote:
> > On Tue, May 12, 2015 at 09:51:26AM +0300, Laurent Pinchart wrote:
> > > On Tuesday 12 May 2015 13:06:11 Simon Horman wrote:
> > > > On Wed, May 06, 2015 at 07:20:05AM +0300, Laurent Pinchart wrote:
> > > > > On Thursday 30 April 2015 16:18:56 Ulrich Hecht wrote:
> > > > > > Minimal support without power management or SMP.
> > > > > > 
> > > > > > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > > > > > ---
> > > > > > 
> > > > > >  arch/arm/mach-shmobile/Kconfig         |  4 ++++
> > > > > >  arch/arm/mach-shmobile/Makefile        |  1 +
> > > > > >  arch/arm/mach-shmobile/setup-r8a7793.c | 33 +++++++++++++++++++++++
> > > > > >  3 files changed, 38 insertions(+)
> > > > > >  create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
> > > > > > 
> > > > > > diff --git a/arch/arm/mach-shmobile/Kconfig
> > > > > > b/arch/arm/mach-shmobile/Kconfig index 0fb4842..140b696 100644
> > > > > > --- a/arch/arm/mach-shmobile/Kconfig
> > > > > > +++ b/arch/arm/mach-shmobile/Kconfig
> > > > > > @@ -80,6 +80,10 @@ config ARCH_R8A7791
> > > > > >  	select ARCH_RCAR_GEN2
> > > > > >  	select I2C
> > > > > > 
> > > > > > +config ARCH_R8A7793
> > > > > > +	bool "R-Car M2-N (R8A7793)"
> > > > > > +	select ARCH_RCAR_GEN2
> > > > > > +
> > > > > >  config ARCH_R8A7794
> > > > > >  	bool "R-Car E2 (R8A77940)"
> > > > > > diff --git a/arch/arm/mach-shmobile/Makefile
> > > > > > b/arch/arm/mach-shmobile/Makefile index 89e463d..e4b8fdb 100644
> > > > > > --- a/arch/arm/mach-shmobile/Makefile
> > > > > > +++ b/arch/arm/mach-shmobile/Makefile
> > > > > > @@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
> > > > > >  obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
> > > > > >  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
> > > > > >  obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
> > > > > > +obj-$(CONFIG_ARCH_R8A7793)	+= setup-r8a7793.o
> > > > > >  obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
> > > > > >  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
> > > > > >  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
> > > > > > diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c
> > > > > > b/arch/arm/mach-shmobile/setup-r8a7793.c new file mode 100644
> > > > > > index 0000000..1d2825c
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm/mach-shmobile/setup-r8a7793.c
> > > > > > @@ -0,0 +1,33 @@
> > > > > > +/*
> > > > > > + * r8a7793 processor support
> > > > > > + *
> > > > > > + * Copyright (C) 2015  Ulrich Hecht
> > > > > > + *
> > > > > > + * This program is free software; you can redistribute it and/or
> > > > > > modify
> > > > > > + * it under the terms of the GNU General Public License as
> > > > > > published by
> > > > > > + * the Free Software Foundation; version 2 of the License.
> > > > > > + *
> > > > > > + * This program is distributed in the hope that it will be useful,
> > > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > > > + * GNU General Public License for more details.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/init.h>
> > > > > > +#include <asm/mach/arch.h>
> > > > > > +
> > > > > > +#include "common.h"
> > > > > > +#include "rcar-gen2.h"
> > > > > > +
> > > > > > +static const char *r8a7793_boards_compat_dt[] __initconst = {
> > > > > > +	"renesas,r8a7793",
> > > > > > +	NULL,
> > > > > > +};
> > > > > > +
> > > > > > +DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device
> > > > > > Tree)")
> > > > > > +	.init_early	= shmobile_init_delay,
> > > > > > +	.init_time	= rcar_gen2_timer_init,
> > > > > > +	.init_late	= shmobile_init_late,
> > > > > > +	.reserve	= rcar_gen2_reserve,
> > > > > > +	.dt_compat	= r8a7793_boards_compat_dt,
> > > > > > +MACHINE_END
> > > > > 
> > > > > How about moving that to setup-rcar-gen2.c instead ? There's nothing
> > > > > specific to r8a7793 here. We could even introduce a
> > > > > "renesas,rcar-gen2" DT compatible entry and match on that instead of
> > > > > "renesas,r8a7793" (which should of course be specified as well in DT).
> > > > > You could also add "renesas,r8a7794" to the setup-rcar-gen2.c compat
> > > > > list and remove setup-r8a7794.c.
> > > > 
> > > > I believe there are two issues here:
> > > > 
> > > > 1. Consolidating code
> > > > 
> > > >    From my point of view I think this is an excellent idea.
> > > >    However I would rather add this patch as-is and then
> > > >    address consolidation later.
> > > >    
> > > >    This avoids blocking on consolidation and I believe we have
> > > >    a pretty good record of coming back and doing consolidation
> > > >    (at least in arch/arm/mach-shmobile/) that has been suggested
> > > >    as a result of adding support for new SoCs.
> > > 
> > > I'm fine with that, as long as we use CPU_METHOD_OF_DECLARE() in patch
> > > 10/15, otherwise it would block any future consolidation.
> > 
> > I'm not sure that I follow. Could you expand on this a little?
> 
> Our current SMP implementations plug the SMP ops into the .smp field of the 
> machine description. This requires one machine description per SoC. Switching 
> to the CPU_METHOD_OF_DECLARE() method of wiring up the SMP ops would allow 
> merging all otherwise identical machine descriptions together. However, as 
> this requires an enable-method property in the cpu node, we can't switch an 
> existing platform from .smp to CPU_METHOD_OF_DECLARE() without breaking 
> backward compatibility with older DTs. I personally don't care, but not 
> everybody seems to agree ;-)
> 
> So, if we want to enable later consolidation, we must start using 
> CPU_METHOD_OF_DECLARE() right away.

Thanks, that seems like a good idea to me.
