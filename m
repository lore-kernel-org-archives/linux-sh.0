Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178BC83F16
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbjHaBMO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbjHaBMM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC6CD7
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id a7976d0c-e643-4e28-8db0-a52e898c5f88;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 38B431C05E1;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 07/12] clocksource: Update sh_tmu of handling.
Date:   Thu, 31 Aug 2023 10:11:54 +0900
Message-Id: <2d323328fba6ac55a1c3cdcefe909fad3ab0d9dc.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/clocksource/sh_tmu.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index beffff81c00f..de65e1c96780 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -420,9 +420,6 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 	ced->suspend = sh_tmu_clock_event_suspend;
 	ced->resume = sh_tmu_clock_event_resume;
 
-	dev_info(&ch->tmu->pdev->dev, "ch%u: used for clock events\n",
-		 ch->index);
-
 	clockevents_config_and_register(ced, ch->tmu->rate, 0x300, 0xffffffff);
 
 	ret = request_irq(ch->irq, sh_tmu_interrupt,
@@ -500,12 +497,12 @@ static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
 	tmu->model = SH_TMU;
 	tmu->num_channels = 3;
 
-	of_property_read_u32(np, "#renesas,channels", &tmu->num_channels);
-
-	if (tmu->num_channels != 2 && tmu->num_channels != 3) {
-		dev_err(&tmu->pdev->dev, "invalid number of channels %u\n",
-			tmu->num_channels);
-		return -EINVAL;
+	if (of_property_read_u32(np, "#renesas,channels", &tmu->num_channels)) {
+		if (tmu->num_channels != 2 && tmu->num_channels != 3) {
+			dev_err(&tmu->pdev->dev,
+				"invalid number of channels %u\n", tmu->num_channels);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -513,7 +510,6 @@ static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
 
 static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 {
-	unsigned int i;
 	int ret;
 
 	tmu->pdev = pdev;
@@ -535,6 +531,11 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	if (tmu->num_channels < 2) {
+		dev_err(&tmu->pdev->dev, "Invalid channels.\n");
+		return -ENXIO;
+	}
+
 	/* Get hold of clock. */
 	tmu->clk = clk_get(&tmu->pdev->dev, "fck");
 	if (IS_ERR(tmu->clk)) {
@@ -573,12 +574,12 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	 * Use the first channel as a clock event device and the second channel
 	 * as a clock source.
 	 */
-	for (i = 0; i < tmu->num_channels; ++i) {
-		ret = sh_tmu_channel_setup(&tmu->channels[i], i,
-					   i == 0, i == 1, tmu);
-		if (ret < 0)
-			goto err_unmap;
-	}
+	ret = sh_tmu_channel_setup(&tmu->channels[0], 0, false, true, tmu);
+	if (ret < 0)
+		goto err_unmap;
+	ret = sh_tmu_channel_setup(&tmu->channels[1], 1, true, false, tmu);
+	if (ret < 0)
+		goto err_unmap;
 
 	platform_set_drvdata(pdev, tmu);
 
-- 
2.39.2

