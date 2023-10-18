Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9FCDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 16:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjJRQFR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjJRQFQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 12:05:16 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282FDA4
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 09:05:14 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7dafb659cso85437917b3.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 09:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697645113; x=1698249913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GosP6h33WoGZRcStTfmJkfvb4Isb39FTi7ZrMV0wE6Y=;
        b=YpMZkvbPpghfwpg6IWD0SLldzg7Ya0SpBgb2iHSRngQhs4hyAQ4BmCza5Iw8qJ86wp
         9ECOPq5g+KIJtLXAFkrCwtej0LRoraqiLDkn77/Dlyymm8BCE0/JsNXwbx8AyKffbaI0
         HZm8bbKzxroBD1KkJEB01RLL7Bz8beAIb4fP5WBcISGX3mfFtxCpgHbMXxKTsYMxT7Js
         /a4kc2DGzzGlUcarYYfrceb8oTeRvz62Ak+I5ibqYQxI+fRSULYQzbq4g37is2B6Gnjx
         9cro+KLtrePeuPd0a1IEVQxP4rIBEc6sfaBfm1MXCHTUwwOTH6nKizRhtjJZxHZA5z/c
         DbBA==
X-Gm-Message-State: AOJu0YwfIyHmBFMo0TJC7/2F66uFgdVrj/WfXyW83umkYk9kjaXGAzur
        OkpSHS0iC7AYLSvBz4ZNQFiACEjSmJ4YUw==
X-Google-Smtp-Source: AGHT+IFsSAEJ7seOXVfXioxJ0KzxgePOykerQBh0E7ixPdn9rstProwbT7JSbqm1+dzYYdVc+B3ZWA==
X-Received: by 2002:a81:80c7:0:b0:59b:c0d7:6766 with SMTP id q190-20020a8180c7000000b0059bc0d76766mr5480240ywf.37.1697645112874;
        Wed, 18 Oct 2023 09:05:12 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id u140-20020a0deb92000000b0059bc980b1eesm1604970ywe.6.2023.10.18.09.05.12
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 09:05:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso1715540276.2
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 09:05:12 -0700 (PDT)
X-Received: by 2002:a25:4488:0:b0:d9a:66a1:a957 with SMTP id
 r130-20020a254488000000b00d9a66a1a957mr4965869yba.13.1697645112116; Wed, 18
 Oct 2023 09:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <4fc0bdc03033bbe43b31c89b6cc705e5f3498846.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <4fc0bdc03033bbe43b31c89b6cc705e5f3498846.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 18:04:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU66TvS7D=tuQUMazO85V9wh+uMf_t086VKBB+C8wvYQg@mail.gmail.com>
Message-ID: <CAMuHMdU66TvS7D=tuQUMazO85V9wh+uMf_t086VKBB+C8wvYQg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 22/35] drivers/clocksource/sh_tmu: Add support CLOCKSOURCE.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Enables registration as a Clocksource in the case of OF.

I think this is not a good description.
What this patch does, is to add support for early registration using
TIMER_OF_DECLARE(), so the timer can be used as a clocksource
on SoCs that do not have any other suitable timer.

Then I wondered: do you need this?  On R-Mobile A1, the TMU is also
used as a clocksource, how come it works there?
The trick is to set preset_lpj based on the CPU core clock frequency.

I see your v2 actually added that, but you dropped the code in v3.
https://lore.kernel.org/linux-sh/236185b4a47f303332aafeacadd9c9652e650062.1694596125.git.ysato@users.sourceforge.jp
Nevertheless, it doesn't work anymore, as you also removed the
clock-frequency property from cpu@0 in DT...
Adding that makes it work without this TMU patch.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c

> @@ -403,7 +411,8 @@ static void sh_tmu_clock_event_resume(struct clock_event_device *ced)
>  }
>
>  static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
> -                                      const char *name)
> +                                      const char *name,
> +                                      struct device_node *np)

"np" is unused in this function, hence this change is unneeded.

