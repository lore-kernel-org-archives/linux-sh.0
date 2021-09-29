Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF38C433FE
	for <linux-sh@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946DF613DB
	for <linux-sh@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbhI2Cfi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Sep 2021 22:35:38 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:23228 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbhI2Cf0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Sep 2021 22:35:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HK0lm0R79z8tX5;
        Wed, 29 Sep 2021 10:32:52 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 10:33:41 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 10:33:40 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/3] csky: Kill MAY_HAVE_SPARSE_IRQ
Date:   Wed, 29 Sep 2021 10:35:21 +0800
Message-ID: <20210929023522.57732-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
References: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
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

The csky platforms use statical irq descriptors allocation
by default, and the dynamical and statical irq allocation
are alternative, it is no need to maintain a separate
MAY_HAVE_SPARSE_IRQ, kill it.

Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/csky/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 9d4d898df76b..45ac662bd011 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -69,7 +69,6 @@ config CSKY
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
 	select OF_EARLY_FLATTREE
-- 
2.26.2

