From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 09 Aug 2012 04:28:45 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <20120809042844.GF1614@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 03, 2012 at 02:00:40PM +0900, Paul Mundt wrote:
> On Thu, Aug 02, 2012 at 02:50:26AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> > 
> > Hi Paul
> > 
> > I noticed that sh irqdomain commit breaks mackerel boot.
> > below is "git bisect" result and kernel log
> > 
> > ------- log -----------------------------
> > ...
> > NR_IRQS:16 nr_irqs:16 16
> > intc: Registered controller 'sh7372-intca' with 108 IRQs
> > intc: Registered controller 'sh7372-intca-irq-lo' with 16 IRQs
> > intc: can't get irq_desc for 0
> > intc: can't get irq_desc for 1
> > intc: can't get irq_desc for 2
> > intc: can't get irq_desc for 3
> > intc: can't get irq_desc for 4
> > intc: can't get irq_desc for 5
> > intc: can't get irq_desc for 6
> > intc: can't get irq_desc for 7
> > intc: can't get irq_desc for 8
> > intc: can't get irq_desc for 9
> > intc: can't get irq_desc for 10
> > intc: can't get irq_desc for 11
> > intc: can't get irq_desc for 12
> > intc: can't get irq_desc for 13
> > intc: can't get irq_desc for 14
> > intc: can't get irq_desc for 15
> > intc: Registered controller 'sh7372-intca-irq-hi' with 16 IRQs
> 
> Great, it's ARM's silly NR_IRQS_LEGACY getting in the way, and we don't
> seem to have any ability to simply not pre-allocate IRQs given that ARM's
> machine_desc lamely doesn't allow 0 as a valid nr_irqs initializer even
> on sparseirq configurations.
> 
> It's not entirely obvious why you are tripping up on this though, as we
> should already gracefully handle the -EEXIST case.
> 
> I'll have a bit of a think over how to fix it properly.

Ok, it's fixed now. We were previously handling the -EEXIST case but were
getting tripped up by moving the irq_desc allocation in to the irq domain
code and not handling the failure case for pre-allocated vectors with
sparseirq.

I'll send this off for -rc2:

---

commit 1026023705b0baa2b37df2a0d1da0022fc7b985e
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Thu Aug 9 12:59:40 2012 +0900

    sh: intc: Handle domain association for sparseirq pre-allocated vectors.
    
    Presently it's assumed that the irqdomain code handles the irq_desc
    allocation for us, but this isn't necessarily the case when we've
    pre-allocated IRQs via sparseirq. Previously we had a -EEXIST check in
    the code that attempted to trap these cases and simply update them
    in-place, but this behaviour was inadvertently lost in the transition to
    irqdomains.
    
    This simply restores the previous behaviour, first attempting to let the
    irqdomain core fetch the allocation for us, and falling back to an
    in-place domain association in the extant IRQ case. Fixes up regressions
    on platforms that pre-allocate legacy IRQs (specifically ARM-based
    SH-Mobile platforms, as SH stopped pre-allocating vectors some time ago).
    
    Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 2374468..32c26d7 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -324,8 +324,16 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 		res = irq_create_identity_mapping(d->domain, irq);
 		if (unlikely(res)) {
-			pr_err("can't get irq_desc for %d\n", irq);
-			continue;
+			if (res = -EEXIST) {
+				res = irq_domain_associate(d->domain, irq, irq);
+				if (unlikely(res)) {
+					pr_err("domain association failure\n");
+					continue;
+				}
+			} else {
+				pr_err("can't identity map IRQ %d\n", irq);
+				continue;
+			}
 		}
 
 		intc_irq_xlate_set(irq, vect->enum_id, d);
@@ -345,8 +353,19 @@ int __init register_intc_controller(struct intc_desc *desc)
 			 */
 			res = irq_create_identity_mapping(d->domain, irq2);
 			if (unlikely(res)) {
-				pr_err("can't get irq_desc for %d\n", irq2);
-				continue;
+				if (res = -EEXIST) {
+					res = irq_domain_associate(d->domain,
+								   irq, irq);
+					if (unlikely(res)) {
+						pr_err("domain association "
+						       "failure\n");
+						continue;
+					}
+				} else {
+					pr_err("can't identity map IRQ %d\n",
+					       irq);
+					continue;
+				}
 			}
 
 			vect2->enum_id = 0;
