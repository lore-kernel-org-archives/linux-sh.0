From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Nov 2014 15:52:04 +0000
Subject: [PATCH 6/6] ARM: shmobile: r8a73a4: add MSTP clock assignments to DT
Message-Id: <1415375524-15468-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Assigns clocks to dmac, i2c*, cmt1, thermal, scif*, sdhi*, and mmcif*.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index c93eada..932ff75 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -72,6 +72,7 @@
 					0 217 IRQ_TYPE_LEVEL_HIGH
 					0 218 IRQ_TYPE_LEVEL_HIGH
 					0 219 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A73A4_CLK_DMAC>;
 			interrupt-names = "error",
 					"ch0", "ch1", "ch2", "ch3",
 					"ch4", "ch5", "ch6", "ch7",
@@ -110,6 +111,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IIC5>;
 
 		status = "disabled";
 	};
@@ -118,6 +120,8 @@
 		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
+		clock-names = "fck";
 
 		renesas,channels-mask = <0xff>;
 
@@ -201,6 +205,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
 	};
 
 	i2c0: i2c@e6500000 {
@@ -209,6 +214,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x428>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC0>;
 		status = "disabled";
 	};
 
@@ -218,6 +224,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x428>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC1>;
 		status = "disabled";
 	};
 
@@ -227,6 +234,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6520000 0 0x428>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC2>;
 		status = "disabled";
 	};
 
@@ -236,6 +244,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6530000 0 0x428>;
 		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IIC3>;
 		status = "disabled";
 	};
 
@@ -245,6 +254,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6540000 0 0x428>;
 		interrupts = <0 178 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IIC4>;
 		status = "disabled";
 	};
 
@@ -254,6 +264,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6550000 0 0x428>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC6>;
 		status = "disabled";
 	};
 
@@ -263,6 +274,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6560000 0 0x428>;
 		interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_IIC7>;
 		status = "disabled";
 	};
 
@@ -272,6 +284,7 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe6570000 0 0x428>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A73A4_CLK_IIC8>;
 		status = "disabled";
 	};
 
@@ -279,6 +292,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -286,6 +301,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -293,6 +310,8 @@
 		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
 		reg = <0 0xe6c40000 0 0x100>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -300,6 +319,8 @@
 		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
 		reg = <0 0xe6c50000 0 0x100>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -307,6 +328,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB2>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -314,6 +337,8 @@
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6cf0000 0 0x100>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB3>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -321,6 +346,7 @@
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_SDHI0>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -329,6 +355,7 @@
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_SDHI1>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -337,6 +364,7 @@
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_SDHI2>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -345,6 +373,7 @@
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF0>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -353,6 +382,7 @@
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF1>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
-- 
1.8.4.5

