Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8242CDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 08:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJRIXt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJRIXs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 04:23:48 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA3C6
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:23:46 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a84204e7aeso50030377b3.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617426; x=1698222226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwIlXUP+DJu4CTXfdNqKhYDl5JSh1iK96ENGaYDnae0=;
        b=aQ/11cPvydH6sN4YWUnMLAwrdkUGZrahZNwjGA4U+/b7DlFLG/z72wrO1V7QcOvbEr
         bLdAI8ze9zZv+WsmtezfKjswnhhqRNv34QmAgBhI3L8fdTvKB/SGYH14qJAcxm1F1tRl
         gAvjLqKIsHQNo+My/rvY3qemFWPCJdQpSQ7xb/6l8cYDVxpbyAxI4n5ohQJN/gS7NA3t
         P/PIer99zOPmXMkqI+VNalMM8G0nXdiiv475DpS0RDCOD6sxcMYSCEkECTI2cNsTAiFe
         Ca/y1vTYsXxJ9QNW3IjElp6bMAEdTAiubUFwR1G5L/BSjVv8Xuu6dcVjKj0l6DreJbww
         YZ8A==
X-Gm-Message-State: AOJu0YxzNIR4WyPKmyM7USWHvi4XFO1TkX8Yz37BZCDVQN+AX+P/bTnC
        UigapYJ62JapLmuvd6DTEZ+PKuwtvURShA==
X-Google-Smtp-Source: AGHT+IFIKpK9kctzWyKB5yKMkQEjPmbeR8Yf3w6s4ElTq1PcWjuBro+SQMOIHK98EVmGttAeX37inw==
X-Received: by 2002:a05:690c:f0b:b0:5a7:e125:478c with SMTP id dc11-20020a05690c0f0b00b005a7e125478cmr6064002ywb.42.1697617426007;
        Wed, 18 Oct 2023 01:23:46 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u133-20020a81848b000000b005a7a92a62besm1310366ywf.8.2023.10.18.01.23.45
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:23:45 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7c93507d5so78084897b3.2
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 01:23:45 -0700 (PDT)
X-Received: by 2002:a81:7282:0:b0:577:189b:ad4 with SMTP id
 n124-20020a817282000000b00577189b0ad4mr5270052ywc.48.1697617425440; Wed, 18
 Oct 2023 01:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <d9f9ca66b43371ce8cf80faffdfcdf593c9563ac.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <d9f9ca66b43371ce8cf80faffdfcdf593c9563ac.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 10:23:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-+XxsZTtos+SMRd+--He3AsQCobiGCc5FHeuwv2XnoQ@mail.gmail.com>
Message-ID: <CAMuHMdW-+XxsZTtos+SMRd+--He3AsQCobiGCc5FHeuwv2XnoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 18/35] drivers/tty/serial: sh-sci.c fix SH4 OF support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - fix earlycon name.

Note that to use earlycon, you currently need to enable EXPERT.
So I propose to fix that using:

--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -658,7 +658,7 @@ config SERIAL_SH_SCI_EARLYCON
        depends on SERIAL_SH_SCI=y
        select SERIAL_CORE_CONSOLE
        select SERIAL_EARLYCON
-       default ARCH_RENESAS
+       default ARCH_RENESAS || SUPERH

 config SERIAL_SH_SCI_DMA
        bool "DMA support" if EXPERT

> - fix earlyprintk hung (NULL pointer reference).

How do you actually use earlyprintk, as SH lacks the EARLY_PRINTK
config symbol?

Looks like tglx missed that when creating commit d0380e6c3c0f6edb
("early_printk: consolidate random copies of identical code").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
