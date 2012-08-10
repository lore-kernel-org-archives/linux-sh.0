From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 10 Aug 2012 12:38:04 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <20120810123804.GK1614@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 09, 2012 at 11:10:43PM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul
> 
> > >     sh: intc: Handle domain association for sparseirq pre-allocated vectors.
> > >     
> > >     Presently it's assumed that the irqdomain code handles the irq_desc
> > >     allocation for us, but this isn't necessarily the case when we've
> > >     pre-allocated IRQs via sparseirq. Previously we had a -EEXIST check in
> > >     the code that attempted to trap these cases and simply update them
> > >     in-place, but this behaviour was inadvertently lost in the transition to
> > >     irqdomains.
> > >     
> > >     This simply restores the previous behaviour, first attempting to let the
> > >     irqdomain core fetch the allocation for us, and falling back to an
> > >     in-place domain association in the extant IRQ case. Fixes up regressions
> > >     on platforms that pre-allocate legacy IRQs (specifically ARM-based
> > >     SH-Mobile platforms, as SH stopped pre-allocating vectors some time ago).
> > >     
> > >     Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> > 
> > This patch solved mackerel board crush bug on linus/master
> 
> ecovec/armadillo/marzen board were OK on this patch,
> but kzm9g board still has problem.
> I'm using "linus/master + paul/sh-latest"
> 
> ========= kernel log ==============-
> ....
> Preemptible hierarchical RCU implementation.                                    
>         RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.                    
> NR_IRQS:16 nr_irqs:16 16                                                        
> intc: Registered controller 'sh73a0-intcs' with 77 IRQs                         
> intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs                
> ------------[ cut here ]------------                                            
> WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
> error: irq_desc already associated; irqU2 hwirq=0x228                         

I screwed up the multi-evt case, it should be trying to associate irq2,
not irq. Try this:

---

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 32c26d7..8f32a13 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -355,7 +355,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 			if (unlikely(res)) {
 				if (res = -EEXIST) {
 					res = irq_domain_associate(d->domain,
-								   irq, irq);
+								   irq2, irq2);
 					if (unlikely(res)) {
 						pr_err("domain association "
 						       "failure\n");

