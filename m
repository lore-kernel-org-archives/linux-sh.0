Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B6BCDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 13:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjJRNEB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 09:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjJRNDy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 09:03:54 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5712610E
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 06:03:52 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7c7262d5eso85492457b3.1
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 06:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634231; x=1698239031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdycpuLVrzszrN21dw+67+yQgNGaoncSefGig6LAy40=;
        b=g6gceSXwOw4aRWL85OLD9M4tACTo3qZUXcPcQAGvEm9o8WIFDjjV5+/wXlRpMWZ4pV
         W7F6OmcwwvfKycgmFg41ictvo+x5loaM7fXoDYXIpFVUceaNpfjHnuGuZ4ouArhe1jTy
         o/ZlV8NLmgW/FT5hWVUZzVQyfDsiiOggfoA/X3Wex7aDPBEqvNbPKTj289TZmkv5zh+7
         OrPiMHGhKqxxo+C4nJ7uDRa/7JYebiNQO1NGnbUiQAz7bC+ceXxDBMOespIiTHtzPwgt
         loHHEwkPJeFpaF1aspvgZ+Y7w3JD5FlnNwAIFy+1LjUmkfbkyWPDa+wB6TlKxJ+IMMeP
         rg3g==
X-Gm-Message-State: AOJu0Yzf7aq+3iNCK7BtJdzvFoZ29gg7T9AdjyeBYdDIry9kMB4HfCaI
        Jk5INcs54m6qzgHaPZUQZGqJQggGlx/FlQ==
X-Google-Smtp-Source: AGHT+IE3SgfQBErGO4bwC7P7HogF+bDX9Iva9FO4gsO/lq5Yq3RcFTvwbTjBqG8B7W2La/V5U3G2SQ==
X-Received: by 2002:a5b:647:0:b0:d9b:4b94:adf5 with SMTP id o7-20020a5b0647000000b00d9b4b94adf5mr5265376ybq.14.1697634231134;
        Wed, 18 Oct 2023 06:03:51 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id e129-20020a255087000000b00d81479172f8sm1283689ybb.5.2023.10.18.06.03.50
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:03:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a87ac9d245so40674317b3.3
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 06:03:50 -0700 (PDT)
X-Received: by 2002:a0d:e84a:0:b0:577:3d46:f90e with SMTP id
 r71-20020a0de84a000000b005773d46f90emr5588526ywe.32.1697634230733; Wed, 18
 Oct 2023 06:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231018124023.2927710-1-geert+renesas@glider.be> <6fdd4de08a97060b952e0bfa4dd3144d9c23e800.camel@physik.fu-berlin.de>
In-Reply-To: <6fdd4de08a97060b952e0bfa4dd3144d9c23e800.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 15:03:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV39vcBSjxHo6+d82jgZHyLnCdoKjT6-jW4QsD8MZ4dpA@mail.gmail.com>
Message-ID: <CAMuHMdV39vcBSjxHo6+d82jgZHyLnCdoKjT6-jW4QsD8MZ4dpA@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/sh4/sh7750: Add STBCR/STBCR2 register support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Adrian,

On Wed, Oct 18, 2023 at 2:46 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2023-10-18 at 14:40 +0200, Geert Uytterhoeven wrote:
> > The new Linux SH7750 clock driver uses the registers for power-down
> > mode control, causing a crash:
> >
> >     byte read to SH7750_STBCR_A7 (0x000000001fc00004) not supported
> >     Aborted (core dumped)
> >
> > Fix this by adding support for the Standby Control Registers STBCR and
> > STBCR2.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is this supposed to be applied on top of Yoshinori's DT conversion series?

No, it's a patch for QEMU.  Sorry for the confusion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
