Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ECDC4332F
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 12:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774F361002
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 12:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhI0MKx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhI0MKx (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 27 Sep 2021 08:10:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B6F561052;
        Mon, 27 Sep 2021 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632744555;
        bh=AI4tpGzcq2lGaC64BREqAyh495k90SIEp0H15kiF3Ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M75I0T5h7qGQRA7oKVHzhSchib2qNPBAVpYc2Ceez7NUOZwwArcsujxIxbHdQ/ATP
         mZyro+adIQsI0CzYxVYVCUwNyW7RmytDcEQyNzmsPWBO8XPyA8pNOFyf98kCtQipmu
         wK0eW/UR5tlcdU2KE+31I74YNjzesYeuU028eGrTNkWnI5E4aZCacqoAFwtKS17s7y
         peuE+DPTWnM6avX5Zz4Mtoq31UjScXfMjtcWJySKMV5Mdne9EDY+Kuc9CKqbhpdmiW
         NcnOg4XLG2BL2SaK4hvINsbMdWcnGDGqXJ4Rveg1c2ymjJrSZqbRfaNWHH7TulQELy
         33km1m23UFHxw==
Received: by mail-lf1-f52.google.com with SMTP id b15so75506283lfe.7;
        Mon, 27 Sep 2021 05:09:15 -0700 (PDT)
X-Gm-Message-State: AOAM5327zUbnZlFvr6ovJOzv6NOhYuccHVN+XqViSq7oTeC1W7Ta3Pev
        DrgOnnymFXrj/kb2iFn8zl/9UnzMYV7FR6DSN/w=
X-Google-Smtp-Source: ABdhPJyNtWcWUZ3v8mDL+/Yc7vrpAv9Q9vg2NiH5xMn0Ry1758YyoowOzWE7K/GfnYa5gYmuS7KzC2hpfEhruxVLhpg=
X-Received: by 2002:a05:6512:3ba0:: with SMTP id g32mr24350829lfv.216.1632744553586;
 Mon, 27 Sep 2021 05:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Sep 2021 20:09:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ6J-ah8xqmBHLu7KWDB9Far2Lzpfu6fFM7EBXNCJFS7g@mail.gmail.com>
Message-ID: <CAJF2gTQ6J-ah8xqmBHLu7KWDB9Far2Lzpfu6fFM7EBXNCJFS7g@mail.gmail.com>
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

I didn't see the patch delete:
#else /* !CONFIG_SPARSE_IRQ */
struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
        [0 ... NR_IRQS-1] = {
                .handle_irq     = handle_bad_irq,
                .depth          = 1,
                .lock           = __RAW_SPIN_LOCK_UNLOCKED(irq_desc->lock),
        }
};
...

Flat irq_desc[] is simple and easy for debugging. We do want to del it?

On Mon, Sep 27, 2021 at 4:11 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Most ARCHs support SPARSE_IRQ, and MAY_HAVE_SPARSE_IRQ is useless, and
> only sh and csky select it, but the could use SPARSE_IRQ too, let's
> kill MAY_HAVE_SPARSE_IRQ, also cleanup the kernel/irq/Kconfig a little.
>
> Kefeng Wang (3):
>   sh: Cleanup about SPARSE_IRQ
>   csky: Use SPARSE_IRQ
>   genirq: Cleanup Kconfig
>
>  arch/csky/Kconfig         |  2 +-
>  arch/sh/Kconfig           |  1 -
>  arch/sh/include/asm/irq.h |  9 -------
>  kernel/irq/Kconfig        | 50 ++++++++++++++++-----------------------
>  4 files changed, 21 insertions(+), 41 deletions(-)
>
> --
> 2.26.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