>  {
>         struct clock_event_device *ced = &ch->ced;
>         int ret;

>  static int sh_tmu_register(struct sh_tmu_channel *ch, const char *name,
> +                          struct device_node *np,

This change is unneeded...

>                            bool clockevent, bool clocksource)
>  {
>         if (clockevent) {
>                 ch->tmu->has_clockevent = true;
> -               sh_tmu_register_clockevent(ch, name);
> +               sh_tmu_register_clockevent(ch, name, np);

... as sh_tmu_register_clockevent() doesn't use "np".

>         } else if (clocksource) {
>                 ch->tmu->has_clocksource = true;
>                 sh_tmu_register_clocksource(ch, name);

> @@ -465,53 +477,59 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
>         else
>                 ch->base = tmu->mapbase + 8 + ch->index * 12;
>
> -       ch->irq = platform_get_irq(tmu->pdev, index);
> +       if (tmu->pdev)
> +               ch->irq = platform_get_irq(tmu->pdev, index);
> +       else
> +               ch->irq = of_irq_get(np, index);

You can use of_irq_get() uncondtionally.

>         if (ch->irq < 0)
>                 return ch->irq;
>
>         ch->cs_enabled = false;
>         ch->enable_count = 0;
>
> -       return sh_tmu_register(ch, dev_name(&tmu->pdev->dev),
> +       return sh_tmu_register(ch, tmu->name, np,

No need to pass np.

>                                clockevent, clocksource);
>  }
>
> -static int sh_tmu_map_memory(struct sh_tmu_device *tmu)
> +static int sh_tmu_map_memory(struct sh_tmu_device *tmu, struct device_node *np)
>  {
>         struct resource *res;
>
> -       res = platform_get_resource(tmu->pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&tmu->pdev->dev, "failed to get I/O memory\n");
> -               return -ENXIO;
> -       }
> +       if (tmu->pdev) {
> +               res = platform_get_resource(tmu->pdev, IORESOURCE_MEM, 0);
> +               if (!res) {
> +                       pr_err("sh_tmu failed to get I/O memory\n");
> +                       return -ENXIO;
> +               }
> +
> +               tmu->mapbase = ioremap(res->start, resource_size(res));
> +       } else
> +               tmu->mapbase = of_iomap(np, 0);

You can use of_iomap() unconditionally.

>
> -       tmu->mapbase = ioremap(res->start, resource_size(res));
>         if (tmu->mapbase == NULL)
>                 return -ENXIO;
>
>         return 0;
>  }
>
> -static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
> +static int sh_tmu_parse_dt(struct sh_tmu_device *tmu, struct device_node *np)
>  {
> -       struct device_node *np = tmu->pdev->dev.of_node;
> -
>         tmu->model = SH_TMU;
>         tmu->num_channels = 3;
>
>         of_property_read_u32(np, "#renesas,channels", &tmu->num_channels);
>
>         if (tmu->num_channels != 2 && tmu->num_channels != 3) {
> -               dev_err(&tmu->pdev->dev, "invalid number of channels %u\n",
> -                       tmu->num_channels);
> +               pr_err("%s: invalid number of channels %u\n",
> +                      tmu->name, tmu->num_channels);
>                 return -EINVAL;
>         }
>
>         return 0;
>  }
>
> -static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
> +static int sh_tmu_setup(struct sh_tmu_device *tmu,
> +                       struct platform_device *pdev, struct device_node *np)
>  {
>         unsigned int i;
>         int ret;

> @@ -531,14 +554,17 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>                 tmu->model = id->driver_data;
>                 tmu->num_channels = hweight8(cfg->channels_mask);
>         } else {
> -               dev_err(&tmu->pdev->dev, "missing platform data\n");
> +               pr_err("%s missing platform data\n", tmu->name);
>                 return -ENXIO;
>         }
>
>         /* Get hold of clock. */
> -       tmu->clk = clk_get(&tmu->pdev->dev, "fck");
> +       if (pdev)
> +               tmu->clk = clk_get(&tmu->pdev->dev, "fck");
> +       else
> +               tmu->clk = of_clk_get(np, 0);

You can use of_clk_get() unconditionally.

>         if (IS_ERR(tmu->clk)) {
> -               dev_err(&tmu->pdev->dev, "cannot get clock\n");
> +               pr_err("%s: cannot get clock\n", tmu->name);
>                 return PTR_ERR(tmu->clk);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
