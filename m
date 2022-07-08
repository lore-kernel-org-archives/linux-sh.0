Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949CC43334
	for <linux-sh@archiver.kernel.org>; Fri,  8 Jul 2022 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiGHLK5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Jul 2022 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiGHLKz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Jul 2022 07:10:55 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E184EFC
        for <linux-sh@vger.kernel.org>; Fri,  8 Jul 2022 04:10:53 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id x17so264170qkh.11
        for <linux-sh@vger.kernel.org>; Fri, 08 Jul 2022 04:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX94cbrLovOpfck0xgvWqtu/KT2R+b8G2H/bh1+Qow4=;
        b=rIrr3OX35LU0zY4c7asG8mn36IPoLFad0whWWjAGVEM4Xbvju73ax85REyqiiwDHDK
         XLVwKAevEitSAXQk2WdDeOz9D9HdYPnYnLnnCfSGCnIaNOaNlIaL7wxGTWr8mcxbSwIA
         +cAd9SgqAxb9T7lcchXAxwa/eTefTS3YMO64IeFfNhQ8XG9VKuC7+14000j8ckwwWxGL
         N5nyG4Yzj86SmhGIhW7jVMmwuD8Tdo2qhZYxMDZEWSe4ucsuf4+mx5PBRinoVfT9K14/
         l816TsybGSHSl7A3pOtBLrE5zlKpxxHJkNA4r+/gvSN5+M9o+8Zizet39OVmqD0c9x3A
         +/4A==
X-Gm-Message-State: AJIora/tAxrplya+q8AaQhvBMDuov328r0QulpZk4GI2sNayT5Iq/0Yi
        frmgnBwxpc09xafQ2rjVa0eruOBhW1ZFyQ==
X-Google-Smtp-Source: AGRyM1vhqk4lt11ZrK6EsUElDHiuRXhg75OMNid0IecdJh+91lSTntWk7WZTmWTq2SJQtv8+1pu65Q==
X-Received: by 2002:a37:b90:0:b0:6b5:5551:113b with SMTP id 138-20020a370b90000000b006b55551113bmr1774074qkl.22.1657278652889;
        Fri, 08 Jul 2022 04:10:52 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k20-20020a05620a07f400b006a6ab259261sm31047984qkk.29.2022.07.08.04.10.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 04:10:52 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g4so37247808ybg.9
        for <linux-sh@vger.kernel.org>; Fri, 08 Jul 2022 04:10:52 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr2852619ybr.380.1657278651934; Fri, 08
 Jul 2022 04:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220708104347.13462-1-phil.edworthy@renesas.com>
In-Reply-To: <20220708104347.13462-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 13:10:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3onSYh+x0xuHd4jGiiY7wjHuQwx1ebd3-XormmVoVMw@mail.gmail.com>
Message-ID: <CAMuHMdV3onSYh+x0xuHd4jGiiY7wjHuQwx1ebd3-XormmVoVMw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: clk: Extend valid clk ptr checks using IS_ERR_OR_NULL
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, Jul 8, 2022 at 12:43 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> We want to allow all drivers to call clk_disable_unprepare() with a
> clock pointer that could be a valid IS_ERR() condition containing
> errno, as this will simplify driver code.
>
> Therefore, ensure we check not only that the clock pointer is not
> NULL, but also is not an error value before using it.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note this has not been tested at all, I don't have any SH boards.
>
> v2:
>  - Only use IS_ERR_OR_NULL in clk_disable() as nobody should be
>    calling the other functions with a clk ptr that is an error.
>  - Improved commit msg to clarify the above

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
