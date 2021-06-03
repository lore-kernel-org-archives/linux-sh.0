Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2DBC47082
	for <linux-sh@archiver.kernel.org>; Thu,  3 Jun 2021 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2124E6139A
	for <linux-sh@archiver.kernel.org>; Thu,  3 Jun 2021 07:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFCHz4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:55:56 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:45740 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFCHz4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 3 Jun 2021 03:55:56 -0400
Received: by mail-vs1-f54.google.com with SMTP id f15so2519244vsq.12;
        Thu, 03 Jun 2021 00:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDAwQCPpjyEMHJ6+8W9IXnXAc/vZN5i56EWW4dTqtUA=;
        b=WNkQOkgZ/xaC8OTQBdichAobDDYE7wrJoTKO3MxaQnTuR/zkHzVY6Idrs2ikDRsUV+
         c8AI+USOcXjN0qUKM4mFyV3MwEcUfTfKkpHul4J4NXpViUHVAdC/aOuRlpCLWzdmWQuu
         FnwNgng2ty3w3vcNyv9xH95+1A/yNEPhtg33tcSofnE28FBeJzL8ecuWMbyGChxSJWCP
         x0AFQULcCokdTdriUmAPwVOKBl3mm7y4QqWc8BdbTcn7I8k+CSWUFE7KRNL/gkKRmBKv
         xIlp4/XcNT1UpG+rw3j1ro8WITYQn5ERnfzWtuIUlczAdhoum6kRkrQiOhzLCukYJIdI
         ZE/w==
X-Gm-Message-State: AOAM532KnjhEVO4pk3wnUQAcfAHYpNOcb7Fz+kf2B8R6NWsDeUaEEgeg
        t4tUcGR10YPrjSqHn0apzUZOUP5Y8w/lc5Hpv4VydTe9ZEDBBw==
X-Google-Smtp-Source: ABdhPJz++m9+iYXMVCv7tBRyLLf0AKMwtglwAbWHZliBAOsJNV8xlJFjQR6T2xsCCuQzUsAYOWcDlqOB4naOgM3IsI8=
X-Received: by 2002:a67:fb8c:: with SMTP id n12mr16616135vsr.18.1622706851340;
 Thu, 03 Jun 2021 00:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210602231443.4670-1-rdunlap@infradead.org> <20210602231443.4670-3-rdunlap@infradead.org>
In-Reply-To: <20210602231443.4670-3-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Jun 2021 09:54:00 +0200
Message-ID: <CAMuHMdX1aCJPASd0vvuo+=sjnS8dv24eB_xY8Fn0L2TkJ8NWiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sh: define __BIG_ENDIAN for math-emu
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Randy,

On Thu, Jun 3, 2021 at 1:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> The headers in include/math-emu/ test for __BYTE_ORDER == __BIG_ENDIAN
> without checking to see if these macros are defined, so add
> a define for __BIG_ENDIAN before pulling in these headers.
>
> This placates these build warnings:
>
> In file included from ../arch/sh/math-emu/math.c:23:
> ../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>    50 | #if __BYTE_ORDER == __BIG_ENDIAN
> In file included from ../arch/sh/math-emu/math.c:24:
> ../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>    59 | #if __BYTE_ORDER == __BIG_ENDIAN
>
> Fixes: 4b565680d163 ("sh: math-emu support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- linux-next-20210528.orig/arch/sh/math-emu/sfp-util.h
> +++ linux-next-20210528/arch/sh/math-emu/sfp-util.h
> @@ -70,4 +70,4 @@
>
>  #define __BYTE_ORDER __LITTLE_ENDIAN
>
> -
> +#define __BIG_ENDIAN 0

I don't think this is the right fix.

I think the right values should be picked up from:

    include/uapi/linux/byteorder/big_endian.h:#define __BIG_ENDIAN 4321
    include/uapi/linux/byteorder/little_endian.h:#define __LITTLE_ENDIAN 1234

How is this picked up on other architectures using <math-emu/single.h>?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
