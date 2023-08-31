Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7DC83F2F
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 16:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbjHaQRn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244228AbjHaQRn (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 31 Aug 2023 12:17:43 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064F90
        for <linux-sh@vger.kernel.org>; Thu, 31 Aug 2023 09:17:40 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-58cbdf3eecaso12125767b3.0
        for <linux-sh@vger.kernel.org>; Thu, 31 Aug 2023 09:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498659; x=1694103459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v2IyQeeO7HHLC0QIz5RhunmJ+En384761n3FYZ0Wkw=;
        b=PGTaoDMMC8t2SFiWBQVn/VOpA2QLb0i5JyMSznJJYmsn0rMc88+QpUf1hnhMrgc7c2
         NA2xFaU/PSA7yxjPnzhPpXlDrkcr4D5F39+d0xODpr43ZATET7GFBqSgoLx2M/0GipLQ
         9thGN+iNptxMgj3C3QjPz70dGKo1pQx3ib0a+bhg2A4Zvr701fteKbiN7dJ6CW2+IQhR
         9ncHQX9n2tiq5hIT1YGjyNFHQVkxn3yzLakmrte6idD+0m+cPU+R9dx/8koL27YhwOCd
         AlSuH1RZZc/JXAdKmNlDS9SBozm1bxfYbK4tII5EPdRx2hWT9Tt9LBWraYLKjN/9QiWP
         cYAQ==
X-Gm-Message-State: AOJu0YwiC+V2bWUYowsvgHjAv0V9/J/E/0DJueYxcqVTpkm8a+fGrU1B
        aDkxzbw2+CuPW0Ycsnos+lNkijsCVHuoCA==
X-Google-Smtp-Source: AGHT+IFoLgeCbxe8mpLZfqg+xLU7oOJHrSsmnnBXutO8u4n+aOdAMv5y49+DyGJNDpDrS7qOYOl7ZA==
X-Received: by 2002:a0d:cdc4:0:b0:592:8cd:6e10 with SMTP id p187-20020a0dcdc4000000b0059208cd6e10mr5276143ywd.49.1693498659484;
        Thu, 31 Aug 2023 09:17:39 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y5-20020a0def05000000b0058cbf72d6f2sm504945ywe.119.2023.08.31.09.17.39
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 09:17:39 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d7225259f52so760037276.0
        for <linux-sh@vger.kernel.org>; Thu, 31 Aug 2023 09:17:39 -0700 (PDT)
X-Received: by 2002:a25:d155:0:b0:d71:5afb:7741 with SMTP id
 i82-20020a25d155000000b00d715afb7741mr94114ybg.60.1693498659085; Thu, 31 Aug
 2023 09:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693384846.git.ysato@users.sourceforge.jp> <1a7d32f58935aee952750a088702f7f2798972d8.1693384846.git.ysato@users.sourceforge.jp>
In-Reply-To: <1a7d32f58935aee952750a088702f7f2798972d8.1693384846.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 18:17:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkVAqdG3yf90mEFpppsWmvzO8UsaOL1NR2705yD+JJuQ@mail.gmail.com>
Message-ID: <CAMuHMdUkVAqdG3yf90mEFpppsWmvzO8UsaOL1NR2705yD+JJuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] sh: target dts.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Aug 30, 2023 at 8:53 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - rts7751r2dplus - Renesas RTS7751R2D-PLUS board.
> - landisk - IO DATA DEVICE LANDISK
> - usl-5p - IO DATA DECVICE USL-5P
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!
> ---
>  arch/sh/boot/dts/include/dt-bindings |   1 +
>  arch/sh/boot/dts/landisk.dts         | 142 ++++++++++++++++++++++
>  arch/sh/boot/dts/rts7751r2dplus.dts  | 168 +++++++++++++++++++++++++++
>  arch/sh/boot/dts/usl-5p.dts          | 146 +++++++++++++++++++++++
>  4 files changed, 457 insertions(+)
>  create mode 120000 arch/sh/boot/dts/include/dt-bindings
>  create mode 100644 arch/sh/boot/dts/landisk.dts
>  create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
>  create mode 100644 arch/sh/boot/dts/usl-5p.dts
>
> diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
> new file mode 120000
> index 000000000000..08c00e4972fa
> --- /dev/null
> +++ b/arch/sh/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings

This should not be needed.

> --- /dev/null
> +++ b/arch/sh/boot/dts/landisk.dts
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree source for IO DATA DEVICE LANDISK
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>

You forgot to post commit d00349bf840505a0 ("sh: SH-INTC helper files")
in ysato/sh-of-wip.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
