From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:46:03 +0000
Subject: [PATCH 13/17] ARM: shmobile: r8a7779: fixup DT node naming for SDHI
Message-Id: <87zjqbc6yv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SDHI DT node from "sdhi" to "sd".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |    6 +++---
 arch/arm/boot/dts/r8a7779.dtsi                 |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index f7578d5..cb9ff29 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -92,15 +92,15 @@
 		renesas,function = "scif4";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sd0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
 				 "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
 };
 
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+&sd0 {
+	pinctrl-0 = <&sd0_pins>;
 	pinctrl-names = "default";
 
 	vmmc-supply = <&fixedregulator3v3>;
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index be737ef..4879b83 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -207,7 +207,7 @@
 		interrupts = <0 100 0x4>;
 	};
 
-	sdhi0: sdhi@ffe4c000 {
+	sd0: sd@ffe4c000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
@@ -217,7 +217,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@ffe4d000 {
+	sd1: sd@ffe4d000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
@@ -227,7 +227,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ffe4e000 {
+	sd2: sd@ffe4e000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
@@ -237,7 +237,7 @@
 		status = "disabled";
 	};
 
-	sdhi3: sdhi@ffe4f000 {
+	sd3: sd@ffe4f000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

