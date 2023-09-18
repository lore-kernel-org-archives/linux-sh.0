Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C7C46CA1
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 16:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjIRQHf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjIRQHZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 12:07:25 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F96E9D;
        Mon, 18 Sep 2023 09:05:37 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d8181087dc9so4212513276.3;
        Mon, 18 Sep 2023 09:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053137; x=1695657937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1/vmY6rZvIej4ygh7IWLFkgOKHXgwWsTVOn8tVpI9o=;
        b=DupzuQotgRbE/jsJGHM/+Sm2IWXH6BENP3qLw+urrJWwZP1Ur17qjVVFJh3FAe1nYr
         rCNuMxcqUZWbgG4zaCG+r1bhDzOmxoaNgo9lako7o2oXo0RbnNvFWWrYj+pcP5v64IG+
         zEFqhjJVx2x5d8dK06kpxgiSg34y6WXtKOBNYR1knygVgYcNrMOHHmiLLyQpqJSt8Qew
         ll2/IKHjPZILs3faWlccT21bt3wequU9Gr+nol50Acs3FMVt9OzE6fWmYUgZf22yea0T
         44m2havz8MwHkn0XWt0zq7KG42hPCVE6Y1jO5i+K0CK/5KCz1j+fWG31P9xkOM8PtXbX
         X3BA==
X-Gm-Message-State: AOJu0YzasUQBJYMVlcDc7OPfzo0trsXHIgG6QXQYL/OtUFD4A0S6rkj+
        iRqv0gY8x+7zWjaVJ912HCMp0shzCgumJQ==
X-Google-Smtp-Source: AGHT+IHbeukF1H1g/gc72+wXvXK7Uqao3n5ggyxh/FDAYy/YJuhQfsu1nUiVYjvhcUGLBG1bCKxV/w==
X-Received: by 2002:a25:b85:0:b0:d7b:97f3:4646 with SMTP id 127-20020a250b85000000b00d7b97f34646mr8460236ybl.60.1695053136709;
        Mon, 18 Sep 2023 09:05:36 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 72-20020a25054b000000b00d7802512079sm2361618ybf.38.2023.09.18.09.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 09:05:36 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5925e580f12so49412407b3.3;
        Mon, 18 Sep 2023 09:05:36 -0700 (PDT)
X-Received: by 2002:a0d:cb16:0:b0:59b:52d6:9a34 with SMTP id
 n22-20020a0dcb16000000b0059b52d69a34mr9887143ywd.11.1695053136322; Mon, 18
 Sep 2023 09:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <a9a3e6f0dfdd1c5d6970d2decffef3c07d93476e.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <a9a3e6f0dfdd1c5d6970d2decffef3c07d93476e.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 18:05:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwGdEJrfuVvwOCL34OmmbkkO=DQeSoqWDkSjxub=00sQ@mail.gmail.com>
Message-ID: <CAMuHMdWwGdEJrfuVvwOCL34OmmbkkO=DQeSoqWDkSjxub=00sQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/30] drivers/clk: SH7750 / SH7751 CPG Driver
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:25 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

>  drivers/clk/renesas/clk-sh7750.c | 236 +++++++++++++++++++++++++++++++

Patch prefix should be "clk: renesas: ".

> --- /dev/null
> +++ b/drivers/clk/renesas/clk-sh7750.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas SH7750/51 CPG driver
> + *
> + * Copyright 2023 Yoshinori Sato <ysato@users.sourceforge.jp>
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>

Please add a blank line.

> +#include "clk-shdiv.h"

This doesn't exist until "[RFC PATCH v2 11/30] drivers/clk: SuperH
generai clock divider helper", so please move that patch up in the
series.

> +#include <dt-bindings/clock/sh7750.h>

This doesn't exist until "[RFC PATCH v2 24/30] include/dt-bindings:
Add SH7750 CPG header.", so please move that patch up in the series.

> +
> +static DEFINE_SPINLOCK(clklock);

I think it would make sense to move this into struct cpg_priv.


> +struct cpg_priv {
> +       struct clk_hw hw;
> +       void __iomem *frqcr;
> +       void __iomem *wdt;
> +       u32 mode;
> +       bool have_div1;
> +};
> +
> +#define to_priv(_hw) container_of(_hw, struct cpg_priv, hw)
> +
> +#define FRQCR_PLL1EN BIT(10)
> +static const int pll1mult[] = { 12, 12, 6, 12, 6, 12, 1};

