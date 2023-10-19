Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFD9CDB483
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 11:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjJSLzG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjJSLzF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 07:55:05 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2412D
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 04:55:03 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7b92cd0ccso98351967b3.1
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 04:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716503; x=1698321303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGpflT/XOxSb9ElO8bdrVKOvwh5Q15JaGBBtfhiJu50=;
        b=UXlUBZrbfmJpd7D7veddvLu6+5JmHcxQxxSOmr5LhQ89axiUbZu7LsxJ62pRLjgYh9
         6nnWPo/He+lc4oWYJN9nikji3PxCzGhsNFoPl/Q/4HkpLVSnDFlwkH4tUGBwaT7m5CnU
         KAweGXD3F4dMVGCewBtRl3QPH0jSBuPMr2UR9xwUoKQLGpK2wki5Gx4+YgFL5eTbAYnd
         vmH7EEF+qGEmg18GV4VQekWNbLbaZeMdHdlSmsfeTHNXzeVYmi7E+mfVW+RMHYoIXsUB
         LBJ4ZAZA9LHE3jpHL8JKVzNnOL82c17z/bOLAqO02YShHBbCFVseuR3HBfLjrKFBTQP6
         YoRg==
X-Gm-Message-State: AOJu0YyEBksY1vFwZPQYRaCe3Q7HExKMNKnrfh1TqnYzB7X9usvqcRZk
        zXP1t5ypTWJdchc1FJzTnNc5xqgZH9Ig3w==
X-Google-Smtp-Source: AGHT+IECB09fOq/E/kMeIGARykvFf/1JTEHNIU49BuibLWhq3lGKv1UjqtpslLWvudtE9tk35oQtcw==
X-Received: by 2002:a81:48d4:0:b0:583:d8d4:7dfe with SMTP id v203-20020a8148d4000000b00583d8d47dfemr1743909ywa.31.1697716502781;
        Thu, 19 Oct 2023 04:55:02 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id c186-20020a0ddac3000000b00592236855cesm2339879ywe.61.2023.10.19.04.55.02
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:55:02 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so8543903276.0
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 04:55:02 -0700 (PDT)
X-Received: by 2002:a25:a202:0:b0:d7f:af26:2c7e with SMTP id
 b2-20020a25a202000000b00d7faf262c7emr1839437ybi.20.1697716502054; Thu, 19 Oct
 2023 04:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <23b14a38a073e8b5efd80c1931d8be1ea105797a.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <23b14a38a073e8b5efd80c1931d8be1ea105797a.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 13:54:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhR47z9=Q1NahCKceKtwwUw9y5AtmQnqw4-u_BFQfi2w@mail.gmail.com>
Message-ID: <CAMuHMdXhR47z9=Q1NahCKceKtwwUw9y5AtmQnqw4-u_BFQfi2w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 33/35] arch/sh: Add dtbs target support.
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/arch/sh/boot/dts/Makefile
> +++ b/arch/sh/boot/dts/Makefile
> @@ -1,2 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_USE_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
> +
> +dtb-$(CONFIG_CPU_J2) += j2_mimas_v2.dtb

Please keep this a separate patch, and move it forward in the series
(or submit it independently).

> +dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += landisk.dtb

This change should be moved into "[RFC PATCH v3 31/35] arch/sh/boot/dts:
LANDISK DeviceTree.".

> +dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += rts7751r2dplus.dtb

This change should be moved into "[RFC PATCH v3 30/35] arch/sh/boot/dts:
RTS7751R2D Plus DeviceTree.".

> +dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += usl-5p.dtb

This change should be moved into "[RFC PATCH v3 32/35] arch/sh/boot/dts:
USL-5P DeviceTree.".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
