Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53854911
	for <linux-sh@vger.kernel.org>; Thu,  4 Apr 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206857; cv=none; b=NKQoFTT1BS4kYWgKM4PSXBpIZOoMBIwtv7aOOKVxsk6CIjCcpqubfX4coeF9p1GfPNGYlWCbNXIy+2aatlfPp8NesFxCU/RP9X4KbJpPxxSovpYdx7ZY+q+u5PIfdyOH4JoHmIQ9oQgcaf7L/p5A/21Bwx3whi0ZZ5xd8QeQiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206857; c=relaxed/simple;
	bh=s7z/DJLA2hvdIV/rv9zwgO39neOGHSX5TSCrrrQvjFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X47kEV0mycV9eAn/ynR1hmrJT3M/dMVFoPOPpAALXDYk2J4asPykpqsYKaIzfFH6kHANDajQVrt2EPeCNpsz1PBgsfi8H/gtqB+sBNVlMcMYFDH1v9mDcPArrLPafa0032GeWmwF/C+btqeAN4V3NcW93eI46xPTUoYlLxUQ/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 250741C03E3;
	Thu,  4 Apr 2024 14:00:55 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [DO NOT MERGE v7 11/36] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
Date: Thu,  4 Apr 2024 13:59:38 +0900
Message-Id: <4d3b2398e724dfa0682eb6108dfca2ae6593b3ee.1712041249.git.ysato@users.sourceforge.jp>
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

Renesas SH7751 PCI Controller json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/pci/renesas,sh7751-pci.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
new file mode 100644
index 000000000000..115c2bb67339
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,sh7751-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 PCI Host controller
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: renesas,sh7751-pci
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: PCI Controller
+      - const: Bus State Controller
+
+  "#interrupt-cells":
+    const: 1
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  dma-ranges: true
+
+  interrupt-controller: true
+
+  renesas,bus-arbit-round-robin:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set DMA bus arbitration to round robin.
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pci@fe200000 {
+            compatible = "renesas,sh7751-pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            device_type = "pci";
+            bus-range = <0 0>;
+            ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+                     <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
+            dma-ranges = <0x02000000 0 0xc000000 0x0c000000 0 0x04000000>;
+            reg = <0xfe200000 0x0400>,
+                  <0xff800000 0x0100>;
+            interrupt-map = <0x0000 0 0 1 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0000 0 0 2 &julianintc 6 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0000 0 0 3 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0000 0 0 4 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 1 &julianintc 6 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 2 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 3 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 4 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 1 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 2 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 3 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 4 &julianintc 6 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-map-mask = <0x1800 0 0 7>;
+    };
-- 
2.39.2

