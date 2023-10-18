Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5544ECDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjJRNuQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjJRNuP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 09:50:15 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B583;
        Wed, 18 Oct 2023 06:50:10 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7db1f864bso81487187b3.3;
        Wed, 18 Oct 2023 06:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637009; x=1698241809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xK9RfUzKYO3igl+qYfqRgLxv0TmNUU4m39Yeu7GndI=;
        b=tZWoOO6M0wyGWVE19yVkQ68eX2I3dtf6h0yqWQmmH1noR5A/2bOqHVBceHu8v6exst
         8SceBKYFR3qcnbWRjQ8HoEGNF+qpNWYWKD89/CjRife6GuL7u5qF3o5oNafwF1yjBSF1
         /Zcybr9gyGQZptpRtkqOltuQk1Osy2KM9L1nIJ+/cfkmsvnUGLMpiohx56d8oikIFMqW
         2FXEtt+uD4aCWT6o1+N/th+75BrFl0NArAUqjx8GMDG+RIdpYzdVB/O2vK9kHy1+Ms2z
         uAjEpVpIdOhpJFtuzAE2inMPLhkcmYxRcBL9TupIgb6pojqHv0eyZSQYOQmkNUr8FPS1
         TiDA==
X-Gm-Message-State: AOJu0YzvdlI+rW0BdMH68E6fz0spUBYoVgJtQXVJrBENeSZONLyb52jX
        4luQk0RNUhWpcyA/nMurtzbI+7fjlKyEcQ==
X-Google-Smtp-Source: AGHT+IFJ72LAMCcMCUMVmJm+nn16khsu3nYajsmn7ZudXc9mavCJgkqTLDRPEVg/qlRfXbCRoeA2IA==
X-Received: by 2002:a81:7b85:0:b0:5a1:d398:2e with SMTP id w127-20020a817b85000000b005a1d398002emr5826514ywc.37.1697637009201;
        Wed, 18 Oct 2023 06:50:09 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id h81-20020a815354000000b0059a34cfa2a8sm1504888ywb.62.2023.10.18.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:50:08 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7c93507d5so81470907b3.2;
        Wed, 18 Oct 2023 06:50:08 -0700 (PDT)
X-Received: by 2002:a81:4917:0:b0:5a7:d016:bffa with SMTP id
 w23-20020a814917000000b005a7d016bffamr5333912ywa.8.1697637008052; Wed, 18 Oct
 2023 06:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <953cf1cef945a7081734ebc5304e3820214dca35.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <953cf1cef945a7081734ebc5304e3820214dca35.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 15:49:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrLi9-pyNrv9WviZ7zNtcvfjr-qa0m2e4=2Jqv8QZtrQ@mail.gmail.com>
Message-ID: <CAMuHMdWrLi9-pyNrv9WviZ7zNtcvfjr-qa0m2e4=2Jqv8QZtrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/35] include/dt-bindings/clock/sh7750.h:
 cpg-sh7750 binding header.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7750 CPG driver binding definition.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/include/dt-bindings/clock/sh7750.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_SH7750_H__
> +#define __DT_BINDINGS_CLOCK_SH7750_H__
> +
> +#define SH7750_CPG_PLLOUT      0
> +
> +#define SH7750_CPG_FCK         1
> +#define SH7750_CPG_BCK         2
> +#define SH7750_CPG_ICK         3
> +
> +#define SH7750_CPG_SCI_CLK     4
> +#define SH7750_CPG_RTC_CLK     5
> +#define SH7750_CPG_TMU012_CLK  6
> +#define SH7750_CPG_SCIF_CLK    7
> +#define SH7750_CPG_DMAC_CLK    8
> +#define SH7750_CPG_UBC_CLK     9
> +#define SH7750_CPG_SQ_CLK      10

The above 7 clocks are not CPG core clocks, but part of the Power-Down
Modes block.  The documentation calls them MSTPx (Module Stop).

So I'd go for SH7750_MSTP_SCI_CLK etc.
And perhaps drop the "_CLK" suffix?

> +#define SH7750_CPG_INTC_CLK    11
> +#define SH7750_CPG_TMU34_CLK   12
> +#define SH7750_CPG_PCIC_CLK    13

Similarly, but the documentation calls these CSTPx (Clock Stop).
So I'd go for SH7750_CSTP_INTC_CLK etc.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
