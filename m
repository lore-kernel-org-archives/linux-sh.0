Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE5CDB465
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 07:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJSHOs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHOr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 03:14:47 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4AAB
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 00:14:46 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a8628e54d4so4214837b3.0
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 00:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699685; x=1698304485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpvXWo/6V1i22b/w1LnolG7teO3Wcdy7rN1XpA4/nIw=;
        b=EfR7ammWJhSz/0ZNSHOw1/5pfk+2AtCHO5MPo3iUiUBbJyRLgoTB5oT3x9E7D9gYim
         9cPvpBG3axTbtoA1oKpKybdvyn8ea6+FiZabE0qWMB6uWQ0TZzmcaBG6E08vE8vbnjyq
         4NqqP5o16e2bOjvca6xhbW0hyNfhwZaXCp102a1rJvjp2W4cI53KzrM80Oepf2OzI3cr
         ZJgR02U2kiengYgr4aXR/3T2Y0130xL9FbpNPmGSIPHy2SjWKxbJx6VPxSlHTQJzgPeK
         +QoZajARn3pA9P/WXTQsx6uFCnbzhnv5EfZDOvtzQATkQHGJrBGyYT2YW+JXqLpmui60
         HcOQ==
X-Gm-Message-State: AOJu0Yxp1M2ojTthkWdd5ZoYZk1qNuUHTcuvogiLo2db8vimcQK4pu0v
        ShuswE+Tua6FMfDghz7BQDlPluF+Ku6+wQ==
X-Google-Smtp-Source: AGHT+IG0jjGvFEhrlOBLo6QY022sj78INrkgArBfeCcOCsrIqIYN9BEe1/ygee2t1bHrmKoFsBB4hg==
X-Received: by 2002:a0d:e6d3:0:b0:5a7:bde8:84a4 with SMTP id p202-20020a0de6d3000000b005a7bde884a4mr794936ywe.14.1697699685041;
        Thu, 19 Oct 2023 00:14:45 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id r1-20020a818101000000b0059b50f126fbsm2197981ywf.114.2023.10.19.00.14.44
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:14:44 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a8628e54d4so4214637b3.0
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 00:14:44 -0700 (PDT)
X-Received: by 2002:a0d:d710:0:b0:5a5:575:e944 with SMTP id
 z16-20020a0dd710000000b005a50575e944mr848560ywd.4.1697699684389; Thu, 19 Oct
 2023 00:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231018124023.2927710-1-geert+renesas@glider.be> <875y338j2c.wl-ysato@users.sourceforge.jp>
In-Reply-To: <875y338j2c.wl-ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 09:14:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7aMoaXUyvb5AHd5ZgbQ7LQhg1GF--yGRG3RZUhj6kBA@mail.gmail.com>
Message-ID: <CAMuHMdW7aMoaXUyvb5AHd5ZgbQ7LQhg1GF--yGRG3RZUhj6kBA@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/sh4/sh7750: Add STBCR/STBCR2 register support
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Oct 19, 2023 at 4:03 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Wed, 18 Oct 2023 21:40:23 +0900,
> Geert Uytterhoeven wrote:
> > The new Linux SH7750 clock driver uses the registers for power-down
> > mode control, causing a crash:
> >
> >     byte read to SH7750_STBCR_A7 (0x000000001fc00004) not supported
> >     Aborted (core dumped)
> >
> > Fix this by adding support for the Standby Control Registers STBCR and
> > STBCR2.
>
> FRQCR is also not returning the correct value, so it needs to be fixed.

I knew there would be more, hence the RFC ;-)

> Here are my changes.
> https://gitlab.com/yoshinori.sato/qemu.git
>
> It include.
> - Minimal CPG support.
> - DT support
> - Add target LANDISK.

Thank you very much!
It would be a good idea to mention this is the cover letter of your
Linux patch series, so your test audience doesn't have to fix
already-solved problems...

BTW, your commit da64d6541226a516 ("hw/sh4: sh7750.c allow access
STBCR and STBCR2.") just ignores writes, and always returns zero
when reading.  This may cause issues with Linux code relying on
clock_ops.is_enabled() to return correct data.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
