From: Rich Felker <dalias@libc.org>
Date: Wed, 06 Jul 2016 14:50:05 +0000
Subject: Re: [PATCH v5 01/22] sh: Add sh-specific early_init_dt_reserve_memory_arch
Message-Id: <20160706145004.GZ15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <1467564402-2649-2-git-send-email-ysato@users.sourceforge.jp>
 <20160704020350.GQ15995@brightrain.aerifal.cx>
 <8760sina98.wl-ysato@users.sourceforge.jp>
In-Reply-To: <8760sina98.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 06, 2016 at 10:53:23PM +0900, Yoshinori Sato wrote:
> On Mon, 04 Jul 2016 11:03:50 +0900,
> Rich Felker wrote:
> > 
> > On Mon, Jul 04, 2016 at 01:46:21AM +0900, Yoshinori Sato wrote:
> > > sh used P1 address space in early device tree.
> > > So need convert P1 to physical address before reserve memory.
> > > 
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > ---
> > >  arch/sh/boards/of-generic.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> > > index 57d45dc..8dbf978 100644
> > > --- a/arch/sh/boards/of-generic.c
> > > +++ b/arch/sh/boards/of-generic.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/clocksource.h>
> > >  #include <linux/irqchip.h>
> > >  #include <linux/clk-provider.h>
> > > +#include <linux/memblock.h>
> > >  #include <asm/machvec.h>
> > >  #include <asm/rtc.h>
> > >  
> > > @@ -203,3 +204,14 @@ static int __init sh_of_device_init(void)
> > >  	return 0;
> > >  }
> > >  arch_initcall_sync(sh_of_device_init);
> > > +
> > > +int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> > > +					     phys_addr_t size, bool nomap)
> > > +{
> > > +	if (nomap)
> > > +		return memblock_remove(base, size);
> > > +
> > > +	if (base >= P1SEG)
> > > +		base &= ~P1SEG;
> > > +	return memblock_reserve(base, size);
> > > +}
> > > -- 
> > 
> > I think we need a consistent form of physical memory addressing in the
> > DT that doesn't require this. Hard-coding details of the segmented
> > memory model all over the place does not look like a good idea; it's
> > going to badly break anything with full 32-bit which I believe some
> > SH-4 models had (those with PMB?) and which J3/J4 will almost
> > certainly have.
> 
> Even 32 bits mode are assigned to the same area now.
> But lookup PMB more better.
> 
> It add "#ifdef CONFIG_29BIT".
> Thanks.

I still don't think there should be any sh-specific code here. Can you
explain why you think it's needed with an example including real
addresses and how they'd get mapped incorrectly without this patch?

Rich
