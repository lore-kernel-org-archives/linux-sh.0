Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330AACDB490
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjJNOya (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJNOyY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:24 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D72DD
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:20 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 8a0388f3-8ee9-4ecd-8d14-697c7feb3ef4;
        Sat, 14 Oct 2023 23:54:19 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 1A8B41C04FD;
        Sat, 14 Oct 2023 23:54:18 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org
Subject: [RFC PATCH v3 11/35] include/dt-bindings/clock/sh7750.h: cpg-sh7750 binding header.
Date:   Sat, 14 Oct 2023 23:53:46 +0900
Message-Id: <953cf1cef945a7081734ebc5304e3820214dca35.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SH7750 CPG driver binding definition.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/dt-bindings/clock/sh7750.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/clock/sh7750.h

diff --git a/include/dt-bindings/clock/sh7750.h b/include/dt-bindings/clock/sh7750.h
new file mode 100644
index 000000000000..10be4eb63bdb
--- /dev/null
+++ b/include/dt-bindings/clock/sh7750.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright 2023 Yoshinori Sato
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SH7750_H__
+#define __DT_BINDINGS_CLOCK_SH7750_H__
+
+#define SH7750_CPG_PLLOUT	0
+
+#define SH7750_CPG_FCK		1
+#define SH7750_CPG_BCK		2
+#define SH7750_CPG_ICK		3
+
+#define SH7750_CPG_SCI_CLK	4
+#define SH7750_CPG_RTC_CLK	5
+#define SH7750_CPG_TMU012_CLK	6
+#define SH7750_CPG_SCIF_CLK	7
+#define SH7750_CPG_DMAC_CLK	8
+#define SH7750_CPG_UBC_CLK	9
+#define SH7750_CPG_SQ_CLK	10
+#define SH7750_CPG_INTC_CLK	11
+#define SH7750_CPG_TMU34_CLK	12
+#define SH7750_CPG_PCIC_CLK	13
+
+#endif
-- 
2.39.2

