Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD6C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjKNIAl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjKNIAi (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:38 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 278871A7
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:35 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 3AB2D1C0314;
        Tue, 14 Nov 2023 17:00:34 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 02/37] sh: Kconfig unified OF supported targets.
Date:   Tue, 14 Nov 2023 16:59:53 +0900
Message-Id: <2e3530590d72257ac5cb657e4f4d4da3ec7d03e7.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
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
index 109bec4dad94..d95f078ff5c9 100644
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
@@ -293,6 +287,7 @@ config SH_LANDISK
 	bool "LANDISK"
 	depends on CPU_SUBTYPE_SH7751R
 	select HAVE_PCI
+	select SYS_SUPPORTS_PCI
 	help
 	  I-O DATA DEVICE, INC. "LANDISK Series" support.
 
@@ -369,6 +364,16 @@ config SH_APSH4AD0A
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

