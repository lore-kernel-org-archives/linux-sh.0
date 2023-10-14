Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B23EC41513
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjJNOyU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjJNOyT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:19 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AE3C9
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:17 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 642154b6-83cf-4400-a4d4-e2907abf3575;
        Sat, 14 Oct 2023 23:54:16 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id A41191C050D;
        Sat, 14 Oct 2023 23:54:15 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 02/35] arch/sh/boards/Kconfig: unified OF supported targets.
Date:   Sat, 14 Oct 2023 23:53:37 +0900
Message-Id: <2155699d6303d196e2f9643dbfa11ddfd7689b9a.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Targets that support OF should be treated as one board.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/Kconfig | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index fafe15d3ba1d..745543e4fece 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -19,16 +19,10 @@ config SH_DEVICE_TREE
 	select TIMER_OF
 	select COMMON_CLK
 	select GENERIC_CALIBRATE_DELAY
-
-config SH_JCORE_SOC
-	bool "J-Core SoC"
-	select SH_DEVICE_TREE
-	select CLKSRC_JCORE_PIT
-	select JCORE_AIC
-	depends on CPU_J2
-	help
-	  Select this option to include drivers core components of the
-	  J-Core SoC, including interrupt controllers and timers.
+	select GENERIC_IOMAP
+	select GENERIC_IRQ_CHIP
+	select SYS_SUPPORTS_PCI
+	select GENERIC_PCI_IOMAP if PCI
 
 config SH_SOLUTION_ENGINE
 	bool "SolutionEngine"
@@ -300,6 +294,7 @@ config SH_LANDISK
 	bool "LANDISK"
 	depends on CPU_SUBTYPE_SH7751R
 	select HAVE_PCI
+	select SYS_SUPPORTS_PCI
 	help
 	  I-O DATA DEVICE, INC. "LANDISK Series" support.
 
@@ -376,6 +371,16 @@ config SH_APSH4AD0A
 	help
 	  Select AP-SH4AD-0A if configuring for an ALPHAPROJECT AP-SH4AD-0A.
 
+config SH_OF_BOARD
+	bool "General Open Firmware boards"
+	select SH_DEVICE_TREE
+	select CLKSRC_JCORE_PIT if CPU_J2
+	select JCORE_AIC if CPU_J2
+	select HAVE_PCI if CPU_SUBTYPE_SH7751R
+	help
+	  This board means general OF supported targets.
+
+
 source "arch/sh/boards/mach-r2d/Kconfig"
 source "arch/sh/boards/mach-highlander/Kconfig"
 source "arch/sh/boards/mach-sdk7780/Kconfig"
-- 
2.39.2

