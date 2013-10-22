From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:37:14 +0000
Subject: [PATCH 07/12] ARM: shmobile: armadillo: tidyup DT node naming
Message-Id: <87wql6kp48.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name.

This patch removed un-used "touchscreen" label

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 1c56c5e..6a54219 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -90,7 +90,7 @@
 
 &i2c0 {
 	status = "okay";
-	touchscreen: st1232@55 {
+	touchscreen@55 {
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
 		interrupt-parent = <&irqpin1>;
@@ -105,12 +105,12 @@
 	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
 
-	scifa1_pins: scifa1 {
+	scifa1_pins: serial1 {
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
 	};
 
-	st1232_pins: st1232 {
+	st1232_pins: touchscreen {
 		renesas,groups = "intc_irq10";
 		renesas,function = "intc";
 	};
@@ -125,7 +125,7 @@
 		renesas,function = "mmc0";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
-- 
1.7.9.5

