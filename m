From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Nov 2011 14:14:39 +0000
Subject: Re: [PATCH 01/07] ARM: mach-shmobile: Kota2 SCIFA2 and SMSC911X support
Message-Id: <20111104141439.GB17594@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110818054407.23410.98641.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110818054407.23410.98641.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 22, 2011 at 12:43:29PM +0900, Paul Mundt wrote:
> On Thu, Aug 18, 2011 at 02:44:07PM +0900, Magnus Damm wrote:
> > +static void __init kota2_timer_init(void)
> > +{
> > +	sh73a0_clock_init();
> > +	shmobile_timer.init();
> > +	return;
> > +}
> > +
> Pointless return.
> 
> > --- 0001/arch/arm/mach-shmobile/platsmp.c
> > +++ work/arch/arm/mach-shmobile/platsmp.c	2011-08-18 13:38:02.000000000 +0900
> > @@ -21,9 +21,11 @@
> >  #include <asm/mach-types.h>
> >  #include <mach/common.h>
> >  
> > +#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2())
> > +
> >  static unsigned int __init shmobile_smp_get_core_count(void)
> >  {
> > -	if (machine_is_ag5evm())
> > +	if (is_sh73a0())
> >  		return sh73a0_get_core_count();
> >  
> >  	return 1;
> 
> No. If you want to do this then simply do what the other platforms are
> doing and construct a cpu.h, then you can centrally define things and use
> cpu_is_xxx() outright. Making CPU inferences from mach type is just
> asking for trouble.

I don't see any updates to this series that address any of these issues,
even after I went to all of the trouble of setting them up in a topic
branch for incremental fixing.

I'll merge the topic branch for now, but don't expect this to happen
again if I don't see cleanup patches or the same lazy-ass approach is
taken for any additional boards.
