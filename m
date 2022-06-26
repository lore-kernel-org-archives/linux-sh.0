Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E0C43334
	for <linux-sh@archiver.kernel.org>; Sun, 26 Jun 2022 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiFZKCG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 26 Jun 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZKCF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 26 Jun 2022 06:02:05 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98219EE06;
        Sun, 26 Jun 2022 03:02:04 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id f14so5193332qkm.0;
        Sun, 26 Jun 2022 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOYqlxwdQdrnN6hSTkbM6b0WWc0keG2pFd9ArViBEXc=;
        b=MpzFQkh0M5y/2N+a8mFTWu+DmWzuiXNtGIb2WYhdBjl9xkCiodapRWvTXrKCIEdjVQ
         n8bX80bbLscB1gWFlPp8SAUCXA2ZzGhMJUErjsE8vPoHHovNt4Vb1Lr3/cl9wcTy4xjC
         o8XCllmkYBWpvKshz7GNzZq8V7DSlsDdL+raAAQKd53GHahBTN97S07WrDiUfGi1DDxn
         lMpvtwF0/ehp3MFRDWXELMIlx7teWE98dg6fVGNISoSu3+S0iRoGYkCITSVi/uBVarE8
         MfeSEX+ZcQYgMzaCSFdciKQVWGeMdjOv+fZiGdgOFmGLJeYjv0sdPtIdiesnj+nSb/6V
         KeYg==
X-Gm-Message-State: AJIora+TAVKBu5/g3FfiISiKSoXAaVwhIlGzJj+H5Fj1Mgqzk6YkVyx8
        TWitHaFtha8hQZ4SKipBPb1Sr0P/qfg4/Q==
X-Google-Smtp-Source: AGRyM1t3IKyqUzzA8DYujLG9UsLC5z8zgmGFSiMRYylKCGSj0dgcZuI1DcuMeP42ss2O22StviGjAg==
X-Received: by 2002:ae9:f40b:0:b0:6ae:fdd7:1935 with SMTP id y11-20020ae9f40b000000b006aefdd71935mr4937140qkl.676.1656237723546;
        Sun, 26 Jun 2022 03:02:03 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006aef641865esm5983024qkp.128.2022.06.26.03.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:02:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id v185so2434528ybe.8;
        Sun, 26 Jun 2022 03:02:02 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr8140536ybb.202.1656237722731; Sun, 26
 Jun 2022 03:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <521788e22ad8f7a5058c154f068b061525321841.1656142814.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <521788e22ad8f7a5058c154f068b061525321841.1656142814.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 26 Jun 2022 12:01:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1zN4Eo52T+AhJtJqBM0woW8vvTgysniMd_nv207NjgA@mail.gmail.com>
Message-ID: <CAMuHMdU1zN4Eo52T+AhJtJqBM0woW8vvTgysniMd_nv207NjgA@mail.gmail.com>
Subject: Re: [PATCH] sh: sq: Use the bitmap API when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Christophe,

On Sat, Jun 25, 2022 at 9:45 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Using the bitmap API is less verbose than hand writing them.
> It also improves the semantic.

Thanks for your patch!

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I don't cross compile, so this patch is NOT compile-tested.

Why not? Cross-compiling is so easy nowadays?
Many distros even provide cross-compilers ("apt install gcc-sh4-linux-gnu").
Else try https://mirrors.edge.kernel.org/pub/tools/crosstool/.

> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c

> @@ -382,7 +381,7 @@ static int __init sq_api_init(void)
>         if (unlikely(!sq_cache))
>                 return ret;
>
> -       sq_bitmap = kzalloc(size, GFP_KERNEL);
> +       sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);

Perhaps you need #include <linux/bitmap.h>?

I don't know, I also didn't bother to cross-compile. Why would I? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
