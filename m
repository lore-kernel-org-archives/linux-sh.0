From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 09 Jun 2014 08:57:12 +0000
Subject: [PATCH] ARM: shmobile: koelsch: Remove duplicate i2c6 nodes
Message-Id: <1402304232-24709-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

A second i2c6 node was a added by
05e234a187058ee ("ARM: shmobile: koelsch dts: Add VDD MPU regulator for
DVFS"). Merge this into the existing node.

Also shuffle i2c nodes so they are all together.

Cc: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d3a914c..82ae120 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -210,25 +210,6 @@
 	clock-frequency = <20000000>;
 };
 
-&i2c2 {
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-	clock-frequency = <400000>;
-
-	eeprom@50 {
-		compatible = "renesas,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&i2c6 {
-	status = "okay";
-	clock-frequency = <100000>;
-};
-
 &pfc {
 	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
@@ -395,10 +376,25 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "renesas,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &i2c6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
+	clock-frequency = <100000>;
 
 	vdd_dvfs: regulator@68 {
 		compatible = "diasemi,da9210";
-- 
2.0.0.rc2

