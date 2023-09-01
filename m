Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8285CA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 12:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbjIAMuR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbjIAMuR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 08:50:17 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DA1708
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 05:49:47 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bf01bcb1aeso1542339a34.3
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572557; x=1694177357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54pwaGpIk06nK1Q+ai1nKmQ5ccYsBJitNk7DgwKiWDg=;
        b=jw1NY+trL+qcC9sPTy8RTll/X8yYkCdnnrlZu03Fw1nFESCs6sI3W3lxbXSwBEvgja
         jZ2FEOuHnCywoWv96VTyRoXfSzccREGboU0k+xtW1OKgXfKeB3afYiv7c1QsZzjgjrGX
         JglQgh0KukcILqPQ4PvA+JC0quUeyW3h244ZGIOamGc8ttG/ohsZnnbHBFpN7r9LMDQS
         ShgvrmcCx16kgqlV9o5eRPWvFR6DiIzhkS3MN2Ps442L5NB77B2ETfqzEnwJ3CCByapD
         yJB13Ug3qPOfIPV48UrgiwRewbZcKUuCLK0lLTa1hG5j00QFjb8ZRINmC8bNGQ8dIHv6
         cPdw==
X-Gm-Message-State: AOJu0YyWRVHdZFZ2uiXankrVMK+PuHbgB34aZsv4P/H+IbpfnMilND8N
        qkX/5y+J8OnwiwEjhET8UFXBzwEkCb5/qA==
X-Google-Smtp-Source: AGHT+IFnD/eBD3S1Ks2+wsJNe+dkr33H9kFVXBmXM5F8gydpxaMNifnPxDgY7yHtzn7b27zahMMEVg==
X-Received: by 2002:a05:6358:4415:b0:139:be3d:d2fa with SMTP id z21-20020a056358441500b00139be3dd2famr1829008rwc.30.1693572556633;
        Fri, 01 Sep 2023 05:49:16 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c9-20020a814e09000000b005928d602f44sm1034110ywb.31.2023.09.01.05.49.16
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:49:16 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-591ba8bd094so20338227b3.3
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:49:16 -0700 (PDT)
X-Received: by 2002:a25:a447:0:b0:d7b:1f20:293c with SMTP id
 f65-20020a25a447000000b00d7b1f20293cmr2337659ybi.1.1693572556027; Fri, 01 Sep
 2023 05:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <52f2118d33bea5e74d4ffda4b3d935772e743ec2.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <52f2118d33bea5e74d4ffda4b3d935772e743ec2.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:49:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9-vJxt_PKnM715QL+9E7uaK4SVx-YtcTppHeufsmSFg@mail.gmail.com>
Message-ID: <CAMuHMdV9-vJxt_PKnM715QL+9E7uaK4SVx-YtcTppHeufsmSFg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 05/12] drivers/irqchip: Add SH7751 and boards
 specific irqchip.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Thu, Aug 31, 2023 at 4:37 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - irq-renesas-sh7751: Renesas SH7751 internal INTC.
> - irq-renesas-r2d: Renesas RTS7751R2D external interrupt encoder.
> - irq-iodata-julian: IO DATA Device LANDISK external interrupt encoder.

Again, please split.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -660,6 +660,10 @@ config APPLE_AIC
>         help
>           Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
>           such as the M1.

Please add a blank line here.

> +config RENESAS_SH_INTC
> +       def_bool y if SH_DEVICE_TREE
> +       select IRQ_DOMAIN
> +       select IRQ_DOMAIN_HIERARCHY
>
>  config MCHP_EIC
>         bool "Microchip External Interrupt Controller"
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index ffd945fe71aa..a3859bdd0442 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -120,3 +120,4 @@ obj-$(CONFIG_IRQ_IDT3243X)          += irq-idt3243x.o
>  obj-$(CONFIG_APPLE_AIC)                        += irq-apple-aic.o
>  obj-$(CONFIG_MCHP_EIC)                 += irq-mchp-eic.o
>  obj-$(CONFIG_SUNPLUS_SP7021_INTC)      += irq-sp7021-intc.o
> +obj-$(CONFIG_RENESAS_SH_INTC)          += irq-renesas-sh7751.o irq-iodata-julian.o irq-renesas-r2d.o

I think it makes sense to split this in 3 different config symbols.

> diff --git a/drivers/irqchip/irq-iodata-julian.c b/drivers/irqchip/irq-iodata-julian.c
> new file mode 100644
> index 000000000000..95e502904a68
> --- /dev/null
> +++ b/drivers/irqchip/irq-iodata-julian.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IO-DATA DEVICE LANDISK / USL-5P (a.k.a Julian) interrupt encoder
> + *
> + * Copyright (C) 2023 Yoshinori Sato
> + */
> +
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>

