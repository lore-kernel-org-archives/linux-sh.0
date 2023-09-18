Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98056C46CA1
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjIRS7f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRS7e (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 14:59:34 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BBF7;
        Mon, 18 Sep 2023 11:59:28 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59be6bcf408so48431907b3.2;
        Mon, 18 Sep 2023 11:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063567; x=1695668367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HLc6ZRG5+6UAn+rIN0XrDAnStPyCLtY9FOVVM/Lr0Q=;
        b=ZAltK9akPYHd9zGluoOJi4S5cOKJBVCyRV0yJBXeunqG5NtDuYtEqnscP4DkcVexn6
         RV6Q73rYgg51tqrFNmUSZ3md8v6VBNUYTOJOsvc8xw3qozE1sIeF62T99+o4yKK8fUgq
         s0Rr504pjLoH7URJbvivgeiBntWvhz+K8asN/dF5HkMdpkOIVrCA4VyygW3AePiaimQt
         6cCoaeFFX/C6XaFFx1GbydnQAnBeoQtyX+1xojglw1f6f9uRCNrXeBhzI3Sc4zh7B5je
         iGOtSnU1vaRP0WiIH181u0WngTtIt8JjdEn7yOXi1qTVckRnO18qj5iGd/XZv/Tba5tf
         teHQ==
X-Gm-Message-State: AOJu0YzIsbmBXlE9bVI9mlmdIbfHJuCRYKtJSnQSsH2ldzTPCvGJ+MjG
        wibCtMyzxzjBY537E2PiagOEjRtBMC9EVg==
X-Google-Smtp-Source: AGHT+IHUHFJZkyXsOl2V5mmCuc2CygXpQ/RLsj0Lo7cM3sXnVYFo1QsUKDTvNrvzqZMsYRph3P1MqA==
X-Received: by 2002:a0d:d945:0:b0:589:cf7c:d566 with SMTP id b66-20020a0dd945000000b00589cf7cd566mr9547456ywe.0.1695063567222;
        Mon, 18 Sep 2023 11:59:27 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id b188-20020a0dc0c5000000b0055a07e36659sm2718779ywd.145.2023.09.18.11.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:59:27 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59be6bcf408so48431747b3.2;
        Mon, 18 Sep 2023 11:59:26 -0700 (PDT)
X-Received: by 2002:a81:4fd1:0:b0:59b:fe46:82de with SMTP id
 d200-20020a814fd1000000b0059bfe4682demr10157294ywb.18.1695063566783; Mon, 18
 Sep 2023 11:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <d886ddd66e60319483619d90176ba34537c471e8.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <d886ddd66e60319483619d90176ba34537c471e8.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 20:59:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh63uOW=gYt2V6S6fOZrQmgcSX2C8dW=sG0ESV-B1i+A@mail.gmail.com>
Message-ID: <CAMuHMdVh63uOW=gYt2V6S6fOZrQmgcSX2C8dW=sG0ESV-B1i+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/30] drivers/clk: SuperH generai clock divider helper
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:26 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

Patch prefix should be "clk: renesas: ".

s/generai/general/

> --- /dev/null
> +++ b/drivers/clk/renesas/clk-shdiv.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SuperH divider clock driver
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include "clk-shdiv.h"
> +
> +#define div_mask(width)        ((1 << (width)) - 1)

"1U << ...", so you can use min() below.


> +
> +static unsigned int _get_table_maxdiv(const struct clk_div_table *table,
> +                                     u8 width)
> +{
> +       unsigned int maxdiv = 0, mask = div_mask(width);
> +       const struct clk_div_table *clkt;
> +
> +       for (clkt = table; clkt->div; clkt++)
> +               if (clkt->div > maxdiv && clkt->val <= mask)
> +                       maxdiv = clkt->div;
> +       return maxdiv;
> +}
> +
> +static unsigned int _get_maxdiv(const struct clk_div_table *table, u8 width)
> +{
> +       if (table)
> +               return _get_table_maxdiv(table, width);
> +       return div_mask(width) + 1;
> +}
> +
> +static unsigned int _get_table_div(const struct clk_div_table *table,
> +                                  unsigned int val)
> +{
> +       const struct clk_div_table *clkt;
> +
> +       for (clkt = table; clkt->div; clkt++)
> +               if (clkt->val == val)
> +                       return clkt->div;
> +       return 0;
> +}
> +
> +static unsigned int _get_div(const struct clk_div_table *table,
> +                            unsigned int val,  u8 width)
> +{
> +       if (table)
> +               return _get_table_div(table, val);
> +       return val + 1;
> +}
> +
> +static unsigned int _get_table_val(const struct clk_div_table *table,
> +                                  unsigned int div)
> +{
> +       const struct clk_div_table *clkt;
> +
> +       for (clkt = table; clkt->div; clkt++)
> +               if (clkt->div == div)
> +                       return clkt->val;
> +       return 0;
> +}
> +
> +static unsigned int _get_val(const struct clk_div_table *table,
> +                            unsigned int div, u8 width)
> +{
> +       if (table)
> +               return  _get_table_val(table, div);
> +       return div - 1;
> +}

