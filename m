From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:54:42 +0000
Subject: [PATCH v2 08/11] ARM: shmobile: Remove CMT renesas,channels-mask from DTS
Message-Id: <20150917095442.5369.63550.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
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
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 Changes since V1:
 - Rebased on top of power-domain changes
 - Added Acked-by and Tested-by from Geert

 arch/arm/boot/dts/r8a73a4.dtsi |    3 ---
 arch/arm/boot/dts/r8a7740.dtsi |    3 ---
 arch/arm/boot/dts/r8a7790.dtsi |    6 ------
 arch/arm/boot/dts/r8a7791.dtsi |    6 ------
 arch/arm/boot/dts/r8a7793.dtsi |    6 ------
 arch/arm/boot/dts/r8a7794.dtsi |    6 ------
 arch/arm/boot/dts/sh73a0.dtsi  |    3 ---
 7 files changed, 33 deletions(-)

--- 0010/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2015-09-17 17:41:05.250513000 +0900
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
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2015-09-17 17:41:05.250513000 +0900
@@ -60,9 +60,6 @@
 		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0x3f>;
-
 		status = "disabled";
 	};
 
--- 0010/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-09-17 17:45:02.110513000 +0900
@@ -226,9 +226,6 @@
 		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -246,9 +243,6 @@
 		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0010/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-09-17 17:44:54.210513000 +0900
@@ -209,9 +209,6 @@
 		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -229,9 +226,6 @@
 		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0010/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-09-17 17:44:48.400513000 +0900
@@ -69,9 +69,6 @@
 		clocks = <&mstp1_clks R8A7793_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -89,9 +86,6 @@
 		clocks = <&mstp3_clks R8A7793_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0010/arch/arm/boot/dts/r8a7794.dtsi
+++ work/arch/arm/boot/dts/r8a7794.dtsi	2015-09-17 17:44:43.300513000 +0900
@@ -161,9 +161,6 @@
 		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -181,9 +178,6 @@
 		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
--- 0001/arch/arm/boot/dts/sh73a0.dtsi
+++ work/arch/arm/boot/dts/sh73a0.dtsi	2015-09-17 17:44:32.950513000 +0900
@@ -84,9 +84,6 @@
 		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0x3f>;
-
 		status = "disabled";
 	};
 
