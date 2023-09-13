Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE72CA5524
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbjIMJYQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A21993
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:06 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 6700ac45-788a-447c-93e6-381be2589e7d;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id E53C31C00A0;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 15/30] Documentation/devicetree: Add renesas,sh7751-intc binding document.
Date:   Wed, 13 Sep 2023 18:23:40 +0900
Message-Id: <144ec782c78a55e5c4f41de421b2f3eb8432554c.1694596125.git.ysato@users.sourceforge.jp>
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
 .../renesas,sh7751-intc.yaml                  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
new file mode 100644
index 000000000000..0f0139545d77
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 Interrupt Controller
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+properties:
+  compatible:
+    items:
+      - const: renesas,sh7751-intc
+
+  '#interrupt-cells':
+    # an interrupt index and flags, as defined in interrupts.txt in
+    # this directory
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  sh7751,irlm:
+    description: If this value true. ICR.IRLM is 1.
+    $ref: /schemas/types.yaml#/definitions/bool
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+
+examples:
+  - |
+        shintc: interrupt-controller@ffd00000 {
+                compatible = "renesas,sh7751-intc";
+                #interrupt-cells = <2>;
+                interrupt-controller;
+                reg = <0xffd00000 14>, <0xfe080000 128>;
+        };
-- 
2.39.2