Lots of functions named "_<foo>()" are called only once.
Please inline them manually.

> +
> +static unsigned long sh_divider_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate,
> +                                        unsigned int val,
> +                                        const struct clk_div_table *table)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned int div;
> +
> +       div = _get_div(table, val, divider->width);
> +
> +       return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +}
> +
> +static unsigned long sh_clk_divider_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned int val;
> +
> +       val = __raw_readw(divider->reg) >> divider->shift;
> +       val &= div_mask(divider->width);
> +
> +       return sh_divider_recalc_rate(hw, parent_rate, val, divider->table);
> +}
> +
> +static bool _is_valid_table_div(const struct clk_div_table *table,
> +                               unsigned int div)
> +{
> +       const struct clk_div_table *clkt;
> +
> +       for (clkt = table; clkt->div; clkt++)
> +               if (clkt->div == div)
> +                       return true;
> +       return false;
> +}
> +
> +static bool _is_valid_div(const struct clk_div_table *table, unsigned int div)
> +{
> +       if (table)
> +               return _is_valid_table_div(table, div);
> +       return true;
> +}
> +
> +static int _round_up_table(const struct clk_div_table *table, int div)
> +{
> +       const struct clk_div_table *clkt;
> +       int up = INT_MAX;
> +
> +       for (clkt = table; clkt->div; clkt++) {
> +               if (clkt->div == div)
> +                       return clkt->div;
> +               else if (clkt->div < div)
> +                       continue;
> +
> +               if ((clkt->div - div) < (up - div))
> +                       up = clkt->div;
> +       }
> +
> +       return up;
> +}
> +
> +static int _div_round_up(const struct clk_div_table *table,
> +                        unsigned long parent_rate, unsigned long rate)
> +{
> +       int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);

unsigned int (everywhere)

> +
> +       if (table)
> +               div = _round_up_table(table, div);
> +
> +       return div;
> +}
> +
> +static int _div_round(const struct clk_div_table *table,
> +                     unsigned long parent_rate, unsigned long rate)
> +{
> +       return _div_round_up(table, parent_rate, rate);
> +}
> +
> +static bool _is_best_div(unsigned long rate, unsigned long now,
> +                        unsigned long best)
> +{
> +       return now <= rate && now > best;
> +}
> +
> +static int _next_div(const struct clk_div_table *table, int div)
> +{
> +       div++;
> +
> +       if (table)
> +               return _round_up_table(table, div);
> +
> +       return div;
> +}
> +
> +static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *best_parent_rate,
> +                              const struct clk_div_table *table, u8 width)
> +{
> +       int i, bestdiv = 0;

unsigned int;

> +       unsigned long parent_rate, best = 0, now, maxdiv;
> +       unsigned long parent_rate_saved = *best_parent_rate;
> +
> +       if (!rate)
> +               rate = 1;
> +
> +       maxdiv = _get_maxdiv(table, width);
> +
> +       if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> +               parent_rate = *best_parent_rate;
> +               bestdiv = _div_round(table, parent_rate, rate);
> +               bestdiv = bestdiv == 0 ? 1 : bestdiv;
> +               bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
> +               return bestdiv;
> +       }
> +
> +       /*
> +        * The maximum divider we can use without overflowing
> +        * unsigned long in rate * i below
> +        */
> +       maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +       for (i = _next_div(table, 0); i <= maxdiv;
> +            i = _next_div(table, i)) {
> +               if (rate * i == parent_rate_saved) {
> +                       /*
> +                        * It's the most ideal case if the requested rate can be
> +                        * divided from parent clock without needing to change
> +                        * parent rate, so return the divider immediately.
> +                        */
> +                       *best_parent_rate = parent_rate_saved;
> +                       return i;
> +               }
> +               parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
> +                                              rate * i);
> +               now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
> +               if (_is_best_div(rate, now, best)) {
> +                       bestdiv = i;
> +                       best = now;
> +                       *best_parent_rate = parent_rate;
> +               }
> +       }
> +
> +       if (!bestdiv) {
> +               bestdiv = _get_maxdiv(table, width);
> +               *best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), 1);
> +       }
> +
> +       return bestdiv;
> +}
> +
> +static long sh_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> +                       unsigned long *prate, const struct clk_div_table *table,
> +                       u8 width)
> +{
> +       int div;
> +
> +       div = clk_divider_bestdiv(hw, rate, prate, table, width);
> +
> +       return DIV_ROUND_UP_ULL((u64)*prate, div);
> +}
> +
> +static int sh_clk_divider_determine_rate(struct clk_hw *hw,
> +                                         struct clk_rate_request *req)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       long rate, prate;
> +
> +       prate = req->best_parent_rate;
> +       rate = sh_divider_round_rate(hw, req->rate, &prate, divider->table,
> +                                    divider->width);
> +       if (rate < 0)
> +               return rate;
> +       req->rate = rate;
> +       req->best_parent_rate = prate;
> +       return 0;
> +}
> +
> +static int sh_divider_get_val(unsigned long rate, unsigned long parent_rate,
> +                          const struct clk_div_table *table, u8 width)
> +{
> +       unsigned int div, value;
> +
> +       div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +
> +       if (!_is_valid_div(table, div))
> +               return -EINVAL;
> +
> +       value = _get_val(table, div, width);
> +
> +       return min_t(unsigned int, value, div_mask(width));

min() (once div_mask() is unsigned)

> +}