Do you need this?

> +#include <linux/of_irq.h>

Do you need this?

> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define NUM_IRQ 16
> +
> +struct julian_intc_priv {
> +       struct device *dev;
> +       void __iomem *base;
> +       struct irq_domain *irq_domain;
> +};
> +
> +static struct julian_intc_priv *irq_data_to_priv(struct irq_data *data)

static inline

> +{
> +       return data->domain->host_data;
> +}

> +static __init int julian_intc_map(struct irq_domain *h, unsigned int virq,

I don't think this can be __init...

> +                              irq_hw_number_t hw_irq_num)
> +{
> +       irq_set_chip_and_handler(virq, &julian_intc_chip, handle_level_irq);
> +       irq_get_irq_data(virq)->chip_data = h->host_data;
> +       irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
> +       return 0;
> +}

> +static int julian_intc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct julian_intc_priv *priv;
> +       struct irq_domain *d;
> +       int ret = 0;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = dev;
> +
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       d = irq_domain_add_tree(np, &julian_intc_domain_ops, priv);
> +       if (d == NULL) {
> +               dev_err(dev, "cannot initialize irq domain\n");
> +               kfree(priv);
> +               ret = -ENOMEM;

"return -ENOMEM;", so you can bail out early, remove the else below,
and reduce indentation below.

> +       } else {
> +               priv->irq_domain = d;
> +               irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
> +       }
> +       return ret;
> +}

> +static int julian_intc_remove(struct platform_device *pdev)
> +{
> +       struct julian_intc_priv *priv = platform_get_drvdata(pdev);

This won't work, as platform_set_drvdata() is never called.

> +
> +       irq_domain_remove(priv->irq_domain);
> +       return 0;
> +}
> +
> +static const struct of_device_id julian_intc_dt_ids[] = {
> +       { .compatible = "iodata,julian-intc" },
> +       {},

Please no comma after a sentinel.

> +};
> +MODULE_DEVICE_TABLE(of, julian_intc_dt_ids);

> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-r2d.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RTS7751R2D interrupt encoder
> + *
> + * Copyright (C) 2023 Yoshinori Sato
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>

Do you need this?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define NUM_IRQ 15
> +
> +struct r2d_intc_priv {
> +       struct device *dev;
> +       void __iomem *base;
> +       struct irq_domain *irq_domain;
> +};
> +
> +static const int imask[] = {

unsigned int

> +       1 << 11,        /* PCI INTD */
> +       1 << 9,         /* CF IDE */
> +       1 << 8,         /* CF CD */
> +       1 << 12,        /* PCI INTC */
> +       1 << 10,        /* SM501 */
> +       1 << 6,         /* AX88796 / KEY */
> +       1 << 5,         /* RTC ALARM */
> +       1 << 4,         /* RTC T */
> +       1 << 7,         /* SDCARD */
> +       1 << 14,        /* PCI INTA */
> +       1 << 13,        /* PCI INTB */
> +       1 << 0,         /* EXT */
> +       1 << 15,        /* TP */

BIT(...)

> +};
> +
> +static struct r2d_intc_priv *irq_data_to_priv(struct irq_data *data)

static inline

> +{
> +       return data->domain->host_data;
> +}

> +static __init int r2d_intc_map(struct irq_domain *h, unsigned int virq,
> +                              irq_hw_number_t hw_irq_num)

I don't think this can be __init.

> +{
> +       irq_set_chip_and_handler(virq, &r2d_intc_chip, handle_level_irq);
> +       irq_get_irq_data(virq)->chip_data = h->host_data;
> +       irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
> +       return 0;
> +}

> +static const struct irq_domain_ops r2d_intc_domain_ops = {
> +//     .alloc = r2d_intc_alloc,

Remove this line?

> +       .map = r2d_intc_map,
> +       .translate = r2d_intc_translate,
> +};
> +
> +static int r2d_intc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct r2d_intc_priv *priv;
> +       struct irq_domain *d;
> +       int ret = 0;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = dev;
> +
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       d = irq_domain_add_tree(np, &r2d_intc_domain_ops, priv);
> +       if (d == NULL) {
> +               dev_err(dev, "cannot initialize irq domain\n");
> +               kfree(priv);
> +               ret = -ENOMEM;

"return -ENOMEM;", so you can bail out early, remove the else below,
and reduce indentation below.

> +       } else {
> +               priv->irq_domain = d;
> +               irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
> +       }
> +       return ret;
> +}
> +
> +static int r2d_intc_remove(struct platform_device *pdev)
> +{
> +       struct r2d_intc_priv *priv = platform_get_drvdata(pdev);

This won't work, as platform_set_drvdata() is never called.

> +
> +       irq_domain_remove(priv->irq_domain);
> +       return 0;
> +}
> +
> +static const struct of_device_id r2d_intc_dt_ids[] = {
> +       { .compatible = "renesas,rts7751r2d-intc" },
> +       {},

Please no comma after a sentinel.

> +};
> +MODULE_DEVICE_TABLE(of, r2d_intc_dt_ids);

> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-sh7751.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas SH7751 interrupt controller driver
> + *
> + * Copyright 2023 Yoshinori Sato <ysato@users.sourceforge.jp>
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_address.h>

Do you need this?

> +#include <linux/of_irq.h>

Do you need this?

> +static void update_ipr(struct sh7751_intc_regs *reg, int irq, int on)
> +{
> +       unsigned int addr;
> +       int pos;

unsigned int

> +       uint16_t pri;
> +
> +       if (irq < 64) {
> +               if (ipr_table[irq] != 0xff) {
> +                       addr = (ipr_table[irq] & 0xf0) >> 2;
> +                       pos = (ipr_table[irq] & 0x0f) * 4;
> +                       pri = ~(0x000f << pos);
> +                       pri &= __raw_readw(reg->ipr + addr);
> +                       if (on)
> +                               pri |= 1 << pos;
> +                       __raw_writew(pri, reg->ipr + addr);
> +               }
> +       } else {
> +               if (pri_table[irq - 64] < 32) {

else if

> +                       pos = pri_table[irq - 64];
> +                       pri = ~(0x000f << pos);
> +                       pri &= __raw_readw(reg->intpri00);
> +                       if (on)
> +                               pri |= 1 << pos;
> +                       __raw_writew(pri, reg->intpri00);
> +               }
> +       }
> +}
> +
> +static void sh7751_disable_irq(struct irq_data *data)
> +{
> +       unsigned int irq = data->irq;
> +       struct sh7751_intc_regs *reg = data->chip_data;
> +       uint16_t icr = __raw_readw(reg->icr);
> +
> +       if (irq < 16 && (icr & ICR_IRLM) == 0) {
> +               clear_bit(irq, imask_mask);
> +               if (interrupt_priority < IMASK_PRIORITY - irq)
> +                       interrupt_priority = IMASK_PRIORITY - irq;
> +               set_interrupt_registers(interrupt_priority);
> +       } else
> +               update_ipr(reg, irq, 0);

Missing curly braces for else case.

> +}
> +
> +static void sh7751_enable_irq(struct irq_data *data)
> +{
> +       unsigned int irq = data->irq;
> +       struct sh7751_intc_regs *reg = data->chip_data;
> +       uint16_t icr = __raw_readw(reg->icr);
> +
> +       if (irq < 16 && (icr & ICR_IRLM) == 0) {
> +               set_bit(irq, imask_mask);
> +               interrupt_priority = IMASK_PRIORITY -
> +                 find_first_bit(imask_mask, IMASK_PRIORITY);

wrong indentation

> +               set_interrupt_registers(interrupt_priority);
> +       } else
> +               update_ipr(reg, irq, 1);

Missing curly braces for else case.

> +}

> +static int __init sh7751_intc_of_init(struct device_node *intc,
> +                                     struct device_node *parent)
> +{
> +       unsigned short icr;

u16

> +       struct irq_domain *domain;
> +       void *intc_baseaddr;
> +       void *intc_baseaddr2;
> +
> +       intc_baseaddr = of_iomap(intc, 0);
> +       intc_baseaddr2 = of_iomap(intc, 1);
> +       if (!intc_baseaddr) {
> +               pr_err("Invalid INTC address\n");
> +               return -EINVAL;
> +       }
> +
> +       sh7751_regs.icr = intc_baseaddr;
> +       sh7751_regs.ipr = intc_baseaddr + 4;
> +       sh7751_regs.intpri00 = intc_baseaddr2;
> +       sh7751_regs.intreq00 = intc_baseaddr2 + 0x20;
> +       sh7751_regs.intmsk00 = intc_baseaddr2 + 0x40;
> +       sh7751_regs.intmskclr00 = intc_baseaddr2 + 0x60;
> +
> +       if (of_property_read_bool(intc, "sh7751,irlm")) {
> +               icr = __raw_readw(sh7751_regs.icr);
> +               icr |= 0x80;    // IRLM = 1

#define ICR_IRLM BIT(7)

> +               __raw_writew(icr, sh7751_regs.icr);
> +       }
> +
> +       domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, &sh7751_regs);
> +       if (!domain) {
> +               pr_err("Unable to allocate domain handle\n");
> +               return -ENOMEM;
> +       }
> +       irq_set_default_host(domain);
> +       return 0;
> +}
> +
> +IRQCHIP_DECLARE(sh_7751_intc,
> +               "renesas,sh7751-intc", sh7751_intc_of_init);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
