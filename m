Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA28C433EF
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549E963211
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhKOKOS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:14:18 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:38608 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhKOKNx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 15 Nov 2021 05:13:53 -0500
Received: by mail-ua1-f46.google.com with SMTP id w23so10708731uao.5;
        Mon, 15 Nov 2021 02:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uczNj+JRGNzcNZDnUARVSzMZZa6FtWsEl77y1g5axMY=;
        b=RGYfHjYonx3hsjWTuJpM+6U7LQkv7t1vCfjrkTdm9rwyLiHAGkyV/4yZ+5Fp7kq8l5
         hhh8/03c6/xFJBmEQUQEUqkvo+qSAqlGh1StYjixtkU1xTtjsgJEOWDt4a6cxFOYu+1N
         XxYxdH/OhZGipjEK/rm553d8hoae3/ciZnR9BwhcGRlVpI7hibraMv0qBwSG5aFPBHj1
         AnhT0tof2wIiw7x5733EOYgaG/X8QMKi7vsxZA2IaXFClycGlY2qKpx0zCAZgWIysknG
         es7xtlQMDc3ccPxfnr28noYXl4nVFg2LDcE0nlpNeKE2Z9QiAOLs8nFJLnKKgK+3bTl+
         vkDQ==
X-Gm-Message-State: AOAM532uLGStkxj4ZN/1OwBsJ8EMMzYLzkPu4WY3eR/u6ErwjiKnuZha
        PaaDICZiEiM+Hmr9HV3OVS/NonWMb2XXbw==
X-Google-Smtp-Source: ABdhPJzIW2+6vIsDVErFpZ8bdIkWNqdcfWrUF7xVzZwZxss56IYTacdHJs+Riu+1iFSCDE2Dav8prA==
X-Received: by 2002:a67:e050:: with SMTP id n16mr40869277vsl.44.1636971054324;
        Mon, 15 Nov 2021 02:10:54 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id f188sm8623117vsc.16.2021.11.15.02.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 02:10:54 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id k83so7952348vke.7;
        Mon, 15 Nov 2021 02:10:53 -0800 (PST)
X-Received: by 2002:a1f:f24f:: with SMTP id q76mr56909184vkh.11.1636971053697;
 Mon, 15 Nov 2021 02:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20211115064128.9896-1-rdunlap@infradead.org>
In-Reply-To: <20211115064128.9896-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 11:10:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULwWi6hEUGY7vA3Nc7DhYLp_dH0o-sVdijWg6Z54GijQ@mail.gmail.com>
Message-ID: <CAMuHMdULwWi6hEUGY7vA3Nc7DhYLp_dH0o-sVdijWg6Z54GijQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: mcount.S: fix build error when PRINTK is not enabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Randy,

On Mon, Nov 15, 2021 at 7:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Fix a build error in mcount.S when CONFIG_PRINTK is not enabled.
> Fixes this build error:
>
> sh2-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
> (.text+0xec): undefined reference to `dump_stack'
>
> Fixes: e460ab27b6c3e ("sh: Fix up stack overflow check with ftrace disabled.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> Possibly even more of this function should conditionally not be built...

What about making STACK_DEBUG depend on PRINTK instead?
It doesn't make much sense to enable the former, if you won't print
any output...

> --- linux-next-20211112.orig/arch/sh/lib/mcount.S
> +++ linux-next-20211112/arch/sh/lib/mcount.S
> @@ -257,9 +257,11 @@ return_to_handler:
>  #ifdef CONFIG_STACK_DEBUG
>         .globl  stack_panic
>  stack_panic:
> +#ifdef CONFIG_PRINTK
>         mov.l   .Ldump_stack, r0
>         jsr     @r0
>          nop
> +#endif
>
>         mov.l   .Lpanic, r0
>         jsr     @r0
> @@ -277,8 +279,10 @@ stack_panic:
>         .long   panic
>  .Lpanic_s:
>         .long   .Lpanic_str
> +#ifdef CONFIG_PRINTK
>  .Ldump_stack:
>         .long   dump_stack
> +#endif
>
>         .section        .rodata
>         .align 2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
