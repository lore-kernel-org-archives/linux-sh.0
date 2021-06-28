Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E180DC2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BE461C29
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 08:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhF1I7r (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:59:47 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:37789 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1I7r (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 04:59:47 -0400
Received: by mail-ua1-f48.google.com with SMTP id f34so6678076uae.4;
        Mon, 28 Jun 2021 01:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXqLoP2FXOdZG3CXN8aleAZhe9QJ9MkT7PLOdMxuHcg=;
        b=c8HKmm/yuEVID70En8VK62wzJsJrJWZMHBHBHWOrwTaADDos9QMeL6qxWT7MXmxahO
         UUpI/Su5be83X9zAcPVKKijLMazBTQRpqRZnBB0F5PLMrvjxiSbOQeTi/SGnd9rt0mCX
         /rilyxwaOfj2iT3iRTmjdRzGZ6MlQWQKm3D+bmF2kKXbJmfSv+JpwgMvo1sJzqdNFD+Z
         STUKsju9yWA2E8SGH4mXuNxdoEYSePLxAxWkeidPtqS6+qQc+OkvcsR3yAxMF7cPKqFZ
         pMwbV1XUcHhkr0lTDnxKVY2ub0BHk10d+fGtaPCxOtXvRKuRBkloPmRYxLmko4zajCTv
         s4Nw==
X-Gm-Message-State: AOAM533FA2AP3f/7ce4U+iewWwEx3kTkj1ymNUEwx8Cyz/E+QvmIQYjz
        C/yjky7RpiDGHybFLmCCfCBrMzbMARvfbUbjPqw=
X-Google-Smtp-Source: ABdhPJxIO1uSDuPU0jECuUQjwacpxDqSqoH0YnfDjNKu6msc+wOMzWK1D7PrExo6WZB0LVIl85K9DUvBjd6hYdRnnAY=
X-Received: by 2002:ab0:70b3:: with SMTP id q19mr19550415ual.2.1624870640448;
 Mon, 28 Jun 2021 01:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de> <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
 <27c78c11-b230-a5b5-6648-6b93daf6afda@physik.fu-berlin.de>
In-Reply-To: <27c78c11-b230-a5b5-6648-6b93daf6afda@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 10:57:09 +0200
Message-ID: <CAMuHMdV+SmxUtvAptYfVgy04jCHeABmsEpn3mcUfFQ_RfTF7eA@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Daniel Palmer <daniel@0x0f.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Adrian, Daniel,

On Sun, Jun 27, 2021 at 10:48 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/27/21 5:08 AM, Daniel Palmer wrote:
> > On Wed, 23 Jun 2021 at 22:32, Christoph Hellwig <hch@lst.de> wrote
> >> I have a vague recollection that you were planning on dropping support
> >> for non-devicetree platforms, is that still the case?
> >
> > Are there any SH4 boards that actually support DT?
> > I'm still using an ecovec24 board(SH7724). I'd love to use DT if
> > that's possible.
>
> There is an unmerged patch set by Yoshinori Sato that adds device tree support for SH.

But it does not include support for SH7724 yet, only for SH775[01]
(note to myself: still have to try it on my landisk).
Fortunately most core devices on SH7724 and Ecovec should already
have DT support in their drivers. The main missing pieces are
interrupt and clock support.
The SH7750 INTC seems to be a simpler derivative of the SH7724 INTC.
The SH7724 clock controller is very similar to those used on later
ARM-based SH/R-Mobile and even R-Car SoCs, so adding support for it
to the renesas-cpg-mssr.c driver framework shouldn't be that difficult.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
