Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5FCDB482
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjJRNC5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjJRNC5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 09:02:57 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CA118;
        Wed, 18 Oct 2023 06:02:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7d532da4bso84980697b3.2;
        Wed, 18 Oct 2023 06:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634170; x=1698238970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn39POTUOHVRSr1tiTQ5eT1Akj0Jz+yj6bVZ2WVj9Kw=;
        b=u4DvwDl7ruquL6mCg8N7Lg5vqLHEKlwNxH8F7IC4JXVc8tNF8ddNBgSeThUVIgY6wy
         paqM4Fbo1XJqp1+YtUsL4w/lYItZM0JG4lG32rW6nH8xo113bkUgVNVyDV7hwj7wCGuL
         KJwyPUQZljWRuFl91phC6z4izwWC0n2ivO318taucxiJn4DjXOkGQ4zecazNgSxdxN1i
         Ux4IYnluqALAlXHZABJsBTKLu81IzxPxFeas0U1T0sZBBjZlXMhv/twevy1/fuTPqfXl
         fdba+LqCQqnniFwNG3fAUQLdTzkdRVrH7pFLjUb/3xKcnAWUaG5YtFetAObnGTKq9qPA
         14lQ==
X-Gm-Message-State: AOJu0Yx9b+AZ+b1/Z7gfGS1i8317SXiprh7XslNdNErnMTcoWdQYd97t
        Amb4Nm2dHWeX0htAf2zY4k2WmdR3rKGMmA==
X-Google-Smtp-Source: AGHT+IFYw+l1f/DP5u4Jr230jxI8FU4+rdL7GZY8awo9wIU3sxAoLRcinrFlWDp4nXkLo0Va9Uuuhg==
X-Received: by 2002:a0d:ddcd:0:b0:59c:aea:d877 with SMTP id g196-20020a0dddcd000000b0059c0aead877mr5278084ywe.40.1697634169937;
        Wed, 18 Oct 2023 06:02:49 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t202-20020a0dead3000000b005a1cc37aff1sm1460254ywe.20.2023.10.18.06.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:02:49 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so7332993276.0;
        Wed, 18 Oct 2023 06:02:49 -0700 (PDT)
X-Received: by 2002:a25:77c5:0:b0:d9a:44fd:c72b with SMTP id
 s188-20020a2577c5000000b00d9a44fdc72bmr4986045ybc.13.1697634169463; Wed, 18
 Oct 2023 06:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <a772e1b6de89af22057d3af31cc03dcad7964fc7.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <a772e1b6de89af22057d3af31cc03dcad7964fc7.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 15:02:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzvgwxtQB1WgW=On7gPf66PR1DGtN2dVYxEmsAqTAYWg@mail.gmail.com>
Message-ID: <CAMuHMdWzvgwxtQB1WgW=On7gPf66PR1DGtN2dVYxEmsAqTAYWg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/35] drivers/clk/renesas: clk-sh7750.c
 SH7750/7751 CPG driver.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> This driver supported SH7750/7751 PLL/Divider clock and module stop.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> ---
>  drivers/clk/renesas/Kconfig      |  21 +-
>  drivers/clk/renesas/Makefile     |   1 +
>  drivers/clk/renesas/clk-sh7750.c | 787 +++++++++++++++++++++++++++++++
>  3 files changed, 807 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/renesas/clk-sh7750.c
>
> diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
> index 37632a0659d8..c52c038ce715 100644
> --- a/drivers/clk/renesas/Kconfig
> +++ b/drivers/clk/renesas/Kconfig
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  config CLK_RENESAS
> -       bool "Renesas SoC clock support" if COMPILE_TEST && !ARCH_RENESAS
> -       default y if ARCH_RENESAS
> +       bool "Renesas SoC clock support" if COMPILE_TEST && !ARCH_RENESAS && SUPERH

"!SUPERH", so the symbol becomes invisible but enabled on SH.

