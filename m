Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC60CA551C
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbjIMJYQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A119A1
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 4f35e0dc-0f2b-45bc-89e1-6f4f9df18c95;
        Wed, 13 Sep 2023 18:24:07 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id B82B11C00A0;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 24/30] include/dt-bindings: Add SH7750 CPG header.
Date:   Wed, 13 Sep 2023 18:23:49 +0900
Message-Id: <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
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
 include/dt-bindings/clock/sh7750.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/clock/sh7750.h

diff --git a/include/dt-bindings/clock/sh7750.h b/include/dt-bindings/clock/sh7750.h
new file mode 100644
index 000000000000..88e60a9a01df
--- /dev/null
+++ b/include/dt-bindings/clock/sh7750.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright 2023 Yoshinori Sato
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SH7750_H__
+#define __DT_BINDINGS_CLOCK_SH7750_H__
+
+#define SH7750_CPG_FCK		0
+#define SH7750_CPG_BCK		1
+#define SH7750_CPG_ICK		2
+
+#endif
-- 
2.39.2

