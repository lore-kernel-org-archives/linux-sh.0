Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EECA551D
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbjIMJYR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbjIMJYM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D058819A6
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:06 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 1e868b68-4384-420d-b6b8-5470341aebb7;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 4A83C1C005D;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 17/30] Documentation/devicetree: Add renesas,sh7751-irl-ext binding document.
Date:   Wed, 13 Sep 2023 18:23:42 +0900
Message-Id: <edb561b3738e9e6317857683c9350c078d370aa1.1694596125.git.ysato@users.sourceforge.jp>
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
 .../renesas,sh7751-irl-ext.yaml               | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
new file mode 100644
index 000000000000..dfc35717b92a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 IRL external encoder with enable regs.
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description: |
+  This is the general used external interrupt encoder on SH7751 based boards.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,sh7751-irl-ext
+
+  '#interrupt-cells':
+    # an interrupt index and flags, as defined in interrupts.txt in
+    # this directory
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    minItems: 1
+
+  sh7751irl,width:
+    description: Enable register width
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  sh7751irl,polarity:
+    description: Enable register polarity
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  sh7751irl,irqbit:
+    description: IRQ to enable register bit mapping
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+  - sh7751irl,width
+  - sh7751irl,polarity
+  - sh7751,irqbit
+
+additionalProperties: false
+
+examples:
+  - |
+        r2dintc: sh7751irl_encoder@a4000000 {
+                compatible = "renesas,sh7751-irl-ext";
+                reg = <0xa4000000 0x02>;
+                interrupt-controller;
+                #address-cells = <1>;
+                #interrupt-cells = <2>;
+                sh7751irl,width = <16>;
+                sh7751irl,polarity = <0>;
+                sh7751irl,irqbit =<11>,         /* PCI INTD */
+                                  <9>,          /* CF IDE */
+                                  <8>,          /* CF CD */
+                                  <12>,         /* PCI INTC */
+                                  <10>,         /* SM501 */
+                                  <6>,          /* KEY */
+                                  <5>,          /* RTC ALARM */
+                                  <4>,          /* RTC T */
+                                  <7>,          /* SDCARD */
+                                  <14>,         /* PCI INTA */
+                                  <13>,         /* PCI INTB */
+                                  <0>,          /* EXT */
+                                  <15>;         /* TP */
+        };
-- 
2.39.2

