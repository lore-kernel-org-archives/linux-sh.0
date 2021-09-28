Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F53C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 05:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36068611C7
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 05:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhI1FKs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhI1FKr (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Tue, 28 Sep 2021 01:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBABF61139;
        Tue, 28 Sep 2021 05:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632805748;
        bh=wxiEQE4HfYuGo22M9COVJdqHjGkdxglZYjdK21SKD1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TMuhghflXMo6tvXMBH8DwdnzXOp7D44+ZzLjkxcibSt5GcVF4aM1kJRCcbuLdJX/N
         ceeIMajuBUjgn8YmoYm7G23JBYq0Cg7wokWIqtmAcEJVZ2KbLgTW0rkx4yBFERb1t3
         2BBNLP0V1zZ47+4RK4IbRnWmsCgiR1mOpKqUpARA0Dxq3Ek9OnSTHgSd2ssbsLN7z2
         Y1IAGTtf/Zq/jqeAq/6cTQc5dcNwrVIVqq1QgfGJtmLn7pK55qHxERN7LjtqJ7iWgj
         qybdsfaNOJOCN3tgekAKFw0HC0NXh1k2vWQwe8RQJuyW78LaOjO+RPZWtgv5tpR1Ho
         3eYJpUa3SOF+w==
Received: by mail-ua1-f51.google.com with SMTP id 37so5866965uaq.11;
        Mon, 27 Sep 2021 22:09:08 -0700 (PDT)
X-Gm-Message-State: AOAM5316lSXj+ObzQjJUa1fAjrW9lsfx55610IZ4JFXUyoScQWpW2O/g
        nl9Jt3atz//Qa6iKHkBNeiND2Bz7LofTdCObrkM=
X-Google-Smtp-Source: ABdhPJzFDBLdxqwLp4ZawHUkPXwOGB4Pixh9LgqRTDXynfixA0A7azNL5SZmYyEGVVt43Oc5tQnW2sWCHSqP36Gz9HI=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr3336009uae.57.1632805747980;
 Mon, 27 Sep 2021 22:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Sep 2021 13:08:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRoXWqcMTkuu=L6gkF2cL79GonN6XBj86BMMptJnmz3zw@mail.gmail.com>
Message-ID: <CAJF2gTRoXWqcMTkuu=L6gkF2cL79GonN6XBj86BMMptJnmz3zw@mail.gmail.com>
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

On Mon, Sep 27, 2021 at 4:11 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Most ARCHs support SPARSE_IRQ, and MAY_HAVE_SPARSE_IRQ is useless, and
> only sh and csky select it, but the could use SPARSE_IRQ too, let's
> kill MAY_HAVE_SPARSE_IRQ, also cleanup the kernel/irq/Kconfig a little.
Can you elaborate the reason on why we need to kill MAY_HAVE_SPARSE_IRQ?
What are the benefits after the patch? (As you know we couldn't drop
"!SPARSE_IRQ".)

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