> +       default y if ARCH_RENESAS || SUPERH
>         select CLK_EMEV2 if ARCH_EMEV2
>         select CLK_RZA1 if ARCH_R7S72100
>         select CLK_R7S9210 if ARCH_R7S9210
> @@ -39,6 +39,11 @@ config CLK_RENESAS
>         select CLK_R9A07G054 if ARCH_R9A07G054
>         select CLK_R9A09G011 if ARCH_R9A09G011
>         select CLK_SH73A0 if ARCH_SH73A0
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7750
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7750S
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7750R
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7751
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7751R

Please combine all of the above into a single statement using "||",
like is done for other shared drivers.

>
>  if CLK_RENESAS
>
> @@ -188,6 +193,10 @@ config CLK_SH73A0
>         select CLK_RENESAS_CPG_MSTP
>         select CLK_RENESAS_DIV6
>
> +config CLK_SH7750
> +       bool "SH7750/7751 family clock support" if COMPILE_TEST
> +       help
> +         This is a driver for SH7750 / SH7751 CPG.
>
>  # Family
>  config CLK_RCAR_CPG_LIB
> @@ -218,6 +227,14 @@ config CLK_RZG2L
>         bool "Renesas RZ/{G2L,G2UL,V2L} family clock support" if COMPILE_TEST
>         select RESET_CONTROLLER
>
> +config CLK_SH7750
> +       bool "Renesas SH7750/7751 family clock support"

"if COMPILE_TEST", so the symbol becomes invisible when auto-enabled.

> +       depends on CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
> +                  CPU_SUBTYPE_SH7750R || \
> +                  CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST

Please drop this dependency, as it is not needed.

> --- /dev/null
> +++ b/drivers/clk/renesas/clk-sh7750.c

> +static void sbcr_sw(struct clk_hw *hw, bool on)
> +{
> +       struct clk_gate *gate = to_clk_gate(hw);
> +       u8 msk = BIT(gate->bit_idx);
> +       u8 val;
> +
> +       val = readb(gate->reg);
> +       if (on)
> +               val &= ~msk;
> +       else
> +               val |= msk;
> +       writeb(val, gate->reg);

RMW (Read-Modify-Write) needs locking.

> +}
> +
> +static int sbcr_enable(struct clk_hw *hw)
> +{
> +       sbcr_sw(hw, true);
> +       return 0;
> +}
> +
> +static void sbcr_disable(struct clk_hw *hw)
> +{
> +       sbcr_sw(hw, false);
> +}
> +
> +static int sbcr_is_enabled(struct clk_hw *hw)
> +{
> +       u8 val;
> +       struct clk_gate *gate = to_clk_gate(hw);
> +
> +       val = readb(gate->reg);
> +       val &= 1 << gate->bit_idx;
> +       return val != 0;
> +}
> +
> +static const struct clk_ops gate_stbcr_ops = {
> +       .enable = sbcr_enable,
> +       .disable = sbcr_disable,
> +       .is_enabled = sbcr_is_enabled,
> +};

These are almost identical to clk_gate_ops, except that they use
8-bit instead of 32-bit register accesses.
Perhaps you can extend the standard gate clock in drivers/clk/clk-gate.c
instead, using a new CLK_GATE_* flag?

> +
> +static void clkstp00_sw(struct clk_hw *hw, bool on)
> +{
> +       u32 val;
> +       struct clk_gate *gate = to_clk_gate(hw);
> +
> +       val = BIT(gate->bit_idx);
> +       if (on)
> +               writel(val, gate->reg + CLKSTPCLR00);
> +       else
> +               writel(val, gate->reg);
> +}
> +
> +static int clkstp00_enable(struct clk_hw *hw)
> +{
> +       clkstp00_sw(hw, true);
> +       return 0;
> +}
> +
> +static void clkstp00_disable(struct clk_hw *hw)
> +{
> +       clkstp00_sw(hw, false);
> +}
> +
> +static int clkstp00_is_enabled(struct clk_hw *hw)
> +{
> +       u8 val;
> +       struct clk_gate *gate = to_clk_gate(hw);
> +
> +       val = readb(gate->reg);

readl()?

> +       val &= 1 << gate->bit_idx;
> +       return val == 0;
> +}
> +
> +static const struct clk_ops gate_clkstp00_ops = {
> +       .enable = clkstp00_enable,
> +       .disable = clkstp00_disable,
> +       .is_enabled = clkstp00_is_enabled,
> +};

