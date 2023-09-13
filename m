Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5846CA5526
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjIMJYQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C53199F
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id ec9dee9f-943d-49be-b71d-7e6d7a11e7dc;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 4DDCB1C00A0;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 12/30] drivers/clk: Add SH7750 CPG drivers entry.
Date:   Wed, 13 Sep 2023 18:23:37 +0900
Message-Id: <4179b63bb3f151a49616c4ae2702de16702ad739.1694596125.git.ysato@users.sourceforge.jp>
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
 drivers/clk/renesas/Kconfig  | 15 ++++++++++++++-
 drivers/clk/renesas/Makefile |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 37632a0659d8..c4e2f7d0349d 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -2,7 +2,7 @@
 
 config CLK_RENESAS
 	bool "Renesas SoC clock support" if COMPILE_TEST && !ARCH_RENESAS
-	default y if ARCH_RENESAS
+	default y if ARCH_RENESAS || SUPERH
 	select CLK_EMEV2 if ARCH_EMEV2
 	select CLK_RZA1 if ARCH_R7S72100
 	select CLK_R7S9210 if ARCH_R7S9210
@@ -39,6 +39,11 @@ config CLK_RENESAS
 	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_R9A09G011 if ARCH_R9A09G011
 	select CLK_SH73A0 if ARCH_SH73A0
+	select CLK_SH7750 if CPU_SUBTYPE_SH7750
+	select CLK_SH7750 if CPU_SUBTYPE_SH7750S
+	select CLK_SH7750 if CPU_SUBTYPE_SH7750R
+	select CLK_SH7750 if CPU_SUBTYPE_SH7751
+	select CLK_SH7750 if CPU_SUBTYPE_SH7751R
 
 if CLK_RENESAS
 
@@ -218,6 +223,14 @@ config CLK_RZG2L
 	bool "Renesas RZ/{G2L,G2UL,V2L} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
 
+config CLK_SH7750
+	bool "Renesas SH7750/7751 family clock support"
+	depends on CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
+	           CPU_SUBTYPE_SH7750R || \
+	           CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST
+	help
+	  This is a driver for SH7750 / SH7751 CPG.
+
 # Generic
 config CLK_RENESAS_CPG_MSSR
 	bool "CPG/MSSR clock support" if COMPILE_TEST
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index de907623fe3f..3f896cf31dc4 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+= r9a09g011-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
+obj-$(CONFIG_CLK_SH7750)		+= clk-sh7750.o clk-shdiv.o
 
 # Family
 obj-$(CONFIG_CLK_RCAR_CPG_LIB)		+= rcar-cpg-lib.o
-- 
2.39.2

