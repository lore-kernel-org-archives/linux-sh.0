From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 22 Apr 2013 14:21:23 +0000
Subject: Re: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
Message-Id: <alpine.LFD.2.02.1304221551240.21884@ionos>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-576123373-1366640484=:21884"
List-Id: <linux-sh.vger.kernel.org>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.LFD.2.02.1304180947070.21884@ionos>
 <20130419150927.GE15233@pengutronix.de>
 <20130422100219.GH15233@pengutronix.de>
In-Reply-To: <20130422100219.GH15233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-576123373-1366640484=:21884
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2013, Uwe Kleine-K=F6nig wrote:
> The options I see are:
>=20
>  - introduce a new set of functions
>    Do you have a nice naming scheme?
>    irq_gc_unmask_enable_reg_hwirqmod32? Or should I rename the existing
>    ones to irq_gc_unmask_enable_reg_irqbaseoffset?

Shudder. We do not need new functions at all, we just need to think a
bit.

>  - use
>  	u32 mask =3D 1 << (d->hwirq - gc->irq_base) % 32;
>    This is ugly but might work assuming irq_base =3D=3D 0 for chips with =
irq
>    domain support and hwirq =3D=3D irq for the others.

Which is not correct, as hwirq is always 0 for !irqdomain users. And
no, we don't set it to irq.

Calculating the mask over and over is stupid to begin with. We can
precompute it and store it in irq_data->mask. For the existing generic
chip users we simply precompute it with 1 << (d->hwirq - gc->irq_base)
and let the irqdomain code calculate it for everything else.

Hmm?

Thanks,

	tglx
---

diff --git a/include/linux/irq.h b/include/linux/irq.h
index bc4e066..03fd64a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -119,6 +119,7 @@ struct irq_domain;
=20
 /**
  * struct irq_data - per irq and irq chip data passed down to chip functio=
ns
+ * @mask:		precomputed bitmask for accessing the chip registers
  * @irq:		interrupt number
  * @hwirq:		hardware interrupt number, local to the interrupt domain
  * @node:		node index useful for balancing
@@ -138,6 +139,7 @@ struct irq_domain;
  * irq_data.
  */
 struct irq_data {
+	u32			mask;
 	unsigned int		irq;
 	unsigned long		hwirq;
 	unsigned int		node;
@@ -700,10 +702,14 @@ struct irq_chip_generic {
  * @IRQ_GC_INIT_NESTED_LOCK:	Set the lock class of the irqs to nested for
  *				irq chips which need to call irq_set_wake() on
  *				the parent irq. Usually GPIO implementations
+ * @IRQ_GC_NO_MASK:		Do not calculate irq_data->mask
+ * @IRQ_GC_MASK_FROM_HWIRQ:	Calculate irq_data->mask from the hwirq number
  */
 enum irq_gc_flags {
 	IRQ_GC_INIT_MASK_CACHE		=3D 1 << 0,
 	IRQ_GC_INIT_NESTED_LOCK		=3D 1 << 1,
+	IRQ_GC_NO_MASK			=3D 1 << 2,
+	IRQ_GC_MASK_FROM_HWIRQ		=3D 1 << 4,
 };
=20
 /* Generic chip callback functions */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c89295a..a013a35 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -39,7 +39,7 @@ void irq_gc_noop(struct irq_data *d)
 void irq_gc_mask_disable_reg(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->disable);
@@ -57,7 +57,7 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 void irq_gc_mask_set_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	gc->mask_cache |=3D mask;
@@ -75,7 +75,7 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 void irq_gc_mask_clr_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	gc->mask_cache &=3D ~mask;
@@ -93,7 +93,7 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
 void irq_gc_unmask_enable_reg(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->enable);
@@ -108,7 +108,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 void irq_gc_ack_set_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->ack);
@@ -122,7 +122,7 @@ void irq_gc_ack_set_bit(struct irq_data *d)
 void irq_gc_ack_clr_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D ~(1 << (d->irq - gc->irq_base));
+	u32 mask =3D ~d->mask;
=20
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->ack);
@@ -136,7 +136,7 @@ void irq_gc_ack_clr_bit(struct irq_data *d)
 void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->mask);
@@ -151,7 +151,7 @@ void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
 void irq_gc_eoi(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->eoi);
@@ -169,7 +169,7 @@ void irq_gc_eoi(struct irq_data *d)
 int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D 1 << (d->irq - gc->irq_base);
+	u32 mask =3D d->mask;
=20
 	if (!(mask & gc->wake_enabled))
 		return -EINVAL;
@@ -254,6 +254,15 @@ void irq_setup_generic_chip(struct irq_chip_generic *g=
c, u32 msk,
 		if (flags & IRQ_GC_INIT_NESTED_LOCK)
 			irq_set_lockdep_class(i, &irq_nested_lock_class);
=20
+		if (!(flags & IRQ_GC_NO_MASK)) {
+			struct irq_data *d =3D irq_get_irq_data(i);
+			u32 mask;
+
+			if (flags & IRQ_GC_MASK_FROM_HWIRQ)
+				d->mask =3D 1 << (d->hwirq % 32);
+			else
+				d->mask =3D 1 << (i - gc->irq_base);
+		}
 		irq_set_chip_and_handler(i, &ct->chip, ct->handler);
 		irq_set_chip_data(i, gc);
 		irq_modify_status(i, clr, set);



--8323328-576123373-1366640484=:21884--
