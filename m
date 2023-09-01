Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4809DCA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbjIAMZi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349403AbjIAMZh (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 08:25:37 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34D10E4
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 05:25:34 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-590685a3be5so20107007b3.0
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571133; x=1694175933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS6bq4tt7chZcwdCpFUKlYy24YbHR5F1COJSZxAO0aQ=;
        b=j8zYz9CSjLeo8Egy6SZEUMifzsIe9BB5Zc3bxw7PJPrChzcAGaM/GQ1A+27Ozmx9uf
         1yszZTOI3IywXaAJdAvxeRTAsRLQA5X0XcOWxp1uWAdMt2qyLSUSBxzCi9iCmewIwa0J
         xAPCko+mtbKs5uozDsB4k/+Hze3tu0ceEvnshb8Li+NDvFtgzxXiEQrVrK26n5vZCaAB
         EN50kCgTZn2gwnPjfiZXeUSX/IhGAoCa9FSnU1nbyErnM/M7Fn1ggxFiEQSnCDmF91r7
         O0HNfirmVQqta8PX+rDP4J/clWf/psqj4mrtxtiloBkj6qe0rsDMJyGcL/zTGMUe/uir
         lQDQ==
X-Gm-Message-State: AOJu0YxrUCQRdsTPwVtGakTNJmRffIf/r8gaO0f0mVvtxhX6zZIrsdqo
        SpfH66ljjolBfMLpgtbSbEmfYVYq0fmRLA==
X-Google-Smtp-Source: AGHT+IFqlK/qJvIKJZE3veK8O4LGGnKr5c3QiqmdgX9mw3x2uKDdkAfCtATXtKwi5T2R46GzyVfF8A==
X-Received: by 2002:a0d:c341:0:b0:594:e145:112e with SMTP id f62-20020a0dc341000000b00594e145112emr2365284ywd.24.1693571132868;
        Fri, 01 Sep 2023 05:25:32 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o5-20020a0dfe05000000b005731dbd4928sm1010751ywf.69.2023.09.01.05.25.32
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:25:32 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d7e741729a2so595286276.2
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:25:32 -0700 (PDT)
X-Received: by 2002:a05:6902:1367:b0:d78:2922:e71b with SMTP id
 bt7-20020a056902136700b00d782922e71bmr2654471ybb.0.1693571132224; Fri, 01 Sep
 2023 05:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <184764e337b9fea92bed4576d776118984e31f38.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <184764e337b9fea92bed4576d776118984e31f38.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:25:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWV-Q0qhkRjKjY_ncdZce8ms+OEBNoZyguq8QOvCkO=5A@mail.gmail.com>
Message-ID: <CAMuHMdWV-Q0qhkRjKjY_ncdZce8ms+OEBNoZyguq8QOvCkO=5A@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 02/12] sh: Update OF handling.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Thu, Aug 31, 2023 at 9:08 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - avoid build warning.
> - reserve external dtb area.
> - use generic interfaces on internal peripheral driver.

... and much more.
Please split in separate patches.

> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c

>  void __init __weak plat_irq_setup(void)
>  {
>  }
> +
> +static int __init sh_of_device_init(void)
> +{
> +       pr_info("SH generic board support: populating platform devices\n");
> +       if (of_have_populated_dt()) {
> +               of_platform_populate(NULL, of_default_bus_match_table,
> +                                    NULL, NULL);
> +       } else {
> +               pr_crit("Device tree not populated\n");
> +       }
> +       return 0;
> +}
> +arch_initcall_sync(sh_of_device_init);

Do you need this?
of_platform_populate() is already called through
drivers/of/platform.c:arch_initcall_sync(of_platform_default_populate_init);

> +
> +void intc_finalize(void)
> +{
> +}

Do you need this? Oh, for arch/sh/kernel/irq.c:void __init init_IRQ().
Perhaps define an inline dummy in a header file?

> --- a/arch/sh/kernel/head_32.S
> +++ b/arch/sh/kernel/head_32.S
> @@ -56,7 +56,7 @@ ENTRY(empty_zero_page)
>   */
>  ENTRY(_stext)
>         !                       Initialize Status Register
> -       mov.l   1f, r0          ! MD=1, RB=0, BL=0, IMASK=0xF
> +       mov.l   1f, r0          ! MD=1, RB=0, BL=1, IMASK=0xF

Why?

>         ldc     r0, sr
>         !                       Initialize global interrupt mask
>  #ifdef CONFIG_CPU_HAS_SR_RB

> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c

> @@ -79,7 +80,9 @@ extern int root_mountflags;
>  #define RAMDISK_PROMPT_FLAG            0x8000
>  #define RAMDISK_LOAD_FLAG              0x4000
>
> +#ifndef CONFIG_OF
>  static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
> +#endif

Having the ability to override the command line is still useful.
And below, the use of command_line[] depends on
!defined(CONFIG_OF) || defined(USE_BUILTIN_DTB).

> @@ -313,10 +332,15 @@ void __init setup_arch(char **cmdline_p)
>         strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));
>  #endif
>  #endif
> +#endif
>
> +#if !defined(CONFIG_OF) || defined(USE_BUILTIN_DTB)
>         /* Save unparsed command line copy for /proc/cmdline */
>         memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
>         *cmdline_p = command_line;
> +#else
> +       *cmdline_p = boot_command_line;
> +#endif
>
>         parse_early_param();

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
