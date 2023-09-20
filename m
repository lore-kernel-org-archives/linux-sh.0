Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4532CE79D1
	for <linux-sh@archiver.kernel.org>; Wed, 20 Sep 2023 12:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjITMa5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjITMaz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 20 Sep 2023 08:30:55 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D409CA
        for <linux-sh@vger.kernel.org>; Wed, 20 Sep 2023 05:30:45 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59ea6064e2eso34004827b3.2
        for <linux-sh@vger.kernel.org>; Wed, 20 Sep 2023 05:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213044; x=1695817844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpTLSwPU8tJNr8pyka6hDeGcM6izaFtpSb6acg1fy74=;
        b=ThBNEt6bIZwzmGfMDkIDI+SPMzDVTR44GDepGc7OliFkakgyXkOVvT+o49sxD2VZd3
         z/p4XiGhOw+IinTz7uFJ7uwNaiOlO/sC949wm+ew8Pjo73Pgil/i3tLMdC6RQh2Piznv
         +6UoWdJUStHb3QOWxMVG3fSZybwpDbMq62cDTxeMAIHQqLmOlhCKsskNtFd2yNV+pRPm
         +OqcDaLERP5fVfI45cO95sTqyDArUVSs4Sqqu+YqksqSGSVV0RCi3Hjc2X0SBFioWuEs
         VOXuHeFVY10A1QOWUuYOLNHmITTfAdIDE4pj43gHN4fYdIrrnYxeNwyD8yvE9TBwNuSN
         fdBQ==
X-Gm-Message-State: AOJu0YxEigGRL7LhvKCE2B1amsZvp3ALpVsaOe9zQV5rA/qpTsdGezzA
        dXiiOtEBY0kuUzb3bLMMr6obNqA9AVJ3wg==
X-Google-Smtp-Source: AGHT+IEaBC/GFpVRjJeW/3qvR1GJYI9kUNsZ5XVWtbByWLOQZYuuF31SfOL9p7Wi2ajZTM5vPQ4xRQ==
X-Received: by 2002:a0d:dfd8:0:b0:59a:b7b2:5f02 with SMTP id i207-20020a0ddfd8000000b0059ab7b25f02mr2332805ywe.18.1695213044654;
        Wed, 20 Sep 2023 05:30:44 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v185-20020a0dd3c2000000b00592548b2c47sm3763353ywd.80.2023.09.20.05.30.44
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:30:44 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59bcd927b45so71650847b3.1
        for <linux-sh@vger.kernel.org>; Wed, 20 Sep 2023 05:30:44 -0700 (PDT)
X-Received: by 2002:a81:a041:0:b0:59a:fa28:2b98 with SMTP id
 x62-20020a81a041000000b0059afa282b98mr2370163ywg.17.1695213044081; Wed, 20
 Sep 2023 05:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
 <cabf9417-e264-fb23-ddd4-24f51f7e72a2@kernel.org> <CAMuHMdWeh2DjSR9-WdDUKJhG_KwDhjUk_e-H3D_gSzVZ16ys9g@mail.gmail.com>
 <25da64c6-cdb2-7758-71d3-fa8ae65de504@kernel.org>
In-Reply-To: <25da64c6-cdb2-7758-71d3-fa8ae65de504@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Sep 2023 14:30:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX12e43Yax3GPxhE65mtDiaPfhwDd55DMbahcr=TXObOQ@mail.gmail.com>
Message-ID: <CAMuHMdX12e43Yax3GPxhE65mtDiaPfhwDd55DMbahcr=TXObOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 25/30] include/dt-bindings: Add sh_intc IRQ - EVT
 conversion helper
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Krzysztof,

On Wed, Sep 20, 2023 at 1:51 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 19/09/2023 15:02, Geert Uytterhoeven wrote:
> > On Wed, Sep 13, 2023 at 12:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 13/09/2023 11:23, Yoshinori Sato wrote:
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
> >>> @@ -0,0 +1,7 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> + *
> >>> + * SH3/4 INTC EVT - IRQ conversion
> >>> + */
> >>> +
> >>> +#define evt2irq(evt)         ((evt) >> 5)
> >>> +#define irq2evt(irq)         ((irq) << 5)
> >>
> >> No, that's not a binding. Drop entire file.
> >
> > The issue is that the hardware documentation does not list interrupt
> > numbers, but event codes.  The latter is a sparse address space.
> > As the "interrupts" property needs interrupt numbers, we have two
> > options:
> >   1. Use hardcoded event codes and evt2irq() in DTS files.
> >      This is the approach Sato-san took,
> >   2. Use hardcoded interrupt numbers in DTS files.
> >      This would avoids the need for the evt2irq() macro in the DT bindings,
> >      but would make life slightly harder for the DTS writer and
> >      for the casual reader, as the conversion needs to be done in
> >      one's head.
> >
> > Note that the documentation for later SoCs that contain both a SuperH
> > and an ARM CPU core, usually lists both the event code and the interrupt
> > number, although the latter may be offset by 32 due to the SPI
> > interrupt base.
> >
> > I agree we do not need irq2evt() in DTS, though.
>
> Is the macro used by the drivers? I have a feeling that not, so it would
> not be suitable for the bindings, but rather as a header included in the
> DTS.

You mean irq2evt()? No, the new DT-aware drivers avoid the conversion
from IRQ numbers to events codes by storing evt2irq() values in the
interrupt table (see drivers/irqchip/irq-renesas-sh7751.c:iprmaps[]).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