unsigned int

> +
> +static unsigned long pll_recalc_rate(struct clk_hw *hw,
> +                                     unsigned long parent_rate)
> +{
> +       struct cpg_priv *cpg = to_priv(hw);
> +       unsigned long rate = parent_rate;
> +       uint16_t frqcr;

u16

Please don't mix uint<n>_t and u<n> in the same driver.

> +static int pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +       struct cpg_priv *cpg = to_priv(hw);
> +
> +       get_round_rate(cpg, &req->rate, NULL, req->rate, req->best_parent_rate);
> +       return 0;
> +}
> +
> +static int pll_set_rate(struct clk_hw *hw,
> +                       unsigned long rate, unsigned long prate)
> +{
> +       struct cpg_priv *cpg = to_priv(hw);
> +       bool oldpll, newpll;
> +       uint16_t frqcr;

u16


> +static void __init register_div(struct device_node *node, struct cpg_priv *cpg)
> +{
> +       static const char * const divout[] = {
> +               [SH7750_CPG_FCK] = "fck",
> +               [SH7750_CPG_BCK] = "bck",
> +               [SH7750_CPG_ICK] = "ick",
> +       };
> +       struct clk *clk;
> +       int i;

unsigned int

> +
> +       for (i = 0; i < ARRAY_SIZE(divout); i++) {
> +               if (sh_div_clk_register(node, divout[i], PLLOUT,
> +                                       cpg->frqcr, i * 3, 3,
> +                                       (i == 0) ? pdiv_table : div_table,
> +                                       &clklock) < 0)
> +                       pr_err("%s: failed to register %s div clock (%ld)\n",
> +                              __func__, divout[i], PTR_ERR(clk));
> +       }
> +}
> +
> +
> +static void __init sh7750_cpg_setup(struct device_node *node)
> +{
> +       unsigned int num_parents;
> +       struct cpg_priv *cpg;
> +
> +       num_parents = of_clk_get_parent_count(node);
> +       if (num_parents < 1) {
> +               pr_err("%s: no parent found", node->name);
> +               return;
> +       }
> +
> +       cpg = kzalloc(sizeof(struct cpg_priv), GFP_KERNEL);
> +       if (!cpg) {
> +               pr_err("%s: failed to alloc memory", node->name);
> +               return;
> +       }
> +
> +       of_property_read_u32_index(node, "renesas,mode", 0, &cpg->mode);
> +       if (cpg->mode >= 7) {
> +               pr_err("%s: Invalid clock mode setting (%u)\n",
> +                      node->name, cpg->mode);
> +               goto cpg_free;
> +       }
> +       cpg->have_div1 = (of_device_is_compatible(node, "renesas,sh7750r-pll-clk") == 0);

What is this for? There are no users of "renesas,sh7750r-pll-clk".

> +
> +       cpg->frqcr = of_iomap(node, 0);
> +       if (cpg->frqcr == NULL) {
> +               pr_err("%s: failed to map divide register", node->name);
> +               goto cpg_free;
> +       }
> +
> +       cpg->wdt = of_iomap(node, 1);
> +       if (cpg->wdt == NULL) {
> +               pr_err("%s: failed to map watchdog register", node->name);
> +               goto unmap_frqcr;
> +       }
> +
> +       if (!register_pll(node, cpg))
> +               goto unmap_wdt;
> +
> +       register_div(node, cpg);
> +
> +unmap_wdt:
> +       iounmap(cpg->wdt);
> +unmap_frqcr:
> +       iounmap(cpg->frqcr);
> +cpg_free:
> +       kfree(cpg);
> +}
> +
> +CLK_OF_DECLARE(sh7750_cpg, "renesas,sh7750-cpg",
> +              sh7750_cpg_setup);

Probably you want a second entry for "renesas,sh7751-cpg"?

Is there a good reason to use CLK_OF_DECLARE()?
Perhaps because you need it early for the timer?

Most modern clock drivers use a platform_driver, registered from
e.g. subsys_initcall().  When you need an early initialization phase,
you can use CLK_OF_DECLARE_DRIVER() for the early part.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
