Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A2EC77B7F
	for <linux-sh@archiver.kernel.org>; Thu, 11 May 2023 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjEKOgc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 11 May 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbjEKOgQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 11 May 2023 10:36:16 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552B106D3;
        Thu, 11 May 2023 07:35:35 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55c939fb24dso81108037b3.2;
        Thu, 11 May 2023 07:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815734; x=1686407734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuNMFCCjBGiRepfEIV/kIi3+pDm4ryspV/CKvccFj/c=;
        b=A9h6pBfQVLkxeZ49T1NCNBgmT73VLkPkLC4+DxjgTlgofNzRABS7jTQ6mly3ue0hn0
         iR9XYeosBM9DZx2rMPul+AJqt2w6mJu/sle/9iJzWEvhwqIq+a9hZ+8vfR2w6qrtHLuz
         YXbd2T6JhjdH5I0Z8BhOCLCi5RcfmxU9eh6PkFk33gJ7fiBHvWRvteU7MZW6K3LNHuAT
         tDa1WL63Ihvn5Pp0zPAJDK9CIPb+9ha5017UmfiB3HJBX/IdBuyJBwHj06/EtAcG4Qlo
         GYa8RsdV08ZKF95GGF2Dndl5jF7k7cHC/zsLKlaO9DHwr77P+z2RT4tc0deAfqnwqp4h
         hjPw==
X-Gm-Message-State: AC+VfDzBf6GRyzKNZlzOoo0VuLQGO7xizHuGwdX9c60yVqcajY9aFRav
        2pEe8zJriIYeKEnOw4EIDfzG/qOWP15B7g==
X-Google-Smtp-Source: ACHHUZ6/C8pDovpD7gt6Gs1M2dYlDqlXiWHvDCgzxLsa2kwyqTH6w3Qt5/xioq9wI19aFyDfY0E2lg==
X-Received: by 2002:a0d:ddd7:0:b0:55a:4bd3:f73b with SMTP id g206-20020a0dddd7000000b0055a4bd3f73bmr24081601ywe.10.1683815734332;
        Thu, 11 May 2023 07:35:34 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id c74-20020a814e4d000000b00552f7767803sm4943160ywb.58.2023.05.11.07.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:35:34 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-55a8019379fso81280627b3.0;
        Thu, 11 May 2023 07:35:33 -0700 (PDT)
X-Received: by 2002:a0d:d90f:0:b0:55a:aeb7:2b0a with SMTP id
 b15-20020a0dd90f000000b0055aaeb72b0amr21601241ywe.23.1683815733695; Thu, 11
 May 2023 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 16:35:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmtfCir4dt6CKe2YxDN53nNAcE=i5oyMkOsPavJ-p0Tw@mail.gmail.com>
Message-ID: <CAMuHMdXmtfCir4dt6CKe2YxDN53nNAcE=i5oyMkOsPavJ-p0Tw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Adrian,

On Wed, May 10, 2023 at 6:36 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> The initialization function for the J-Core AIC aic_irq_of_init() is
> currently missing the call to irq_alloc_descs() which allocates and
> initializes all the IRQ descriptors. Add missing function call and
> return the error code from irq_alloc_descs() in case the allocation
> fails.
>
> Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for your patch!

I am not an IRQ expert, so I'd like to leave the technical parts for
e.g. Marc.  But I think you should add to the description that this
is based on a patch by Rich.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
