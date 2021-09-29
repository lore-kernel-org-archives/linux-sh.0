Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F8C433F5
	for <linux-sh@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C23F6124A
	for <linux-sh@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbhI2Cfc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Sep 2021 22:35:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:22383 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbhI2CfV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Sep 2021 22:35:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HK0gl07wrzQjGq;
        Wed, 29 Sep 2021 10:29:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 10:33:40 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 10:33:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
Date:   Wed, 29 Sep 2021 10:35:19 +0800
Message-ID: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Most ARCHs support SPARSE_IRQ, the dynamical and statical irq
description allocation are alternative.

The last user of MAY_HAVE_SPARSE_IRQ is sh/csky, but the sh use
SPARSE_IRQ, MAY_HAVE_SPARSE_IRQ could be kill. and for csky, it
uses statical allocation by default. 

So MAY_HAVE_SPARSE_IRQ seems to be useless, no need to maintain a
separate MAY_HAVE_SPARSE_IRQ config, kill it.

Also cleanup the kernel/irq/Kconfig a little.

v2: 
- drop all the NR_IRQS suggested by Geert
- don' use SPARSE_IRQ for csky by default, suggested by Guo.

Kefeng Wang (3):
  sh: Cleanup about SPARSE_IRQ
  csky: Kill MAY_HAVE_SPARSE_IRQ
  genirq: Cleanup Kconfig

 arch/csky/Kconfig         |  1 -
 arch/sh/Kconfig           |  1 -
 arch/sh/include/asm/irq.h | 11 ---------
 kernel/irq/Kconfig        | 50 ++++++++++++++++-----------------------
 4 files changed, 20 insertions(+), 43 deletions(-)

-- 
2.26.2

