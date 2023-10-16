Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E5ECDB465
	for <linux-sh@archiver.kernel.org>; Mon, 16 Oct 2023 18:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJPSqi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Oct 2023 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPSqh (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 16 Oct 2023 14:46:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14595
        for <linux-sh@vger.kernel.org>; Mon, 16 Oct 2023 11:46:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697481993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5lOtFCmp2EnJ5uU2+ZtthsADmg/4/vgkKt3Er4SCqA=;
        b=DP/Obxi+7RwQD+5F9SgmSsluf4jdAcCAvAkwPmKn8Nm0tpRP8QWchRFipA5sUE0rWjVAPt
        Fk+lZNiG/J2QAiQqhnxUDPaiOImzgg8/r9QPSE7ZXA2O5YIq3LsYz6+jIx2iAE8kcaG6pB
        bdNm63LGBC93cyc3aejFDuB/5cj52Mo6u64nKsSdXo1rJvnH23X642xn0Qc3qkjAAev2HV
        Uu54g2nbcdvpLRx1C1hOm6ALKE0J6gzOCkNlT6MZYUuMT45/PRCel1KFfYkkPQBlCQ/MTl
        DIOPtSBrbudCTdBJ0aGMGOwPOVKT10NazIAIv3xehl2BNBsiaqFPVRzzr4yAxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697481993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5lOtFCmp2EnJ5uU2+ZtthsADmg/4/vgkKt3Er4SCqA=;
        b=3UrGHVro3WSFP+4DXMqFAB7yeoGwIYTi2jaUMs9aUDzefkxieQWAFt+4UCa0VUZQOMe0zn
        G1qp3fql44zBSyAQ==
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, maz@kernel.org
Subject: Re: [RFC PATCH v3 16/35] drivers/irqchip: SH7751 IRL external
 encoder with enable gate.
In-Reply-To: <5dfc2f45fd9a701a92ba86800e4f6eba35d96ede.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <5dfc2f45fd9a701a92ba86800e4f6eba35d96ede.1697199949.git.ysato@users.sourceforge.jp>
Date:   Mon, 16 Oct 2023 20:46:32 +0200
Message-ID: <87edhu76d3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Yoshinori!

On Sat, Oct 14 2023 at 23:53, Yoshinori Sato wrote:

Please Cc LKML on irqchip patches as that's the proper list according to
MAINTAINERS. Due to that I don't have the cover letter and ...

> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -688,4 +688,11 @@ config RENESAS_SH7751_INTC
>  	  Support for the Renesas SH7751 On-chip interrupt controller.
>  	  And external interrupt encoder for some targets.

... I have no idea against which tree this is supposed to apply. None of
the trees I usually use has the above. So I assume it's a patch in the
same series, but what do I know.

> +config RENESAS_SH7751IRL_INTC
> +	bool "Renesas SH7751 based target IRL encoder support."
> +	depends on RENESAS_SH7751_INTC
> +	help
> +	  Support for External Interrupt encoder
> +	  on the some Renesas SH7751 based target.
> +
>  endmenu
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 26c91d075e25..91df16726b1f 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -121,3 +121,5 @@ obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
>  obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
>  obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
>  obj-$(CONFIG_RENESAS_SH7751_INTC)	+= irq-renesas-sh7751.o
> +obj-$(CONFIG_RENESAS_SH7751IRL_INTC)	+= irq-renesas-sh7751irl.o
> +
> diff --git a/drivers/irqchip/irq-renesas-sh7751irl.c b/drivers/irqchip/irq-renesas-sh7751irl.c
> new file mode 100644
> index 000000000000..1520d0cfda1e
> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-sh7751irl.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0

GPL-2.0-only please

> +struct sh7751irl_intc_priv {
> +	void __iomem *base;
> +	struct irq_domain *irq_domain;
> +	int width;
> +	int type;
> +	int nr_irq;
> +	u32 enable_map[NUM_IRQ];
> +};

Please use proper tabular alignment for struct definitions. See:

   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +enum {type_enable, type_mask};

What's this? A true/false replacement? If you want you own constants,
then please make them upper case.

> +static inline u32 get_reg(void *addr, int w)
> +{
> +	switch (w) {
> +	case 8:
> +		return __raw_readb(addr);
> +	case 16:
> +		return __raw_readw(addr);
> +	case 32:
> +		return __raw_readl(addr);
> +	}
> +	return 0;

Reaching this is a bug, no?

> +}
> +
> +static inline void set_reg(void *addr, int w, u32 val)
> +{
> +	switch (w) {
> +	case 8:
> +		__raw_writeb(val, addr);
> +		break;
> +	case 16:
> +		__raw_writew(val, addr);
> +		break;
> +	case 32:
> +		__raw_writel(val, addr);
> +		break;
> +	}
> +}
> +
> +static inline struct sh7751irl_intc_priv *irq_data_to_priv(struct irq_data *data)
> +{
> +	return data->domain->host_data;

So in sh7751irl_intc_map() you store host_data in chip_data and now you
retrieve it from the domain...

> +}
> +
> +static inline u32 set_reset_bit(int val, u32 in, int bit, int type)
> +{
> +	val &= 1;
> +	if (type == type_mask)
> +		val ^= 1;
> +	in &= ~(1 << bit);
> +	return in | (val << bit);

This is horrible to read, really.

First of all mixing int (val) and u32 (in) for the OR operation is plain
wrong.

Here the 'type_mask' really threw me off as it's completely non-obvious
that type_mask is an enum constant, which means 'type' should be type of
the very same enum as well, but as you made the enum anonymous that does
not work.

So let me go through this in detail:

> +	val &= 1;

What's this for? Making sure that the caller does not provide anything
else than 1 or 0? So any even number is equivalent to 0 and any odd
number equivalent to 1, right? How is that supposed to work correctly?

> +	if (type == type_mask)
> +		val ^= 1;

So 'type_mask' if set inverts 'val', right? So why is it named mask?
That's confusing at best.

> +	in &= ~(1 << bit);

Again you are mixing signed and unsigned values. Also please use
BIT(bit).

> +	return in | (val << bit);

This whole thing boils down to:

static inline u32 set_reset_bit(u32 regval, int bit, bool set, bool invert)
{
        if (set ^ invert)
              	return regval | BIT(bit);
        return regval & ~BIT(bit);
}

No?

> +}
> +
> +static inline void mask_unmask(struct irq_data *data, int en)

s/en/bool enable/

> +{
> +	struct sh7751irl_intc_priv *priv = irq_data_to_priv(data);
> +	int irq = data->irq - EXTIRQ_BASE;

What guarantees that the Linux interrupt number is exactly EXTIRQ_BASE +
offset? Linux interrupt numbers are not guaranteed to be linear or
consecutive, unless the underlying interrupt domain is declared that
way, which the tree domain is definitely not.

The proper way to map the interrupt to an hardware offset is the
hardware interrupt number, i.e. irqd_to_hwirq(data). That number is set
when the interrupt is mapped and this avoids the whole EXTIRQ_BASE magic
completely.

> +	u32 val;
> +
> +	if (priv->nr_irq > irq && priv->enable_map[irq] < priv->width) {

How can you end up with an invalid interrupt number or with an invalid
width here? I'm all for defensive programming, but this is just
unexplainable. The whole point of interrupt domains and their associated
interrupt chips is that irq_data contains the correct information which is
required to handle these things efficiently.

> +		val = get_reg(priv->base, priv->width);
> +		val = set_reset_bit(en, val, priv->enable_map[irq], priv->type);

So as this is the only place which uses this magic set_reset_bit()
inline, you can just inline it directly and make the code readable. All
of this can be condensed into:

	struct sh7751irl_intc_priv *priv = irq_data_to_priv(data);
        u32 msk = BIT(priv->enable_map[irqd_to_hwirq(data)]);

	val = get_reg(priv->base, priv->width) & ~msk;
        if (enable ^ priv->invert)
              	val |= msk;
	set_reg(priv->base, priv->width, val);

Hmm?

> +static int sh7751irl_intc_map(struct irq_domain *h, unsigned int virq,
> +			       irq_hw_number_t hw_irq_num)

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#line-breaks

> +{
> +	irq_set_chip_and_handler(virq, &sh7751irl_intc_chip, handle_level_irq);
> +	irq_get_irq_data(virq)->chip_data = h->host_data;

irq_set_chip_data(...) if at all

> +	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
> +	return 0;
> +}
> +
> +static int sh7751irl_intc_translate(struct irq_domain *domain,
> +			       struct irq_fwspec *fwspec, unsigned long *hwirq,
> +			       unsigned int *type)

Same comment vs. line breaks

> +{
> +	if (fwspec->param[0] >= NUM_IRQ)
> +		return -EINVAL;
> +
> +	switch (fwspec->param_count) {
> +	case 2:
> +		*type = fwspec->param[1];
> +		fallthrough;
> +	case 1:
> +		*hwirq = fwspec->param[0] + EXTIRQ_BASE;

So if you store fwspec->param[0] in hwirq then the above code just works
by reading hwirq, no?

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops sh7751irl_intc_domain_ops = {
> +	.map = sh7751irl_intc_map,
> +	.translate = sh7751irl_intc_translate,

See the struct initializer documentation...

> +};
> +
> +static int sh7751irl_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct sh7751irl_intc_priv *priv;
> +	struct irq_domain *d;
> +	int ret = 0;
> +	int type = -1;
> +	u32 *p;
> +	unsigned int i, nr_input = 0;
> +	const char *type_str;

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = of_iomap(node, 0);
> +	if (IS_ERR(priv->base)) {
> +		ret = PTR_ERR(priv->base);
> +		goto error;
> +	}

Missing newline. Same on lots of places below. Please use empty newlines
to structure the code so that the individual functional blocks are easy
to identify.

> +	of_property_read_u32(node, "renesas,width", &priv->width);
> +	if (priv->width != 8 && priv->width != 16 && priv->width != 32) {
> +		pr_err("%s Invalid register width.\n", node->name);
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +	if (!of_property_read_string(node, "renesas,regtype", &type_str)) {
> +		if (strcasecmp("enable", type_str) == 0)
> +			type = type_enable;
> +		else if (strcasecmp("mask", type_str) == 0)
> +			type = type_mask;
> +	}

I'm not convinced about this "enable" "mask" wording here. As I said
above this indicates whether the register bits are inverted or not.

> +	if (type < 0) {
> +		pr_err("%pOFP: renesas,regtype Invalid register type (%s).\n", node, type_str);
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +	priv->type = type;

Please make this simply a boolean value and be done with it.

> +	priv->nr_irq = of_property_count_u32_elems(node, "renesas,irqbit");
> +	if (priv->nr_irq < NUM_IRQ) {
> +		of_property_read_u32_array(node, "renesas,irqbit", priv->enable_map, priv->nr_irq);
> +		for (p = priv->enable_map, i = 0; i < priv->nr_irq; p++, i++) {
> +			if (*p != 0xffffffff)

Please use a proper define and not magic constants.

> +				nr_input++;
> +		}
> +	}
> +	if (priv->nr_irq <= 0 || priv->nr_irq >= NUM_IRQ || nr_input > priv->width) {

We usually assume that NUM_IRQ[S] is the number of interrupts which can
be handled by a domain/interrupt chip. But you require that the number
of irqbits defined in the device tree is less than NUM_IRQ which is
confusing at best. I really had to read these conditions three times to
understand the logic here.

Also nr_input > priv->width is wrong if there are enough entries with an
enable map of 0xFFFFFFFF so that nr_input is <= priv->width.

Aside of that what checks that the bit number provided in enable_map is
actually valid vs. priv->width? AFACIT, nothing. That's why you need
magic checks in your mask/unmask function. Ensure correctness at setup
time and not with magic checks at runtime.

> +		pr_err("%pOFP: renesas,irqbit Invalid register definition.\n", node);
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +	d = irq_domain_add_tree(node, &sh7751irl_intc_domain_ops, priv);

Why is this a tree when the number of hardware interrupts is fixed?

irq_domain_add_linear() is the right thing to use here.

> +	if (d == NULL) {

  if (!d) {

> +		pr_err("%pOFP: cannot initialize irq domain\n", node);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	priv->irq_domain = d;

What's the purpose of storing the domain pointer here? Nothing,
AFAICT.

Thanks,

        tglx
