Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B9C433B4
	for <linux-sh@archiver.kernel.org>; Tue, 11 May 2021 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E4961207
	for <linux-sh@archiver.kernel.org>; Tue, 11 May 2021 11:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEKLwK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 May 2021 07:52:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2359 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEKLwK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 May 2021 07:52:10 -0400
Received: from dggeml717-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ffbkz5fnDz5vVb;
        Tue, 11 May 2021 19:47:39 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggeml717-chm.china.huawei.com (10.3.17.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 19:51:01 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 11 May
 2021 19:51:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-sh@vger.kernel.org>
CC:     <ysato@users.sourceforge.jp>, <dalias@libc.org>
Subject: [PATCH -next] sh: maple: Remove unnecessary INIT_LIST_HEAD()
Date:   Tue, 11 May 2021 19:53:29 +0800
Message-ID: <20210511115329.3804751-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The list_head maple_waitq and maple_sentq are
initialized statically. It is unnecessary to
initialize by INIT_LIST_HEAD().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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
2.25.1

