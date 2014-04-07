From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Apr 2014 22:37:44 +0000
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
Message-Id: <201404080237.45734.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add device nodes for the R8A7790 internal PCI bridge devices.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- reworded summary (fixing typo) and changelog;
- removed extra spaces before {;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -820,4 +820,43 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pci0: pci@ee090000 {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee090000 0x0 0xc00>,
+		      <0x0 0xee080000 0x0 0x1100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+	pci1: pci@ee0b0000 {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0b0000 0x0 0xc00>,
+		      <0x0 0xee0a0000 0x0 0x1100>;
+		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <1 1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+	pci2: pci@ee0d0000 {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0d0000 0x0 0xc00>,
+		      <0x0 0xee0c0000 0x0 0x1100>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <2 2>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
 };
