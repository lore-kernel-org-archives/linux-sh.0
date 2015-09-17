From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:54:23 +0000
Subject: [PATCH v2 06/11] ARM: shmobile: Update CMT compat string users in DTS
Message-Id: <20150917095423.5369.73513.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Use recently updated r8a73a4 and R-Car Gen2 CMT0 and CMT1 compat strings.

With this change in place we can keep device-specific configuration in
the driver and the driver can be able to support CMT1 specific features.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Added Acked-by and Tested-by from Geert
 - Added Acked-by from Laurent

 arch/arm/boot/dts/r8a73a4.dtsi |    2 +-
 arch/arm/boot/dts/r8a7790.dtsi |    4 ++--
 arch/arm/boot/dts/r8a7791.dtsi |    4 ++--
 arch/arm/boot/dts/r8a7793.dtsi |    4 ++--
 arch/arm/boot/dts/r8a7794.dtsi |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

--- 0001/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2015-09-17 17:35:37.230513000 +0900
@@ -114,7 +114,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a73a4", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-09-17 17:35:37.230513000 +0900
@@ -219,7 +219,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7790", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7790", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -233,7 +233,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a7790", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7790", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-09-17 17:35:37.230513000 +0900
@@ -202,7 +202,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7791", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -216,7 +216,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7791", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--- 0001/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-09-17 17:35:37.230513000 +0900
@@ -62,7 +62,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7793", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7793", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -76,7 +76,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a7793", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7793", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--- 0001/arch/arm/boot/dts/r8a7794.dtsi
+++ work/arch/arm/boot/dts/r8a7794.dtsi	2015-09-17 17:35:37.230513000 +0900
@@ -154,7 +154,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7794", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -168,7 +168,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7794", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
