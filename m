From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Apr 2014 22:49:41 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add internal PCI bridge nodes
Message-Id: <201404080249.42211.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404080248.14139.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404080248.14139.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add device nodes for the R8A7791 internal PCI bridge devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791.dtsi |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -875,4 +875,30 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pci0: pci@ee090000 {
+		compatible = "renesas,pci-r8a7791";
+		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
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
+	pci1: pci@ee0d0000 {
+		compatible = "renesas,pci-r8a7791";
+		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		reg = <0x0 0xee0d0000 0x0 0xc00>,
+		      <0x0 0xee0c0000 0x0 0x1100>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <1 1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
 };