> +static int _register_divider(struct device_node *node, const char *name,
> +                            const char *parent_name,
> +                            void __iomem *reg, u8 shift, u8 width,
> +                            const struct clk_div_table *table,
> +                            spinlock_t *lock)
> +{
> +       struct clk_divider *div;
> +       struct clk_init_data init;
> +
> +       /* allocate the divider */
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return -ENOMEM;
> +
> +       init.name = name;
> +       init.ops = &sh_clk_divider_ops;
> +       init.flags = 0;
> +       init.parent_names = (parent_name ? &parent_name : NULL);
> +       init.num_parents = (parent_name ? 1 : 0);
> +
> +       /* struct clk_divider assignments */
> +       div->reg = reg;
> +       div->shift = shift;
> +       div->width = width;
> +       div->lock = lock;
> +       div->hw.init = &init;
> +       div->table = table;
> +
> +       /* register the clock */
> +       if (of_clk_hw_register(node, &div->hw) < 0)
> +               kfree(div);
> +       of_clk_add_hw_provider(node, of_clk_hw_simple_get, &div->hw);
> +
> +       return 0;

Please propagate the error in case of failure.

> +}
> +
> +int sh_div_clk_register(struct device_node *node, const char *name,
> +                       const char *parent_name,
> +                       void __iomem *reg, u8 shift, u8 width,
> +                       const struct clk_div_table *table,
> +                       spinlock_t *lock)
> +{
> +       return _register_divider(node, name, parent_name, reg, shift,
> +                                width, table, lock);

Is there a reason why you made _register_divider() a separate function?

> +}
> +EXPORT_SYMBOL_GPL(sh_div_clk_register);
> diff --git a/drivers/clk/renesas/clk-shdiv.h b/drivers/clk/renesas/clk-shdiv.h
> new file mode 100644
> index 000000000000..fd49c06da9ff
> --- /dev/null
> +++ b/drivers/clk/renesas/clk-shdiv.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __CLK_SHDIV_H__
> +#define __CLK_SHDIV_H__
> +/*
> + * SuperH divider clock driver
> + */
> +
> +#include <linux/of.h>
> +#include <linux/clk-provider.h>

There is no need to include these headers.
You do need to include <linux/compiler_types.h> for __iomem;

You can use forward declarations:

    struct device_node;
    struct clk_div_table;
    struct spinlock;

> +
> +int sh_div_clk_register(struct device_node *node, const char *name,
> +                       const char *parent_name,
> +                       void __iomem *reg, u8 shift, u8 width,
> +                       const struct clk_div_table *table,
> +                       spinlock_t *lock);

struct spinlock *lock

> +
> +#endif

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
