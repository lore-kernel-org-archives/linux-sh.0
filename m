From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 05 Jan 2015 22:25:25 +0000
Subject: [PATCH v5 2/3] ARM: shmobile: r8a7791: add CAN DT support
Message-Id: <2610028.tvJWHLiVKM@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1652479.NHBlqJ9OaR@wasted.cogentembedded.com>
In-Reply-To: <1652479.NHBlqJ9OaR@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the generic R8A7791 parts of the CAN0/1 device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 5:
- fixed whitespace errors/warnings given by checkpatch.pl;
- added Geert's ACK.

Changes in version 4:
- refreshed the patch.

Changes in version 3:
- added 2 more CAN clocks along with "clock-names" property in the CAN0/1 device
  nodes;
- refreshed the patch.

Changes in version 2:
- fixed the "compatible" property in the CAN device nodes.

 arch/arm/boot/dts/r8a7791.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -816,6 +816,26 @@
 		};
 	};
 
+	can0: can@e6e80000 {
+		compatible = "renesas,can-r8a7791";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
+			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
+	can1: can@e6e88000 {
+		compatible = "renesas,can-r8a7791";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
+			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;

