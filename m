Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C0E7849A
	for <linux-sh@archiver.kernel.org>; Mon,  2 Oct 2023 13:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjJBNwH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjJBNwG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 2 Oct 2023 09:52:06 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80221B4
        for <linux-sh@vger.kernel.org>; Mon,  2 Oct 2023 06:52:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59e88a28b98so39782757b3.1
        for <linux-sh@vger.kernel.org>; Mon, 02 Oct 2023 06:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696254722; x=1696859522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP/IZEmrTGPvdwMje0U6Oy8tm2j5pOA+lCgKxWgG3jM=;
        b=GtD3d2DLQtY8+UiIBLp2HkYIydnJRO3GT7zRoEzcy8lLzpjx1Wc5PZuDheH5IWaPf7
         ih6bWGa9L55McEHn+W6y+0AcfkhOW3ZB0+VdyA5P5HEbQ3XkFYgSRQ4qVmuokxeLHY8i
         RRnyGGLNB2vLHkQTiAau+rt7snf2NMqfUfM9fvfikuRNUHyjmXQy0aUypC+raQdEHiTg
         fsHnyQoog2f0EZede2MJLfSCaKBb5nNK//x8XkjA1BNVpZCLJaPxoQaXnRGTO221Cu1b
         sko/GiuPzn5oDLjq0Tv2hnuH2MfQuG4/x84Lhjbtes9kobm7dUm8LJxX63Yt6i2hB3jN
         tG0A==
X-Gm-Message-State: AOJu0YznOzjZSuzazXgV35jajCBnT9qhLCbDzwG8qKw6gDAZPpr50PR7
        SHpmna6mJhhP7jx6V5eW80vrAamPuMXfjA==
X-Google-Smtp-Source: AGHT+IE2Gw+BWw1wvbTYAoOuEsc312vJ/PioS8embtI/PCAmxuDS7R9XC7R6zjiA/CCLYRhUPYJJOg==
X-Received: by 2002:a81:6d05:0:b0:589:e815:8d71 with SMTP id i5-20020a816d05000000b00589e8158d71mr11509167ywc.11.1696254722467;
        Mon, 02 Oct 2023 06:52:02 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id cn32-20020a05690c0d2000b005927a79333esm5543987ywb.28.2023.10.02.06.52.02
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 06:52:02 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59f6492b415so39903547b3.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Oct 2023 06:52:02 -0700 (PDT)
X-Received: by 2002:a0d:ca82:0:b0:59b:e1db:6c5b with SMTP id
 m124-20020a0dca82000000b0059be1db6c5bmr14163176ywd.13.1696254722067; Mon, 02
 Oct 2023 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
 <CAMuHMdUUEhev1F40FhiJyCENvca9YTx_hv1gT_DTXyVMCKjU8g@mail.gmail.com> <87bkdhtb0v.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87bkdhtb0v.wl-ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Oct 2023 15:51:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-cxEghFTL8QALkSuWkSU1MdBxRk+p9=C8Q1z3XA2GCQ@mail.gmail.com>
Message-ID: <CAMuHMdU-cxEghFTL8QALkSuWkSU1MdBxRk+p9=C8Q1z3XA2GCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 26/30] arch/sh: RTS7751R2D Plus DeviceTree.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Mon, Oct 2, 2023 at 3:22 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Tue, 19 Sep 2023 22:25:19 +0900,
> Geert Uytterhoeven wrote:
> > On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/arch/sh/boot/dts/rts7751r2dplus.dts
> > > @@ -0,0 +1,124 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Device Tree Source for the Renesas RTS7751R2D Plus
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sh7751.dtsi"
> >
> > #include "sh7751r.dtsi"?
> >
> > To make that work, you can create "sh7751.dtsi" that includes
> > "sh7751.dtsi" and overrides the parts that are different.
>
> The only difference between 7751 and 7751R is CPG,
> so I don't differentiate between them.
>
> Shall we write the CPG differences in sh7751r.dtsi?

Yes please.
That way the .dts board file for a board with SH7751 can include sh7751.dtsi,
and the .dts board file for a board with SH7751R can include sh7751r.dtsi.
All common parts should be put in sh7751.dtsi, to avoid duplication.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
