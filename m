From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:45:46 +0000
Subject: [PATCH 11/17] ARM: shmobile: r8a7778: fixup DT node naming for SDHI
Message-Id: <8738o3dljt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SDHI DT node from "sdhi" to "sd".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |    6 +++---
 arch/arm/boot/dts/r8a7778.dtsi                |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 8146d26..b317a1dc6 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -81,15 +81,15 @@
 		renesas,function = "mmc";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sd0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl",
 				  "sdhi0_cd", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
 };
 
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+&sd0 {
+	pinctrl-0 = <&sd0_pins>;
 	pinctrl-names = "default";
 
 	vmmc-supply = <&fixedregulator3v3>;
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 873eeb9..322b703 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -165,7 +165,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi@ffe4c000 {
+	sd0: sd@ffe4c000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
@@ -175,7 +175,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@ffe4d000 {
+	sd1: sd@ffe4d000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
@@ -185,7 +185,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ffe4f000 {
+	sd2: sd@ffe4f000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

