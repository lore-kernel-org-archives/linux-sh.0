From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 12 Nov 2014 09:43:42 +0000
Subject: Re: [PATCH] irqchip: atmel-aic: fix irqdomain initialization
Message-Id: <20141112104342.3d28ad46@bbrezillon>
List-Id: <linux-sh.vger.kernel.org>
References: <20141110230301.GV4068@piout.net>
	<1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
	<20141111225800.GE3698@titan.lakedaemon.net>
In-Reply-To: <20141111225800.GE3698-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>, Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Hi Jason,

On Tue, 11 Nov 2014 17:58:00 -0500
Jason Cooper <jason@lakedaemon.net> wrote:

> On Tue, Nov 11, 2014 at 02:33:36PM +0100, Boris Brezillon wrote:
> > First of all IRQCHIP_SKIP_SET_WAKE is not a valid irq_gc_flags and thus
> > should not be passed as the last argument of
> > irq_alloc_domain_generic_chips.
> > 
> > Then pass the correct handler (handle_fasteoi_irq) to
> > irq_alloc_domain_generic_chips instead of manually re-setting it in the
> > initialization loop.
> > 
> > And eventually initialize default irq flags to the pseudo standard:
> > IRQ_REQUEST | IRQ_PROBE | IRQ_AUTOEN.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Hello Kevin,
> > 
> > This patch has not been tested yet but it should solve the issue you've
> > experienced with the IRQ_GC_BE_IO flag and the atmel-aic driver.
> > 
> > I'll test it tomorrow and let you know if it actually works.

Tested it, and it seems to work.

> > 
> > Regards,
> > 
> > Boris
> > 
> >  drivers/irqchip/irq-atmel-aic-common.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Applied to irqchip/urgent with Kevin's Tested-by.  Also, flagged for
> stable, v3.17 and up.

Thanks!

> 
> Boris, once this is in mainline, you may want to generate a patch
> against older versions (in the arch dir) for the stable team.

Actually, the old irq driver does not use the generic irqchip
infrastructure and thus is not impacted by this bug.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
