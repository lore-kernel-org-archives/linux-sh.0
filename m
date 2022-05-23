Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67453C433F5
	for <linux-sh@archiver.kernel.org>; Mon, 23 May 2022 09:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiEWJQk (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 May 2022 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiEWJQi (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 23 May 2022 05:16:38 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C721344A30
        for <linux-sh@vger.kernel.org>; Mon, 23 May 2022 02:16:37 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,246,1647270000"; 
   d="scan'208";a="121939240"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 May 2022 18:16:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.109])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A739E423DF13;
        Mon, 23 May 2022 18:16:35 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: clk: Extend valid clk ptr checks using IS_ERR_OR_NULL
Date:   Mon, 23 May 2022 10:16:33 +0100
Message-Id: <20220523091633.5217-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

In order to allow all drivers to call clk functions with an invalid clk
ptr, ensure we check not only for a NULL clk ptr, but also for errors
before using it.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Note this has not been tested at all, I don't have any SH boards.
---
 drivers/sh/clk/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index d996782a7106..b843c99b3604 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -253,7 +253,7 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return;
 
 	spin_lock_irqsave(&clock_lock, flags);
@@ -294,7 +294,7 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return -EINVAL;
 
 	spin_lock_irqsave(&clock_lock, flags);
@@ -470,7 +470,7 @@ void clk_enable_init_clocks(void)
 
 unsigned long clk_get_rate(struct clk *clk)
 {
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return 0;
 
 	return clk->rate;
@@ -482,7 +482,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	int ret = -EOPNOTSUPP;
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return 0;
 
 	spin_lock_irqsave(&clock_lock, flags);
@@ -513,7 +513,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (!parent || !clk)
+	if (!parent || IS_ERR_OR_NULL(clk))
 		return ret;
 	if (clk->parent == parent)
 		return 0;
@@ -542,7 +542,7 @@ EXPORT_SYMBOL_GPL(clk_set_parent);
 
 struct clk *clk_get_parent(struct clk *clk)
 {
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return NULL;
 
 	return clk->parent;
@@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(clk_get_parent);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return 0;
 
 	if (likely(clk->ops && clk->ops->round_rate)) {
-- 
2.34.1