These look identical to clk_gate_ops, so you can just use
clk_register_gate() instead?

> +static int register_div(struct device_node *node, struct cpg_priv *cpg)
> +{
> +       static const char * const divout[] = {
> +               "fck", "bck", "ick",
> +       };
> +       static const char * const mstpout[] = {
> +               "sci_clk", "rtc_clk", "tmu012_clk",     /* STBCR */
> +               "scif_clk", "dmac_clk",                 /* STBCR */
> +               "ubc_clk", "sq_clk",                    /* STBCR2 */

FTR, qemu does not support STBCR and STBCR2 yet, causing
"qemu-system-sh4 -M r2d" to crash.  I have posted a patch to fix that:
"[PATCH RFC] hw/sh4/sh7750: Add STBCR/STBCR2 register support"
https://lore.kernel.org/all/20231018124023.2927710-1-geert+renesas@glider.be

> +               "intc_clk", "tmu34_clk", "pcic_clk",    /* CLKSTP00 */
> +       };

The order of the entries in these two arrays is tied intimately to
the values in include/dt-bindings/clock/sh7750.h.  Hence I think it
would be good to reflect that in the data and code below, by using
the SH7750_CPG_* identifier.

> +       struct sh_clk_reg_arg args[ARRAY_SIZE(divout) + ARRAY_SIZE(mstpout)];
> +       unsigned int i, j;
> +       int ret;
> +
> +       for (i = 0; i < ARRAY_SIZE(divout); i++) {
> +               args[i].type = CLK_DIV;
> +               args[i].name  = divout[i];
> +               args[i].parent = PLLOUT;
> +               args[i].reg = cpg->frqcr;
> +               args[i].ops = &sh_clk_divider_ops;
> +               args[i].div.shift = i * 3;
> +               args[i].div.width = 3;
> +               args[i].div.table = (i == 0) ? pdiv_table : div_table;
> +       }
> +       for (i = 0, j = ARRAY_SIZE(divout); j < ARRAY_SIZE(args); i++, j++) {
> +               args[j].type = CLK_GATE;
> +               args[j].name  = mstpout[i];
> +               args[j].parent = divout[0];
> +               switch (i) {
> +               case 0 ... 4:
> +                       args[j].reg = cpg->frqcr + STBCR;
> +                       args[j].gate.bit_idx = i;
> +                       args[j].ops = &gate_stbcr_ops;
> +                       break;
> +               case 5 ... 6:
> +                       args[j].reg = cpg->frqcr + STBCR2;
> +                       args[j].gate.bit_idx = i - 5;
> +                       args[j].ops = &gate_stbcr_ops;
> +                       break;
> +               case 7 ... 9:
> +                       args[j].reg = cpg->clkstp00;
> +                       args[j].gate.bit_idx = i - 7;
> +                       args[j].ops = &gate_clkstp00_ops;
> +                       break;
> +               }
> +       }
> +
> +       ret = _clk_register(node, ARRAY_SIZE(args), args,
> +                           &cpg->clklock, &cpg->hw);
> +       if (ret < 0)
> +               pr_err("%pOF: failed to register clock (%d)\n",
> +                      node, ret);
> +       return ret;
> +}
> +
> +static struct cpg_priv *sh7750_cpg_setup(struct device_node *node)
> +{
> +       unsigned int num_parents;
> +       u32 mode;
> +       struct cpg_priv *cpg;
> +       int ret = 0;
> +
> +       num_parents = of_clk_get_parent_count(node);
> +       if (num_parents < 1) {
> +               pr_err("%s: no parent found", node->name);
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       of_property_read_u32_index(node, "renesas,mode", 0, &mode);
> +       if (mode >= 7) {
> +               pr_err("%s: Invalid clock mode setting (%u)\n",
> +                      node->name, mode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       cpg = kzalloc(sizeof(struct cpg_priv), GFP_KERNEL);
> +       if (!cpg) {
> +               pr_err("%pOF: failed to alloc memory", node);

No need to print an error message on allocation failure, as the
core memory allocation code already took care of that.

> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       cpg->frqcr = of_iomap(node, 0);
> +       if (cpg->frqcr == NULL) {

!cpg->frqcr

> +               pr_err("%pOF: failed to map divide register", node);
> +               ret = -ENODEV;
> +               goto cpg_free;
> +       }
> +
> +       cpg->clkstp00 = of_iomap(node, 1);
> +       if (cpg->clkstp00 == NULL) {

!cpg->clkstp00

> +               pr_err("%pOF: failed to map clkstp00 register", node);
> +               ret = -ENODEV;
> +               goto unmap_frqcr;
> +       }
> +       cpg->mode = mode;
> +
> +       ret = register_pll(node, cpg);
> +       if (ret < 0)
> +               goto unmap_clkstp00;
> +
> +       ret = register_div(node, cpg);
> +       if (ret < 0)
> +               goto unmap_clkstp00;
> +
> +       return cpg;
> +
> +unmap_clkstp00:
> +       iounmap(cpg->clkstp00);
> +unmap_frqcr:
> +       iounmap(cpg->frqcr);
> +cpg_free:
> +       kfree(cpg);
> +       return ERR_PTR(ret);
> +}
> +
> +static void __init sh7750_cpg_init(struct device_node *node)
> +{
> +       cpg_data = sh7750_cpg_setup(node);
> +       if (IS_ERR(cpg_data))
> +               cpg_data = NULL;
> +       else
> +               cpg_data->have_div1 = !of_device_is_compatible(node, "renesas,sh7750r");

Please no explicit of_device_is_compatible() checks in code that is
called through a compatible-based match.

You can differentiate using multiple CLK_OF_DECLARE_DRIVER() stances,\
each with a different init function.

> +}
> +
> +CLK_OF_DECLARE_DRIVER(sh7750_cpg, "renesas,sh7750-cpg",
> +                     sh7750_cpg_init);
> +
> +static int sh7750_cpg_probe(struct platform_device *pdev)
> +{
> +       if (cpg_data)
> +               return 0;
> +       cpg_data = sh7750_cpg_setup(pdev->dev.of_node);
> +       if (IS_ERR(cpg_data))
> +               return PTR_ERR(cpg_data);
> +       cpg_data->have_div1 = (of_device_get_match_data(&pdev->dev) != NULL);
> +       return 0;
> +}
> +
> +static const struct of_device_id sh7750_cpg_of_match[] = {
> +       { .compatible = "renesas,sh7750-cpg",
> +         .data = (void *)1 },
> +       { .compatible = "renesas,sh7750s-cpg",
> +         .data = (void *)1 },
> +       { .compatible = "renesas,sh7750r-cpg",
> +         .data = 0 },
> +       { .compatible = "renesas,sh7751-cpg",
> +         .data = (void *)1 },
> +       { .compatible = "renesas,sh7751r-cpg",
> +         .data = 0 },
> +       { }
> +};
> +
> +static struct platform_driver sh7750_cpg_driver = {
> +       .probe  = sh7750_cpg_probe,
> +       .driver = {
> +               .name = "sh7750-cpg",
> +               .of_match_table = sh7750_cpg_of_match,
> +       },
> +};
> +builtin_platform_driver(sh7750_cpg_driver);

As the clock driver is always probed early through
CLK_OF_DECLARE_DRIVER, what is the use of the extra platform driver?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
