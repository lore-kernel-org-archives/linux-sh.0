Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC3C77B71
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 07:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDRHS5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjDRHSw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 03:18:52 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69F4687
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:18:49 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54c12009c30so553276897b3.9
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802328; x=1684394328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UsF7Kbc/vSkr2Vqmahz1EVbwcrqb7UJmZIpPgx3dH8=;
        b=K6wcVftC933DC1lKpSnsNHrIfuqr71XJk7yOntYRkKm0idTrwmn5oQXzAWFYh9gfq6
         EyOzVOM3TFTbJlDWZ6TVhvGCYuMf2rqdJpmw7LlHXMf5ukVoY5a6sIQ1UHVa27X1IkKX
         3979IGq0wpsvqGpffvpkMXBCTAC69uLxXucMTJDX9gJxTYarnCTodqBh1+fwt9prI3ls
         NaXhwn6zMdKRv9Xn2GfxzD4kUGwYzcL5pR4cOCVSY0k82Ajd1hpE7xihcbmcgSLlstUK
         mbkwClwDEczRLOp15+7ZFX+v3wIJwASYWFcrNCpKohkh/H32io2Rm6arY9PUy1kxJfXs
         PrQQ==
X-Gm-Message-State: AAQBX9dL55EvKMaJ0IOzLA/OseUYYdfalOXX2l4S/jsPXu8btnpMAhq9
        NwhUFNzwUmc4ZkX+avlEyZOvFa0J4eLTmQ==
X-Google-Smtp-Source: AKy350aHrEPnKg1TO0JwIdCE8Vc3K2jYZpgPFHfrRr/akTufONSOiZk5DSH4NyfaigSLSdIWeRnQzA==
X-Received: by 2002:a81:4f82:0:b0:54f:8cf7:c117 with SMTP id d124-20020a814f82000000b0054f8cf7c117mr18841355ywb.45.1681802328236;
        Tue, 18 Apr 2023 00:18:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id r40-20020a814428000000b0054f6ca85641sm3629316ywa.99.2023.04.18.00.18.48
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:18:48 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-555bc7f6746so1699107b3.6
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:18:48 -0700 (PDT)
X-Received: by 2002:a81:a087:0:b0:54f:ba86:9fb with SMTP id
 x129-20020a81a087000000b0054fba8609fbmr19087612ywg.24.1681802327875; Tue, 18
 Apr 2023 00:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net> <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
In-Reply-To: <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Apr 2023 09:18:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
Message-ID: <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
Subject: Re: [PATCH] Fix J-core aic warning spam
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Adrian, Rob,

On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
> > From: Rich Felker <dalias@libc.org>
> > Signed-off-by: Rob Landley <rob@landley.net>
> >
> > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
> > on J2 SOC.

> > --- a/drivers/irqchip/irq-jcore-aic.c
> > +++ b/drivers/irqchip/irq-jcore-aic.c
> > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
> >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> >       struct irq_domain *domain;
> > +     int rc;
> >
> >       pr_info("Initializing J-Core AIC\n");
> >
> > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
> >       jcore_aic.irq_unmask = noop;
> >       jcore_aic.name = "AIC";
> >
> > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
> > +                          of_node_to_nid(node));
> > +     if (rc < 0)
> > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> > +                     min_irq);

This is a fatal error, so please bail out, instead of continuing.

> >       domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
> >                                      &jcore_aic_irqdomain_ops,
> >                                      &jcore_aic);
>
> This more looks like it's adding a missing call to irc_alloc_descs() rather than
> silencing kernel messages. The latter would be a brushing over of an error while
> the former would fix the actual problem, wouldn't it?
>
> So, I think the patch title might be misleading.

Indeed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
