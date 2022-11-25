Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A5C433FE
	for <linux-sh@archiver.kernel.org>; Fri, 25 Nov 2022 01:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKYBRa (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 24 Nov 2022 20:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYBRa (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 24 Nov 2022 20:17:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E688D56
        for <linux-sh@vger.kernel.org>; Thu, 24 Nov 2022 17:17:28 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJH5L14FSzRpMV;
        Fri, 25 Nov 2022 09:16:54 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 09:17:26 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <cuigaosheng1@huawei.com>, <lethal@linux-sh.org>, <damm@igel.co.jp>
CC:     <linux-sh@vger.kernel.org>
Subject: [PATCH] sh/intc: Add missing list_del(&d->list) in register_intc_controller
Date:   Fri, 25 Nov 2022 09:17:25 +0800
Message-ID: <20221125011725.3287607-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The list_del(&d->list) should be called in the error handling in
register_intc_controller(), otherwise, d will be freed, but d->list
will not be removed from &intc_list, list traversal may cause UAF.

Fix it by adding missing list_del(&d->list) in register_intc_controller.

Fixes: 2dcec7a988a1 ("sh: intc: set_irq_wake() support")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/sh/intc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index ca4f4ca413f1..6bf38cd0f6e5 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -387,6 +387,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	kfree(d->window);
 err1:
+	list_del(&d->list);
 	kfree(d);
 err0:
 	pr_err("unable to allocate INTC memory\n");
-- 
2.25.1

