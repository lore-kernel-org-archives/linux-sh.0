Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1D6C433EF
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3558460F70
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 08:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhI0IM7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:12:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:25918 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhI0IM5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 27 Sep 2021 04:12:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HHwGG3VvRzbmmr;
        Mon, 27 Sep 2021 16:07:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 16:11:17 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 16:11:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] sh: Cleanup about SPARSE_IRQ
Date:   Mon, 27 Sep 2021 16:14:00 +0800
Message-ID: <20210927081402.191717-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
References: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

After commit 37744feebc08 ("sh: remove sh5 support"), sh always
enable SPARSE_IRQ, kill unused MAY_HAVE_SPARSE_IRQ and NR_IRQS
define under !CONFIG_SPARSE_IRQ.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sh/Kconfig           | 1 -
 arch/sh/include/asm/irq.h | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6904f4bdbf00..70afb30e0b32 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -56,7 +56,6 @@ config SUPERH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
-	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
 	select NO_DMA if !MMU && !DMA_COHERENT
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 839551ce398c..5a7b6e324e4c 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -5,16 +5,7 @@
 #include <linux/cpumask.h>
 #include <asm/machvec.h>
 
-/*
- * Only legacy non-sparseirq platforms have to set a reasonably sane
- * value here. sparseirq platforms allocate their irq_descs on the fly,
- * so will expand automatically based on the number of registered IRQs.
- */
-#ifdef CONFIG_SPARSE_IRQ
 # define NR_IRQS		8
-#else
-# define NR_IRQS		512
-#endif
 
 /*
  * This is a special IRQ number for indicating that no IRQ has been
-- 
2.26.2

