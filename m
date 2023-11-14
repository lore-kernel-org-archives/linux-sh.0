Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9BEC072A2
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKNIBA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjKNIA7 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:59 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E2A7195
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:56 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id A80E01C04EC;
        Tue, 14 Nov 2023 17:00:55 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 14/37] dt-bindings: clock: sh7750-cpg: Add renesas,sh7750-cpg header.
Date:   Tue, 14 Nov 2023 17:00:05 +0900
Message-Id: <65cf2917d762e2f2933dbf9e8d61735b2bc4fb7b.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SH7750 CPG Clock output define.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/clock/renesas,sh7750-cpg.yaml    | 103 ++++++++++++++++++
 include/dt-bindings/clock/sh7750-cpg.h        |  26 +++++
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
 create mode 100644 include/dt-bindings/clock/sh7750-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
new file mode 100644
index 000000000000..da0b837c1123
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,sh7750-cpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7750/7751 Clock Pulse Generator (CPG)
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description:
+  The Clock Pulse Generator (CPG) generates core clocks for the SoC.  It
+  includes PLLs, and variable ratio dividers.
+
+  The CPG may also provide a Clock Domain for SoC devices, in combination with
+  the CPG Module Stop (MSTP) Clocks.
+
+properties:
+  compatible:
+    enum:
+      - renesas,sh7750-cpg             # SH7750
+      - renesas,sh7750s-cpg            # SH775S
+      - renesas,sh7750r-cpg            # SH7750R
+      - renesas,sh7751-cpg             # SH7751
+      - renesas,sh7751r-cpg            # SH7751R
+
+  reg: true
+
+  reg-names: true
+
+  clocks: true
+
+  clock-names: true
+
+  '#clock-cells':
+    const: 1
+
+  renesas,mode:
+    description: Board-specific settings of the MD[0-2] pins on SoC
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 6
+
+  '#power-domain-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,sh7750-cpg
+              - renesas,sh7750s-cpg
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: FRQCR
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,sh7750r-cpg
+              - renesas,sh7751-cpg
+              - renesas,sh7751r-cpg
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: FRQCR
+            - const: CLKSTP00
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sh7750-cpg.h>
+    cpg: clock-controller@ffc00000 {
+        #clock-cells = <1>;
+        #power-domain-cells = <0>;
+        compatible = "renesas,sh7751r-cpg";
+        clocks = <&xtal>;
+        clock-names = "xtal";
+        reg = <0xffc00000 20>, <0xfe0a0000 16>;
+        reg-names = "FRQCR", "CLKSTP00";
+        renesas,mode = <0>;
+    };
diff --git a/include/dt-bindings/clock/sh7750-cpg.h b/include/dt-bindings/clock/sh7750-cpg.h
new file mode 100644
index 000000000000..17d5a8076aac
--- /dev/null
+++ b/include/dt-bindings/clock/sh7750-cpg.h
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
+#define SH7750_MSTP_SCI		4
+#define SH7750_MSTP_RTC		5
+#define SH7750_MSTP_TMU012	6
+#define SH7750_MSTP_SCIF	7
+#define SH7750_MSTP_DMAC	8
+#define SH7750_MSTP_UBC		9
+#define SH7750_MSTP_SQ		10
+#define SH7750_CSTP_INTC	11
+#define SH7750_CSTP_TMU34	12
+#define SH7750_CSTP_PCIC	13
+
+#endif
-- 
2.39.2

