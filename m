Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F2C4167B
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjKNIAn (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjKNIAm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:42 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D6B19B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:38 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id DACAA1C00A4;
        Tue, 14 Nov 2023 17:00:37 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v4 04/37] dt-bindings: interrupt-controller: Add header for Renesas SH3/4 INTC.
Date:   Tue, 14 Nov 2023 16:59:55 +0900
Message-Id: <5d796f8d8e27a1c68f4103f9a0d92c84fb0bdda8.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Renesas SH7751 Interrupt controller priority register define.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../dt-bindings/interrupt-controller/sh_intc.h   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
new file mode 100644
index 000000000000..b399cd15e1a8
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sh_intc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * SH3/4 INTC EVT - IRQ conversion
+ */
+
+#define evt2irq(evt)		((evt) >> 5)
+
+#define IPRA			0
+#define IPRB			4
+#define IPRC			8
+#define IPRD			12
+#define INTPRI00		256
+#define IPR_B12			12
+#define IPR_B8			8
+#define IPR_B4			4
+#define IPR_B0			0
-- 
2.39.2

