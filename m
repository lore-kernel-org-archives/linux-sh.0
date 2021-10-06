Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE3FC433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4D0611AE
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 21:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhJFVK4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhJFVKz (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 6 Oct 2021 17:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9A8361184;
        Wed,  6 Oct 2021 21:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633554542;
        bh=7y2OqyGeh/YLbNHB3wW+VV17BTzd0SdtkHXCJgfSaiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=broTUrrlFiLEzw1V1KzqJl3cjITvNqn8fuEk42SbT6TOR0Idnr3Wvw0BoG0aE0XuK
         NcpZbDNChXN5OOm6Ht7gYg7ZqR5OmZTcfjSzeNJPRg5cOCMbxZr7joE/D0yEs5pSX7
         F6alwzWwl4jZJjHSLNJ16AL9sS7C3JKfDDqnlFebb4Ue/y4PFm2G7NOIciGL8rG0+j
         kKeZDu8KP9lnqWGFDFTpdF2tScH7ckPbtPihCtX8t+0miILAe0Nj8i5SmOPEIDCtkc
         6vimnh2FYEuku4Zh1t+GlHrloVdffSs/V1GeuzJwGJWGcqAOcnZovErMBgw7nd29RK
         UA/OZl+re6dPA==
Received: by mail-ed1-f53.google.com with SMTP id z20so14717139edc.13;
        Wed, 06 Oct 2021 14:09:02 -0700 (PDT)
X-Gm-Message-State: AOAM533/8G/TZNYeblvl5Z6W1A2KYxB1wwLwWPvS+0f74gQ5L+328nyU
        yr7wrukPjbTjDere1PWyyqWK05btydDsSqbEEQ==
X-Google-Smtp-Source: ABdhPJymkbNsN9aT73y46BJl6usZeJjKrfNWWvIOkuSTs2FD7IqIC9KCjaQE7Xpsh+yBqmdTH3WZm/Iyih4k6MZ6upc=
X-Received: by 2002:a05:6402:44c:: with SMTP id p12mr678627edw.145.1633554530546;
 Wed, 06 Oct 2021 14:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211006164332.1981454-1-robh@kernel.org> <20211006164332.1981454-7-robh@kernel.org>
 <YV4KkAC2p9D4yCnH@antec>
In-Reply-To: <YV4KkAC2p9D4yCnH@antec>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Oct 2021 16:08:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLv+Ym=hxxz2vm0H3pbx1FRkBpHs3V=8DKjG43n+gS+RA@mail.gmail.com>
Message-ID: <CAL_JsqLv+Ym=hxxz2vm0H3pbx1FRkBpHs3V=8DKjG43n+gS+RA@mail.gmail.com>
Subject: Re: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
To:     Stafford Horne <shorne@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 6, 2021 at 3:44 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Wed, Oct 06, 2021 at 11:43:26AM -0500, Rob Herring wrote:
> > Replace open coded parsing of CPU nodes' 'reg' property with
> > of_get_cpu_hwid().
> >
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: openrisc@lists.librecores.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/openrisc/kernel/smp.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> > index 415e209732a3..7d5a4f303a5a 100644
> > --- a/arch/openrisc/kernel/smp.c
> > +++ b/arch/openrisc/kernel/smp.c
> > @@ -65,11 +65,7 @@ void __init smp_init_cpus(void)
> >       u32 cpu_id;
> >
> >       for_each_of_cpu_node(cpu) {
> > -             if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> > -                     pr_warn("%s missing reg property", cpu->full_name);
> > -                     continue;
> > -             }
> > -
> > +             cpu_id = of_get_cpu_hwid(cpu);

Oops, that should be: of_get_cpu_hwid(cpu, 0);

I thought I double checked all those...

> You have defined of_get_cpu_hwid to return u64, will this create compiler
> warnings when since we are storing a u64 into a u32?

I'm counting on the caller to know the max size for their platform.

>
> It seems only if we make with W=3.
>
> I thought we usually warned on this.  Oh well, for the openrisc bits.

That's only on ptr truncation I think.

> Acked-by: Stafford Horne <shorne@gmail.com>
>
> >               if (cpu_id < NR_CPUS)
> >                       set_cpu_possible(cpu_id, true);
> >       }
> > --
> > 2.30.2
> >
