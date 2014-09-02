From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Sep 2014 09:13:00 +0000
Subject: [PATCH v2 04/10] ARM: shmobile: sh73a0: add MSTP clock assignments to DT
Message-Id: <1409649186-1046-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Assigns clocks to i2c*, mmcif, sdhi*, and scif*.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 84efcc1..dad8404 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -135,6 +135,7 @@
 			      0 168 IRQ_TYPE_LEVEL_HIGH
 			      0 169 IRQ_TYPE_LEVEL_HIGH
 			      0 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks SH73A0_CLK_IIC0>;
 		status = "disabled";
 	};
 
@@ -147,6 +148,7 @@
 			      0 52 IRQ_TYPE_LEVEL_HIGH
 			      0 53 IRQ_TYPE_LEVEL_HIGH
 			      0 54 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks SH73A0_CLK_IIC1>;
 		status = "disabled";
 	};
 
@@ -159,6 +161,7 @@
 			      0 172 IRQ_TYPE_LEVEL_HIGH
 			      0 173 IRQ_TYPE_LEVEL_HIGH
 			      0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks SH73A0_CLK_IIC2>;
 		status = "disabled";
 	};
 
@@ -171,6 +174,7 @@
 			      0 184 IRQ_TYPE_LEVEL_HIGH
 			      0 185 IRQ_TYPE_LEVEL_HIGH
 			      0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks SH73A0_CLK_IIC3>;
 		status = "disabled";
 	};
 
@@ -183,6 +187,7 @@
 			      0 188 IRQ_TYPE_LEVEL_HIGH
 			      0 189 IRQ_TYPE_LEVEL_HIGH
 			      0 190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks SH73A0_CLK_IIC4>;
 		status = "disabled";
 	};
 
@@ -192,6 +197,7 @@
 		interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH
 			      0 141 IRQ_TYPE_LEVEL_HIGH>;
 		reg-io-width = <4>;
+		clocks = <&mstp3_clks SH73A0_CLK_MMCIF0>;
 		status = "disabled";
 	};
 
@@ -202,6 +208,7 @@
 			      0 84 IRQ_TYPE_LEVEL_HIGH
 			      0 85 IRQ_TYPE_LEVEL_HIGH>;
 		cap-sd-highspeed;
+		clocks = <&mstp3_clks SH73A0_CLK_SDHI0>;
 		status = "disabled";
 	};
 
@@ -213,6 +220,7 @@
 			      0 89 IRQ_TYPE_LEVEL_HIGH>;
 		toshiba,mmc-wrprotect-disable;
 		cap-sd-highspeed;
+		clocks = <&mstp3_clks SH73A0_CLK_SDHI1>;
 		status = "disabled";
 	};
 
@@ -223,6 +231,7 @@
 			      0 105 IRQ_TYPE_LEVEL_HIGH>;
 		toshiba,mmc-wrprotect-disable;
 		cap-sd-highspeed;
+		clocks = <&mstp3_clks SH73A0_CLK_SDHI2>;
 		status = "disabled";
 	};
 
@@ -230,6 +239,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c40000 0x100>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -237,6 +248,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -244,6 +257,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA2>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -251,6 +266,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c70000 0x100>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA3>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -258,6 +275,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c80000 0x100>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -265,6 +284,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cb0000 0x100>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA5>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -272,6 +293,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cc0000 0x100>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks SH73A0_CLK_SCIFA6>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -279,6 +302,8 @@
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cd0000 0x100>;
 		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA7>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -286,6 +311,8 @@
 		compatible = "renesas,scifb-sh73a0", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFB>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
-- 
1.8.4.5

