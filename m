Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3611C4332F
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA16060F46
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 14:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhI0OKT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234682AbhI0OKP (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 27 Sep 2021 10:10:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83FDA61058;
        Mon, 27 Sep 2021 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751717;
        bh=ktYooaNuS/l3irntvYIc/zVHS2lkWkI0eqToMcMCx2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kcGaU0v0nba50XYMKsMamhr0rLGzBMSZWaHpSTRib+yKqXH/U6tWEb8CPoiN8O+59
         MZEXnipoWbW1iGLTX3P6TdAFcvgiOsNCNbldOrUzQuy0Yts1BUXLwH/YZGVsDHQt3q
         /AgycnnEnV92XxyF70rmozpdlSID1/aUUn/IofgfBsv4wpinI6UW0au+slNul8TVK2
         +mGh3sG/8sYGyYoaq5nBKqb2ade+Q+mfikMQeJLGffLThF/hrKCHcfELZ3ZYRrrZYt
         gq9rvaKiqiKemJWabeRPsO7CFTShSaLffyYB+gE1M7ziQxmqQeJ/kyFDvM6iyTuRIn
         lQLT1vNv9SMxQ==
Received: by mail-lf1-f41.google.com with SMTP id b20so78287516lfv.3;
        Mon, 27 Sep 2021 07:08:37 -0700 (PDT)
X-Gm-Message-State: AOAM530dlTeZq3YlX4H1rmCVW5Ytd6OMzyg/5rBNhECTLVF4GBpZ9/jP
        wqXaiTpiYNIyFBQicT7THd22LZFIWgXcJQnRXyM=
X-Google-Smtp-Source: ABdhPJw58woOx1/DECIFcI12BF3oWqo7EXg8x8s/UAp+Mt0Uzqbc0lPLAL1Ez4D+D6eUalDBenubb3TfsyhKwS1p1a4=
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr23505110lff.641.1632751715269;
 Mon, 27 Sep 2021 07:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
 <CAJF2gTQ6J-ah8xqmBHLu7KWDB9Far2Lzpfu6fFM7EBXNCJFS7g@mail.gmail.com> <083297b0-58e2-aa1e-2f8a-47845a9b373e@huawei.com>
In-Reply-To: <083297b0-58e2-aa1e-2f8a-47845a9b373e@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Sep 2021 22:08:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQVFuOZkKrjL5YtNGgxxZRuE1ve+s9DWQHX4w8EtDAYSw@mail.gmail.com>
Message-ID: <CAJF2gTQVFuOZkKrjL5YtNGgxxZRuE1ve+s9DWQHX4w8EtDAYSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Sep 27, 2021 at 8:35 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2021/9/27 20:09, Guo Ren wrote:
> > I didn't see the patch delete:
> > #else /* !CONFIG_SPARSE_IRQ */
> > struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
> >          [0 ... NR_IRQS-1] = {
> >                  .handle_irq     = handle_bad_irq,
> >                  .depth          = 1,
> >                  .lock           = __RAW_SPIN_LOCK_UNLOCKED(irq_desc->lock),
> >          }
> > };
> > ...
> >
> > Flat irq_desc[] is simple and easy for debugging. We do want to del it?
>
> This patches want to kill MAY_HAVE_SPARSE_IRQ,  not !SPARSE_IRQ.
>
> so I won't delete above parts(eg, ARM could use both SPARSE_IRQ and
>
> !SPARSE_IRQ via different config,)
>
> >
> > On Mon, Sep 27, 2021 at 4:11 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >> Most ARCHs support SPARSE_IRQ, and MAY_HAVE_SPARSE_IRQ is useless, and
> >> only sh and csky select it, but the could use SPARSE_IRQ too, let's
> >> kill MAY_HAVE_SPARSE_IRQ, also cleanup the kernel/irq/Kconfig a little.
Why couldn't choice SPARSE in menuconfig?

> >>
> >> Kefeng Wang (3):
> >>    sh: Cleanup about SPARSE_IRQ
> >>    csky: Use SPARSE_IRQ
> >>    genirq: Cleanup Kconfig
> >>
> >>   arch/csky/Kconfig         |  2 +-
> >>   arch/sh/Kconfig           |  1 -
> >>   arch/sh/include/asm/irq.h |  9 -------
> >>   kernel/irq/Kconfig        | 50 ++++++++++++++++-----------------------
> >>   4 files changed, 21 insertions(+), 41 deletions(-)
> >>
> >> --
> >> 2.26.2
> >>
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
