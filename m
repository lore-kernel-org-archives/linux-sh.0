From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Dec 2014 04:56:08 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: Use MSTP for SCIF clocks
Message-Id: <20141215045608.316.71001.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up MSTP clocks to SCIF devices on r8a7779 to allow
clock gating to work as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20141211-v3.18
 Broken out from previously submitted
 [PATCH] ARM: shmobile: r8a7779 CCF DTS update

 arch/arm/boot/dts/r8a7779.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2014-12-15 12:26:48.000000000 +0900
@@ -200,7 +200,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -209,7 +209,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -218,7 +218,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -227,7 +227,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -236,7 +236,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -245,7 +245,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
