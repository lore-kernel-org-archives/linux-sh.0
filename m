From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Dec 2014 00:13:44 +0000
Subject: [PATCH 05/10] iommu/ipmmu-vmsa: Add device tree bindings documentation
Message-Id: <1418602429-11276-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt

Cc: devicetree@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
new file mode 100644
index 000000000000..88b5bacc8c7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -0,0 +1,37 @@
+* Renesas VMSA-Compatible IOMMU
+
+The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
+It provides address translation for bus masters outside of the CPU, each
+connected to the IPMMU through a port called micro-TLB.
+
+
+Required Properties:
+
+  - compatible: Must contain "renesas,ipmmu-vmsa".
+  - reg: Base address and size of the IPMMU registers.
+  - interrupts: Specifier for the MMU fault interrupt.
+
+  - #iommu-cells: Must be 1.
+
+Each bus master connected to an IPMMU must reference the IPMMU in its device
+node with the following property:
+
+  - iommus: A reference to the IPMMU in two cells. The first cell is a phandle
+    to the IPMMU and the second cell the number of the micro-TLB that the
+    device is connected to.
+
+
+Example: R8A7791 IPMMU-MX and VSP1-D0 bus master
+
+	ipmmu_mx: mmu@fe951800 {
+		compatible = "renasas,ipmmu-vmsa";
+		reg = <0 0xfe951800 0 0x800>;
+		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+	};
+
+	vsp1@fe928000 {
+		...
+		iommus = <&ipmmu_mx 13>;
+		...
+	};
-- 
2.0.4

