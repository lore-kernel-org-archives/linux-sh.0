Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D9CA551A
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjIMJYS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjIMJYM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344A19A7
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 11745018-a1d5-4315-be8b-03d88360b561;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 7733F1C00A0;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 18/30] drivers/clocksource: sh_tmu clocks property support.
Date:   Wed, 13 Sep 2023 18:23:43 +0900
Message-Id: <78b37903cfb2cc64f0f09287a3e075d7dda73260.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/clocksource/sh_tmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index beffff81c00f..878324986f49 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -537,6 +537,9 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 
 	/* Get hold of clock. */
 	tmu->clk = clk_get(&tmu->pdev->dev, "fck");
+	if (IS_ERR(tmu->clk) && IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
+		/* use DeviceTree clocks property */
+		tmu->clk = devm_clk_get(&tmu->pdev->dev, NULL);
 	if (IS_ERR(tmu->clk)) {
 		dev_err(&tmu->pdev->dev, "cannot get clock\n");
 		return PTR_ERR(tmu->clk);
-- 
2.39.2

