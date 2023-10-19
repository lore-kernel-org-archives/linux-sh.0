Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A785CDB465
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 10:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbjJSKCH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjJSKCG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 06:02:06 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C9119
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 03:02:04 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a82f176860so73908677b3.1
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709723; x=1698314523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niw5BKTg/t6c6JO4K0n2yjG4XpNPAapxWDZCLcVu4OA=;
        b=hF3WZhe/KNJZy8oqf8pOrlj3NJt9R6518/4YCJ0kfGnei69V9EJD3tzNdjVpZnaHx2
         5cLu2KxEUoSF2e7B1xsVe+QBBcRTnMWFEX/hwn8C4bm+e7JZnvf1kTjkGSdLnM0820pB
         5KyNW6yhvEwJUilU7D0H6W0ygVcFBK7U1vjOvtax8uJn4drRUWz9kGeF03uotPv9Wjyq
         5ocZh80u45BO49Q4sBRWxuawrDpWGK5JD5viYuhTzkyexm9MPgSQG+tI0DXYVeC4bikn
         4RNZv/OFdWlrlSDncINfblcp4b7Rg/r17wS3LmAJ0d9ITAoSCKz4FnWmInWfdSE8WAel
         ItkA==
X-Gm-Message-State: AOJu0Yy9xAskU8mzqgmNfMVudXK22SFhz4inFn1e66S/v8Ii0ozzLj02
        mMRZokj9ViRuVeQDbyFKJ5Q/5zrG9XnnKw==
X-Google-Smtp-Source: AGHT+IEenSWtWGCCa0LuCekr2WXddsGYKLISioGoo9mtm//HNjcLhYelcYXP+3qqVlMtvqrAEaTneA==
X-Received: by 2002:a0d:df42:0:b0:5a7:c8a9:79e8 with SMTP id i63-20020a0ddf42000000b005a7c8a979e8mr1893966ywe.4.1697709722943;
        Thu, 19 Oct 2023 03:02:02 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id w20-20020a81a214000000b005925c896bc3sm2299145ywg.53.2023.10.19.03.02.02
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 03:02:02 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a82f176860so73908537b3.1
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 03:02:02 -0700 (PDT)
X-Received: by 2002:a25:cec5:0:b0:d9a:6831:ec1c with SMTP id
 x188-20020a25cec5000000b00d9a6831ec1cmr1873253ybe.53.1697709722205; Thu, 19
 Oct 2023 03:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <ce8f731c6c7fbec19d67b1fbf353d0f6856e064d.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <ce8f731c6c7fbec19d67b1fbf353d0f6856e064d.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 12:01:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXw1ZQeB7N-8AQ_Ojt74MKQNFmVafTNxNQ-HfKJd83QHg@mail.gmail.com>
Message-ID: <CAMuHMdXw1ZQeB7N-8AQ_Ojt74MKQNFmVafTNxNQ-HfKJd83QHg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/35] arch/sh/kernel/setup.c: Update DT support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Fix fdt initialize.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> ---
>  arch/sh/kernel/setup.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index b3da2757faaf..8fdbb9836134 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -31,6 +31,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/mount.h>
>  #include <asm/io.h>
> @@ -79,7 +80,13 @@ extern int root_mountflags;
>  #define RAMDISK_PROMPT_FLAG            0x8000
>  #define RAMDISK_LOAD_FLAG              0x4000
>
> +#if defined(CONFIG_OF) || !defined(USE_BUILTIN_DTB)

This breaks non-DT.  I assume you meant "&&" instead?

Also, USE_BUILTIN_DTB lacks the CONFIG_-prefix.

However, I'm not sure this works as expected, as I have CONFIG_USE_BUILTIN_DTB=y
on qemu/r2d, but the kernel command line passed to qemu is not used
by Linux?

> +#define CHOSEN_BOOTARGS
> +#endif
> +
> +#ifndef CHOSEN_BOOTARGS
>  static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
> +#endif
>
>  static struct resource code_resource = {
>         .name = "Kernel code",

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
