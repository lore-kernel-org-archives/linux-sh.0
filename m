Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E7CA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 12:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbjIAMWs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjIAMWs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 08:22:48 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEED7
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 05:22:45 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579de633419so19952147b3.3
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570965; x=1694175765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+fbAY0AQ4IyUfojl6zWquLJUBKL58f9v5pef77Ydhc=;
        b=IB5FUFtTHLPe3J3IM9CO/b6U9K04ykHnWY8h5Y0gc+BuXdao6ECgzTM4Fz7I5NGhQn
         xo6gnMUk+G9a1tRPL0EXeYhbt/a/HQFolsDN+RWjyrbUvN/bbHQUjzp8ZZik9mccMdEV
         zOfdhTyxxdxU3hW6eYoh6IJfmX5ftqhybR8hN7Ut7pNw/ooPTxTQF/7FZ1nYzA/iCC2v
         2/b4/DIZzjPlcW5PMuX9gdyoFsWNlcVoBKQPoTJTzMSyramq8c8sfVKihBn6aji9fF1x
         9o38ee9hXV83FSXdPcaJy9GLDCX29aQ4Jya7Cx5d+WaipmTcKcfSfPEshS0/FVC6OZ9L
         kkfQ==
X-Gm-Message-State: AOJu0Ywb3vq9P1xSWL0a+VOmza5hqGj9wYfI600a4ERGfVy6WC0UDCvV
        FDNExl4S3gSANWBkTJ4tlDTvDrs7vzPzGA==
X-Google-Smtp-Source: AGHT+IEsIYgJd0aX25c19gBPrv472iAa+6vo4PsZ8VO4Ct+OmnST2kVbn3+1B8LemikFtc79f+FErQ==
X-Received: by 2002:a0d:e211:0:b0:569:479f:6d7f with SMTP id l17-20020a0de211000000b00569479f6d7fmr2235701ywe.43.1693570964653;
        Fri, 01 Sep 2023 05:22:44 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id g126-20020a815284000000b005956b451fb8sm1006385ywb.100.2023.09.01.05.22.44
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:22:44 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-579de633419so19952027b3.3
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:22:44 -0700 (PDT)
X-Received: by 2002:a25:e002:0:b0:d0a:8973:b1c with SMTP id
 x2-20020a25e002000000b00d0a89730b1cmr2939741ybg.12.1693570964068; Fri, 01 Sep
 2023 05:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <95d8b86480c60012252b37b9b13e5f709a2ec177.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <95d8b86480c60012252b37b9b13e5f709a2ec177.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:22:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUS0YHgFXfhJah5yKMbeAtWV33G-N-GVaB62jY4qObNLg@mail.gmail.com>
Message-ID: <CAMuHMdUS0YHgFXfhJah5yKMbeAtWV33G-N-GVaB62jY4qObNLg@mail.gmail.com>
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig

> @@ -363,14 +363,17 @@ config CPU_SUBTYPE_SH7091
>  config CPU_SUBTYPE_SH7750R
>         bool "Support SH7750R processor"
>         select CPU_SH4
> +       select COMMON_CLK_SH7750 if COMMMON_CLK
>
>  config CPU_SUBTYPE_SH7750S
>         bool "Support SH7750S processor"
>         select CPU_SH4
> +       select COMMON_CLK_SH7750 if COMMMON_CLK
>
>  config CPU_SUBTYPE_SH7751
>         bool "Support SH7751 processor"
>         select CPU_SH4
> +       select COMMON_CLK_SH7750 if COMMMON_CLK

Might be easier to handle this in the clock Kconfig, cfr. the various
conditional selects at the top of drivers/clk/renesas/Kconfig

>         help
>           Select SH7751 if you have a 166 Mhz SH-4 HD6417751 CPU,
>           or if you have a HD6417751R CPU.
> @@ -378,6 +381,8 @@ config CPU_SUBTYPE_SH7751
>  config CPU_SUBTYPE_SH7751R
>         bool "Support SH7751R processor"
>         select CPU_SH4
> +       select COMMON_CLK_SH7750 if COMMMON_CLK
> +       select PCI_SH7751 if SH_DEVICE_TREE
>
>  config CPU_SUBTYPE_SH7760
>         bool "Support SH7760 processor"

> @@ -744,6 +749,7 @@ config ROMIMAGE_MMCIF
>  choice
>         prompt "Kernel command line"
>         optional
> +       depends on !SH_DEVICE_TREE

Why? On other architectures, overriding the kernel command line
is supported.  This is also useful in case of a builtin DTB.

>         default CMDLINE_OVERWRITE
>         help
>           Setting this option allows the kernel command line arguments
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index fafe15d3ba1d..ffdada2a128d 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -16,9 +16,14 @@ config SH_DEVICE_TREE
>         bool
>         select OF
>         select OF_EARLY_FLATTREE
> +       select OF_ADDRESS

Not needed, as it is already enabled:

    config OF_ADDRESS
            def_bool y
            depends on !SPARC && (HAS_IOMEM || UML)

>         select TIMER_OF
>         select COMMON_CLK
>         select GENERIC_CALIBRATE_DELAY
> +       select GENERIC_IOMAP
> +       select GENERIC_IRQ_CHIP
> +       select SYS_SUPPORTS_PCI
> +       select GENERIC_PCI_IOMAP if PCI
>
>  config SH_JCORE_SOC
>         bool "J-Core SoC"
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

SH_DEVICE_TREE already selects COMMON_CLK.
(same for landisk)

> +       help
> +         Select RTS7751R2D if configuring for a Renesas Technology
> +         Sales SH-Graphics board. (Use DeviceTree)
> +
>  config SH_RSK
>         bool "Renesas Starter Kit"
>         depends on CPU_SUBTYPE_SH7201 || CPU_SUBTYPE_SH7203 || \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
