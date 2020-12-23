Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE415C433DB
	for <linux-sh@archiver.kernel.org>; Wed, 23 Dec 2020 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE1E207AA
	for <linux-sh@archiver.kernel.org>; Wed, 23 Dec 2020 06:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLWGvH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 23 Dec 2020 01:51:07 -0500
Received: from condef-10.nifty.com ([202.248.20.75]:29208 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLWGvH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 23 Dec 2020 01:51:07 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2020 01:51:06 EST
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-10.nifty.com with ESMTP id 0BN6Z9gE009478
        for <linux-sh@vger.kernel.org>; Wed, 23 Dec 2020 15:35:09 +0900
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 0BN6YEvV020406;
        Wed, 23 Dec 2020 15:34:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0BN6YEvV020406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608705254;
        bh=wn59jeOCTy7mMAcAiQw9aRHlYpJopLoesfRO+zLZGnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMak6dDKLKahNXbVW6rctA05eQ/6TleikJCSXd/ecjZGevmvf/EcTwD5Ot08/6+8/
         zcFFe/0l/gQGuprromwWi+t9b40fXyjbLvBGKanNIv95e4OYTfHap/2OsPWuTEql9H
         qj6DP2hLVe/1msYsGioltctco3ct58aqhpu6RM6A0VbTo6NyVf2RTpHJQ+2NjODD4I
         jsFFcVXASzSwoUbf5zDAYlUdknu0hxH0cfCKc7Mkz4WyVU5IxZfGJzd1a1EuQifHz4
         tcvO3zNJhoWiZIEdg4bm93SsJYyF8/sudfvm6PT5jE7JBKINMgI5fvH/KO3h0I/S7X
         ZUbAQ/rDhkyqA==
X-Nifty-SrcIP: [209.85.214.171]
Received: by mail-pl1-f171.google.com with SMTP id s15so4216344plr.9;
        Tue, 22 Dec 2020 22:34:14 -0800 (PST)
X-Gm-Message-State: AOAM532Z3rrsxSrgZYW7A+oDkunUYxgGnn4lrs0XGT9bWbOiS8itRWZh
        XE9BhqUqwZwWq5KXA4S1jTkExDh+d/0p9HnPD2w=
X-Google-Smtp-Source: ABdhPJxaUQJ/9o1CK/l9arsWooi5Hqd5sg6UwENurfCRKX0OhO3Lvyw8z3z32FCD95KGbcUl6BlA7UnwzjXR4+TWmfM=
X-Received: by 2002:a17:902:521:b029:dc:2836:ec17 with SMTP id
 30-20020a1709020521b02900dc2836ec17mr1426470plf.47.1608705253707; Tue, 22 Dec
 2020 22:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20201212161831.GA28098@roeck-us.net> <20201222205402.2269377-1-ndesaulniers@google.com>
In-Reply-To: <20201222205402.2269377-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 23 Dec 2020 15:33:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGT9fw59-s9Tz-cA7zNt6TVdPdB5WMSea55U3qETDphw@mail.gmail.com>
Message-ID: <CAK7LNASGT9fw59-s9Tz-cA7zNt6TVdPdB5WMSea55U3qETDphw@mail.gmail.com>
Subject: Re: [PATCH] sh: check return code of request_irq
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Dec 23, 2020 at 5:54 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> request_irq is marked __must_check, but the call in shx3_prepare_cpus
> has a void return type, so it can't propagate failure to the caller.
> Follow cues from hexagon and just print an error.
>
> Fixes: c7936b9abcf5 ("sh: smp: Hook in to the generic IPI handler for SH-X3 SMP.")
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>


Thanks for the patch, Nick.

I just wondered if there was a better error handling than
printing the message. I have no idea if the system will
boot up correctly when the request_irq() fails here.

I hope the maintainers will suggest something, if any.




> ---
>  arch/sh/kernel/cpu/sh4a/smp-shx3.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
> index f8a2bec0f260..1261dc7b84e8 100644
> --- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
> +++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
> @@ -73,8 +73,9 @@ static void shx3_prepare_cpus(unsigned int max_cpus)
>         BUILD_BUG_ON(SMP_MSG_NR >= 8);
>
>         for (i = 0; i < SMP_MSG_NR; i++)
> -               request_irq(104 + i, ipi_interrupt_handler,
> -                           IRQF_PERCPU, "IPI", (void *)(long)i);
> +               if (request_irq(104 + i, ipi_interrupt_handler,
> +                           IRQF_PERCPU, "IPI", (void *)(long)i))
> +                       pr_err("Failed to request irq %d\n", i);
>
>         for (i = 0; i < max_cpus; i++)
>                 set_cpu_present(i, true);
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
Best Regards
Masahiro Yamada
