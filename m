Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F8ACA0FE8
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 12:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbjIAM00 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347272AbjIAM00 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 08:26:26 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED2CFE
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 05:26:23 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d7e72883ab1so582775276.0
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571182; x=1694175982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaoOIhv/wU4dzShCHLCtTjtEF5ARVdm9tb2+k2BBgWo=;
        b=O4RfkU/6JhuhOdEgplVeP4WrmGqqPExJr/Sf2m0zjOjhG1tyu3uXP59b1crMHUpMk+
         /cf6teXotDvq/Vhx6BElEKmqeuuRXDfc54DsxnIkj9YMYe6UIIlhc0IApIUPt2oluQs+
         kVRVVS7ZehmPZJXOz8sbn+cVcqO2Tumjx4VIfftvVTF85zwBNLIUnUfc5Rpu5K+K1E8P
         uyURDA5mVmI+48VV5GeF1aW5G+okD8mlb6H3sDiaHUsIc5IHXr/iFIKpwFE03dNHGSXU
         dsMox4Vw88OFB3R3WeuyInZd7PYfNC78bvFec7pc+0mKuAdw+hDdxHZpl1bIpdcLw4Bd
         M9pA==
X-Gm-Message-State: AOJu0Yz3BxXTg9WerjSD4tq0eWlvK1nk7blZ18A56kuLpUVM4NoT3GdC
        A05Mmu8wYq9fuwFKgbzrjdlYTSbjX0hJBA==
X-Google-Smtp-Source: AGHT+IHfrfwxz7vglIEJIDIxiQz9DT2pP7Uu6X1H12xQ5FO3UuCp0DfXwZVL6yCMS4krenG1AEvIJQ==
X-Received: by 2002:a25:d102:0:b0:d06:4f8a:53d5 with SMTP id i2-20020a25d102000000b00d064f8a53d5mr2779579ybg.1.1693571182610;
        Fri, 01 Sep 2023 05:26:22 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v1-20020a25ab81000000b00d749a394c87sm859903ybi.16.2023.09.01.05.26.22
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:26:22 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d7b89ae27d3so1432031276.3
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:26:22 -0700 (PDT)
X-Received: by 2002:a25:8e8d:0:b0:d0c:49df:756 with SMTP id
 q13-20020a258e8d000000b00d0c49df0756mr2533982ybl.10.1693571182155; Fri, 01
 Sep 2023 05:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <4a138cf1ff14ff6166a66851db7476096fa3f009.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <4a138cf1ff14ff6166a66851db7476096fa3f009.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:26:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXMH3zaVgUmXt6SptHJzpwz67MPd=8LSqtGLyJ9CuP9A@mail.gmail.com>
Message-ID: <CAMuHMdWXMH3zaVgUmXt6SptHJzpwz67MPd=8LSqtGLyJ9CuP9A@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 03/12] sh: SH4 OF support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Thu, Aug 31, 2023 at 5:22 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - switch generic framework in clock / PCI.

... and much more.
Please split in separate patches.

> --- a/arch/sh/kernel/cpu/clock.c
> +++ b/arch/sh/kernel/cpu/clock.c
> @@ -14,12 +14,13 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/clk.h>
> +#include <linux/of.h>
>  #include <asm/clock.h>
>  #include <asm/machvec.h>
>
>  int __init clk_init(void)
>  {
> -       int ret;
> +       int ret = 0;
>
>  #ifndef CONFIG_COMMON_CLK
>         ret = arch_clk_init();

Perhaps make this whole function depend on CONFIG_COMMON_CLK,
and call sh_of_clk_init() (or of_clk_init()) directly() from time_init()?

> @@ -15,6 +15,7 @@ perf-$(CONFIG_CPU_SUBTYPE_SH7750)     := perf_event.o
>  perf-$(CONFIG_CPU_SUBTYPE_SH7750S)     := perf_event.o
>  perf-$(CONFIG_CPU_SUBTYPE_SH7091)      := perf_event.o
>
> +ifndef CONFIG_OF

CONFIG_SH_DEVICE_TREE

>  # CPU subtype setup
>  obj-$(CONFIG_CPU_SUBTYPE_SH7750)       += setup-sh7750.o
>  obj-$(CONFIG_CPU_SUBTYPE_SH7750R)      += setup-sh7750.o

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
