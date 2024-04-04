Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0A5676F
	for <linux-sh@vger.kernel.org>; Thu,  4 Apr 2024 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206859; cv=none; b=nbjr75JQs53a0d0Ey1xpif38pyqtIAh64wntIRXd7WDRg/Eo1LKK6iNGCS5RMzFgbxWdbkGOno3BwobWQgsDQ3mSvGM+U5RL2VJ2OXOERrSX/YfpkpFgbY236s5gsBevWB3qn7ofarRb79ASvYf5tve4JknZWqqSH7JVSza9gBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206859; c=relaxed/simple;
	bh=1xMW4sZCG05RmqUl4sfWusbiwrMTmOWImJT9AqMcM98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAWPBFPXbcDwmxj0ozFCD0iRtFnHUvqVYA0PWRHNQnXh24poqERhcUwdyzUdFL/zTsH+DNs96rL8yVr4V+Sc8el41AA2DJzu+gH4yjDcWOYy45A8yTh07CpsmFVkj8yXIYBzfcNiUN6noQ/oXdrNtITpcsaTe+BR6pIwqlRvJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 1F1281C03BE;
	Thu,  4 Apr 2024 14:00:57 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [DO NOT MERGE v7 12/36] dt-bindings: clock: sh7750-cpg: Add renesas,sh7750-cpg header.
Date: Thu,  4 Apr 2024 13:59:40 +0900
Message-Id: <bd25c147683abbc416f237f0e78cd716d52dc927.1712041249.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712041249.git.ysato@users.sourceforge.jp>
References: <cover.1712041249.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SH7750 CPG Clock output define.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/clock/renesas,sh7750-cpg.yaml    | 105 ++++++++++++++++++
 include/dt-bindings/clock/sh7750-cpg.h        |  26 +++++
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
 create mode 100644 include/dt-bindings/clock/sh7750-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
new file mode 100644
index 000000000000..04c10b0834ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
@@ -0,0 +1,105 @@
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
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: extal
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
+        clocks = <&extal>;
+        clock-names = "extal";
+        reg = <0xffc00000 20>, <0xfe0a0000 16>;
+        reg-names = "FRQCR", "CLKSTP00";
+        renesas,mode = <0>;
+    };
diff --git a/include/dt-bindings/clock/sh7750-cpg.h b/include/dt-bindings/clock/sh7750-cpg.h
new file mode 100644
index 000000000000..ec267be91adf
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
+#define SH7750_CPG_PCK		1
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

