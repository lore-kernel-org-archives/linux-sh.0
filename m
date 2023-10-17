Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C9CDB474
	for <linux-sh@archiver.kernel.org>; Tue, 17 Oct 2023 09:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjJQJ2B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 17 Oct 2023 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjJQJ1u (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 17 Oct 2023 05:27:50 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35F18A
        for <linux-sh@vger.kernel.org>; Tue, 17 Oct 2023 02:27:40 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59e88a28b98so47008517b3.1
        for <linux-sh@vger.kernel.org>; Tue, 17 Oct 2023 02:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534859; x=1698139659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qlh0dmVrg/Alj6sCt+kMYrbIpuqt/FKRebN9q5AoSs=;
        b=BJg6bRHbOc+gj96PjKjJW3y8LTRgsgI8wgcjP0X0pJcWnu8HYvkIwPFo3PtmLKZQHz
         3x7WmGX7Ea32hXkvogiMM9cq1o2fq2cVgLRG9NhzQJOnpmP6VX5bO2x/+ZlTKO6IZHFY
         bAHrtfUXiEEL7aHw5hZOIWHObPRldkXvumsDcwej2kIyJcE2f8y9dxtjcvEcUXsS7RWw
         W8erPdWVWOgYM1JuIs1qB1bDGywHDOorgxhickYl+5CkdN9KGBaV2bm3OjyraPPxdiCk
         IpaSX9FMsoddGhTB+nV03ep2b28UbtY5FAich9I9BqWFr2NbRUdaM9YERo3S3kZ6msb+
         qBEg==
X-Gm-Message-State: AOJu0Yxr10YLOrv4TZn5+Z5cJiMp5XvfGNA3h0hlUK/F983CTd8rZala
        0xne4Duyeqlp4getkXDRiq5LR/hdFQa51Q==
X-Google-Smtp-Source: AGHT+IEZJ9frtKYSXkgm1cCBGqGVfOhKga2r+hGuIDJ3pYxMKONU4Zv5OrMWUpC1/VknDyqaRd+RJg==
X-Received: by 2002:a81:a00c:0:b0:5a7:fcad:e865 with SMTP id x12-20020a81a00c000000b005a7fcade865mr1086854ywg.2.1697534859265;
        Tue, 17 Oct 2023 02:27:39 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id x9-20020a0dd509000000b005a7be94585bsm460680ywd.96.2023.10.17.02.27.39
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:27:39 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a8628e54d4so20156947b3.0
        for <linux-sh@vger.kernel.org>; Tue, 17 Oct 2023 02:27:39 -0700 (PDT)
X-Received: by 2002:a0d:d7c8:0:b0:5a7:d088:2c5d with SMTP id
 z191-20020a0dd7c8000000b005a7d0882c5dmr856602ywd.26.1697534858848; Tue, 17
 Oct 2023 02:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <b7d3002d7033a94a57577af68a13f4cfc3a88947.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <b7d3002d7033a94a57577af68a13f4cfc3a88947.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Oct 2023 11:27:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVH=yTFFmJ0bPzpj4OvbcRRcy4GGV_ppEFxLDa7Z3B2Qw@mail.gmail.com>
Message-ID: <CAMuHMdVH=yTFFmJ0bPzpj4OvbcRRcy4GGV_ppEFxLDa7Z3B2Qw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 14/35] drivers/irqchip: Add SH7751 Internal INTC drivers.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        tglx@linutronix.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7751 Internal interrupt controler driver.

controller

>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-sh7751.c

> +static int __init load_ipr_map(struct device_node *intc,
> +                              struct sh7751_intc_priv *priv)
> +{
> +       int num_ipr;
> +       struct iprmap *p;
> +       u32 val[3];
> +       unsigned int i, idx;
> +
> +       num_ipr = of_property_count_elems_of_size(intc, "renesas,ipr-map", sizeof(u32) * 3);
> +       if (num_ipr < 0)
> +               return num_ipr;
> +
> +       priv->iprmap = kcalloc(num_ipr, sizeof(struct iprmap), GFP_KERNEL);
> +       if (priv->iprmap == NULL) {
> +               pr_err("%s: Failed to alloc memory\n", intc->name);

No need to print anything, as the memory allocation core code already
takes care of that.

> +               return -ENOMEM;
> +       }
> +       priv->num_ipr = num_ipr;
> +
> +       for (p = priv->iprmap, idx = 0; num_ipr > 0; p++, num_ipr--) {
> +               for (i = 0; i < 3; idx++, i++) {
> +                       if (of_property_read_u32_index(intc, "renesas,ipr-map",
> +                                                      idx, &val[i])) {

You can use of_find_property() once to find the property, and iterate
its values using of_prop_next_u32().

> +                               pr_err("%s: Failed to load ipr-map\n", intc->name);
> +                               kfree(priv->iprmap);
> +                               return -EINVAL;
> +                       }
> +               }
> +               p->irq = evt2irq(val[0]);
> +               p->reg = val[1];
> +               p->bits = val[2];
> +       }
> +       /* This table will be searched using bsearch, so sort it. */
> +       sort(priv->iprmap, priv->num_ipr, sizeof(struct iprmap),
> +            sort_ipr_cmp, sort_ipr_swap);
> +
> +       for (p = priv->iprmap, idx = 0; idx < priv->num_ipr; p++, idx++)
> +               pr_debug("irq=%04x reg=%02x bits=%d\n", p->irq, p->reg, p->bits);
> +       return 0;
> +}
> +
> +static int __init sh7751_intc_of_init(struct device_node *intc,
> +                                     struct device_node *parent)
> +{
> +       u16 icr;
> +       struct irq_domain *domain;
> +       void *intc_baseaddr;
> +       void *intc_baseaddr2;
> +       struct sh7751_intc_priv *priv;
> +       int ret;
> +
> +       intc_baseaddr = of_iomap(intc, 0);
> +       intc_baseaddr2 = of_iomap(intc, 1);
> +       if (IS_ERR(intc_baseaddr)) {

of_iomap() returns NULL on failure.
Missing check for intc_baseaddr2.

> +               pr_err("%pOFP: Invalid register definition\n", intc);
> +               return -EINVAL;
> +       }
> +
> +       priv = kzalloc(sizeof(struct sh7751_intc_priv), GFP_KERNEL);
> +       if (priv == NULL) {
> +               pr_err("%pOFP: Failed to alloc memory\n", intc);

No need to print anything, as the memory allocation core code already
takes care of that.

> +               return -ENOMEM;
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
