Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF2DC6FD18
	for <linux-sh@archiver.kernel.org>; Thu, 20 Apr 2023 00:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDTAwZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 20:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjDTAwJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 20:52:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA87D87
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 17:51:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1a6715ee82fso6332685ad.1
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 17:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681951903; x=1684543903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqF45JdEtwy5x9aUfDNmjIWZWROgjg0a7clPuPwl+GE=;
        b=icOOfbwV+i8N14McVwZKRDmopPn6G1JB9Lw32iR/VyqK5FULuDuMNLIwYWiPb0PHzK
         qkN6/JfTMR+Kc+W9M4xzAbeUM2SC7VpxmAW5PV+6REGAoKj5douguB2FtIySTojB7ceT
         NP7gDMo9OjcApLbYTYhc57YTgLjH76nv3Y5pAq2lnd19TEWBSa3p3QePkiB2yruIuSAn
         OcNOAhINX2V1XQxPMsx9zSARS696xybOW1iL6Mc3H0bRSN0sPI3BI62WAQigVqCSMwqH
         nS6C/+Ozs9LDONRJ91ViHDoPwJpuLhzNvh4wJR5HvYSIiGI/4qaw0XWOxxtI7cTQeeNY
         77ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951903; x=1684543903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqF45JdEtwy5x9aUfDNmjIWZWROgjg0a7clPuPwl+GE=;
        b=IBjG59jgNRW/h1V26VINaRqy9MY3QknAfot7iQkcZLdeUQJPHtcXMTTYulvo4EIlxE
         rdzYbZJgFFaWZnxZFulUo0yf9EthdMeGdveVnByHezPN+TFqJzRSPqF6g4V8LCAjpFeI
         MBaCXaxECecHqpgyHfc2Yt/fX+iI195ieEcTLUgSESzajD++lp8j7luoMDKPtX3jZgUC
         6FtMbzrPGW1Zqyp/bTjLHEp49ohWqPZqVr5qwJArFPNdKoDBLf65jHPQEuTLITRoFtHF
         iTiR3EccBuY2plHS229uKxSkSlrgu1kF2c/JcugZrDGBJTT9Ldh2VzdH4ebfdzK+wSW/
         /0QA==
X-Gm-Message-State: AAQBX9cB7kFqbYCc9VpTNrZVSVvLK8DIuG/vagSGoUZDFor7qWvywEsw
        gdxv0tZwtxkXqNpzFnpGiGJeyR86BuQXhp+o/MAXvDvB
X-Google-Smtp-Source: AKy350bQyK+qHGPF2f+B6XwS+K2ZyeKJm59HXWmY9nvPu5gAzcHCEtL4MiDXDodiavzCSLKKHtUfuA==
X-Received: by 2002:a17:903:284:b0:1a6:acb6:24 with SMTP id j4-20020a170903028400b001a6acb60024mr7140039plr.41.1681951903177;
        Wed, 19 Apr 2023 17:51:43 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id bh7-20020a170902a98700b001a19cf1b37esm73629plb.40.2023.04.19.17.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:51:42 -0700 (PDT)
Message-ID: <fb177f03-9b6f-adca-4fd2-475df82f0a2d@landley.net>
Date:   Wed, 19 Apr 2023 20:06:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
 <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
 <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
 <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
 <CAMuHMdX5Hn2QR127M4NjNLWJMrEVUQK5ApCkeb2nDuSid1o90g@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdX5Hn2QR127M4NjNLWJMrEVUQK5ApCkeb2nDuSid1o90g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 4/19/23 02:27, Geert Uytterhoeven wrote:
