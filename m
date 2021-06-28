Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC4C11F64
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDA561C8E
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 19:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhF1TPj (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:15:39 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40914 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhF1TPj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 15:15:39 -0400
Received: by mail-vs1-f54.google.com with SMTP id e26so9288289vsh.7;
        Mon, 28 Jun 2021 12:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkcjAWg2iZfJCNWSyvUR3eFiJYg/imvuPuSRT3awcqs=;
        b=sKHIhFY511F0lTDL9L6lfXhdh3rJ/EVnYpqgP7QsrJPEFZ3RovEhnonNkIE8aqxR50
         wBirT2e1j8wP5VsGQztM5FwOJ24i/8kCn9hIsmatcVhmRB6Kb0JxBIvgy7wOUzqbB28j
         swUqN4gHwVdWeQyRRb6BKKr2/0Pl3dO4OSoAgRonCWJSiiqfg05qYunXrnyx9e4wkdjG
         Hl96oqIjS99r+zIzEYykAZvL+c51kz8f/0xfifwYc7mDBoGUdS134cmJVD9l4tjShwGc
         z+nzILHv+tfM+IAK7O7KuMx6IA9UL2Pbyj1k5J4K/WHC3pQtqcI5xDzIN6OzxSOy10ww
         hdpg==
X-Gm-Message-State: AOAM533A0ZVm1GD1ljlI4r9R9wfL2lManU5/3WwThOjOEK2zUgVB04Hm
        W0WustExVkUTsFGo7wn8CrXvnqCSNzs6okMefto=
X-Google-Smtp-Source: ABdhPJxzhb7WVJl3CFD16mEMwzISZSi/yuq3DYndd8EySALZPGjkuHG+heuA13DFlvF7q6NwSTlS4/Lr3iFx5u+m81E=
X-Received: by 2002:a67:fa45:: with SMTP id j5mr7644558vsq.18.1624907591118;
 Mon, 28 Jun 2021 12:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de> <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
 <20210628133858.GA21602@lst.de> <4d6b7c35-f2fa-b476-b814-598a812770e6@landley.net>
 <20210628134955.GA22559@lst.de> <1141b20f-7cdf-1477-ef51-876226db7a37@landley.net>
 <20210628163312.GA29659@lst.de>
In-Reply-To: <20210628163312.GA29659@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 21:12:58 +0200
Message-ID: <CAMuHMdVT17ruQZKJXAahMvQQVMnJNoaSjHSuqat-CHOCV4hVaA@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Christoph,

On Mon, Jun 28, 2021 at 6:33 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 28, 2021 at 09:29:59AM -0500, Rob Landley wrote:
> > > No.  My hope is to kill dma_declarare_coherent, an API for board
> > > support files to declare device-specific regions to be used for
> > > coherent DMA.
> >
> > Q) If I haven't got regression test hardware to make sure I properly converted
> > each of these entire boards to device tree, Is there anything else I can do to
> > help you remove this function from common code, such as inlining some portion of
> > this function?
> >
> > A) You can convert the board to device tree.
> >
> > Which part of this exchange have I misunderstood?
>
> The part that there is no easy way out without the device tree
> conversion.

So you keep this functionality around with DT.  Which means there's
some code to parse the DT, extract a region, and handle it?
I'm just wondering which terrible maintenance burden would be left by
making the handling function public, so the SH platform code can still call it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
