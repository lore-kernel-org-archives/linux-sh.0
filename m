Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAC3C4743C
	for <linux-sh@archiver.kernel.org>; Wed, 23 Jun 2021 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FCB61026
	for <linux-sh@archiver.kernel.org>; Wed, 23 Jun 2021 13:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWNi1 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 23 Jun 2021 09:38:27 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:33454 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFWNi1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 23 Jun 2021 09:38:27 -0400
Received: by mail-vk1-f173.google.com with SMTP id f2so520408vkc.0;
        Wed, 23 Jun 2021 06:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRwGVTRnG0zW3NttzH7gOF+9Sju3wYweP6tlvzlLQAw=;
        b=KDaQcY78z4L9VpJw7FO1bRFDdNaz4oCnrQbL4GjPG3Rp8In3UDSt7ETYrTaufKu9Qh
         a8lRxP3TGMBaMh7Fh3TaLhNlXR+pp2usB9pMGN8z7fbeGSC6hnJUHF1Hv52Q4XK41nsQ
         PPjp0yNQhwCRZc4X3/ZvCw/flZygulbgyvASgKp/MhJ14dIBwGlR8ZHffzTt/lmg/f+t
         WJn5QFpy7b0RBLIXQ/kQjpeoEyGUxK4Kj1jU0w7Ey8/5LBoJ4B3Uol6dpyRBlskUzbnA
         xDZPP7tT+81sGZx68/QAcCLDjW6y3Su6ASXDw8dzOmOElMnWxyOEITDm3gu51fFU6N7N
         xSUA==
X-Gm-Message-State: AOAM532Jf5CA8gGoWj3oypcL/fpwSL2OzJKQn0chA+RY0/OxkMuMJCDe
        gYj+puYQTZeW+p4Je0U8vWd62oy7is9LxeJtsTGkHUBBDaE=
X-Google-Smtp-Source: ABdhPJx4nCb36+ndIPmUN591CUcdm1WQ2GBX3PfSOPNz/3zIgcTQud2Oanma2GZ9hqCdlPH4vE12pCCf+AykNT6UF18=
X-Received: by 2002:ac5:cf08:: with SMTP id y8mr24080869vke.2.1624455368505;
 Wed, 23 Jun 2021 06:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de>
In-Reply-To: <20210623133205.GA28589@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Jun 2021 15:35:57 +0200
Message-ID: <CAMuHMdVXN3NGyLqJKNwTOEGSQTm1PahMGBmLLH5yhEEnPiD=EQ@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Christoph,

On Wed, Jun 23, 2021 at 3:33 PM Christoph Hellwig <hch@lst.de> wrote:
> I have a vague recollection that you were planning on dropping support
> for non-devicetree platforms, is that still the case?

There are no devicetree SuperH platforms upstream, only J2, so that
means dropping support for all SuperH platforms?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