> On Tue, Apr 18, 2023 at 11:56 PM Rob Landley <rob@landley.net> wrote:
>>
>> On 4/18/23 04:16, Geert Uytterhoeven wrote:
>> > Hi Rob,
>> >
>> > On Tue, Apr 18, 2023 at 10:59 AM Rob Landley <rob@landley.net> wrote:
>> >> On 4/18/23 03:10, John Paul Adrian Glaubitz wrote:
>> >> > On Tue, 2023-04-18 at 03:09 -0500, Rob Landley wrote:
>> >> >> On 4/18/23 02:18, Geert Uytterhoeven wrote:
>> >> >> > On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
>> >> >> > <glaubitz@physik.fu-berlin.de> wrote:
>> >> >> > > On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
>> >> >> > > > From: Rich Felker <dalias@libc.org>
>> >> >> > > > Signed-off-by: Rob Landley <rob@landley.net>
>> >> >> > > >
>> >> >> > > > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
>> >> >> > > > on J2 SOC.
>> >> >> >
>> >> >> > > > --- a/drivers/irqchip/irq-jcore-aic.c
>> >> >> > > > +++ b/drivers/irqchip/irq-jcore-aic.c
>> >> >> > > > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
>> >> >> > > >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
>> >> >> > > >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
>> >> >> > > >       struct irq_domain *domain;
>> >> >> > > > +     int rc;
>> >> >> > > >
>> >> >> > > >       pr_info("Initializing J-Core AIC\n");
>> >> >> > > >
>> >> >> > > > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
>> >> >> > > >       jcore_aic.irq_unmask = noop;
>> >> >> > > >       jcore_aic.name = "AIC";
>> >> >> > > >
>> >> >> > > > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
>> >> >> > > > +                          of_node_to_nid(node));
>> >> >> > > > +     if (rc < 0)
>> >> >> > > > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>> >> >> > > > +                     min_irq);
>> >> >> >
>> >> >> > This is a fatal error, so please bail out, instead of continuing.
>> >> >>
>> >> >> If it can continue, it's not a fatal error. (Some pieces of hardware might not
>> >> >> come up, but the board might still be usable.) If it can't continue, how does
>> >> >> the _type_ of failure matter?
>> >> >
>> >> > I would still consider it fatal if any of the integral board components failed to
>> >> > initialize. I don't think we want users to boot up their system into such an undefined
>> >> > state.
>> >>
>> >> So if the network card doesn't work, kernel panic? If it's fatal, why does the
>> >> function return? It could have called panic() instead. How does panicing _help_?
>> >> (If the driver loads and the hardware works, we're good. If it doesn't, it won't
>> >> work and they'll notice...)
>> >
>> > I didn't suggest to call panic(), just return rc.
>>
>> Ah, I misunderstood.
>>
>> > Diving deeper, irq_alloc_descs() can fail only when passing bad or severely
>> > out-of-range values, so that's very unlikely.
>> >
>> > BTW, what are the noisy boot messages? What's the call chain?
>>
>> I have a log lying around somewhere...
> 
> Thanks!
> 
> It was a bit too large for the list, so I only kept the first relevant
> part below...
> 
>> Initializing J-Core AIC
>> ------------[ cut here ]------------
>> error: virq16 is not allocated
>> WARNING: CPU: 0 PID: 0 at kernel/irq/irqdomain.c:571
>> irq_domain_associate+0x120/0x178
>>
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2 #1
>> PC is at irq_domain_associate+0x120/0x178
>> PR is at irq_domain_associate+0x120/0x178
>> PC  : 10049b90 SP  : 103bdec0 SR  : 400001f1
>> R0  : 0000001e R1  : 1042d024 R2  : 1042d024 R3  : 00000028
>> R4  : 00000001 R5  : 0006f1ff R6  : 00000008 R7  : 103bde04
>> R8  : 1200c000 R9  : 00000010 R10 : 00000000 R11 : 00000010
>> R12 : 10049a70 R13 : 103bfcac R14 : 1030a398
>> MACH: 00000000 MACL: 00057fa8 GBR : 00000000 PR  : 10049b90
>>
>> Call trace:
>>  [<100496f0>] __irq_domain_add+0x80/0x1dc
>>  [<10049cd2>] irq_domain_create_legacy+0x46/0x68
>>  [<10049a70>] irq_domain_associate+0x0/0x178
>>  [<104517da>] aic_irq_of_init+0x82/0xd8
>>  [<1020ab90>] of_iomap+0x0/0x30
>>  [<1031df1c>] _printk+0x0/0x24
>>  [<1045630c>] of_irq_init+0xe4/0x228
>>  [<100a5a10>] kfree+0x0/0x250
>>  [<10042376>] vprintk_emit+0xde/0x1fc
>>  [<1004239c>] vprintk_emit+0x104/0x1fc
>>  [<10309940>] strlen+0x0/0x60
>>  [<100424a6>] vprintk_default+0x12/0x20
>>  [<10309940>] strlen+0x0/0x60
>>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>>  [<1031df1c>] _printk+0x0/0x24
>>  [<104456f8>] init_IRQ+0x14/0x28
>>  [<10309940>] strlen+0x0/0x60
>>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>>  [<1031df1c>] _printk+0x0/0x24
>>  [<1044394c>] start_kernel+0x3b8/0x73c
>>  [<1044320c>] unknown_bootoption+0x0/0x170
>>  [<1000202a>] _stext+0x2a/0x34
>>
>> Code:
>>   10049b8a:  mov.l     10049bd8 <irq_domain_associate+0x168/0x178>, r4  !
>> 10393da0 <0x10393da0>
>>   10049b8c:  jsr       @r1
>>   10049b8e:  mov       r11, r5
>> ->10049b90:  trapa     #62
>>   10049b92:  bra       10049b0e
>>   10049b94:  mov       #-22, r12
>>   10049b96:  mov.l     10049bd0 <irq_domain_associate+0x160/0x178>, r1  !
>> 1031da2c <__warn_printk+0x0/0x38>
>>   10049b98:  mov.l     10049bdc <irq_domain_associate+0x16c/0x178>, r4  !
>> 10393dc0 <0x10393dc0>
>>   10049b9a:  jsr       @r1
>>
>> ---[ end trace 0000000000000000 ]---
> 
> OK, so virq 16-127 are non-functional without this fix.
> 
> One other thing to consider when sending a v2: v1 lacks an SoB
> from the original author.

Last I heard Rich and his family were on sabbatical in Indonesia. He pops up
from time to time but hasn't answered the last couple pokes I made at him.

He handed this patch off to Jeff Dionne who handed it off to me. Here is the
patch publicly posted on Rich's website two years ago:

  https://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=beb1f3ae8ad6

Does Linux require copyright assignments now? I thought even the FSF had finally
dropped that requirement...

Rob
