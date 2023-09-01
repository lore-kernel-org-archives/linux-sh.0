Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAECA0FE8
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 13:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjIANCH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjIANCG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 09:02:06 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CFCE0
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 06:02:04 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-58d9ba95c78so20419267b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573323; x=1694178123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qev5VxCkMRIazk7rlQkvsPfcTh8CSe9KKvd8bfh/PIA=;
        b=WCppAz/DAv/VFW7OppnnbKd7RbkOYbSqbZjXO9Sv61ea4JQpKdr39dU3vUpi8yJZn1
         jZA8l/FwRiRaA7zvtCJ78ei32OQn/YCEaBLZxoza+Qp44SzRrBoYLBnYErWXFl0+ntZL
         Wnjbfh82T3cL2uSBvIddTOMp8r3nkvmf9JD9K5oCagbcSZyreJroxew/gosRBDgZTee9
         j+JWLx4/K3dt0o8UM3jRkXego1twTbrXauX0TG8x1Af6y3moSp5hVtzuwx1Y/pwDg6pg
         Q181Vjz52G1Y9yZlPSRzXjCxv1CDpGRyxW8+9IdQ67dU70H4JtLJFf2NpoXAJgm/e6rF
         0cAg==
X-Gm-Message-State: AOJu0YyL7YQl8dq6S15M16fWgYxvqSUltwU5YpN+B/p9vS4a1GIC5BF5
        a9IRgv7uQGONto9RBzM8iDcvHrRYerebHw==
X-Google-Smtp-Source: AGHT+IEkMc9anV73ZEM541vbSEUMcMp8hidENo0NGSYIVwK/HMb7yJcy1OIuCIzGmAIItV5BxYoAhQ==
X-Received: by 2002:a81:8641:0:b0:583:e958:39c6 with SMTP id w62-20020a818641000000b00583e95839c6mr2407864ywf.34.1693573323138;
        Fri, 01 Sep 2023 06:02:03 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y194-20020a0dd6cb000000b005950e1bbf11sm1030108ywd.60.2023.09.01.06.02.02
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:02:03 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso1538783276.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:02:02 -0700 (PDT)
X-Received: by 2002:a25:3c6:0:b0:d4b:f4e4:62f4 with SMTP id
 189-20020a2503c6000000b00d4bf4e462f4mr2691276ybd.10.1693573322704; Fri, 01
 Sep 2023 06:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <2d323328fba6ac55a1c3cdcefe909fad3ab0d9dc.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <2d323328fba6ac55a1c3cdcefe909fad3ab0d9dc.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 15:01:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7Yw49pKtHvNazY6ABb+wd=Ee4JYT4DB9Ff2qAkTFinQ@mail.gmail.com>
Message-ID: <CAMuHMdU7Yw49pKtHvNazY6ABb+wd=Ee4JYT4DB9Ff2qAkTFinQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 07/12] clocksource: Update sh_tmu of handling.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 7:22 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -420,9 +420,6 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
>         ced->suspend = sh_tmu_clock_event_suspend;
>         ced->resume = sh_tmu_clock_event_resume;
>
> -       dev_info(&ch->tmu->pdev->dev, "ch%u: used for clock events\n",
> -                ch->index);
> -

Why?

>         clockevents_config_and_register(ced, ch->tmu->rate, 0x300, 0xffffffff);
>
>         ret = request_irq(ch->irq, sh_tmu_interrupt,
> @@ -500,12 +497,12 @@ static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
>         tmu->model = SH_TMU;
>         tmu->num_channels = 3;
>
> -       of_property_read_u32(np, "#renesas,channels", &tmu->num_channels);
> -
> -       if (tmu->num_channels != 2 && tmu->num_channels != 3) {
> -               dev_err(&tmu->pdev->dev, "invalid number of channels %u\n",
> -                       tmu->num_channels);
> -               return -EINVAL;
> +       if (of_property_read_u32(np, "#renesas,channels", &tmu->num_channels)) {
> +               if (tmu->num_channels != 2 && tmu->num_channels != 3) {
> +                       dev_err(&tmu->pdev->dev,
> +                               "invalid number of channels %u\n", tmu->num_channels);
> +                       return -EINVAL;
> +               }

Why?
I understand TMU on SH7751 has 5 channels, so just extended the check?

Note that of_property_read_u32() returns zero on success.

>         }
>
>         return 0;
> @@ -513,7 +510,6 @@ static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
>
>  static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>  {
> -       unsigned int i;
>         int ret;
>
>         tmu->pdev = pdev;
> @@ -535,6 +531,11 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>                 return -ENXIO;
>         }
>
> +       if (tmu->num_channels < 2) {
> +               dev_err(&tmu->pdev->dev, "Invalid channels.\n");
> +               return -ENXIO;
> +       }
> +

Why?

>         /* Get hold of clock. */
>         tmu->clk = clk_get(&tmu->pdev->dev, "fck");
>         if (IS_ERR(tmu->clk)) {
> @@ -573,12 +574,12 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>          * Use the first channel as a clock event device and the second channel
>          * as a clock source.
>          */
> -       for (i = 0; i < tmu->num_channels; ++i) {
> -               ret = sh_tmu_channel_setup(&tmu->channels[i], i,
> -                                          i == 0, i == 1, tmu);
> -               if (ret < 0)
> -                       goto err_unmap;
> -       }
> +       ret = sh_tmu_channel_setup(&tmu->channels[0], 0, false, true, tmu);
> +       if (ret < 0)
> +               goto err_unmap;
> +       ret = sh_tmu_channel_setup(&tmu->channels[1], 1, true, false, tmu);
> +       if (ret < 0)
> +               goto err_unmap;

Why,  oh why?...

>
>         platform_set_drvdata(pdev, tmu);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
