Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4341C77B73
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 11:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjDSLxV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 07:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjDSLxU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 07:53:20 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A5BC670
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 04:53:19 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-555e170df98so8164977b3.10
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 04:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905198; x=1684497198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqBJefBTOjKtPx3VpN4srRDkOTFXUacO/QdHki9qfXg=;
        b=kzwDjKLTxct+D/MUUAk6HPhkRyFHQc1iR2/O0R951ffP5iD4T1+YFY26W0Q6ZwIGzK
         H/KwQst57UwKKs1gjMU4DxpbXje2CHDr6eOCPGOwQlrXuAIEDYEL0jFejjTO4hbfWDYb
         FxOtTIyfs4mx+Ey9WO/heVqPNyLk2UlkMd6impKanu1M9WS1s5eJtnCJyugwzsI2EkvL
         uwZKrX9DIrmiIZL5nFTSVbkFb6L/uFzrONJrY7OECRCkBdbaVVdQhbJUEBJr7VodhZn+
         xdxX9TA4Lgj6Ht+heQYqTUs3U9sdOd7snIdiRWFZEwJMMImnGCSKx2fs3B0630v8z3uF
         OGFw==
X-Gm-Message-State: AAQBX9fj+6LwIHq9mXDYGoRR02oWaRuOCjBCwLYTti4i2EZu9pC+j1Ri
        aaUkKNUFPC5DQxHFLkmpkl2TGhdxz7U0X0/v
X-Google-Smtp-Source: AKy350YjLTgaoPevdEwXCcBPJfKfuI5k4B/OdRxV2fbIOcmHaBls50NslUWSt1SeHfnwKjRBxB27WA==
X-Received: by 2002:a81:9903:0:b0:52e:ff80:3287 with SMTP id q3-20020a819903000000b0052eff803287mr2008675ywg.9.1681905196962;
        Wed, 19 Apr 2023 04:53:16 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id cs2-20020a05690c0ec200b00545a08184a7sm4469423ywb.55.2023.04.19.04.53.16
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:53:16 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54fe82d8bf5so182928517b3.3
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 04:53:16 -0700 (PDT)
X-Received: by 2002:a81:e16:0:b0:552:a4af:da with SMTP id 22-20020a810e16000000b00552a4af00damr2170546ywo.10.1681905196090;
 Wed, 19 Apr 2023 04:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net> <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net> <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
 <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net> <b6ba777419f0d94c5f39cfc4698e2dd4f7319e16.camel@physik.fu-berlin.de>
 <b42c6496ffb531459eb7995fd4b5e828f599b4fe.camel@physik.fu-berlin.de>
In-Reply-To: <b42c6496ffb531459eb7995fd4b5e828f599b4fe.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Apr 2023 13:53:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoH+V4hL_D=4YuoBFq3MYm==X1if3mXyAZdWy5un+Ufw@mail.gmail.com>
Message-ID: <CAMuHMdVoH+V4hL_D=4YuoBFq3MYm==X1if3mXyAZdWy5un+Ufw@mail.gmail.com>
Subject: Re: [PATCH] Fix J-core aic warning spam
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Apr 19, 2023 at 12:25 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> I just wanted to perform a test build of the J2 kernel, but I'm getting lots of error messages
> from the assembler about unknown opcodes when trying to build j2_defconfig.

Looks like upstream gcc does not support -mj2, and thus the build fails
with "unknown opcode" due to the use of "cas.l".
Disabling CONFIG_SMP in j2_defconfig fixes/works around that.

Just checked with Arnd on IRC, who says opcodes/sh-opc.h was last updated
in a meaningful way back in 2005...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
