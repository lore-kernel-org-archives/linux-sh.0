From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:47 +0000
Subject: [PATCH 12/17] ARM: shmobile: r8a7791: Add SATA nodes to r8a7791.dtsi
Message-Id: <b8532c699a163702bfcadaaa4c23c4ff71b67eec.1391665761.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds SATA[01] device nodes to r8a7791.dtsi.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 94e3cc1..d5cc362 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -366,6 +366,24 @@
 		status = "disabled";
 	};
 
+	sata0: sata@ee300000 {
+		compatible = "renesas,sata-r8a7791";
+		reg = <0 0xee300000 0 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
+		status = "disabled";
+	};
+
+	sata1: sata@ee500000 {
+		compatible = "renesas,sata-r8a7791";
+		reg = <0 0xee500000 0 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.5.2

