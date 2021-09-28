Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D97C433FE
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 05:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84251611C7
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 05:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhI1Fo7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:44:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:26922 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhI1Fo7 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Sep 2021 01:44:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJSx14wHkzbmQH;
        Tue, 28 Sep 2021 13:39:01 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 13:43:17 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 13:43:17 +0800
Message-ID: <3cd69b8f-c1af-baaa-31aa-f2e61e4c84b6@huawei.com>
Date:   Tue, 28 Sep 2021 13:43:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
 <CAJF2gTRoXWqcMTkuu=L6gkF2cL79GonN6XBj86BMMptJnmz3zw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAJF2gTRoXWqcMTkuu=L6gkF2cL79GonN6XBj86BMMptJnmz3zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org


On 2021/9/28 13:08, Guo Ren wrote:
> On Mon, Sep 27, 2021 at 4:11 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Most ARCHs support SPARSE_IRQ, and MAY_HAVE_SPARSE_IRQ is useless, and
>> only sh and csky select it, but the could use SPARSE_IRQ too, let's
>> kill MAY_HAVE_SPARSE_IRQ, also cleanup the kernel/irq/Kconfig a little.
> Can you elaborate the reason on why we need to kill MAY_HAVE_SPARSE_IRQ?
> What are the benefits after the patch? (As you know we couldn't drop
> "!SPARSE_IRQ".)

If csky want to keep MAY_HAVE_SPARSE_IRQ, then I won't kill it, or no 
one use it,

then cleanup it.


