Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A328CD5BB8
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 13:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjISNC7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjISNC4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 09:02:56 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CEF9
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:02:50 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59c0b9ad491so40524367b3.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128569; x=1695733369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVJ924+eZdz+ptMjjsePmlhy6BWyXyHDaTel0hPAIe0=;
        b=E6imM5/Ci0bgtP1fOUL9BqitTuzYuDD4JoRFO+hzjVZkztLf41jMBEsGTHBUPL9fzd
         +4lU4Tj8hwNcu/bGqFxLubCfj8Q9y+LymQDew5DT5pOnKIKahq09YJy5qWua7dhWY3iv
         beSgn6Plf+bLchoMAP2WvC7Ix5fwgsxcjhxXNHbFrV+yB+fL2Djr2ZIRmO0ao/dITKi2
         3aD8SFR5lUfENaQuxwl8955kSwQABCIbK/rId+Rj2H1DQHRp5AIAYotDqcWYpM+eTksH
         nFC1f0tg8eq1m8ABOukAAfmp/D4m8R09VOnl2IcavfUDAtyW2sSvGzBzSViW4ft6ms6O
         4Guw==
X-Gm-Message-State: AOJu0YxtDE5JBpB3HgJ4IO2wAeFMUC+ZFgKQn8KsgZz+jURJsm26+cUx
        Dsw2Z0kRQNG1B2AFc0tNUmzc9tb+m+5sMw==
X-Google-Smtp-Source: AGHT+IHr6BxP2bkf9DFdDNpT895pdIFqFWPKQ3sYOo6hG5JMbnSr/lQY3R6m1imTshyBKPWZhYAcOQ==
X-Received: by 2002:a81:4948:0:b0:586:cf7:2207 with SMTP id w69-20020a814948000000b005860cf72207mr12661698ywa.14.1695128568954;
        Tue, 19 Sep 2023 06:02:48 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id f4-20020a0ddc04000000b005869ca8da8esm3137036ywe.146.2023.09.19.06.02.48
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 06:02:48 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59c2ca01f27so32540807b3.2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:02:48 -0700 (PDT)
X-Received: by 2002:a0d:d541:0:b0:59b:c4a5:f2ba with SMTP id
 x62-20020a0dd541000000b0059bc4a5f2bamr12897540ywd.9.1695128568571; Tue, 19
 Sep 2023 06:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
 <cabf9417-e264-fb23-ddd4-24f51f7e72a2@kernel.org>
In-Reply-To: <cabf9417-e264-fb23-ddd4-24f51f7e72a2@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 15:02:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeh2DjSR9-WdDUKJhG_KwDhjUk_e-H3D_gSzVZ16ys9g@mail.gmail.com>
Message-ID: <CAMuHMdWeh2DjSR9-WdDUKJhG_KwDhjUk_e-H3D_gSzVZ16ys9g@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 12:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 13/09/2023 11:23, Yoshinori Sato wrote:
> > --- /dev/null
> > +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > + *
> > + * SH3/4 INTC EVT - IRQ conversion
> > + */
> > +
> > +#define evt2irq(evt)         ((evt) >> 5)
> > +#define irq2evt(irq)         ((irq) << 5)
>
> No, that's not a binding. Drop entire file.

The issue is that the hardware documentation does not list interrupt
numbers, but event codes.  The latter is a sparse address space.
As the "interrupts" property needs interrupt numbers, we have two
options:
  1. Use hardcoded event codes and evt2irq() in DTS files.
     This is the approach Sato-san took,
  2. Use hardcoded interrupt numbers in DTS files.
     This would avoids the need for the evt2irq() macro in the DT bindings,
     but would make life slightly harder for the DTS writer and
     for the casual reader, as the conversion needs to be done in
     one's head.

Note that the documentation for later SoCs that contain both a SuperH
and an ARM CPU core, usually lists both the event code and the interrupt
number, although the latter may be offset by 32 due to the SPI
interrupt base.

I agree we do not need irq2evt() in DTS, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
