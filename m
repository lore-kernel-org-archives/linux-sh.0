From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Aug 2012 07:54:08 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <20120820075408.GA21643@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 20, 2012 at 12:41:28AM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul
> Cc Magnus
> 
> > > > place. At least we know the irqdomain code isn't at fault anymore.
> 
> I tried show irq number on "non-irqdomain kernel" and "irqdomain kernel".
> And compared these 2 kernel irq table.
> ("irqdomain kernel" doesn't have my quick hack patch => got WARNING)
> 
> It were
> 	register_intc_controller(&intcs_desc);
> 	register_intc_controller(&intca_irq_pins_desc);
> 	register_intc_controller(&intc_pint0_desc);
> 	register_intc_controller(&intc_pint1_desc);
> 
> 1st register_intc_controller()'s irq were
> 	irqdomain	: from 448 to 680
>         non-irqdomain	: from 448 to 680
> 2nd register_intc_controller()'s irq were
> 	irqdomain	: from 560 to 959 <>         non-irqdomain	: from 544 to 943 <
How are you getting these ranges?

The irqdomain ranges are calculated using evt2irq(), but it looks like
sh73a0 needs to use intcs_evt2irq()/to_intc_vect() for factoring in the
offsets. That offset factorization appears to be what is throwing this
out of range -- though why evt2irq() use on these vectors hasn't resulted
in issues before this I don't know.

Do you observe any difference by dropping evt2irq() bounding for the
linear range and simply using the tree type?

---

diff --git a/drivers/sh/intc/irqdomain.c b/drivers/sh/intc/irqdomain.c
index 3968f1c..5ba8ba7 100644
--- a/drivers/sh/intc/irqdomain.c
+++ b/drivers/sh/intc/irqdomain.c
@@ -44,6 +44,7 @@ static const struct irq_domain_ops intc_evt_ops = {
 void __init intc_irq_domain_init(struct intc_desc_int *d,
 				 struct intc_hw_desc *hw)
 {
+#if 0
 	unsigned int irq_base, irq_end;
 
 	/*
@@ -62,6 +63,7 @@ void __init intc_irq_domain_init(struct intc_desc_int *d,
 		d->domain = irq_domain_add_linear(NULL, hw->nr_vectors,
 						  &intc_evt_ops, NULL);
 	else
+#endif
 		d->domain = irq_domain_add_tree(NULL, &intc_evt_ops, NULL);
 
 	BUG_ON(!d->domain);
