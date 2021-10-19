Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C1C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 19 Oct 2021 12:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6546A61378
	for <linux-sh@archiver.kernel.org>; Tue, 19 Oct 2021 12:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhJSMcn (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:32:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25169 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhJSMcm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Oct 2021 08:32:42 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HYY225Y8Bz1DGn9;
        Tue, 19 Oct 2021 20:28:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 20:30:28 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 20:30:27 +0800
Message-ID: <3c64a5a1-128a-7448-f429-b2d195819ca2@huawei.com>
Date:   Tue, 19 Oct 2021 20:30:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>
References: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Thomas, Could you pickup this cleanup patchset from your tree if 
possible, thanks.

On 2021/9/29 10:35, Kefeng Wang wrote:
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
>    sh: Cleanup about SPARSE_IRQ
>    csky: Kill MAY_HAVE_SPARSE_IRQ
>    genirq: Cleanup Kconfig
> 
>   arch/csky/Kconfig         |  1 -
>   arch/sh/Kconfig           |  1 -
>   arch/sh/include/asm/irq.h | 11 ---------
>   kernel/irq/Kconfig        | 50 ++++++++++++++++-----------------------
>   4 files changed, 20 insertions(+), 43 deletions(-)
> 
