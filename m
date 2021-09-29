Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E8C433FE
	for <linux-sh@archiver.kernel.org>; Wed, 29 Sep 2021 07:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B821613CD
	for <linux-sh@archiver.kernel.org>; Wed, 29 Sep 2021 07:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbhI2HXs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:23:48 -0400
Received: from mail-vk1-f176.google.com ([209.85.221.176]:42985 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244284AbhI2HXs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 29 Sep 2021 03:23:48 -0400
Received: by mail-vk1-f176.google.com with SMTP id o204so694047vko.9;
        Wed, 29 Sep 2021 00:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpAjqd6jtBapvZHG3sZE9JvtpBjBfjvuAlUrFfuoZVg=;
        b=LsjO96FuqJpwMDNCSa/uNRshpZgsfPI9I2koHWLWAvGHrscS18cdCyftcz9xXv2g9J
         feNdzati/vrIbh4kzmZXLSIxUFvr66k3ZO9kUDSefodXEzJyp8V3/2D5HwcGPbJewTL3
         dAZVQdMy/+qsKGfVw0CzA6BZqC3YyJT+y+YygfvyrshMNuiitrfgN4kljujeCwAiCoF5
         d2xsjeyZIPCZbOJxGGiYSi5AUq/xZOy66CUAImGrai7+H+h6X9APshK7CyO2VMkj40n3
         f6OK1TzaJc3sXhp6zsF1msTbUwl+I4DSBFrxiRM71985JSrHfMiAE+dGE3gKOVaH2wjs
         8Htw==
X-Gm-Message-State: AOAM532gtnGrkGlyMA1T/4aIyRpZ/pYPI6eJ8K4n4bBpbwQqF1CArgjB
        kab+BMjRMi9Zv6+sgiDoXEZFQJNqTD3SGRRH8nnn0+M83Uc=
X-Google-Smtp-Source: ABdhPJyshoR9y4AOppOE55f+1Qt+xdAPpSdcIPDoMtHbneQD8flGNWiLU13LziA6qNzmauYDZYLZkHmKFFXyVP+85qw=
X-Received: by 2002:a1f:3a4b:: with SMTP id h72mr8265739vka.19.1632900126825;
 Wed, 29 Sep 2021 00:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Sep 2021 09:21:55 +0200
Message-ID: <CAMuHMdVjfBEcvKMCvcG2P+K4rs+SZHDcf4OKsGzyFjtOHNFyqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Kefeng,

On Wed, Sep 29, 2021 at 4:35 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Most ARCHs support SPARSE_IRQ, the dynamical and statical irq
> description allocation are alternative.
>
> The last user of MAY_HAVE_SPARSE_IRQ is sh/csky, but the sh use
> SPARSE_IRQ, MAY_HAVE_SPARSE_IRQ could be kill. and for csky, it
> uses statical allocation by default.
>
> So MAY_HAVE_SPARSE_IRQ seems to be useless, no need to maintain a
> separate MAY_HAVE_SPARSE_IRQ config, kill it.
>
> Also cleanup the kernel/irq/Kconfig a little.
>
> v2:
> - drop all the NR_IRQS suggested by Geert
> - don' use SPARSE_IRQ for csky by default, suggested by Guo.
>
> Kefeng Wang (3):
>   sh: Cleanup about SPARSE_IRQ
>   csky: Kill MAY_HAVE_SPARSE_IRQ
>   genirq: Cleanup Kconfig

Thanks for the update!

Tested on SH on landisk (real) and rts7751r2d (qemu), so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

P.S. Please use the same version number in all patches of the series,
     to avoid confusing tools like b4.

https://lore.kernel.org/all/20210929023522.57732-1-wangkefeng.wang@huawei.com/
2021-09-29  2:35 ` [PATCH v1 1/3] sh: Cleanup about SPARSE_IRQ Kefeng Wang
2021-09-29  2:35 ` [PATCH v2 2/3] csky: Kill MAY_HAVE_SPARSE_IRQ Kefeng Wang
2021-09-29  2:35 ` [PATCH v3 3/3] genirq: Cleanup Kconfig Kefeng Wang
                          ^^

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
