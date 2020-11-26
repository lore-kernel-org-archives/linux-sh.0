Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFBC56201
	for <linux-sh@archiver.kernel.org>; Thu, 26 Nov 2020 02:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D20921534
	for <linux-sh@archiver.kernel.org>; Thu, 26 Nov 2020 02:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgKZCpj (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:45:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7735 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgKZCpj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 Nov 2020 21:45:39 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChMYY6lTMzkfZH;
        Thu, 26 Nov 2020 10:45:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 10:45:29 +0800
From:   Lu Wei <luwei32@huawei.com>
To:     <dalias@libc.org>, <lethal@linux-sh.org>,
        <adrian@mcmen.demon.co.uk>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] maple: fix wrong return value of maple_bus_init().
Date:   Thu, 26 Nov 2020 10:43:11 +0800
Message-ID: <20201126024311.292908-1-luwei32@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

If KMEM_CACHE or maple_alloc_dev failed, the maple_bus_init() will return 0
rather than error, because the retval is not changed after KMEM_CACHE or
maple_alloc_dev failed.

Fixes: 17be2d2b1c33 ("sh: Add maple bus support for the SEGA Dreamcast.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lu Wei <luwei32@huawei.com>
---
 drivers/sh/maple/maple.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index e5d7fb81ad66..44a931d41a13 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -835,8 +835,10 @@ static int __init maple_bus_init(void)
 
 	maple_queue_cache = KMEM_CACHE(maple_buffer, SLAB_HWCACHE_ALIGN);
 
-	if (!maple_queue_cache)
+	if (!maple_queue_cache) {
+		retval = -ENOMEM;
 		goto cleanup_bothirqs;
+	}
 
 	INIT_LIST_HEAD(&maple_waitq);
 	INIT_LIST_HEAD(&maple_sentq);
@@ -849,6 +851,7 @@ static int __init maple_bus_init(void)
 		if (!mdev[i]) {
 			while (i-- > 0)
 				maple_free_dev(mdev[i]);
+			retval = -ENOMEM;
 			goto cleanup_cache;
 		}
 		baseunits[i] = mdev[i];
-- 
2.22.0

