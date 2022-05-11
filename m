Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A91C433F5
	for <linux-sh@archiver.kernel.org>; Wed, 11 May 2022 02:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiEKCxe (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 10 May 2022 22:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbiEKCxS (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 10 May 2022 22:53:18 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81746127940;
        Tue, 10 May 2022 19:52:13 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 May
 2022 10:52:12 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 11 May
 2022 10:52:11 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sh: maple: remove useless INIT_LIST_HEAD()
Date:   Wed, 11 May 2022 10:52:10 +0800
Message-ID: <1652237530-11859-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The list_head maple_waitq & maple_sentq are initialized statically by
LIST_HEAD(). It is unnecessary to initialize by INIT_LIST_HEAD(). Drop
them.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/sh/maple/maple.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index e24e220e56ee..44f00d7cc669 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -839,9 +839,6 @@ static int __init maple_bus_init(void)
 		goto cleanup_bothirqs;
 	}
 
-	INIT_LIST_HEAD(&maple_waitq);
-	INIT_LIST_HEAD(&maple_sentq);
-
 	/* setup maple ports */
 	for (i = 0; i < MAPLE_PORTS; i++) {
 		checked[i] = false;
-- 
2.7.4

