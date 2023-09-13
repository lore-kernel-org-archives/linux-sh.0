Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA44CA551E
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjIMJYR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5219A3
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 474c7c67-e39a-4118-8de6-b94fe2beb786;
        Wed, 13 Sep 2023 18:24:07 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 20F7D1C005D;
        Wed, 13 Sep 2023 18:24:07 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 25/30] include/dt-bindings: Add sh_intc IRQ - EVT conversion helper
Date:   Wed, 13 Sep 2023 18:23:50 +0900
Message-Id: <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
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
 arch/sh/boot/dts/include/dt-bindings               | 1 +
 include/dt-bindings/interrupt-controller/sh_intc.h | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
new file mode 120000
index 000000000000..08c00e4972fa
--- /dev/null
+++ b/arch/sh/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
new file mode 100644
index 000000000000..cab546fba396
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sh_intc.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * SH3/4 INTC EVT - IRQ conversion
+ */
+
+#define evt2irq(evt)		((evt) >> 5)
+#define irq2evt(irq)		((irq) << 5)
-- 
2.39.2

