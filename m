From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Sep 2012 00:23:51 +0000
Subject: Re: [PATCH] ARM: shmobile: Build code depending on PM only if PM is set
Message-Id: <20120912002351.GB26818@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201207090015.12531.rjw@sisk.pl>
In-Reply-To: <201207090015.12531.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 11, 2012 at 10:44:40PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 11, 2012, Simon Horman wrote:
> > On Mon, Jul 09, 2012 at 06:49:15PM +0200, Rafael J. Wysocki wrote:
> > > On Monday, July 09, 2012, Magnus Damm wrote:
> > > > On Mon, Jul 9, 2012 at 5:13 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > On Monday, July 09, 2012, Simon Horman wrote:
> > > > >> On Mon, Jul 09, 2012 at 12:15:12AM +0200, Rafael J. Wysocki wrote:
> > > > >> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > >> >
> > > > >> > There are a few files under arch/arm/mach-shmobile/ whose entire
> > > > >> > contents depend on CONFIG_PM, but they are compiled even if
> > > > >> > CONFIG_PM is unset.  It is cleaner to modify the Makefile to
> > > > >> > avoid building those files entirely for CONFIG_PM unset and
> > > > >> > remove #ifdef CONFIG_PM directives from them.
> > > > >> >
> > > > >> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > >> > ---
> > > > >> >  arch/arm/mach-shmobile/Makefile              |    4 +++-
> > > > >> >  arch/arm/mach-shmobile/include/mach/common.h |    4 ++++
> > > > >> >  arch/arm/mach-shmobile/pm-r8a7740.c          |    3 ---
> > > > >> >  arch/arm/mach-shmobile/pm-rmobile.c          |    2 --
> > > > >> >  arch/arm/mach-shmobile/pm-sh7372.c           |    4 ----
> > > > >> >  5 files changed, 7 insertions(+), 10 deletions(-)
> > > > >> >
> > > > >> > Index: linux/arch/arm/mach-shmobile/Makefile
> > > > >> > =================================> > > > >> > --- linux.orig/arch/arm/mach-shmobile/Makefile
> > > > >> > +++ linux/arch/arm/mach-shmobile/Makefile
> > > > >> > @@ -37,11 +37,13 @@ obj-$(CONFIG_ARCH_SH7372)       += entry-intc.
> > > > >> >  obj-$(CONFIG_ARCH_R8A7740) += entry-intc.o
> > > > >> >
> > > > >> >  # PM objects
> > > > >> > -obj-$(CONFIG_SUSPEND)              += suspend.o
> > > > >> >  obj-$(CONFIG_CPU_IDLE)             += cpuidle.o
> > > > >> > +ifeq ($(CONFIG_PM),y)
> > > > >> > +obj-$(CONFIG_SUSPEND)              += suspend.o
> > > > >> >  obj-$(CONFIG_ARCH_SHMOBILE)        += pm-rmobile.o
> > > > >> >  obj-$(CONFIG_ARCH_SH7372)  += pm-sh7372.o sleep-sh7372.o
> > > > >> >  obj-$(CONFIG_ARCH_R8A7740) += pm-r8a7740.o
> > > > >> > +endif
> > > > >> >  obj-$(CONFIG_ARCH_R8A7779) += pm-r8a7779.o
> > > > >> >
> > > > >> >  # Board objects
> > > > >> > Index: linux/arch/arm/mach-shmobile/include/mach/common.h
> > > > >> > =================================> > > > >> > --- linux.orig/arch/arm/mach-shmobile/include/mach/common.h
> > > > >> > +++ linux/arch/arm/mach-shmobile/include/mach/common.h
> > > > >> > @@ -41,7 +41,11 @@ extern void sh7372_add_early_devices(voi
> > > > >> >  extern void sh7372_add_standard_devices(void);
> > > > >> >  extern void sh7372_clock_init(void);
> > > > >> >  extern void sh7372_pinmux_init(void);
> > > > >> > +#ifdef CONFIG_PM
> > > > >> >  extern void sh7372_pm_init(void);
> > > > >> > +#else
> > > > >> > +static inline void sh7372_pm_init(void) {}
> > > > >>
> > > > >> This seems to slightly alter the behaviour in the case where
> > > > >> CONFIG_PM is not set. I'm unsure if that is a problem or not.
> > > > >
> > > > > I don't think it would be a problem, all of those settings are PM-related.
> > > > >
> > > > > Magnus, what do you think?
> > > > 
> > > > Cleaning up the code is always nice, but I wonder if you take the
> > > > following into consideration?
> > > > 
> > > > CONFIG_CPU_IDLE=y
> > > > CONFIG_PM=n
> > > 
> > > This actually doesn't work (please see below).
> > > 
> > > > Also, slightly off topic, but on top of that we have the ARM specific
> > > > CONFIG_ARM_CPU_SUSPEND which is required to build cpu_resume() in
> > > > sleep-sh7372.c, and this in turn in needed for CPUIdle or
> > > > Suspend-to-RAM on sh7372.
> > > > 
> > > > It would be nice to simplify all this somehow. From the ARM arch code
> > > > we do want to use cpu_resume() and cpu_suspend() both from CPUIdle and
> > > > Suspend-to-RAM - this since the same low level sleep code is used for
> > > > both cases.
> > > 
> > > Yes, please see my fix for the build bug reported by Guennadi.
> > > cpu_resume() and cpu_suspend() are not available if CONFIG_SUSPEND is unset.
> > 
> > Hi Rafael,
> > 
> > I may have missed something, but it seems that this patch wasn't merged.
> 
> No, it wasn't, because we addressed the problem in a different way.
> 
> > Aside from whether it still applies or not, is it still appropriate?
> > And if so, is it appropriate to go through the linux-pm tree?
> 
> I believe commit a1ee61b8f4b56e5e6ced16b83d5098e0f4238a45
> (ARM: shmobile: Take cpuidle dependencies into account correctly) from Magnus
> fixed this particular problem.

Thanks, case closed :)
