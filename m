From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 29 Dec 2014 22:06:07 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: add CAN DT support
Message-Id: <5498306.nhRks3sT7k@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2616635.bsb7mLynhA@wasted.cogentembedded.com>
In-Reply-To: <2616635.bsb7mLynhA@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the generic R8A7790 parts of the CAN0/1 device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7790.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -792,6 +792,26 @@
 		};
 	};
 
+	can0: can@e6e80000 {
+		compatible = "renesas,can-r8a7790";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
+		       	 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
+	can1: can@e6e88000 {
+		compatible = "renesas,can-r8a7790";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
+		       	 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;

