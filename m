From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 06 Jul 2012 18:40:03 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix platsmp.c build when ARCH_SH73A0=n
Message-Id: <201207062040.03245.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120706082005.30495.53308.sendpatchset@w520>
In-Reply-To: <20120706082005.30495.53308.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Friday, July 06, 2012, Arnd Bergmann wrote:
> On Friday 06 July 2012, Simon Horman wrote:
> > On Fri, Jul 06, 2012 at 05:20:05PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Fix build error in the case of SMP=y but ARCH_SH73A0=n
> > > introduced by:
> > > 
> > > 9601e87 ARM: shmobile: fix smp build
> > > 
> > > The use of of_machine_is_compatible() will link in the
> > > the SoC-specific symbols:
> > > "sh73a0_get_core_count", "sh73a0_smp_prepare_cpus",
> > > "sh73a0_secondary_init" and "sh73a0_boot_secondary".
> > > 
> > > This patch adds an ugly #ifdef wrapper as a stop-gap
> > > solution.
> > 
> > I will be happier once we have a more permanent solution :^)
> 
> That should not take too long. Marc Zyngier has posted a number
> of versions of his SMP abstraction that will remove the need
> for the multiplexer.
> 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > Tested-by: Simon Horman <horms@verge.net.au>
> > 
> 
> It can actually be written a little nicer now, like
> 
> #define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
>                        (IS_ENABLED(CONFIG_ARCH_SH73A0) && \
> 			of_machine_is_compatible("renesas,sh73a0")))
> 
> but that won't work for the backport and it's still a little
> ugly.

Can you please take the $subject patch directly to the fixes branch?
Or do you want me to generate a pull request with just this one patch?

Rafael
