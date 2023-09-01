Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21246CA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 13:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbjIANLT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349705AbjIANLS (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 09:11:18 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57810CA
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 06:11:13 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d71dd633f33so1559363276.2
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573873; x=1694178673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tk/Aww2DcVBfpvviL7msfs2mEzI0sJ9pdXev1aletA=;
        b=X2YbHzLvcC/j1EH7j/x9fi10bn8NVbEH9SiynrIxGvxR5YrSxbmNdN9bkiB6H0T8jD
         56a48CVXfamBF5CB5oj8GiUMRorkwWzAbpC9/aVRrGq6MQotti9V3nJOT41IRlVhWxpa
         zPb5E8kP3gh+m+BfDYDZw2HnXKNWhWSOIOWTQXL4k6JqFxIwDT9liIeHVB3JyYa7hfww
         QamxC000qgD1e4zOSMF6IPmOOMF95YwNZ1LXR+U4mJeoK4FKwb+VLKBOkyMGtKy8n7Mk
         Sdg5GKqNSjK/18Pqye1I0am7+mwqgMkJl7pPnLphoOUdBgsALIGlZXPEZgfcoA37OVsE
         BGww==
X-Gm-Message-State: AOJu0YwPLqwpy9LflGReKfIElaOv75cK19KJ6xbFV4RLdaLzZonq7ogq
        8fhOI1SbjXPHRjUlV348Rx5vkklpIexm0Q==
X-Google-Smtp-Source: AGHT+IHmdxSPfXWKpSL5eY2hxfz/5nqSSLfk8L6h7PtPHlf4Hznr6TtDPfoC/RAw3+py+IfVmNmaWQ==
X-Received: by 2002:a25:44c:0:b0:d05:bf5b:918f with SMTP id 73-20020a25044c000000b00d05bf5b918fmr2412810ybe.28.1693573872753;
        Fri, 01 Sep 2023 06:11:12 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 200-20020a250bd1000000b00d13b72fae3esm882302ybl.2.2023.09.01.06.11.12
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:11:12 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7225259f52so1577448276.0
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:11:12 -0700 (PDT)
X-Received: by 2002:a25:f50d:0:b0:bcd:39d6:1ab1 with SMTP id
 a13-20020a25f50d000000b00bcd39d61ab1mr2445236ybe.39.1693573872225; Fri, 01
 Sep 2023 06:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <fb76aed2eb920d4f6accb67774103eb478fe25fe.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <fb76aed2eb920d4f6accb67774103eb478fe25fe.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 15:11:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXWzjFEdMFrbMg9fK_Zub6E2jMPnwzOhpojA1QcrHbig@mail.gmail.com>
Message-ID: <CAMuHMdVXWzjFEdMFrbMg9fK_Zub6E2jMPnwzOhpojA1QcrHbig@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 09/12] of: FDT vaddr support for SH.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 5:18 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> sh using virt address in FDT.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -643,6 +643,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
>                 fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
>                 if (!size)
>                         break;
> +#ifdef CONFIG_SUPERH
> +               base = virt_to_phys(base);
> +#endif

I guess this is a no-go.
Why can't you use physical address, like all other platforms?

>                 memblock_reserve(base, size);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
