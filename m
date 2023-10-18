Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A8CDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 08:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjJRICv (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRICu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 04:02:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4BC6
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:02:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697616166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Cc+B4dWgiL9MV6NCFW/jquPmevSlB14J1/atsXGf5A=;
        b=WOVONb/aUXfx/Ql3+qCL9m97t/ntc9oOjtGefeAnVtGB7btyqtlVqvmkfQYoLO0bhsCGR3
        h6QXCF9cexuoGdJJMX8pZXx1EZVVeIw2FY2tYD12hqbdIeRWhF6/YdfBOnSMPQIWffL+c1
        p5oK63s4HN2iFH8ndnBPa/+MIhZumwjvG9WaapcV9Ea9SXhr0uZnWK7BKTQPVIbrTNtQGN
        GQPbOZahiD9aI7Rif0oYx8q6P6b6e05FQS0nE2qRgBricyPsEeX6JPkyYcyTRAZXYL78Pm
        542KA0HzHpcwvMtQrVQwJynys0aLtclc1qRthep0GoUSoBbA/bA3li72lzeW9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697616166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Cc+B4dWgiL9MV6NCFW/jquPmevSlB14J1/atsXGf5A=;
        b=KWybGaX9n0lQ/3RaEfMAEcAfR9Lx1CTDckSebk+EW/9MqqNvAco2Tl5kFUJMNxBi/MPoGl
        mgg2H0Un+886x9Aw==
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, maz@kernel.org
Subject: Re: [RFC PATCH v3 14/35] drivers/irqchip: Add SH7751 Internal INTC
 drivers.
In-Reply-To: <b7d3002d7033a94a57577af68a13f4cfc3a88947.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <b7d3002d7033a94a57577af68a13f4cfc3a88947.1697199949.git.ysato@users.sourceforge.jp>
Date:   Wed, 18 Oct 2023 10:02:45 +0200
Message-ID: <87v8b44au2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, Oct 14 2023 at 23:53, Yoshinori Sato wrote:
> +config RENESAS_SH7751_INTC
> +	bool "Renesas SH7751 Interrupt Controller"
> +	depends on SH_DEVICE_TREE || COMPILE_TEST
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY

IRQ_DOMAIN_HIERARCHY selects IRQ_DOMAIN already

> +struct sh7751_intc_priv {
> +	void *icr;
> +	void *ipr;
> +	void *intpri00;
> +	void *intreq00;
> +	void *intmsk00;
> +	void *intmskclr00;
> +	struct iprmap *iprmap;
> +	unsigned int num_ipr;
> +	bool irlm;
> +};

See the other mail vs. formatting

> +#define ICR_IRLM BIT(7)
> +
> +/* Bitmap of IRQ masked */
> +#define IMASK_PRIORITY	15
> +
> +static DECLARE_BITMAP(imask_mask, IMASK_PRIORITY);
> +static int interrupt_priority;
> +
> +static inline void set_interrupt_registers(int ip)
> +{
> +	unsigned long __dummy;
> +
> +	asm volatile(
> +#ifdef CONFIG_CPU_HAS_SR_RB
> +		     "ldc	%2, r6_bank\n\t"
> +#endif
> +		     "stc	sr, %0\n\t"
> +		     "and	#0xf0, %0\n\t"
> +		     "shlr2	%0\n\t"
> +		     "cmp/eq	#0x3c, %0\n\t"
> +		     "bt/s	1f	! CLI-ed\n\t"
> +		     " stc	sr, %0\n\t"
> +		     "and	%1, %0\n\t"
> +		     "or	%2, %0\n\t"
> +		     "ldc	%0, sr\n"
> +		     "1:"
> +		     : "=&z" (__dummy)
> +		     : "r" (~0xf0), "r" (ip << 4)
> +		     : "t");

Why has this to be ASM and cannot be done in C with the existing
accessors? Also this really lacks a comment what this is actually doing.

> +}

Missing newline after }.

