Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FCC77B71
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDRJRO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDRJRN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 05:17:13 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26910E7
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 02:17:11 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54fbb713301so207057407b3.11
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 02:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809430; x=1684401430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG1R9oG6uaczv1KWTSXG5OjFqoDdtkMy6AcBE07f8EE=;
        b=ddRvLDNLijqOVXubrthcWaM6NkJQNR6IlcH82Q/nnSFwEAOwbLgOFm8Isb4lqcAGw1
         up75z++0HYUr9OAs+AWIGI1PPTti+7US6dK5MapOZz09TD6f+O6E0mP3BDSmFBsYhQ85
         ip8keu394IKEwpPvD20ajCgowibwLbX480OXdrNyNoT5W1B9X5rPPB08NlAx+YBizS0q
         Y9YqnW6oYzzJJSuTgOdKeKaMCgYGpRJn4nIurOCP5ei3IIkPn8Um/RBchMYhazCgnZOp
         TZcwPgC1vAx7l4H81+TXKNLe07Cq5RUUaJwY0G6QdKvzHW823hsuT4Goo+cPWiQzdRJG
         D3QQ==
X-Gm-Message-State: AAQBX9c1Ojmre2mLCLmXpE9wLQl9AZr0MKi7VMkqXHfUwjwEpb5aRhQS
        ZIq6S0zU+TiKmALLYryjnA9S/GyzFjLwgA==
X-Google-Smtp-Source: AKy350YzQXVL7HaslZLNv9cGqGDL3DZ3EToRmXAAHK7lDGpoUXLOWCHmpp9apO5GVvvt7rZPEzH6Aw==
X-Received: by 2002:a0d:d50d:0:b0:54c:288a:a2a1 with SMTP id x13-20020a0dd50d000000b0054c288aa2a1mr16833420ywd.27.1681809429982;
        Tue, 18 Apr 2023 02:17:09 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 184-20020a810ac1000000b00545a081848bsm3703571ywk.27.2023.04.18.02.17.09
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 02:17:09 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-552fb3c2bb7so40768167b3.10
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 02:17:09 -0700 (PDT)
X-Received: by 2002:a81:5ac1:0:b0:54f:d816:8963 with SMTP id
 o184-20020a815ac1000000b0054fd8168963mr17164068ywb.19.1681809429227; Tue, 18
 Apr 2023 02:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net> <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
In-Reply-To: <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Apr 2023 11:16:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
Message-ID: <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
Subject: Re: [PATCH] Fix J-core aic warning spam
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob,

On Tue, Apr 18, 2023 at 10:59 AM Rob Landley <rob@landley.net> wrote:
> On 4/18/23 03:10, John Paul Adrian Glaubitz wrote:
> > On Tue, 2023-04-18 at 03:09 -0500, Rob Landley wrote:
> >> On 4/18/23 02:18, Geert Uytterhoeven wrote:
> >> > On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
> >> > <glaubitz@physik.fu-berlin.de> wrote:
> >> > > On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
> >> > > > From: Rich Felker <dalias@libc.org>
> >> > > > Signed-off-by: Rob Landley <rob@landley.net>
> >> > > >
> >> > > > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
> >> > > > on J2 SOC.
> >> >
> >> > > > --- a/drivers/irqchip/irq-jcore-aic.c
> >> > > > +++ b/drivers/irqchip/irq-jcore-aic.c
> >> > > > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
> >> > > >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> >> > > >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> >> > > >       struct irq_domain *domain;
> >> > > > +     int rc;
> >> > > >
> >> > > >       pr_info("Initializing J-Core AIC\n");
> >> > > >
> >> > > > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
> >> > > >       jcore_aic.irq_unmask = noop;
> >> > > >       jcore_aic.name = "AIC";
> >> > > >
> >> > > > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
> >> > > > +                          of_node_to_nid(node));
> >> > > > +     if (rc < 0)
> >> > > > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> >> > > > +                     min_irq);
> >> >
> >> > This is a fatal error, so please bail out, instead of continuing.
> >>
> >> If it can continue, it's not a fatal error. (Some pieces of hardware might not
> >> come up, but the board might still be usable.) If it can't continue, how does
> >> the _type_ of failure matter?
> >
> > I would still consider it fatal if any of the integral board components failed to
> > initialize. I don't think we want users to boot up their system into such an undefined
> > state.
>
> So if the network card doesn't work, kernel panic? If it's fatal, why does the
> function return? It could have called panic() instead. How does panicing _help_?
> (If the driver loads and the hardware works, we're good. If it doesn't, it won't
> work and they'll notice...)

I didn't suggest to call panic(), just return rc.

Diving deeper, irq_alloc_descs() can fail only when passing bad or severely
out-of-range values, so that's very unlikely.

BTW, what are the noisy boot messages? What's the call chain?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
