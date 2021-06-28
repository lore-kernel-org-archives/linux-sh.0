Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B6CC2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7833661CC0
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 14:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhF1OeA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 10:34:00 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:38603 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhF1Ob5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 10:31:57 -0400
Received: by mail-vs1-f51.google.com with SMTP id o7so10124625vss.5;
        Mon, 28 Jun 2021 07:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJfl2dK57KiZa2924NmaS6ccSWynT7w2dh6/tJZbRtc=;
        b=IZEuaGHeqpAZTt2Yme8ZVmDUzkUVYj0nhlLdBh9lQ+HWEUW8bFyoItR8TY5DeVMbmI
         eiJAUwatoGahUZ23iSnVBCsnwLkqwyqcQkI626+oMYGxv2jK9T7b5hRfXdmECjlbv5oW
         yQ0Jjfvnr1DUNv1srbxQL3DqjhQPfTPq1k/EnEy4NrSBXwnBuQ6BziKLbc7OG6rs7Bm9
         gRK+fEOhAcIM3bs93pAk8djueqMfxmTRUwwLAmA2PzttSv0CkIEFzXVpy3tsbUufs6wt
         4n51pGV23mZJU7sLPkKngBDO4Yh04uNvhOXLyVv6dZBOpE5M0EJYbv2sgwNR0u/ykuyd
         K+LA==
X-Gm-Message-State: AOAM5338mhsjbA4N6MURGKCjqul8w7DID2ME3C3uorkxN5PeWPZduXPC
        PUpcxmqTdUN/fk/meBL3ecS+NpJWvZajVng0ElHCosHDELKJIw==
X-Google-Smtp-Source: ABdhPJwLxmk3uBOFWBCL5M1PkiIvkNI0F6ru0t+EyWqbf43UiQg3ml/MQ2WF5uxWE6LMCi1SOdDHAsk+aVvf/IRS22E=
X-Received: by 2002:a67:770d:: with SMTP id s13mr5897612vsc.40.1624890569715;
 Mon, 28 Jun 2021 07:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de>
In-Reply-To: <20210623133205.GA28589@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 16:29:18 +0200
Message-ID: <CAMuHMdUOaRiJcO1fq3u4tgeB0aUbfn_qn7DEZtW4BC+7ECcx4Q@mail.gmail.com>
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
>
> The reason I'm asking is because all but one users of
> dma_declare_coherent_memory are in the sh platform setup code, and
> I'd really like to move towards killing this function off.

I guess you mean drivers/remoteproc/remoteproc_virtio.c?

BeagleV Starlight Beta will be adding two more in
drivers/nvdla/nvdla_gem.c.
https://github.com/esmil/linux/commit/ce5cffcc8e618604a0d442758321fc5577751c9d

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
