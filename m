Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08250C433DB
	for <linux-sh@archiver.kernel.org>; Tue, 29 Dec 2020 13:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4739206F6
	for <linux-sh@archiver.kernel.org>; Tue, 29 Dec 2020 13:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgL2NIo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 29 Dec 2020 08:08:44 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40902 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgL2NIn (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 29 Dec 2020 08:08:43 -0500
Received: by mail-oi1-f176.google.com with SMTP id p5so14541704oif.7;
        Tue, 29 Dec 2020 05:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55BF9LGP/3e9LMkfd7/X2NTZkoK/W4LemoCa3QSAEtM=;
        b=GbkOQO5vaCuz56PrUaQ9JvaLvlbV5vxcRquXzpRcVqp7lVrcDmSiz5M7M1vl/NAbj7
         rlza2a0Ce2NNGzYPzwtVRLzMSNQMt23V7A4Oo1mHjh8ANLipcm+Ls1+IH5jVSVnpbF/U
         3WORGZO1Sqeeg4J4SrCsdwcZbEm3lvyWtoObWqzBqEqyX1idgQXcg74kXykZ/9HsRcdI
         WooXDuysb/pqQTNbDu2dw5c+r0n4lMsTvs2vT4YuvUdgTwEZE2H60UueLX7Yf0GoT78z
         egEc1u/iAFlUsze5RF0VGHk6lQkTWtZn/FIZC+5AAw+oVpYzze1L3Oog+uCWra2kKGPP
         TR+Q==
X-Gm-Message-State: AOAM532lsHQUEftdCGT2/wuHOaBdk10V7vGq1zRyvJmsTJE+UENcDKkD
        YiRTiwDxvdAsU81hwpE2A5/7/dTmkwEzmxj523A=
X-Google-Smtp-Source: ABdhPJxpUhZhi636mfGYblnJawbMJPDR24YWZKnTvbBTAsoSf8EFuqU95hyyDRRkS/y+XaOzFT+KF4gxV9vKYBtkKsg=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr2267513oia.54.1609247283124;
 Tue, 29 Dec 2020 05:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20201210124422.3858524-1-anders.roxell@linaro.org>
In-Reply-To: <20201210124422.3858524-1-anders.roxell@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Dec 2020 14:07:52 +0100
Message-ID: <CAMuHMdUAaRRsHi2+Yr+PkALGeDYQkBROU3pKkp-z6BXNNtK+Rw@mail.gmail.com>
Subject: Re: [PATCH] sh: kernel: traps: remove unused variable
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Dec 10, 2020 at 1:46 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> When building defconfig the following warning shows up:
>
> arch/sh/kernel/traps.c: In function 'nmi_trap_handler':
> arch/sh/kernel/traps.c:183:15: warning: unused variable 'cpu' [-Wunused-variable]
>   unsigned int cpu = smp_processor_id();
>                ^~~
>
> Remove an unused variable 'cpu'.
>
> Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
