From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:31:44 +0000
Subject: [RFC/PATCH 4/6] ARM: shmobile: r8a7791: Rename the serial port clock to fck
Message-Id: <1398817906-6023-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 44f0344..a3a89c4 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -318,7 +318,7 @@
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -327,7 +327,7 @@
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -336,7 +336,7 @@
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -345,7 +345,7 @@
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -354,7 +354,7 @@
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -363,7 +363,7 @@
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -372,7 +372,7 @@
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -381,7 +381,7 @@
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -390,7 +390,7 @@
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -399,7 +399,7 @@
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -408,7 +408,7 @@
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -417,7 +417,7 @@
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -426,7 +426,7 @@
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -435,7 +435,7 @@
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -444,7 +444,7 @@
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -453,7 +453,7 @@
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -462,7 +462,7 @@
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -471,7 +471,7 @@
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		status = "disabled";
 	};
 
-- 
1.8.3.2

