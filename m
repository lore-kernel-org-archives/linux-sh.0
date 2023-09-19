Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF70ACD5BA7
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjISM3J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISM3I (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:29:08 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EDF2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:29:02 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d818d4230f6so5168584276.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126541; x=1695731341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3nbdZcdEsks17ma/17ioDF072UrYwkGJtLBJCDn8IM=;
        b=tXoM8yCNntnHP8WVbRlD1rhtDyPF9pHDmt0eLd3T+569fIlr0SbFRb0jf7wDIQ8liF
         C8D2EOLJLq2W/MFzVEWyq8qrx+pvdUL3TGUlWVkLZZPlMUnV3at4f6SJa/Lt+rYEZEce
         P4nSl8/Mom+Jf+36farXiKxXipb6e9/4vHXFTZAVNcppXRLuljKUiJDj9yOAYbGvMlZf
         Y6XsFb2wzspJQcQtZB6RaCPiUjYCrWHz3rLPys9ujB4bTeaQnw7dqY8P9muf4eNqY9ip
         fGS/1h0x+XFSOw4oL5epqG7FU4pDk24gDpQpZpMfOs2yncD+AGEkXcuv4dvo5uRhUt/B
         nzxw==
X-Gm-Message-State: AOJu0Yxg8LOdjN5OOi8BGYt53suTMqXJNCddTInDYW4ozbh3l3NrcbiE
        qw7GnzMI9EPFYpb3+/n9h2Ix/xclCxO6kQ==
X-Google-Smtp-Source: AGHT+IEOcTom9tweoAP+y77kR6tl8Amf9XD/yvFfBaWffDT3ZRCXYEu2FIqUziDrgTgUDeWSl3FLtQ==
X-Received: by 2002:a25:e0ce:0:b0:d0a:fa7f:2fbf with SMTP id x197-20020a25e0ce000000b00d0afa7f2fbfmr12977991ybg.48.1695126541470;
        Tue, 19 Sep 2023 05:29:01 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v20-20020a25ab94000000b00d7360e0b240sm2839175ybi.31.2023.09.19.05.29.01
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:29:01 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8168d08bebso5412223276.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:29:01 -0700 (PDT)
X-Received: by 2002:a25:2fd3:0:b0:d78:15ab:58d3 with SMTP id
 v202-20020a252fd3000000b00d7815ab58d3mr11460820ybv.0.1695126541079; Tue, 19
 Sep 2023 05:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <6e1e1555ab25ef9b2c71ad03ea061e9f0821d85c.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <6e1e1555ab25ef9b2c71ad03ea061e9f0821d85c.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:28:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpsC8kO4ymT6MUHHW1a-QVKe4J0z6jdc4Wd69yXbqvZw@mail.gmail.com>
Message-ID: <CAMuHMdVpsC8kO4ymT6MUHHW1a-QVKe4J0z6jdc4Wd69yXbqvZw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/30] arch/sh: Add dtbs target support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
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

Until here, everything is fine.

> +dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += landisk.dtb
> +dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += rts7751r2dplus.dtb
> +dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += usl-5p.dtb

These DTS files do not exist yet.
Please update the Makefile in each patch that adds a new DTS file.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
