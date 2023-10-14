Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D792CDB482
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjJNOyW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjJNOyW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:22 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF79D7
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:18 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 9c49908a-b945-4247-8f4b-4fb645bed3d8;
        Sat, 14 Oct 2023 23:54:17 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 0B81D1C04FD;
        Sat, 14 Oct 2023 23:54:17 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 07/35] arch/sh/kernel/time.c: support COMMON_CLK.
Date:   Sat, 14 Oct 2023 23:53:42 +0900
Message-Id: <f35fd083bca4ceb9ce870f73e27b8bfd2c85fd53.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Initialize the clock and timer using the COMMON_CLK procedure.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/time.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 821a09cbd605..ce5b7c2f8628 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -19,7 +19,9 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 #include <asm/platform_early.h>
+#include <linux/of_clk.h>
 
+#ifndef CONFIG_SH_DEVICE_TREE
 static void __init sh_late_time_init(void)
 {
 	/*
@@ -43,3 +45,13 @@ void __init time_init(void)
 
 	late_time_init = sh_late_time_init;
 }
+#else
+/* CONFIG_SH_DEVICE_TREE */
+void __init time_init(void)
+{
+	pr_info("SH generic board support: scanning for clk providers\n");
+
+	of_clk_init(NULL);
+	timer_probe();
+}
+#endif
-- 
2.39.2

