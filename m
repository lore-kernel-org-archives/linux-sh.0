Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47092CA0FE6
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 13:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjIANc0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjIANcZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 09:32:25 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32131CDD
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 06:32:22 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-58fae4a5285so21004547b3.0
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575141; x=1694179941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCRjcs+znTgLj1c7GLs4q0qWG1/wafkOXYHtiDy7J2w=;
        b=KlncmCcQWvQ5Cotxbuw7TDwSdSzw+iJ+365Ybid3ac7Yr8b8cHtD5LGxN0rOjWexhe
         rQpN3d2Vgc7RisAWR0sFYspXl922C1stJLESzbNaAJfekqApuXPL7R2gpVVxJ2iQj6O+
         pNJ/qsRLmNgsTwj8GOZsl6eus/ldAXo59FWSyMgrThrJ7khi8/lB+CvSFxxDseDsunY1
         U7aQnuKjWMA/3A8e+VuxYXho+d8JssYFxV8E5u+5HZRB3yjGwXbA45HEPs6zuEmXhy56
         p+xuS0+rlq88WSmP4s+hK0UylFKT8oHkyVtU0Cz4O6qVx64TScg8Z8yzD+T67C8U57PG
         Qq4Q==
X-Gm-Message-State: AOJu0YwwjbrsUrCzuqqR1CwXpGtppX8lSUUk/IJVGZ4BJjJ/+x0acBsR
        jj8EThBbV9JBxXgoOipyD1GDR/KwwZSRdA==
X-Google-Smtp-Source: AGHT+IFotXr22ihPC3PBeHbbSBeUP3c5Fo5csZCr4VrYrZ4mrIAcgfyup0Xn8hbESGsPwX2zV/lx6A==
X-Received: by 2002:a81:8641:0:b0:583:e958:39c6 with SMTP id w62-20020a818641000000b00583e95839c6mr2500974ywf.34.1693575141207;
        Fri, 01 Sep 2023 06:32:21 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id p21-20020a0de615000000b00586a09026casm1068354ywe.34.2023.09.01.06.32.21
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:32:21 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58d9ba95c78so20820327b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:32:21 -0700 (PDT)
X-Received: by 2002:a25:c709:0:b0:d78:3abc:ec73 with SMTP id
 w9-20020a25c709000000b00d783abcec73mr2918203ybe.6.1693575140748; Fri, 01 Sep
 2023 06:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693384846.git.ysato@users.sourceforge.jp>
 <1a7d32f58935aee952750a088702f7f2798972d8.1693384846.git.ysato@users.sourceforge.jp>
 <CAMuHMdUkVAqdG3yf90mEFpppsWmvzO8UsaOL1NR2705yD+JJuQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUkVAqdG3yf90mEFpppsWmvzO8UsaOL1NR2705yD+JJuQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 15:32:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUurVUpEjrR4X2m6cyg4zudMGdtk4b3=vKbF6YzMUtZ+A@mail.gmail.com>
Message-ID: <CAMuHMdUurVUpEjrR4X2m6cyg4zudMGdtk4b3=vKbF6YzMUtZ+A@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] sh: target dts.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 6:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Aug 30, 2023 at 8:53 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > --- /dev/null
> > +++ b/arch/sh/boot/dts/landisk.dts
> > @@ -0,0 +1,142 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree source for IO DATA DEVICE LANDISK
> > + *
> > + * Copyright 2023 Yoshinori Sato
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/sh_intc.h>
>
> You forgot to post commit d00349bf840505a0 ("sh: SH-INTC helper files")
> in ysato/sh-of-wip.

And that one needs:

--- a/include/dt-bindings/interrupt-controller/sh_intc.h
+++ b/include/dt-bindings/interrupt-controller/sh_intc.h
@@ -1,2 +1,2 @@
-#define evt2irq(evt)           (((evt) >> 5) - 16)
-#define irq2evt(irq)           (((irq) + 16) << 5)
+#define evt2irq(evt)           (((evt) >> 5))
+#define irq2evt(irq)           (((irq)) << 5)

Cfr. commit a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4") in v6.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
