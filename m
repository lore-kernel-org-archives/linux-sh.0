From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 02 Jul 2014 22:43:23 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add CAN DT support
Message-Id: <201407030243.25237.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407030239.15921.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407030239.15921.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the generic R8A7791 parts of the CAN0/1 device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -518,6 +518,22 @@
 		status = "disabled";
 	};
 
+	can0: can@e6e80000 {
+		compatible = "renesas,rcar-can";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>;
+		status = "disabled";
+	};
+
+	can1: can@e6e88000 {
+		compatible = "renesas,rcar-can";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
