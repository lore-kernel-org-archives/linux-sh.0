From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Aug 2012 07:16:06 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: fixup RELOC_BASE of intca_irq_pins_desc
Message-Id: <20120831071606.GE7014@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5l95bfg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5l95bfg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Kobayashi-san,

this patch was handled by Rafael and should appear in 3.6-rc3.
Thus, I would rather not add it to my kzm9g breanch.

I have, however, now pulled Rafael's fixes branch into my next branch.
So you should be able to get working kzm9g code there (once kernel.org syncs).

On Fri, Aug 31, 2012 at 03:55:05PM +0900, Tetsuyuki Kobayashi wrote:
> Simon-san,
> 
> Could you apply this patch to kzm9g branch ?
> 
> (2012/08/21 9:35), Kuninori Morimoto wrote:
> >sh73a0 :: intca_irq_pins_desc irq table had conflict
> >from irq 552 to irq 557 before.
> >But the second controller was simply trampling the
> >first one by way of the -EEXIST case from irq_alloc_desc_at().
> >
> >But now, we have irqdomain support from
> >1d6a21b0a672fb29b01ccf397d478e0541e17716
> >(sh: intc: initial irqdomain support)
> >
> >The irqdomain code has simply tightened down the sanity checks and
> >error path. So, sh73a0 CPU board got some WARNING when booting now.
> >This patch fixup RELOC_BASE to solve this issue.
> >
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >---
> >This patch is for paul/sh-latest branch
> >
> >  arch/arm/mach-shmobile/intc-sh73a0.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
> >index ee44740..588555a 100644
> >--- a/arch/arm/mach-shmobile/intc-sh73a0.c
> >+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
> >@@ -259,9 +259,9 @@ static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
> >  	return 0; /* always allow wakeup */
> >  }
> >
> >-#define RELOC_BASE 0x1000
> >+#define RELOC_BASE 0x1200
> >
> >-/* INTCA IRQ pins at INTCS + 0x1000 to make space for GIC+INTC handling */
> >+/* INTCA IRQ pins at INTCS + RELOC_BASE to make space for GIC+INTC handling */
> >  #define INTCS_VECT_RELOC(n, vect) INTCS_VECT((n), (vect) + RELOC_BASE)
> >
> >  INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
> >
> 
