Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23827C7EE22
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 09:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjECJLY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 05:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjECJLN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 05:11:13 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D04C09;
        Wed,  3 May 2023 02:10:43 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a20a56a01so64616807b3.3;
        Wed, 03 May 2023 02:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104942; x=1685696942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydJHkGj1V4xdjO1riJrL8EFCn+f8ZNI6AJKZfUSPBcI=;
        b=iiB/qguqy2Uf7yjdwgJqhC09q93UNiiThvOLWd91fj/xAyxzfLiG71MbcvW9DBn0lg
         uB+ynh6t57CGA++y5kXpvOcAMQnCHFScG4jLY9pPyvOvxwaNCizXsBFMwOzVXgtjvjKc
         QUhmj4ztoqPU8qpTdImUY/9PMX/3FLJeQD08OI5K2ypy64fTCqC9lZ63kA+ya+Zh/sGi
         YlXE1ZyY/Z7R+RLhvfQME+YX37Y4TfzG9maCjVNK36JGS2+LkNixsPJiJy+QBNnLc28P
         fqppVehx0aJZIdvxcxyjcm8bJhgwR7GSM2rAXCNM/ZhbfRKNybnzBxJm4GyTp1D5zgFG
         OoOw==
X-Gm-Message-State: AC+VfDz7Z3GP7KHpXzxpCaXE+DznBe9c7ralLnwQnPxoxaBHK1n8vddN
        Z02d2WxLQKlWZZpjCc2ENmsJ4khz1N++Qg==
X-Google-Smtp-Source: ACHHUZ7cUSQTyW390y8qJ7x+k7x3B9WEwYfXBNglWH1B7R9RlbtXukObsYNiKkX6WaGea69UfrilwA==
X-Received: by 2002:a81:6cc4:0:b0:55a:a64b:ebdf with SMTP id h187-20020a816cc4000000b0055aa64bebdfmr4272668ywc.15.1683104942484;
        Wed, 03 May 2023 02:09:02 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id d190-20020a0df4c7000000b0054fcbf35b94sm8535483ywf.87.2023.05.03.02.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 02:09:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-55a00da4e53so70358197b3.0;
        Wed, 03 May 2023 02:09:01 -0700 (PDT)
X-Received: by 2002:a0d:cc4b:0:b0:55a:3420:5adc with SMTP id
 o72-20020a0dcc4b000000b0055a34205adcmr10043141ywd.51.1683104941745; Wed, 03
 May 2023 02:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <eed749a0ec500edf4f70a50578eaa50803fdaf3c.camel@physik.fu-berlin.de>
In-Reply-To: <eed749a0ec500edf4f70a50578eaa50803fdaf3c.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 11:08:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOJn97KMBa0YoQo+a7tGDwMTTQ8YPHT7VJ2zJjEYEV0Q@mail.gmail.com>
Message-ID: <CAMuHMdWOJn97KMBa0YoQo+a7tGDwMTTQ8YPHT7VJ2zJjEYEV0Q@mail.gmail.com>
Subject: Re: Fixing "int-to-pointer-cast" warning in J2 code
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh <linux-sh@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Adrian,

CC dt

On Wed, May 3, 2023 at 10:14 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> When building j2_defconfig, the following warning is issued:
>
> arch/sh/kernel/cpu/sh2/probe.c: In function 'scan_cache':
> arch/sh/kernel/cpu/sh2/probe.c:24:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    24 |  j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
>       |
>
> Reading the code and look how other users of of_flat_dt_translate_address()
> used the return code, I came up with the following patch which fixes the issue:
>
> diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
> index d342ea08843f..a0dc3675fc68 100644
> --- a/arch/sh/kernel/cpu/sh2/probe.c
> +++ b/arch/sh/kernel/cpu/sh2/probe.c
> @@ -14,14 +14,14 @@
>  #include <asm/cache.h>
>
>  #if defined(CONFIG_CPU_J2)
> -extern u32 __iomem *j2_ccr_base;
> +extern phys_addr_t j2_ccr_base;
>  static int __init scan_cache(unsigned long node, const char *uname,
>                              int depth, void *data)
>  {
>         if (!of_flat_dt_is_compatible(node, "jcore,cache"))
>                 return 0;
>
> -       j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
> +       j2_ccr_base = of_flat_dt_translate_address(node);

of_flat_dt_translate_address() indeed returns a CPU physical address
(perhaps its return type should be changed from u64 to phys_addr_t?)...

>
>         return 1;
>  }
> diff --git a/arch/sh/mm/cache-j2.c b/arch/sh/mm/cache-j2.c
> index f277862a11f5..2bc6d38d6f7c 100644
> --- a/arch/sh/mm/cache-j2.c
> +++ b/arch/sh/mm/cache-j2.c
> @@ -22,7 +22,7 @@
>  #define DCACHE_FLUSH   0x200
>  #define CACHE_FLUSH    (ICACHE_FLUSH | DCACHE_FLUSH)
>
> -u32 __iomem *j2_ccr_base;
> +phys_addr_t j2_ccr_base;

... however, all other users of j2_ccr_base use this with __raw_*()
I/O accessors, so "u32 __iomem *" is correct.

What is missing is a proper conversion from physical to virtual
addresses, using e.g. ioremap().

As this is nommu, the identity mapping in ioremap() in
arch/sh/include/asm/io.h should do, and cannot fail.

So just:

    j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);

should be fine.

BTW, "jcore,cache" does not have any DT binding documentation.

>
>  static void j2_flush_icache(void *args)
>  {
>
> Does that look reasonable?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
