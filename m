From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:31:43 +0000
Subject: [RFC/PATCH 3/6] ARM: shmobile: r8a7790: Rename the serial port clock to fck
Message-Id: <1398817906-6023-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d38d703..0684710 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -344,7 +344,7 @@
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -353,7 +353,7 @@
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -362,7 +362,7 @@
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -371,7 +371,7 @@
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -380,7 +380,7 @@
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -389,7 +389,7 @@
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -398,7 +398,7 @@
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -407,7 +407,7 @@
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -416,7 +416,7 @@
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -425,7 +425,7 @@
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
-- 
1.8.3.2

