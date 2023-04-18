Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F94C77B71
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 08:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjDRI7J (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 04:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDRI7I (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 04:59:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920893AA2
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 01:59:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso5371035ad.3
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681808347; x=1684400347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mt/pzg/ZQwyyg7nEDpHALvmIEGaAuqZArskSHZuDYj0=;
        b=Mlk0z1hNIGsVx1x4J3QjVjMOf7cSm8Wxf6MZk96McCmXrH/4CuHyE6oAaFf4HvOc/a
         U/2SIFm93F/UC2rO9rfWs+gMMhxIjKMy/E1rcBU1j2bXXVdAv+eLT3QJ9VZeEBEeXt1N
         EkBozAtd4oKaQzee/dJDMDjl4K+lGo7Z589zriKnKoAHxVvU9U+5h/ac8bOm4bcjP6r7
         cpoWI37+ol7lVLIkfvsB9UbKdqs3c6KxLIwAhqjJ8TQEuFnrxvdg9crECtaz6W2QlsgQ
         R1zQhcKWnHENKwAUtNZ6Ef+Zm2rM2gXzmBrA6jScB7lD0NzLyGYsTuXs3qc4uaMiTdu7
         M2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808347; x=1684400347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mt/pzg/ZQwyyg7nEDpHALvmIEGaAuqZArskSHZuDYj0=;
        b=fY5JcHBqU301nwWr7T0CkbI1pqmK4xmxf1al4LRcosOPehbGdDp0PZYPwTfa06Xit8
         yc0TPQ+PDULAv43YikRfjzWk0VXaEiVk7F5A8SIAF0n82/X/APZ127iiIcb8vfTYjcTj
         n1l4lmdMMUUdgfrg0enxsKPbpRsj1FkxW0FWHgAGDhNgixncDsXQCPnK4fUcDFBCPsTz
         /zccbPLQH8gKPi8oIT4644zHMkBd9LIA8XaT29M7ewdauzBRKqtviYpp8LGonaiHyNGt
         mdh6aBcPmh91OfdZ+1TB2sb34IxuGvEGqQ1TvwrKAgRRbfp/8mLK3ZH/2WYpCazjC30i
         g2ww==
X-Gm-Message-State: AAQBX9cfn5MPDdkXR3WHQ8QTK+Li3MHJ9GGkAgoA5jyyxNgTOOB2OtzP
        luoEJ2LBcOseJqgg1KLgAOgQ6yY/a8Obsx0XIxAkqtMY
X-Google-Smtp-Source: AKy350Yym1AmN4jp30Q3a66jQOaMrjJ1T4g0LI23zAruF/VXdj/+FrON4qWoHwMRac/qBDtPQ9LX4A==
X-Received: by 2002:a17:903:11c4:b0:1a6:45e5:a26a with SMTP id q4-20020a17090311c400b001a645e5a26amr1750709plh.27.1681808347013;
        Tue, 18 Apr 2023 01:59:07 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902d38100b001a66e81d8fdsm9085929pld.116.2023.04.18.01.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 01:59:06 -0700 (PDT)
Message-ID: <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
Date:   Tue, 18 Apr 2023 04:14:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
 <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 4/18/23 03:10, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-04-18 at 03:09 -0500, Rob Landley wrote:
>> 
>> On 4/18/23 02:18, Geert Uytterhoeven wrote:
>> > Hi Adrian, Rob,
>> > 
>> > On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
>> > <glaubitz@physik.fu-berlin.de> wrote:
>> > > On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
>> > > > From: Rich Felker <dalias@libc.org>
>> > > > Signed-off-by: Rob Landley <rob@landley.net>
>> > > > 
>> > > > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
>> > > > on J2 SOC.
>> > 
>> > > > --- a/drivers/irqchip/irq-jcore-aic.c
>> > > > +++ b/drivers/irqchip/irq-jcore-aic.c
>> > > > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
>> > > >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
>> > > >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
>> > > >       struct irq_domain *domain;
>> > > > +     int rc;
>> > > > 
>> > > >       pr_info("Initializing J-Core AIC\n");
>> > > > 
>> > > > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
>> > > >       jcore_aic.irq_unmask = noop;
>> > > >       jcore_aic.name = "AIC";
>> > > > 
>> > > > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
>> > > > +                          of_node_to_nid(node));
>> > > > +     if (rc < 0)
>> > > > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>> > > > +                     min_irq);
>> > 
>> > This is a fatal error, so please bail out, instead of continuing.
>> 
>> If it can continue, it's not a fatal error. (Some pieces of hardware might not
>> come up, but the board might still be usable.) If it can't continue, how does
>> the _type_ of failure matter?
> 
> I would still consider it fatal if any of the integral board components failed to
> initialize. I don't think we want users to boot up their system into such an undefined
> state.

So if the network card doesn't work, kernel panic? If it's fatal, why does the
function return? It could have called panic() instead. How does panicing _help_?
(If the driver loads and the hardware works, we're good. If it doesn't, it won't
work and they'll notice...)

*shrug* You're the arch maintainer, you're welcome to change it. You can define
it to be as brittle as possible if you like. Me, I read "worse is better" long
ago (https://dreamsongs.com/RiseOfWorseIsBetter.html) and The Unix Philosophy by
Mike Gancarz (when it breaks, you get to keep the pieces) and generally try to
leave it up to the user what to do about things. I've also used a LOT of
secondhand hardware over the years that got repurposed after it stopped being
useful for its original task. (Right to repair and all that.)

But it's not my call...

Rob
