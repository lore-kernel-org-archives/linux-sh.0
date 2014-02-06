From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:49 +0000
Subject: [PATCH 14/17] ARM: shmobile: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <cde630f763b07ff5d8ff7d34969f9dd05a2a4001.1391665761.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds SATA[01] device nodes to r8a7790.dtsi

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 8cc68f7..0914921 100644
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
1.8.5.2

