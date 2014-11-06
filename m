From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 06 Nov 2014 16:50:40 +0000
Subject: [PATCH v4 5/6] ARM: shmobile: sh73a0: add MSTP clock assignments to DT
Message-Id: <1415292641-30331-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Assigns clocks to cmt1, i2c*, mmcif, sdhi*, and scif*.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 4bec870..b48b382 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -56,6 +56,8 @@
 
 		renesas,channels-mask = <0x3f>;
 
+		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
+		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -145,6 +147,7 @@
 			      0 168 IRQ_TYPE_LEVEL_HIGH
 			      0 169 IRQ_TYPE_LEVEL_HIGH
 			      0 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks SH73A0_CLK_IIC0>;
 		status = "disabled";
 	};
 
@@ -157,6 +160,7 @@
 			      0 52 IRQ_TYPE_LEVEL_HIGH
 			      0 53 IRQ_TYPE_LEVEL_HIGH
 			      0 54 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks SH73A0_CLK_IIC1>;
 		status = "disabled";
 	};
 
@@ -169,6 +173,7 @@
 			      0 172 IRQ_TYPE_LEVEL_HIGH
 			      0 173 IRQ_TYPE_LEVEL_HIGH
 			      0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks SH73A0_CLK_IIC2>;
 		status = "disabled";
 	};
 
@@ -181,6 +186,7 @@
 			      0 184 IRQ_TYPE_LEVEL_HIGH
 			      0 185 IRQ_TYPE_LEVEL_HIGH
 			      0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks SH73A0_CLK_IIC3>;
 		status = "disabled";
 	};
 
@@ -193,6 +199,7 @@
 			      0 188 IRQ_TYPE_LEVEL_HIGH
 			      0 189 IRQ_TYPE_LEVEL_HIGH
 			      0 190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks SH73A0_CLK_IIC4>;
 		status = "disabled";
 	};
 
@@ -202,6 +209,7 @@
 		interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH
 			      0 141 IRQ_TYPE_LEVEL_HIGH>;
 		reg-io-width = <4>;
+		clocks = <&mstp3_clks SH73A0_CLK_MMCIF0>;
 		status = "disabled";
 	};
 
@@ -212,6 +220,7 @@
 			      0 84 IRQ_TYPE_LEVEL_HIGH
 			      0 85 IRQ_TYPE_LEVEL_HIGH>;
 		cap-sd-highspeed;
+		clocks = <&mstp3_clks SH73A0_CLK_SDHI0>;
 		status = "disabled";
 	};
 
@@ -223,6 +232,7 @@
 			      0 89 IRQ_TYPE_LEVEL_HIGH>;
 		toshiba,mmc-wrprotect-disable;
 		cap-sd-highspeed;
+		clocks = <&mstp3_clks SH73A0_CLK_SDHI1>;
 		status = "disabled";
 	};
 
@@ -233,6 +243,7 @@
 			      0 105 IRQ_TYPE_LEVEL_HIGH>;
 		toshiba,mmc-wrprotect-disable;
 		cap-sd-highspeed;
+		clocks = <&mstp3_clks SH73A0_CLK_SDHI2>;
 		status = "disabled";
 	};
 
@@ -240,6 +251,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c40000 0x100>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -247,6 +260,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -254,6 +269,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA2>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -261,6 +278,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c70000 0x100>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA3>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -268,6 +287,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c80000 0x100>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -275,6 +296,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cb0000 0x100>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA5>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -282,6 +305,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cc0000 0x100>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks SH73A0_CLK_SCIFA6>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -289,6 +314,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cd0000 0x100>;
 		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA7>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -296,6 +323,8 @@
 		compatible = "renesas,scifb-sh73a0", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFB>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
-- 
1.8.4.5

