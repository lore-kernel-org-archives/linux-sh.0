Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C032C4167B
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjKNIA7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjKNIA6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:58 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B7E819E
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:55 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id A1D8F1C03C0;
        Tue, 14 Nov 2023 17:00:54 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 13/37] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
Date:   Tue, 14 Nov 2023 17:00:04 +0900
Message-Id: <f16957c3396af37aab328f577f5af19e369b299b.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Renesas SH7751 PCI Controller json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/pci/renesas,sh7751-pci.yaml      | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
new file mode 100644
index 000000000000..17bc7d2118a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
@@ -0,0 +1,123 @@
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
+    items:
+      - enum:
+          - renesas,sh7751-pci
+
+  reg:
+    minItems: 3
+    maxItems: 3
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
+  interrupt-controller: true
+
+  renesas,bcr1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIBCR1 value. This value makes add the value of BSC's BCR1.
+
+  renesas,mcrmask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIMCR value. This value makes clear bit in the value of BSC's MCR.
+
+  renesas,intm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIINTM value.
+
+  renesas,aintm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIIANTM value.
+
+  renesas,lsr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCILSR0 and PCILSR1 values.
+      First word is PCILSR0, Second word is PCILSR1.
+
+  renesas,lar:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCILSA0 and PCILAR1 values.
+      First word is PCILAR0, Second word is PCILAR1.
+
+  renesas,dmabt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIDMABT value.
+
+  renesas,pintm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SH7751 PCIC PCIPINTM value.
+
+  renesas,config:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      SH7751 PCIC PCICONFIG values array. Register Number and value pair list.
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
+    pci@fe200000 {
+            compatible = "renesas,sh7751-pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+                     <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
+            reg = <0xfe200000 0x0400>,
+                  <0x0c000000 0x04000000>,
+                  <0xff800000 0x0030>;
+            #interrupt-cells = <1>;
+            interrupt-map = <0x0000 0 0 1 &julianintc 5>,
+                            <0x0000 0 0 2 &julianintc 6>,
+                            <0x0000 0 0 3 &julianintc 7>,
+                            <0x0000 0 0 4 &julianintc 8>,
+                            <0x0800 0 0 1 &julianintc 6>,
+                            <0x0800 0 0 2 &julianintc 7>,
+                            <0x0800 0 0 3 &julianintc 8>,
+                            <0x0800 0 0 4 &julianintc 5>,
+                            <0x1000 0 0 1 &julianintc 7>,
+                            <0x1000 0 0 2 &julianintc 8>,
+                            <0x1000 0 0 3 &julianintc 5>,
+                            <0x1000 0 0 4 &julianintc 6>;
+            interrupt-map-mask = <0x1800 0 0 7>;
+    };
-- 
2.39.2

