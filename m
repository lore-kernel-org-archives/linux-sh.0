Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0591FC46CA1
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 15:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIRP2W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIRP1y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 11:27:54 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BDA273B
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:24:31 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6564515ec4eso13552896d6.2
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050549; x=1695655349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP5F9prql7onwCdd9+oMZyXQodhtAGyClSQqZQguiSs=;
        b=u+EpW4M7fIhEX4eu7s2GXCj5EOQ1givE5ny8vrFGS6iNR8fzYEj9c6Oa0lBQw3EFN6
         XdXrxiqxUNg/efB4S34wDElR2/c/z1KJl2nug9u95I7Gp4v+PS0epeOPjXJBtaGu3gVO
         6oTtniRPUJ/I0Ne6kD8CvYKdXH+DzoYxRcVPFx1so2KZ8mmHlP3dWFgWIXuOFRzywDS4
         wQvxxbTXHH9x2zx1EBt0oLpiBp4C8aSAU7808JnhOkedMj4UjN4c730xwuQpuUVGezik
         6Gkscyz6fAxRplTO+2vw/H6wbx6SQ+dMqtxjSO2xx5C+Bsgb/UQbGYKtMJMXqohccWJV
         1nmA==
X-Gm-Message-State: AOJu0YwQfSc9kpjW6wQbeldCgqM24493QL938iTsmxS2OfAGX/XUyqm9
        ybqr3lC7AUXSJ7rPlJ9rxA4yxEgFa/xz9w==
X-Google-Smtp-Source: AGHT+IGuPi77NKBOmRpKT6BpHgm4v77yWL+l2QOaT4SbSXh2WA4KX4YML7ePoEn5liMvv2vqoFWeYw==
X-Received: by 2002:a81:a104:0:b0:595:406b:93fa with SMTP id y4-20020a81a104000000b00595406b93famr10750512ywg.2.1695050056755;
        Mon, 18 Sep 2023 08:14:16 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id c127-20020a0df385000000b005463e45458bsm2633707ywf.123.2023.09.18.08.14.16
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:14:16 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59bd2e19c95so48992437b3.0
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:14:16 -0700 (PDT)
X-Received: by 2002:a81:52ca:0:b0:59b:bea7:29cb with SMTP id
 g193-20020a8152ca000000b0059bbea729cbmr8967337ywb.1.1695050056223; Mon, 18
 Sep 2023 08:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <236185b4a47f303332aafeacadd9c9652e650062.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <236185b4a47f303332aafeacadd9c9652e650062.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:14:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWn1hO4MFHrrUibmxnapQOEUYc-57U+__-8Ldb_s1qYug@mail.gmail.com>
Message-ID: <CAMuHMdWn1hO4MFHrrUibmxnapQOEUYc-57U+__-8Ldb_s1qYug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/30] arch/sh: Disable SH specific drivers in OF enabled.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:35 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> OF uses a common framework.
> Avoid using clk, irq and PCI SH-specific drivers.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig

> @@ -379,6 +379,7 @@ config CPU_SUBTYPE_SH7751
>  config CPU_SUBTYPE_SH7751R
>         bool "Support SH7751R processor"
>         select CPU_SH4
> +       select PCI_SH7751 if SH_DEVICE_TREE

Is PCI a hard requirement for using SH7751?
It not, it should not be auto-enabled by default.

> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c

> @@ -116,6 +117,8 @@ static void __init sh_of_mem_reserve(void)
>  static void __init sh_of_setup(char **cmdline_p)
>  {
>         struct device_node *root;
> +       struct device_node *cpu;
> +       int freq;

u32

>
>         sh_mv.mv_name = "Unknown SH model";
>         root = of_find_node_by_path("/");
> @@ -125,6 +128,9 @@ static void __init sh_of_setup(char **cmdline_p)
>         }
>
>         sh_of_smp_probe();
> +       cpu = of_find_node_by_name(NULL, "cpu");
> +       if (!of_property_read_u32(cpu, "clock-frequency", &freq))
> +               preset_lpj = freq / 500;
>  }
>
>  static int sh_of_irq_demux(int irq)
> @@ -140,25 +146,14 @@ static void __init sh_of_init_irq(void)
>         irqchip_init();
>  }
>
> -static int __init sh_of_clk_init(void)
> -{
> -#ifdef CONFIG_COMMON_CLK
> -       /* Disabled pending move to COMMON_CLK framework. */
> -       pr_info("SH generic board support: scanning for clk providers\n");
> -       of_clk_init(NULL);
> -#endif
> -       return 0;
> -}
> -
>  static struct sh_machine_vector __initmv sh_of_generic_mv = {
>         .mv_setup       = sh_of_setup,
>         .mv_name        = "devicetree", /* replaced by DT root's model */
>         .mv_irq_demux   = sh_of_irq_demux,
>         .mv_init_irq    = sh_of_init_irq,
> -       .mv_clk_init    = sh_of_clk_init,
> +       .mv_clk_init    = noopi,
>         .mv_mode_pins   = noopi,
> -       .mv_mem_init    = noop,

warning: ‘noop’ defined but not used [-Wunused-function]

> -       .mv_mem_reserve = sh_of_mem_reserve,
> +       .mv_mem_init    = sh_of_mem_init,
>  };
>
>  struct sh_clk_ops;

> --- a/drivers/sh/Makefile
> +++ b/drivers/sh/Makefile
> @@ -2,7 +2,9 @@
>  #
>  # Makefile for the SuperH specific drivers.
>  #
> +ifneq ($(CONFIG_SH_DEVICE_TREE),y)
>  obj-$(CONFIG_SH_INTC)                  += intc/
> +endif
>  ifneq ($(CONFIG_COMMON_CLK),y)
>  obj-$(CONFIG_HAVE_CLK)                 += clk/
>  endif

The above three lines can be simplified to

    obj-$(CONFIG_HAVE_LEGACY_CLK) += clk

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
