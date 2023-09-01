Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D348CA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 12:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbjIAM1E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347272AbjIAM1D (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 08:27:03 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75010D4
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 05:27:00 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59231a1ca9eso20339367b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571219; x=1694176019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N7rO2BU0AIrzW8I0nLPauaiNcBdHrQYP7m7W8wMp0o=;
        b=fgrxfEdlH6z1uU17DB64Cpg9B3LJaSI4H5vlVPVc63jLZQazDdqZXMzGE0+pIyhpDA
         22BsNkbcWmgb4gqZdGoOQ+hHGa/WAsqdXp0kDplWhNpuJgU0n8bFW6rqCX6sXKiemcMg
         +P8TV0vzOs1WfBOYwwVRN2YINfYuIPcgq+gOADYZDDBTI6CkO/TvTK/iSIABDyxTZFOB
         /eCoo702MkRnPQLSXLZ14OrQa9s5IlNg6PyzO6I5xniBWMqRzgQparJXnf6l5P7/S2FU
         /kWXjgYrFn/zyy7s2hJ72yruqqKQ9V7Nl44WH41SD/UCmg69/3M8d0uBz7UXWoebihpl
         aBmw==
X-Gm-Message-State: AOJu0YyIN6AZwAVInF9ej94FzCtZHd16OgqYb2RS1otCN8925WGQ6qJd
        PXwwt57pS2w6BBHWEE7h9V/Y2KXTrRUcbg==
X-Google-Smtp-Source: AGHT+IFq2oBNinrj7D1LKdKqx4FeZGOPAwM0J85+yzRSLd62qWLKNi1/U38Rcj55ZZ3/gKeYG8UVJw==
X-Received: by 2002:a81:a157:0:b0:595:320d:c9e2 with SMTP id y84-20020a81a157000000b00595320dc9e2mr2476438ywg.24.1693571219341;
        Fri, 01 Sep 2023 05:26:59 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id h8-20020a816c08000000b0058451c12076sm1029365ywc.14.2023.09.01.05.26.59
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:26:59 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5920efd91c7so20267667b3.2
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:26:59 -0700 (PDT)
X-Received: by 2002:a25:8206:0:b0:d78:21e0:c06d with SMTP id
 q6-20020a258206000000b00d7821e0c06dmr2541480ybk.64.1693571218807; Fri, 01 Sep
 2023 05:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <541eb279023563f17245deabc32b9f65dbf92b9a.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <541eb279023563f17245deabc32b9f65dbf92b9a.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:26:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTJg9sKrhzGrWZu1-GmLtCRSSajPt59=E_v4uQ3N0Zdg@mail.gmail.com>
Message-ID: <CAMuHMdVTJg9sKrhzGrWZu1-GmLtCRSSajPt59=E_v4uQ3N0Zdg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 04/12] clk: SH7750 / 7751 clk driver.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 11:32 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Use COMMON_CLK framework clock driver.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/sh/Kconfig
> @@ -0,0 +1,7 @@
> +config COMMON_CLK_SH7750
> +       bool "Clcok driver for SH7750/SH7751"

Clock

> +       depends on CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
> +                  CPU_SUBTYPE_SH7750R || \
> +                  CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R

|| COMPILE_TEST?

Anyway, I would do

    select COMMON_CLK_SH7750 if CPU_SUBTYPE_SH7750 || ...

at the top, and

    bool "Clock driver for SH7750/SH7751" if COMPILE_TEST

cfr. drivers/clk/renesas/Kconfig.

BTW, do you plan to put all SuperH clock drivers under SH?
For a simple CPG like in SH7750/7751 that could make sense.
For the more complex ones like SH7724, you probably want to plug
into the existing drivers/clk/renesas/renesas-cpg-mssr.c instead,
as it is very similar to the CPG on later Renesas ARM SoCs.

But even SH7751 has Standby Control registers with Module Stop
bits...

> +       help
> +         This driver supports the Renesas SH7750 and SH7751 CPG.
> diff --git a/drivers/clk/sh/Makefile b/drivers/clk/sh/Makefile
> new file mode 100644
> index 000000000000..7122c37655aa
> --- /dev/null
> +++ b/drivers/clk/sh/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_COMMON_CLK_SH7750) += clk-sh7750.o
> +obj-$(CONFIG_COMMON_CLK_SH7750) += clk-shdiv.o

These can be one line.

> diff --git a/drivers/clk/sh/clk-sh7750.c b/drivers/clk/sh/clk-sh7750.c
> new file mode 100644
> index 000000000000..f41712a9cf44
> --- /dev/null
> +++ b/drivers/clk/sh/clk-sh7750.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Renesas SH7750/51 clock driver
> + *
> + * Copyright 2023 Yoshinori Sato <ysato@users.sourceforge.jp>
> + */
> +
> +#include <linux/clk.h>

Do you need the consumer API?

> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +
> +struct clk *sh_div_clk_register(struct device *dev, const char *name,
> +                               const char *parent_name,
> +                               void __iomem *reg, u8 shift, u8 width,
> +                               const struct clk_div_table *table,
> +                               spinlock_t *lock);

Please move this to a (private) header file.  Else builds with W=1
will complain about "warning: no previous prototype".

