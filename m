Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10770C433EF
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA276108E
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 14:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhI0Obd (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:31:33 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:33658 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhI0Obb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 27 Sep 2021 10:31:31 -0400
Received: by mail-ua1-f54.google.com with SMTP id r8so12423149uap.0;
        Mon, 27 Sep 2021 07:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9nizv9GkJMYH6DdVVrnBumEJDaVbOlmnn+hAvH58aA=;
        b=UNGgjHmEvQaDXF0VvdhKm1gm2uF8ooAC3dfSVXtdR5cUHyhDCDDdJmR71u3HZX4I7Y
         oPB7Ido254F1DEeWBbVBRPWVlGgrSiDCGHeotw/dI8QU7ZAjb2cGJQJBrH6WKpXCb79/
         NcVv4WQANKdNV1ugQQvX4lm/7GRfatEYduC0EHe8k1XDqe5aaxgOipFOwIN4gLBmp7uf
         cmxMbclo7akE0ydfgS2TR5VwC45+ZnuPejrqhWozcInJgyJz+rsGlFKAF4mFrPKKtoGk
         1HVa9HPKLokyCzNmBPYnkZJW81SVTJDRvNmUzFNn8C8lYMsLeIQ5YGAKe9nupYTXo9pY
         +SZw==
X-Gm-Message-State: AOAM530oZyCEQSlEaXa5K6Bto1o3oadoUnewqeReZATiJoQ8nEg0IcfY
        q2Fx4D+jc8ieyTrxJGUUStTWaqrJiGonftvNMDQ=
X-Google-Smtp-Source: ABdhPJz66AcPtBjy0uphPGt6FmuIQQzoqOP0aQhxO6op69AK8A/BV/QlNry/bou0tAxXIFo6+0hNzZT6L9KJrz7Be1I=
X-Received: by 2002:ab0:540d:: with SMTP id n13mr20580uaa.78.1632752991762;
 Mon, 27 Sep 2021 07:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com> <20210927081402.191717-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20210927081402.191717-2-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Sep 2021 16:29:40 +0200
Message-ID: <CAMuHMdUC9FtGhXCQFTsGVf3yfX=WUZ4V30SGL9BzgAhOMYaH_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] sh: Cleanup about SPARSE_IRQ
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Kefeng,

On Mon, Sep 27, 2021 at 10:11 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> After commit 37744feebc08 ("sh: remove sh5 support"), sh always
> enable SPARSE_IRQ, kill unused MAY_HAVE_SPARSE_IRQ and NR_IRQS
> define under !CONFIG_SPARSE_IRQ.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One question below...

> --- a/arch/sh/include/asm/irq.h
> +++ b/arch/sh/include/asm/irq.h
> @@ -5,16 +5,7 @@
>  #include <linux/cpumask.h>
>  #include <asm/machvec.h>
>
> -/*
> - * Only legacy non-sparseirq platforms have to set a reasonably sane
> - * value here. sparseirq platforms allocate their irq_descs on the fly,
> - * so will expand automatically based on the number of registered IRQs.
> - */
> -#ifdef CONFIG_SPARSE_IRQ
>  # define NR_IRQS               8
> -#else
> -# define NR_IRQS               512
> -#endif

I'm wondering if we can go even further, and just remove the definition
of NR_IRQS, and fall back to the default in include/asm-generic/irq.h?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
