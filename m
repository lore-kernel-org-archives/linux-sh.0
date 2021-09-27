Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB47C4332F
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E268060FF2
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 12:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhI0Mh3 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:37:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:21368 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbhI0Mh3 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 27 Sep 2021 08:37:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJ27V0yKlzRG8L;
        Mon, 27 Sep 2021 20:31:34 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 20:35:49 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 20:35:49 +0800
Subject: Re: [PATCH 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
To:     Guo Ren <guoren@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
 <CAJF2gTQ6J-ah8xqmBHLu7KWDB9Far2Lzpfu6fFM7EBXNCJFS7g@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <083297b0-58e2-aa1e-2f8a-47845a9b373e@huawei.com>
Date:   Mon, 27 Sep 2021 20:35:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTQ6J-ah8xqmBHLu7KWDB9Far2Lzpfu6fFM7EBXNCJFS7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org


On 2021/9/27 20:09, Guo Ren wrote:
> I didn't see the patch delete:
> #else /* !CONFIG_SPARSE_IRQ */
> struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
>          [0 ... NR_IRQS-1] = {
>                  .handle_irq     = handle_bad_irq,
>                  .depth          = 1,
>                  .lock           = __RAW_SPIN_LOCK_UNLOCKED(irq_desc->lock),
>          }
> };
> ...
>
> Flat irq_desc[] is simple and easy for debugging. We do want to del it?

This patches want to kill MAY_HAVE_SPARSE_IRQ,  not !SPARSE_IRQ.

so I won't delete above parts(eg, ARM could use both SPARSE_IRQ and

!SPARSE_IRQ via different config,)

>
> On Mon, Sep 27, 2021 at 4:11 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Most ARCHs support SPARSE_IRQ, and MAY_HAVE_SPARSE_IRQ is useless, and
>> only sh and csky select it, but the could use SPARSE_IRQ too, let's
>> kill MAY_HAVE_SPARSE_IRQ, also cleanup the kernel/irq/Kconfig a little.
>>
>> Kefeng Wang (3):
>>    sh: Cleanup about SPARSE_IRQ
>>    csky: Use SPARSE_IRQ
>>    genirq: Cleanup Kconfig
>>
>>   arch/csky/Kconfig         |  2 +-
>>   arch/sh/Kconfig           |  1 -
>>   arch/sh/include/asm/irq.h |  9 -------
>>   kernel/irq/Kconfig        | 50 ++++++++++++++++-----------------------
>>   4 files changed, 21 insertions(+), 41 deletions(-)
>>
>> --
>> 2.26.2
>>
>
