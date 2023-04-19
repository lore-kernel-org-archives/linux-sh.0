Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F28C77B78
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 07:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjDSH1g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDSH1f (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 03:27:35 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3A4200
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 00:27:33 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id m14so13660141ybk.4
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 00:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889252; x=1684481252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnmGjF48O69/Trx7l6ag0FQGIm7TFgKJDIxMJziIghM=;
        b=ORXVuRymjl1+bVAY3s6Lc7XY3E0zoFVlS0FUpO3LL+zoSejKfn+TfYeSDv40rFxB/g
         089qDrb9mC/8U2MvTJLGqboJSHGuMxzd/Zr30bGDB2Csqx4vsHRhRA/qeNC6T92g+XEM
         wOHRgrS0vvX//Ts2p8wZ++nQpBmDfLTzAokJS77o/LIZYl16q0wdwqQ2uM8rrioTJWOV
         eqZFglT/wEG5oj7TboyaJ5FW1hhRt6fD51+69a2nLhRg7xRVAaYvO1h62+BpDC3WK9Zv
         VQiuEALNOjXANgFm6+TJd0XFn3aenPBNA2LxuhpFJG6BTGQDr1aaIETWL78rheYS3frq
         rudw==
X-Gm-Message-State: AAQBX9eAI9t0xgzYCQD/34lHG0IyDNLxyd9jufC3znXcyzfNtX5eY0OM
        /et3Kd7sWfgVH9OMLMbGX+18J+pOSGkf1otG
X-Google-Smtp-Source: AKy350Y/gnvw8DElwy2uKkTRi0eBXhtpGY8oQle+qzHnztT0tBEkSFl3AaaAjCrF5uU7DILSA2AShA==
X-Received: by 2002:a25:1f84:0:b0:b77:678b:ca53 with SMTP id f126-20020a251f84000000b00b77678bca53mr17024966ybf.64.1681889252476;
        Wed, 19 Apr 2023 00:27:32 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 126-20020a810884000000b0054f882539b1sm4291458ywi.109.2023.04.19.00.27.31
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:27:31 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-54fe82d8bf5so175075687b3.3
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 00:27:31 -0700 (PDT)
X-Received: by 2002:a0d:ddc4:0:b0:555:be69:a805 with SMTP id
 g187-20020a0dddc4000000b00555be69a805mr2565533ywe.51.1681889251491; Wed, 19
 Apr 2023 00:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net> <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net> <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
 <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
In-Reply-To: <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Apr 2023 09:27:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5Hn2QR127M4NjNLWJMrEVUQK5ApCkeb2nDuSid1o90g@mail.gmail.com>
Message-ID: <CAMuHMdX5Hn2QR127M4NjNLWJMrEVUQK5ApCkeb2nDuSid1o90g@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 11:56 PM Rob Landley <rob@landley.net> wrote:
>
> On 4/18/23 04:16, Geert Uytterhoeven wrote:
> > Hi Rob,
> >
> > On Tue, Apr 18, 2023 at 10:59 AM Rob Landley <rob@landley.net> wrote:
> >> On 4/18/23 03:10, John Paul Adrian Glaubitz wrote:
> >> > On Tue, 2023-04-18 at 03:09 -0500, Rob Landley wrote:
> >> >> On 4/18/23 02:18, Geert Uytterhoeven wrote:
> >> >> > On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
> >> >> > <glaubitz@physik.fu-berlin.de> wrote:
> >> >> > > On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
> >> >> > > > From: Rich Felker <dalias@libc.org>
> >> >> > > > Signed-off-by: Rob Landley <rob@landley.net>
> >> >> > > >
> >> >> > > > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
> >> >> > > > on J2 SOC.
> >> >> >
> >> >> > > > --- a/drivers/irqchip/irq-jcore-aic.c
> >> >> > > > +++ b/drivers/irqchip/irq-jcore-aic.c
> >> >> > > > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
> >> >> > > >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> >> >> > > >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> >> >> > > >       struct irq_domain *domain;
> >> >> > > > +     int rc;
> >> >> > > >
> >> >> > > >       pr_info("Initializing J-Core AIC\n");
> >> >> > > >
> >> >> > > > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
> >> >> > > >       jcore_aic.irq_unmask = noop;
> >> >> > > >       jcore_aic.name = "AIC";
> >> >> > > >
> >> >> > > > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
> >> >> > > > +                          of_node_to_nid(node));
> >> >> > > > +     if (rc < 0)
> >> >> > > > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> >> >> > > > +                     min_irq);
> >> >> >
> >> >> > This is a fatal error, so please bail out, instead of continuing.
> >> >>
> >> >> If it can continue, it's not a fatal error. (Some pieces of hardware might not
> >> >> come up, but the board might still be usable.) If it can't continue, how does
> >> >> the _type_ of failure matter?
> >> >
> >> > I would still consider it fatal if any of the integral board components failed to
> >> > initialize. I don't think we want users to boot up their system into such an undefined
> >> > state.
> >>
> >> So if the network card doesn't work, kernel panic? If it's fatal, why does the
> >> function return? It could have called panic() instead. How does panicing _help_?
> >> (If the driver loads and the hardware works, we're good. If it doesn't, it won't
> >> work and they'll notice...)
> >
> > I didn't suggest to call panic(), just return rc.
>
> Ah, I misunderstood.
>
> > Diving deeper, irq_alloc_descs() can fail only when passing bad or severely
> > out-of-range values, so that's very unlikely.
> >
> > BTW, what are the noisy boot messages? What's the call chain?
>
> I have a log lying around somewhere...

Thanks!

It was a bit too large for the list, so I only kept the first relevant
part below...

> Initializing J-Core AIC
> ------------[ cut here ]------------
> error: virq16 is not allocated
> WARNING: CPU: 0 PID: 0 at kernel/irq/irqdomain.c:571
> irq_domain_associate+0x120/0x178
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2 #1
> PC is at irq_domain_associate+0x120/0x178
> PR is at irq_domain_associate+0x120/0x178
> PC  : 10049b90 SP  : 103bdec0 SR  : 400001f1
> R0  : 0000001e R1  : 1042d024 R2  : 1042d024 R3  : 00000028
> R4  : 00000001 R5  : 0006f1ff R6  : 00000008 R7  : 103bde04
> R8  : 1200c000 R9  : 00000010 R10 : 00000000 R11 : 00000010
> R12 : 10049a70 R13 : 103bfcac R14 : 1030a398
> MACH: 00000000 MACL: 00057fa8 GBR : 00000000 PR  : 10049b90
>
> Call trace:
>  [<100496f0>] __irq_domain_add+0x80/0x1dc
>  [<10049cd2>] irq_domain_create_legacy+0x46/0x68
>  [<10049a70>] irq_domain_associate+0x0/0x178
>  [<104517da>] aic_irq_of_init+0x82/0xd8
>  [<1020ab90>] of_iomap+0x0/0x30
>  [<1031df1c>] _printk+0x0/0x24
>  [<1045630c>] of_irq_init+0xe4/0x228
>  [<100a5a10>] kfree+0x0/0x250
>  [<10042376>] vprintk_emit+0xde/0x1fc
>  [<1004239c>] vprintk_emit+0x104/0x1fc
>  [<10309940>] strlen+0x0/0x60
>  [<100424a6>] vprintk_default+0x12/0x20
>  [<10309940>] strlen+0x0/0x60
>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>  [<1031df1c>] _printk+0x0/0x24
>  [<104456f8>] init_IRQ+0x14/0x28
>  [<10309940>] strlen+0x0/0x60
>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>  [<1031df1c>] _printk+0x0/0x24
>  [<1044394c>] start_kernel+0x3b8/0x73c
>  [<1044320c>] unknown_bootoption+0x0/0x170
>  [<1000202a>] _stext+0x2a/0x34
>
> Code:
>   10049b8a:  mov.l     10049bd8 <irq_domain_associate+0x168/0x178>, r4  !
> 10393da0 <0x10393da0>
>   10049b8c:  jsr       @r1
>   10049b8e:  mov       r11, r5
> ->10049b90:  trapa     #62
>   10049b92:  bra       10049b0e
>   10049b94:  mov       #-22, r12
>   10049b96:  mov.l     10049bd0 <irq_domain_associate+0x160/0x178>, r1  !
> 1031da2c <__warn_printk+0x0/0x38>
>   10049b98:  mov.l     10049bdc <irq_domain_associate+0x16c/0x178>, r4  !
> 10393dc0 <0x10393dc0>
>   10049b9a:  jsr       @r1
>
> ---[ end trace 0000000000000000 ]---

OK, so virq 16-127 are non-functional without this fix.

One other thing to consider when sending a v2: v1 lacks an SoB
from the original author.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