> +
> +static DEFINE_SPINLOCK(clklock);
> +
> +static struct clk_div_table pdiv_table[] = {

const

> +       { .val = 0, .div = 2, },
> +       { .val = 1, .div = 3, },
> +       { .val = 2, .div = 4, },
> +       { .val = 3, .div = 6, },
> +       { .val = 4, .div = 8, },
> +       { .val = 0, .div = 0, },
> +};
> +
> +static struct clk_div_table div_table[] = {

const

> +       { .val = 0, .div = 1, },
> +       { .val = 1, .div = 2, },
> +       { .val = 2, .div = 3, },
> +       { .val = 3, .div = 4, },
> +       { .val = 4, .div = 6, },
> +       { .val = 5, .div = 8, },
> +       { .val = 0, .div = 0, },
> +};
> +
> +struct pll_clock {
> +       struct clk_hw hw;
> +       void __iomem *frqcr;
> +       void __iomem *wdt;
> +       int md;

u32

> +       bool div1;
> +};
> +
> +#define to_pll_clock(_hw) container_of(_hw, struct pll_clock, hw)
> +
> +static unsigned long pll_recalc_rate(struct clk_hw *hw,
> +                                     unsigned long parent_rate)
> +{
> +       struct pll_clock *pll_clock = to_pll_clock(hw);
> +       unsigned long rate = parent_rate;
> +       uint16_t frqcr;
> +       static const int pll1[] = { 12, 12, 6, 12, 6, 12, 1};
> +
> +       frqcr = ioread16(pll_clock->frqcr);
> +       if (frqcr & (1 << 10)) {

Please add a define for "1 << 10" (or "BIT(10)").

#define FRQCR_PLL1EN    BIT(10)

> +               rate *= pll1[pll_clock->md];
> +               if (pll_clock->md < 6 && pll_clock->div1)
> +                       rate /= 2;
> +       }
> +       return rate;
> +}
> +
> +static const struct clk_ops pll_ops = {
> +       .recalc_rate = pll_recalc_rate,
> +};
> +
> +static void __init sh7750_pll_clk_setup(struct device_node *node)
> +{
> +       unsigned int num_parents;
> +       struct clk *clk;
> +       const char *clk_name = node->name;
> +       const char *parent_name;
> +       struct pll_clock *pll_clock;
> +       struct clk_init_data init;
> +
> +       num_parents = of_clk_get_parent_count(node);
> +       if (num_parents < 1) {
> +               pr_err("%s: no parent found", clk_name);
> +               return;
> +       }
> +
> +       pll_clock = kzalloc(sizeof(struct pll_clock), GFP_KERNEL);
> +       if (!pll_clock)
> +               return;
> +
> +       pll_clock->frqcr = of_iomap(node, 0);
> +       if (pll_clock->frqcr == NULL) {
> +               pr_err("%s: failed to map frequenct control register",

frequency

> +                      clk_name);
> +               goto free_clock;
> +       }
> +
> +       pll_clock->wdt = of_iomap(node, 1);
> +       if (pll_clock->wdt == NULL) {
> +               pr_err("%s: failed to map watchdog register", clk_name);
> +               goto unmap_frqcr;
> +       }
> +
> +       of_property_read_u32_index(node, "sh7750,md", 0, &pll_clock->md);

R-Mobile A1 uses "renesas,mode" for this, cfr.
Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml

> +       if (pll_clock->md >= 7) {
> +               pr_err("%s: failed to clock mode setting (%d)\n",

invalid clock mode setting?
%u

> +                      clk_name, pll_clock->md);
> +               goto unmap_wdt;
> +       }
> +       pll_clock->div1 = !of_property_read_bool(node, "sh7750,rtype");

Shouldn't this be derived from the compatible value instead?

> +static void __init sh7750_div_clk_setup(struct device_node *node)
> +{
> +       unsigned int num_parents;
> +       struct clk *clk;
> +       const char *clk_name = node->name;
> +       const char *parent_name;
> +       void __iomem *freqcr = NULL;
> +       int i;

unsigned int

> +       int num_clks;
> +       int offset;
> +
> +       num_parents = of_clk_get_parent_count(node);
> +       if (num_parents < 1) {
> +               pr_err("%s: no parent found", clk_name);
> +               return;
> +       }
> +
> +       num_clks = of_property_count_strings(node, "clock-output-names");

Please no more clock-output-names.

> +CLK_OF_DECLARE(sh7750_div_clk, "renesas,sh7750-div-clock",
> +              sh7750_div_clk_setup);
> +CLK_OF_DECLARE(sh7750_pll_clk, "renesas,sh7750-pll-clock",
> +              sh7750_pll_clk_setup);

I think this should be a unified clock driver generating all clocks.
As there are no bindings yet, I will comment on the DTS files instead.

> diff --git a/drivers/clk/sh/clk-shdiv.c b/drivers/clk/sh/clk-shdiv.c
> new file mode 100644
> index 000000000000..2c016c413dd6
> --- /dev/null
> +++ b/drivers/clk/sh/clk-shdiv.c

> +static const struct clk_ops sh_clk_divider_ops = {
> +       .recalc_rate = sh_clk_divider_recalc_rate,
> +       .round_rate = sh_clk_divider_round_rate,

Please implement .determine_rate() instead of the deprecated
.round_rate().

> +       .set_rate = sh_clk_divider_set_rate,
> +};

> --- a/drivers/sh/Makefile
> +++ b/drivers/sh/Makefile
> @@ -2,7 +2,9 @@
>  #
>  # Makefile for the SuperH specific drivers.
>  #
> +ifneq ($(CONFIG_RENESAS_SH_INTC),y)
>  obj-$(CONFIG_SH_INTC)                  += intc/
> +endif

This change does not belong in this patch.

>  ifneq ($(CONFIG_COMMON_CLK),y)
>  obj-$(CONFIG_HAVE_CLK)                 += clk/
>  endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
