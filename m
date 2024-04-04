Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E45B1FB
	for <linux-sh@vger.kernel.org>; Thu,  4 Apr 2024 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206867; cv=none; b=E3VQ2hyjmpIF1+dMVuO6Td7kpChCH2EtrrrXCY2Ux93jl9v3R2joonPCFhcTaHj1sL1gGJiILscAbT459GowM2BZJoECAGZlvaM0JL0OeaETTKqvJzQeP5WSyR5YQzP5Djw+MX8DfZIWMMpP+TXSCvTDHLJNCbVfSOGwE6axOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206867; c=relaxed/simple;
	bh=D5ws4kol4ISHVGnY0BX2xqWsX9b4sW1yZaI0O/y/rdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DX/nEhFTw5PR8u2jNdUlKPaVOyYSW8gCJnIzRnqcj4PUpFWorqPxCwSz+OnPHuMqPt0vOL1V2O87qVsFr5CvwSdxrfv8bRHsQkAVmOIVwdm2Vf1rUT4nqUwn7YdZN6fex71LnQm5mRs3u4q4NrdFbzNodIPBnkIt+FvvUk0n5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 1F4D91C092F;
	Thu,  4 Apr 2024 14:01:05 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [DO NOT MERGE v7 16/36] dt-bindings: interrupt-controller: renesas,sh7751-intc: Add json-schema
Date: Thu,  4 Apr 2024 13:59:48 +0900
Message-Id: <cdb5f83d3e66b71ac63abe2d5cb69c201ff9ca1e.1712041249.git.ysato@users.sourceforge.jp>
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

Renesas SH7751 INTC json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../renesas,sh7751-intc.yaml                  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
new file mode 100644
index 000000000000..fb924eff465d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
@@ -0,0 +1,53 @@
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
+    const: 1
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ICR
+      - const: INTPRI00
+
+  renesas,icr-irlm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If true four independent interrupt requests mode (ICR.IRLM is 1).
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#interrupt-cells'
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/renesas,sh7751-intc.h>
+    shintc: interrupt-controller@ffd00000 {
+            compatible = "renesas,sh7751-intc";
+            reg = <0xffd00000 14>, <0xfe080000 128>;
+            reg-names = "ICR", "INTPRI00";
+            #interrupt-cells = <1>;
+            interrupt-controller;
+    };
+...
-- 
2.39.2

