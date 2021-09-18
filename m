Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035AEC433EF
	for <linux-sh@archiver.kernel.org>; Sat, 18 Sep 2021 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13126103B
	for <linux-sh@archiver.kernel.org>; Sat, 18 Sep 2021 11:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhIRLVs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 18 Sep 2021 07:21:48 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:41706 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhIRLVs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 18 Sep 2021 07:21:48 -0400
Received: by mail-ua1-f47.google.com with SMTP id f24so7771066uav.8;
        Sat, 18 Sep 2021 04:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+95Akgiaz9WFBupooVQKul5TnDqhDaarMu481JkCNos=;
        b=1pcmGyft6ErF0QKrncnT+kw6apPkrSSYaO1DO2ivy0qjXVkySC5QtE/PmxaJc4tx4T
         qDB34kVaRJ8SoKnSEHlk5LVO/wvWIgViNOhQ6Vq2AZIQQZr+vNwPCbl7gqXgS8XRXb7D
         up4YMrC60bxltNkyl+1zLflcO+l2mEY9yGWZdZ/2fzSqpOYeddzQ7PVTtrjoQ184arJu
         MIFbIfJ3ZpzNY5UnYLp1BMDi70U3fcDMaGcA0WcdB/j0SQU0aGMk6prOOwRZdYZH3bF5
         9nlI8brDZc9pRLzGXp0iDm9XkYJbxZv+QFePmGBdgvN3TVC99zCfr31LpxLoeNl6PEFZ
         hxnQ==
X-Gm-Message-State: AOAM531QMebAbKrrQyJdUetP+MuL363j3Flbec8Cqumv9bg2q+lc02iq
        KGc7aQ7qsmAC80antUSVuZxL6agJi9TnTzgLcxM=
X-Google-Smtp-Source: ABdhPJyOznufnHIHUMrEx98iGrlFtZwpScs0wiE8WDZzjoiZ975N7acgfbjIzblZ322QQ6vJZxy5ylvzDL3e8QTQ82E=
X-Received: by 2002:a9f:35aa:: with SMTP id t39mr7546907uad.89.1631964024115;
 Sat, 18 Sep 2021 04:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
 <1acace03-4273-a5ad-50b4-5ab8e3baa551@landley.net> <CAMuHMdUYUbjPSitt3wTi-YY5CEKwDJNJKPp9Pbfewm7B0CXP2A@mail.gmail.com>
 <f83c84d1-27d7-978f-4a3a-0c1f5a97c24f@landley.net>
In-Reply-To: <f83c84d1-27d7-978f-4a3a-0c1f5a97c24f@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 18 Sep 2021 13:20:13 +0200
Message-ID: <CAMuHMdUQuZ_fR4VogQ3Eo9NKGMpmAYnWraFAnYLy46uX99r1NQ@mail.gmail.com>
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
To:     Rob Landley <rob@landley.net>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob,

On Sat, Sep 18, 2021 at 6:45 AM Rob Landley <rob@landley.net> wrote:
> On 9/17/21 4:21 AM, Geert Uytterhoeven wrote:
> > On Fri, Sep 17, 2021 at 3:12 AM Rob Landley <rob@landley.net> wrote:
> >> On 9/15/21 8:50 AM, Geert Uytterhoeven wrote:
> >> >     arch/sh/include/asm/pgtable-3level.h:37:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >> ...
> >> > The truncation to "unsigned long" has been there since forever, so
> >> > probably it still works fine ;-)
> >>
> >> 1) Linux is LP64 so sizeof(long) and sizeof(pointer) always match, so it's not
> >> truncating.
> >>
> >> 2) The sh5 only ever shipped evaluation units, it never had a production run,
> >> and we haven't implemented j64 yet, so all superh targets are currently 32 bit.
> >> (I.E. it's complaining about _expanding_ the pointer, which shouldn't be a
> >> problem as long as endianness is respected.)
> >
> > The build error is for 32-bit.
>
> I know. I'm just saying your fix doesn't seem wrong. (Personally I would have
> just cast once to (void *) and let C not being C++ do the right thing, but eh...)

That would still give a warning, as "unsigned long long" us 64-bit, and
"void *" is 32-bit.

> Not sure I understand the point of the original code though. Under what
> conditions do you want 64 bit page tables on a 32 bit system? (Some PAE variant?)
>
> > If CONFIG_X2TLB=y, pgd_t.pgd is "unsigned long long", i.e. 64-bit, so
> > casting it to a pointer needs an intermediate cast to "unsigned long".
> > See arch/sh/include/asm/page.h:
>
> I can't find a user of it. None of the existing defconfigs select this option:
>
>   $ grep -r X2TLB arch/sh/configs

Note that these are reduced config files, so auto-selected symbols are
not present in the defconfig.

config X2TLB
        def_bool y
        depends on (CPU_SHX2 || CPU_SHX3) && MMU

and e.g.

config CPU_SUBTYPE_SH7723
        bool "Support SH7723 processor"
        select CPU_SH4A
        select CPU_SHX2

>
> And it's weird in other ways, like 8k page size. (Why...?)
>
> Google finds sh-x2 mentioned in Renesas' sh4a debugger docs, but I've never
> played with the renesas "a" variants. The stuff I'm familiar with is all
> following up on what Hitachi did, not Renesas.
>
> *shrug* You fix looks good enough to me.
>
> Acked-by: Rob Landley <rob@landley.net>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
