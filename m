Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD29C4332F
	for <linux-sh@archiver.kernel.org>; Fri, 18 Nov 2022 02:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiKRCsF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiKRCsE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 17 Nov 2022 21:48:04 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6528DA64
        for <linux-sh@vger.kernel.org>; Thu, 17 Nov 2022 18:48:03 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ND1N31kJ5zJnnW;
        Fri, 18 Nov 2022 10:44:51 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 10:48:01 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <lethal@linux-sh.org>, <linux-sh@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 1/2] sh: intc: Fix compile errors about casting
Date:   Fri, 18 Nov 2022 02:46:10 +0000
Message-ID: <20221118024611.112732-2-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221118024611.112732-1-yuancan@huawei.com>
References: <20221118024611.112732-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The following errors was given when compiling drivers/sh/intc/core.c

 drivers/sh/intc/core.c: In function ‘intc_redirect_irq’:
 drivers/sh/intc/core.c:70:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   generic_handle_irq((unsigned int)irq_desc_get_handler_data(desc));
                      ^
 drivers/sh/intc/core.c: In function ‘intc_register_irq’:
 drivers/sh/intc/core.c:119:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   irq_set_chip_data(irq, (void *)data[primary]);
                          ^
 drivers/sh/intc/core.c: In function ‘register_intc_controller’:
 drivers/sh/intc/core.c:360:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
          (void *)irq);
          ^
 cc1: all warnings being treated as errors

Fix by casting variables to unsigned long first.

Fixes: 2be6bb0c79c7 ("sh: intc: Split up the INTC code.")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/sh/intc/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index ca4f4ca413f1..4a4ad10de758 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -67,7 +67,7 @@ void intc_set_prio_level(unsigned int irq, unsigned int level)
 
 static void intc_redirect_irq(struct irq_desc *desc)
 {
-	generic_handle_irq((unsigned int)irq_desc_get_handler_data(desc));
+	generic_handle_irq((unsigned long)irq_desc_get_handler_data(desc));
 }
 
 static void __init intc_register_irq(struct intc_desc *desc,
@@ -116,7 +116,7 @@ static void __init intc_register_irq(struct intc_desc *desc,
 	disable_irq_nosync(irq);
 	irq_set_chip_and_handler_name(irq, &d->chip, handle_level_irq,
 				      "level");
-	irq_set_chip_data(irq, (void *)data[primary]);
+	irq_set_chip_data(irq, (void *)(unsigned long)data[primary]);
 
 	/*
 	 * set priority level
@@ -357,7 +357,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 			irq_set_chip(irq2, &dummy_irq_chip);
 			irq_set_chained_handler_and_data(irq2,
 							 intc_redirect_irq,
-							 (void *)irq);
+							 (void *)(unsigned long)irq);
 		}
 	}
 
-- 
2.17.1

