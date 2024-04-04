Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC143AB6
	for <linux-sh@vger.kernel.org>; Thu,  4 Apr 2024 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206871; cv=none; b=KA7Oa/+cEb/6Fp4NsNySSuOl2nG0ezGVAmxadZniu1V1Dhn5ZTKlQ59upKT2HL0+0Sl4cPPVEDd4BroqWUDmXQYZByP2Dp14v7G9FHDSpCBPU5cFS8VzUk9OqY2KCqXF1fnlohUCrIMVshkGM2hv57vIdoWmmacqMuqP2z9HQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206871; c=relaxed/simple;
	bh=7IdyKC16TiRcoV3/cW/Zd7MaUktUAv9ffK9AZ3hzcao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hr6OqgCugIAq/WqqRkVWOlQIVX2Tfiyihbaf93N7VpsFcXp6Bt8g8LULqbT+ie8DD8xRkCVgqqcq6fu6hxj2iMGNLtBihIq1Fn/9lwANTzSHLhZhl0LNvSZAEYopxLnI2M9/niPNDF1fKmnL4gXsFSz/d8JSE04J6wWkcL/ObaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id EDD231C016F;
	Thu,  4 Apr 2024 14:01:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [DO NOT MERGE v7 18/36] dt-bindings: interrupt-controller: renesas,sh7751-irl-ext: Add json-schema
Date: Thu,  4 Apr 2024 13:59:52 +0900
Message-Id: <39bee5a5e2b8e30c072a69211983b723bd3ab98d.1712041249.git.ysato@users.sourceforge.jp>
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

Renesas SH7751 external interrupt encoder json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../renesas,sh7751-irl-ext.yaml               | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
new file mode 100644
index 000000000000..fc174c0467e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 external interrupt encoder with enable regs.
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description:
+  This is the generally used external interrupt encoder on SH7751 based boards.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,sh7751-irl-ext
+
+  reg: true
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  renesas,set-to-disable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Invert enable registers. Setting the bit to 0 enables interrupts.
+
+  renesas,enable-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      IRQ enable register bit mapping
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - renesas,enable-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    r2dintc: interrupt-controller@a4000000 {
+        compatible = "renesas,sh7751-irl-ext";
+        reg = <0xa4000000 0x02>;
+        interrupt-controller;
+        #address-cells = <0>;
+        #interrupt-cells = <1>;
+        renesas,enable-reg = <12 9 10 3 0 4 1 2 8 5 6 7 15 15 15 11>;
+    };
-- 
2.39.2

