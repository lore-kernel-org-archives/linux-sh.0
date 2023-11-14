Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8BC4167B
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjKNIAs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjKNIAr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:47 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B8E819E
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:43 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 40E3F1C02FE;
        Tue, 14 Nov 2023 17:00:43 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v4 07/37] sh: Fix COMMON_CLK support in CONFIG_OF=y.
Date:   Tue, 14 Nov 2023 16:59:58 +0900
Message-Id: <3ca76277d7409f458fb64ea25d6c7ad3cfc38ce5.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Initialize the clock and timer using the COMMON_CLK procedure.
sh's earlytimer mechanism doesn't work properly in OF,
so timer initialization is delayed.
If CONFIG_OF=y, perform the general timer initialization procedure.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c | 28 ++++------------------------
 arch/sh/kernel/time.c       | 12 ++++++++++++
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index f7f3e618e85b..f1ca5a914c11 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <asm/machvec.h>
@@ -98,16 +99,7 @@ static void sh_of_smp_probe(void)
 
 #endif
 
-static void noop(void)
-{
-}
-
-static int noopi(void)
-{
-	return 0;
-}
-
-static void __init sh_of_mem_reserve(void)
+static void __init sh_of_mem_init(void)
 {
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
@@ -140,25 +132,13 @@ static void __init sh_of_init_irq(void)
 	irqchip_init();
 }
 
-static int __init sh_of_clk_init(void)
-{
-#ifdef CONFIG_COMMON_CLK
-	/* Disabled pending move to COMMON_CLK framework. */
-	pr_info("SH generic board support: scanning for clk providers\n");
-	of_clk_init(NULL);
-#endif
-	return 0;
-}
-
 static struct sh_machine_vector __initmv sh_of_generic_mv = {
 	.mv_setup	= sh_of_setup,
 	.mv_name	= "devicetree", /* replaced by DT root's model */
 	.mv_irq_demux	= sh_of_irq_demux,
 	.mv_init_irq	= sh_of_init_irq,
-	.mv_clk_init	= sh_of_clk_init,
-	.mv_mode_pins	= noopi,
-	.mv_mem_init	= noop,
-	.mv_mem_reserve	= sh_of_mem_reserve,
+	.mv_mode_pins	= generic_mode_pins,
+	.mv_mem_init	= sh_of_mem_init,
 };
 
 struct sh_clk_ops;
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

