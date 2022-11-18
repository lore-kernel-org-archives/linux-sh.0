Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF0FC433FE
	for <linux-sh@archiver.kernel.org>; Fri, 18 Nov 2022 02:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiKRCsF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRCsE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 17 Nov 2022 21:48:04 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36A8DA47
        for <linux-sh@vger.kernel.org>; Thu, 17 Nov 2022 18:48:03 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ND1N2685rzJnnT;
        Fri, 18 Nov 2022 10:44:50 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 10:48:01 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <lethal@linux-sh.org>, <linux-sh@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 0/2] sh: intc: Fix UAF and compile error problems
Date:   Fri, 18 Nov 2022 02:46:09 +0000
Message-ID: <20221118024611.112732-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
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

This series fix servel compile errors and an UAF problem in
drivers/sh/intc/core.c.

Yuan Can (2):
  sh: intc: Fix compile errors about casting
  sh: intc: Fix possible UAF in register_intc_controller()

 drivers/sh/intc/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.17.1

