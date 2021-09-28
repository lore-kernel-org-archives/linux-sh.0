Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF737C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 04:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0CB61157
	for <linux-sh@archiver.kernel.org>; Tue, 28 Sep 2021 04:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhI1EtX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Sep 2021 00:49:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13348 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhI1EtX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Sep 2021 00:49:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJRhT2YxJz8yww;
        Tue, 28 Sep 2021 12:43:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 12:47:40 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 12:47:40 +0800
Message-ID: <f68bf3ba-987d-fd82-adce-8ed1681cecd1@huawei.com>
Date:   Tue, 28 Sep 2021 12:47:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/3] csky: Use SPARSE_IRQ
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
 <20210927081402.191717-3-wangkefeng.wang@huawei.com>
 <CAJF2gTT1oM6L+R4c6bKKJV5xnHre+P4+779vH5h7xG9Hf-ZKCQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAJF2gTT1oM6L+R4c6bKKJV5xnHre+P4+779vH5h7xG9Hf-ZKCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org


On 2021/9/28 11:39, Guo Ren wrote:
> On Mon, Sep 27, 2021 at 4:11 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> The sparse IRQ framework is preferred, switch over to it,
>> and Kill MAY_HAVE_SPARSE_IRQ.
>>
>> Cc: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/csky/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
>> index 9d4d898df76b..3d720a577be7 100644
>> --- a/arch/csky/Kconfig
>> +++ b/arch/csky/Kconfig
>> @@ -69,7 +69,6 @@ config CSKY
>>          select HAVE_RSEQ
>>          select HAVE_STACKPROTECTOR
>>          select HAVE_SYSCALL_TRACEPOINTS
>> -       select MAY_HAVE_SPARSE_IRQ
>>          select MODULES_USE_ELF_RELA if MODULES
>>          select OF
>>          select OF_EARLY_FLATTREE
>> @@ -82,6 +81,7 @@ config CSKY
>>          select PCI_SYSCALL if PCI
>>          select PCI_MSI if PCI
>>          select SET_FS
>> +       select SPARSE_IRQ
> Most csky platforms use !SPARSE_IRQ, so please remove the above line.
Ok, will drop this.
>
>>          select TRACE_IRQFLAGS_SUPPORT
>>
>>   config LOCKDEP_SUPPORT
>> --
>> 2.26.2
>>
>
