From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 09 Feb 2015 16:02:34 +0000
Subject: [PATCH v2 06/15] ARM: shmobile: r8a7778: add MSTP clock assignments to DT
Message-Id: <1423497763-3450-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Assigns clocks to i2c*, tmu*, scif*, mmcif, sdhi*, and hspi*.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 98e941b..2ddfaa3e 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -133,6 +133,7 @@
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -142,6 +143,7 @@
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -151,6 +153,7 @@
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -160,6 +163,7 @@
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -169,6 +173,8 @@
 		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_TMU0>;
+		clock-names = "fck";
 
 		#renesas,channels = <3>;
 
@@ -181,6 +187,8 @@
 		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_TMU1>;
+		clock-names = "fck";
 
 		#renesas,channels = <3>;
 
@@ -193,6 +201,8 @@
 		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_TMU2>;
+		clock-names = "fck";
 
 		#renesas,channels = <3>;
 
@@ -203,6 +213,8 @@
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -210,6 +222,8 @@
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -217,6 +231,8 @@
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -224,6 +240,8 @@
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -231,6 +249,8 @@
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -238,6 +258,8 @@
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -245,6 +267,7 @@
 		compatible = "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
 		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7778_CLK_MMC>;
 		status = "disabled";
 	};
 
@@ -252,6 +275,7 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7778_CLK_SDHI0>;
 		status = "disabled";
 	};
 
@@ -259,6 +283,7 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7778_CLK_SDHI1>;
 		status = "disabled";
 	};
 
@@ -266,6 +291,7 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7778_CLK_SDHI2>;
 		status = "disabled";
 	};
 
@@ -273,6 +299,7 @@
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
 		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -282,6 +309,7 @@
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
 		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -291,6 +319,7 @@
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
 		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
2.2.2

