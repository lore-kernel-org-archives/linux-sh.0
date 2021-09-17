Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE398C433EF
	for <linux-sh@archiver.kernel.org>; Fri, 17 Sep 2021 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB0E611EE
	for <linux-sh@archiver.kernel.org>; Fri, 17 Sep 2021 09:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbhIQJZg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:25:36 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:41827 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245705AbhIQJWu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 17 Sep 2021 05:22:50 -0400
Received: by mail-ua1-f46.google.com with SMTP id f24so5688272uav.8;
        Fri, 17 Sep 2021 02:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I/7meg9hzcw7tEZzqH2YXfTn0DbCHMjtqTubXnUYqM=;
        b=dbhbZ3+ULfqp1/spGZK77yrmQQ+jygp00REsOYh9oi4neYqM9nvykqIFxeJoQ04+mp
         g6r4nidWmC+hm8zPUQbD4hOT1HEXJv4zET6K7WayjjpQUO7SUhxXll9FCZzhGO9tpOwb
         gU0N0p/HEvfkj+La1qsvdNVr8AWKTf7sOsWKMAr1JnZhYmgF9gmTiImoZAL8CPoK+RBK
         NfGERpaN8Uh7dzvk4zW7C5yMkIG1z+Va3Q7LOXS4wWwK6KeLnx4av8gZS+iNtSosAiHU
         2CriEHjBdbSJEFdx90Y9ehnuxvMMOL6nYkjnB3Jdf8aitQEgWQxtJ3X2YqJrCsYpaRxT
         a/6w==
X-Gm-Message-State: AOAM531FJERQQ+EyppXfuTFbrzVL0k0cKemm7zBKywJBy6RIu7cK+/NS
        FxSGxDN3TVJcJjSHvKHqTeWC5TZ2McQy11d1KDs=
X-Google-Smtp-Source: ABdhPJwDxvombQXM8qDAYdgzwqm9pCHR3qlDCJ/FLgNppzCu2UdGidrdzoe/gRoxmK+GNur1xSzAvGWKBs1rxvDGBGw=
X-Received: by 2002:ab0:6dc7:: with SMTP id r7mr3590208uaf.14.1631870481125;
 Fri, 17 Sep 2021 02:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
 <1acace03-4273-a5ad-50b4-5ab8e3baa551@landley.net>
In-Reply-To: <1acace03-4273-a5ad-50b4-5ab8e3baa551@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Sep 2021 11:21:09 +0200
Message-ID: <CAMuHMdUYUbjPSitt3wTi-YY5CEKwDJNJKPp9Pbfewm7B0CXP2A@mail.gmail.com>
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

On Fri, Sep 17, 2021 at 3:12 AM Rob Landley <rob@landley.net> wrote:
> On 9/15/21 8:50 AM, Geert Uytterhoeven wrote:
> >     arch/sh/include/asm/pgtable-3level.h:37:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> ...
> > The truncation to "unsigned long" has been there since forever, so
> > probably it still works fine ;-)
>
> 1) Linux is LP64 so sizeof(long) and sizeof(pointer) always match, so it's not
> truncating.
>
> 2) The sh5 only ever shipped evaluation units, it never had a production run,
> and we haven't implemented j64 yet, so all superh targets are currently 32 bit.
> (I.E. it's complaining about _expanding_ the pointer, which shouldn't be a
> problem as long as endianness is respected.)

The build error is for 32-bit.
If CONFIG_X2TLB=y, pgd_t.pgd is "unsigned long long", i.e. 64-bit, so
casting it to a pointer needs an intermediate cast to "unsigned long".
See arch/sh/include/asm/page.h:

#ifdef CONFIG_X2TLB
typedef struct { unsigned long pte_low, pte_high; } pte_t;
typedef struct { unsigned long long pgprot; } pgprot_t;
typedef struct { unsigned long long pgd; } pgd_t;
#define pte_val(x) \
        ((x).pte_low | ((unsigned long long)(x).pte_high << 32))
#define __pte(x) \
        ({ pte_t __pte = {(x), ((unsigned long long)(x)) >> 32}; __pte; })
#else
typedef struct { unsigned long pte_low; } pte_t;
typedef struct { unsigned long pgprot; } pgprot_t;
typedef struct { unsigned long pgd; } pgd_t;
#define pte_val(x)      ((x).pte_low)
#define __pte(x)        ((pte_t) { (x) } )
#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
