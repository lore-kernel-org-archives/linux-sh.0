From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 08:10:33 +0000
Subject: [PATCH 08/08] ARM: shmobile: Remove CMT renesas,channels-mask from DTS
Message-Id: <20150621081033.10187.38630.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
In-Reply-To: <20150621080903.10187.20998.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Update the DTS to remove the now deprecated "renesas,channels-mask" property.

The channel information is now kept in the device driver and can easily
be determined based on the compat string.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a73a4.dtsi |    3 ---
 arch/arm/boot/dts/r8a7740.dtsi |    3 ---
 arch/arm/boot/dts/r8a7790.dtsi |    6 ------
 arch/arm/boot/dts/r8a7791.dtsi |    6 ------
 arch/arm/boot/dts/r8a7793.dtsi |    6 ------
 arch/arm/boot/dts/r8a7794.dtsi |    6 ------
 arch/arm/boot/dts/sh73a0.dtsi  |    3 ---
 7 files changed, 33 deletions(-)

--- 0009/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2015-06-20 14:51:41.942366518 +0900
@@ -120,9 +120,6 @@
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0001/arch/arm/boot/dts/r8a7740.dtsi
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2015-06-20 14:52:11.332366518 +0900
@@ -60,9 +60,6 @@
 		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0x3f>;
-
 		status = "disabled";
 	};
 
--- 0009/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-06-20 14:50:43.532366518 +0900
@@ -218,9 +218,6 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -237,9 +234,6 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0009/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-06-20 14:51:00.622366518 +0900
@@ -199,9 +199,6 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -218,9 +215,6 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0009/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-06-20 14:51:16.702366518 +0900
@@ -68,9 +68,6 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7793_CLK_CMT0>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -87,9 +84,6 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7793_CLK_CMT1>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0009/arch/arm/boot/dts/r8a7794.dtsi
+++ work/arch/arm/boot/dts/r8a7794.dtsi	2015-06-20 14:51:29.512366518 +0900
@@ -57,9 +57,6 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -76,9 +73,6 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
 		clock-names = "fck";
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0001/arch/arm/boot/dts/sh73a0.dtsi
+++ work/arch/arm/boot/dts/sh73a0.dtsi	2015-06-20 14:51:56.502366518 +0900
@@ -84,9 +84,6 @@
 		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0x3f>;
-
 		status = "disabled";
 	};
 
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
