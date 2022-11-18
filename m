Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A7C43219
	for <linux-sh@archiver.kernel.org>; Fri, 18 Nov 2022 02:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiKRCsG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiKRCsF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 17 Nov 2022 21:48:05 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BC8DA65
        for <linux-sh@vger.kernel.org>; Thu, 17 Nov 2022 18:48:03 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ND1RG2X4fz15MkX;
        Fri, 18 Nov 2022 10:47:38 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 10:48:01 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <lethal@linux-sh.org>, <linux-sh@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 2/2] sh: intc: Fix possible UAF in register_intc_controller()
Date:   Fri, 18 Nov 2022 02:46:11 +0000
Message-ID: <20221118024611.112732-3-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221118024611.112732-1-yuancan@huawei.com>
References: <20221118024611.112732-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

If the allocation of d->window failed in register_intc_controller(), it
will goto err1 and d will be freed, but d->list will not be removed from
intc_list, then list traversal may cause UAF, fix it.

Fixes: 2be6bb0c79c7 ("sh: intc: Split up the INTC code.")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/sh/intc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 4a4ad10de758..98079a3ebe8a 100644
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
2.17.1

