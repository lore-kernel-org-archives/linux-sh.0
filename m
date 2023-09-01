Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D1CA0FE4
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjIAO00 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjIAO0Z (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 10:26:25 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B66CC5
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 07:26:22 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-58dfe2d5b9aso169317b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 07:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578382; x=1694183182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rinMlOgd+oYxdRhWNbzuljXiSFeUvbdEcRzKJDidIvc=;
        b=MDbpqzr2Nq4ymj454iD+ef0De6uYNKz9CmyTISK1B0yvV3dz1lEmGWiaOE7SzGkB/u
         HgW6E0T55qdSaAKTHA0iMlJnPg7xwm9KV2eTO/Jkc8rxSSTzP4E4bxODmHJN6AeEX/Al
         Zd85jXe04qCd20K5b1fQ/8Q54YNnc2aXzACzJLkRYvMW6SxwH05Wn86Kskpczux6HfRZ
         2+0Ob1lvO3NbSDXBIRBxem18ncPv71lcm6uKQzC2AGpmnRLyz96DqgZfEyfDzFddvnvw
         9bqvayP7Wkk8Dev7LT1opNEJufGMoebp9HArAy0IMenPcfAOAgcIlFljcJOpi9fjl5iv
         jODw==
X-Gm-Message-State: AOJu0YxHanycF1x9WxCg56nPRuh6fWKBY8tlu4kFr33T4wASZC+Lt/SM
        JqAb2UkdGLVK4BXmSYNIF5yOFfSGSypo0Q==
X-Google-Smtp-Source: AGHT+IF1MFEu6KZcHam+sMHE9HmaZisoLBYQC8OAVhVnM4484kc7xKFWpnLEkrK+/HSa5rBsOLgVfQ==
X-Received: by 2002:a0d:db4f:0:b0:583:9db5:7e89 with SMTP id d76-20020a0ddb4f000000b005839db57e89mr3986654ywe.24.1693578381909;
        Fri, 01 Sep 2023 07:26:21 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i63-20020a0dc642000000b0058605521e6esm1081276ywd.125.2023.09.01.07.26.21
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:26:21 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d74a012e613so19584276.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 07:26:21 -0700 (PDT)
X-Received: by 2002:a25:e7d1:0:b0:d67:46c9:d0fd with SMTP id
 e200-20020a25e7d1000000b00d6746c9d0fdmr3187606ybh.22.1693578381373; Fri, 01
 Sep 2023 07:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <95d8b86480c60012252b37b9b13e5f709a2ec177.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <95d8b86480c60012252b37b9b13e5f709a2ec177.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 16:26:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0rmmi8=DyQL-WmMdFyo4g6obNXjWutNGEz=3QcO_d+g@mail.gmail.com>
Message-ID: <CAMuHMdV0rmmi8=DyQL-WmMdFyo4g6obNXjWutNGEz=3QcO_d+g@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 01/12] sh: Add OF target boards.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 5:19 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig

> @@ -702,7 +707,7 @@ config BUILTIN_DTB_SOURCE
>  config ZERO_PAGE_OFFSET
>         hex
>         default "0x00010000" if PAGE_SIZE_64KB || SH_RTS7751R2D || \
> -                               SH_7751_SOLUTION_ENGINE
> +                               SH_7751_SOLUTION_ENGINE || SH_RTS7751R2D_OF

This is the only user of SH_RTS7751R2D_OF. Can we get rid of it?

>         default "0x00004000" if PAGE_SIZE_16KB || SH_SH03
>         default "0x00002000" if PAGE_SIZE_8KB
>         default "0x00001000"

> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -161,6 +166,17 @@ config SH_RTS7751R2D
>           Select RTS7751R2D if configuring for a Renesas Technology
>           Sales SH-Graphics board.
>
> +config SH_RTS7751R2D_OF
> +       bool "RTS7751R2D (DeviceTree)"
> +       depends on CPU_SUBTYPE_SH7751R
> +       select HAVE_PCI
> +       select IO_TRAPPED if MMU
> +       select SH_DEVICE_TREE
> +       select COMMON_CLK
> +       help
> +         Select RTS7751R2D if configuring for a Renesas Technology
> +         Sales SH-Graphics board. (Use DeviceTree)
> +
>  config SH_RSK
>         bool "Renesas Starter Kit"
>         depends on CPU_SUBTYPE_SH7201 || CPU_SUBTYPE_SH7203 || \
> @@ -300,8 +316,20 @@ config SH_LANDISK
>         bool "LANDISK"
>         depends on CPU_SUBTYPE_SH7751R
>         select HAVE_PCI
> +       select SYS_SUPPORTS_PCI
> +       help
> +         I-O DATA DEVICE, INC. "LANDISK Series" support.
> +
> +config SH_LANDISK_OF
> +       bool "LANDISK (DeviceTree)"
> +       depends on CPU_SUBTYPE_SH7751R
> +       select HAVE_PCI
> +       select SYS_SUPPORTS_PCI
> +       select SH_DEVICE_TREE
> +       select COMMON_CLK
>         help
>           I-O DATA DEVICE, INC. "LANDISK Series" support.
> +         Use Device Tree.
>
>  config SH_TITAN
>         bool "TITAN"

Apart from the above, there are no users of the "<machine>_OF" symbols.
Do we need them?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