> +static int search_ipr_comp(const void *a, const void *b)
> +{
> +	return (int)a - ((struct iprmap *)b)->irq;

(long)a please. It does not matter on 32-bit, but casting a pointer to
long is the correct way to do it.

> +}
> +
> +static void update_ipr(struct sh7751_intc_priv *priv, int irq, int pval)
> +{
> +	void *prireg;
> +	struct iprmap *p;
> +	u16 pri;

See the othermail vs. variable declarations. Please fix all over the place.

> +	p = bsearch((void *)irq, priv->iprmap, priv->num_ipr,
> +		       sizeof(struct iprmap), search_ipr_comp);

See Documentation vs. line breaks and argument alignment

> +	if (p) {
> +		prireg = (p->reg < INTPRI00) ? priv->ipr : priv->intpri00;
> +		prireg += p->reg & (INTPRI00 - 1);
> +		pri = ~(0x000f << p->bits);

No magic numbers please. Use a define.

> +		pri &= __raw_readw(prireg);
> +		pri |= (pval & 0x0f) << p->bits;
> +		__raw_writew(pri, prireg);
> +	} else
> +		pr_warn_once("%s: undefined IPR in irq %d\n", __FILE__, irq);

Lacks brackets on the else clause.

> +}
> +
> +static void sh7751_disable_irq(struct irq_data *data)
> +{
> +	unsigned int irq = data->irq;
> +	struct sh7751_intc_priv *priv = data->chip_data;
> +
> +	if (irq < 16 && !priv->irlm) {
> +		/* IRL encoded externel interrupt */

external

> +		/* disable for SR.IMASK */
> +		clear_bit(irq, imask_mask);
> +		if (interrupt_priority < IMASK_PRIORITY - irq)
> +			interrupt_priority = IMASK_PRIORITY - irq;
> +		set_interrupt_registers(interrupt_priority);
> +	} else
> +		/* Internal periphreal interrupt */

peripheral and missing brackets.

> +		/* IPR priority is 0 */
> +		update_ipr(priv, irq, 0);
> +}
> +
> +static void sh7751_enable_irq(struct irq_data *data)
> +{
> +	unsigned int irq = data->irq;
> +	struct sh7751_intc_priv *priv = data->chip_data;
> +
> +	if (irq < 16 && !priv->irlm) {
> +		set_bit(irq, imask_mask);
> +		interrupt_priority = IMASK_PRIORITY -
> +		  find_first_bit(imask_mask, IMASK_PRIORITY);
> +		set_interrupt_registers(interrupt_priority);
> +	} else
> +		update_ipr(priv, irq, 1);

This does a bsearch on every mask/unmask operation. Why can't this be
done once at setup time and cached per interrupt?

This code lacks any form of comment and explanation what all of this is
about. You are not only leaving reviewers and casual readers puzzled,
you yourself will have a hard time understanding this magic 6 month down
the road.

> +}
> +
> +static const struct irq_chip sh7751_irq_chip = {
> +	.name		= "SH7751-INTC",
> +	.irq_unmask	= sh7751_enable_irq,
> +	.irq_mask	= sh7751_disable_irq,
> +};
> +
> +static int irq_sh7751_map(struct irq_domain *h, unsigned int virq,
> +				  irq_hw_number_t hw_irq_num)

Argument alignment please.

> +{
> +	irq_set_chip_and_handler(virq, &sh7751_irq_chip, handle_level_irq);
> +	irq_get_irq_data(virq)->chip_data = h->host_data;
> +	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
> +	return 0;
> +}

Newline.

> +static const struct irq_domain_ops irq_ops = {
> +	.map = irq_sh7751_map,
> +	.xlate  = irq_domain_xlate_onecell,

Struct formatting

> +};
> +
> +static int sort_ipr_cmp(const void *a, const void *b)
> +{
> +	unsigned int irq_a = ((struct iprmap *)a)->irq;
> +	unsigned int irq_b = ((struct iprmap *)b)->irq;
> +
> +	return irq_a - irq_b;

Why are irq_a/b unsigned int? The substraction clearly hints signed, no?

> +}
> +
> +static void sort_ipr_swap(void *a, void *b, int sz)
> +{
> +	struct iprmap tmp;
> +
> +	memcpy(&tmp, a, sizeof(tmp));
> +	memcpy(a, b, sizeof(tmp));
> +	memcpy(b, &tmp, sizeof(tmp));
> +}
> +
> +static int __init load_ipr_map(struct device_node *intc,
> +			       struct sh7751_intc_priv *priv)
> +{
> +	int num_ipr;
> +	struct iprmap *p;
> +	u32 val[3];
> +	unsigned int i, idx;
> +
> +	num_ipr = of_property_count_elems_of_size(intc, "renesas,ipr-map", sizeof(u32) * 3);
> +	if (num_ipr < 0)
> +		return num_ipr;
> +
> +	priv->iprmap = kcalloc(num_ipr, sizeof(struct iprmap), GFP_KERNEL);
> +	if (priv->iprmap == NULL) {
> +		pr_err("%s: Failed to alloc memory\n", intc->name);
> +		return -ENOMEM;
> +	}
> +	priv->num_ipr = num_ipr;
> +
> +	for (p = priv->iprmap, idx = 0; num_ipr > 0; p++, num_ipr--) {
> +		for (i = 0; i < 3; idx++, i++) {
> +			if (of_property_read_u32_index(intc, "renesas,ipr-map",
> +						       idx, &val[i])) {
> +				pr_err("%s: Failed to load ipr-map\n", intc->name);
> +				kfree(priv->iprmap);
> +				return -EINVAL;
> +			}
> +		}
> +		p->irq = evt2irq(val[0]);
> +		p->reg = val[1];
> +		p->bits = val[2];
> +	}
> +	/* This table will be searched using bsearch, so sort it. */

So this is one of the rare comments in this code. It comments the
obvious as the other comments do too.

Thanks,

        tglx
