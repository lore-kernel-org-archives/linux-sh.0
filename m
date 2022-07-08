Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1BBC43334
	for <linux-sh@archiver.kernel.org>; Fri,  8 Jul 2022 10:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiGHKny (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Jul 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiGHKnx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Jul 2022 06:43:53 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD12D631D
        for <linux-sh@vger.kernel.org>; Fri,  8 Jul 2022 03:43:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,255,1650898800"; 
   d="scan'208";a="127203121"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 08 Jul 2022 19:43:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.28])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6464B4274EF8;
        Fri,  8 Jul 2022 19:43:50 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] sh: clk: Extend valid clk ptr checks using IS_ERR_OR_NULL
Date:   Fri,  8 Jul 2022 11:43:47 +0100
Message-Id: <20220708104347.13462-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

We want to allow all drivers to call clk_disable_unprepare() with a
clock pointer that could be a valid IS_ERR() condition containing
errno, as this will simplify driver code.

Therefore, ensure we check not only that the clock pointer is not
NULL, but also is not an error value before using it.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Note this has not been tested at all, I don't have any SH boards.

v2:
 - Only use IS_ERR_OR_NULL in clk_disable() as nobody should be
   calling the other functions with a clk ptr that is an error.
 - Improved commit msg to clarify the above
---
 drivers/sh/clk/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index d996782a7106..878812583940 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -253,7 +253,7 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return;
 
 	spin_lock_irqsave(&clock_lock, flags);
-- 
2.34.1

