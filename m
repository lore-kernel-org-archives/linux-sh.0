Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD4C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 03:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE11461266
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 03:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhI1DlA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 23:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238745AbhI1DlA (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 27 Sep 2021 23:41:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 281D661266;
        Tue, 28 Sep 2021 03:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632800361;
        bh=cZS0uYwzEHLzghBzzjPNkkQ9XIFN1URXtq1heMtHKCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MUJf2APCeRGbwQpJps2UX8I5MHZrcvDl21Na4Gx5xu2+94E7zweYNklL04tIXrwgo
         Xm5LN+ahM4dhzTn1iFRzmTHIil/jupaNVWRBlCECQxvYXW9YBbm4DnwOY9MhQ9mOfi
         T0GQiB0NGFvKZ4GgLPwbOZJgNAooMrgf6RZQsVKzn00mpqe3L2/l1fVg7w4dNHBFvv
         rQ0T17UAQLexqyxXk03KnTatr6yJcInDOmZyCndI46eFq6AYRPzNw8GtjYQtup55f1
         +v2CRylZ0yDkmqYRqQo5fTjKgFhQbDB2q4XE8PwRT88rEEGkahOYpLOb846kfpg059
         EV0sdpf/xoQPA==
Received: by mail-vk1-f178.google.com with SMTP id h132so7881269vke.8;
        Mon, 27 Sep 2021 20:39:21 -0700 (PDT)
X-Gm-Message-State: AOAM531eCpPi6CTzqoPXIgpYwrdAMWoJI70BZNrPKf0H9BTgVMV7jbVW
        2JD/1COEOKHe2tbb0OMXbmjpdzEaDz60B7suuFo=
X-Google-Smtp-Source: ABdhPJxF6sQbpuA1/9xzp++9k1gswI0ej1fatzgOpSYnn05SO1D7JxUwDMQJLSFzVl8F1CTC7pIiXxxwBkzQ8oMBW+Q=
X-Received: by 2002:a1f:1844:: with SMTP id 65mr3177491vky.3.1632800360350;
 Mon, 27 Sep 2021 20:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com> <20210927081402.191717-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20210927081402.191717-3-wangkefeng.wang@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Sep 2021 11:39:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT1oM6L+R4c6bKKJV5xnHre+P4+779vH5h7xG9Hf-ZKCQ@mail.gmail.com>
Message-ID: <CAJF2gTT1oM6L+R4c6bKKJV5xnHre+P4+779vH5h7xG9Hf-ZKCQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] csky: Use SPARSE_IRQ
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
> The sparse IRQ framework is preferred, switch over to it,
> and Kill MAY_HAVE_SPARSE_IRQ.
>
> Cc: Guo Ren <guoren@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/csky/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 9d4d898df76b..3d720a577be7 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -69,7 +69,6 @@ config CSKY
>         select HAVE_RSEQ
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> -       select MAY_HAVE_SPARSE_IRQ
>         select MODULES_USE_ELF_RELA if MODULES
>         select OF
>         select OF_EARLY_FLATTREE
> @@ -82,6 +81,7 @@ config CSKY
>         select PCI_SYSCALL if PCI
>         select PCI_MSI if PCI
>         select SET_FS
> +       select SPARSE_IRQ
Most csky platforms use !SPARSE_IRQ, so please remove the above line.

>         select TRACE_IRQFLAGS_SUPPORT
>
>  config LOCKDEP_SUPPORT
> --
> 2.26.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
