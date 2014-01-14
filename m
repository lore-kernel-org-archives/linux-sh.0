From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 14 Jan 2014 17:05:30 +0000
Subject: [PATCH 1/2] ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA[01] device nodes to r8a7790.dtsi

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b2c2845..f2f5394 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -400,6 +400,24 @@
 		status = "disabled";
 	};
 
+	sata0: sata@ee300000 {
+		compatible = "renesas,sata-r8a7790";
+		reg = <0 0xee300000 0 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
+		status = "disabled";
+	};
+
+	sata1: sata@ee500000 {
+		compatible = "renesas,sata-r8a7790";
+		reg = <0 0xee500000 0 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.3.1

