From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 22 Mar 2013 01:23:48 +0000
Subject: [PATCH 2/6] ARM: shmobile: sh73a0: move SDHI and MMCIF DT nodes to sh73a0.dtsi
Message-Id: <1363915432-21720-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

To avoid having to repeat common DT node properties in all .dts files
move them to SoC's .dtsi file, setting their status to "disabled."
Individual boards will pick up devices, that they want to use and
change their DT node status to enabled.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   41 +++++++++---------------
 arch/arm/boot/dts/sh73a0-reference.dtsi      |   24 --------------
 arch/arm/boot/dts/sh73a0.dtsi                |   44 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 50 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index cadcf30..f33b5cc 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -12,7 +12,7 @@
  */
 
 /dts-v1/;
-/include/ "sh73a0-reference.dtsi"
+/include/ "sh73a0.dtsi"
 
 / {
 	model = "KZM-A9-GT";
@@ -44,34 +44,23 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
-
-	sdhi0: sdhi@0xee100000 {
-		compatible = "renesas,shmobile-sdhi";
-		reg = <0xee100000 0x100>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 83 4
-				0 84 4
-				0 85 4>;
-		vmmc-supply = <&reg_3p3v>;
-		bus-width = <4>;
-		toshiba,mmc-has-idle-wait;
-	};
-
-	sdhi2: sdhi@0xee140000 {
-		compatible = "renesas,shmobile-sdhi";
-		reg = <0xee140000 0x100>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 104 4
-				0 105 4>;
-		vmmc-supply = <&reg_3p3v>;
-		bus-width = <4>;
-		broken-cd;
-		toshiba,mmc-wrprotect-disable;
-		toshiba,mmc-has-idle-wait;
-	};
 };
 
 &mmcif {
 	bus-width = <8>;
 	vmmc-supply = <&reg_1p8v>;
+	status = "okay";
+};
+
+&sdhi0 {
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&sdhi2 {
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <4>;
+	broken-cd;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sh73a0-reference.dtsi b/arch/arm/boot/dts/sh73a0-reference.dtsi
deleted file mode 100644
index d4bb012..0000000
--- a/arch/arm/boot/dts/sh73a0-reference.dtsi
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Device Tree Source for the SH73A0 SoC
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/include/ "sh73a0.dtsi"
-
-/ {
-	compatible = "renesas,sh73a0";
-
-	mmcif: mmcif@0x10010000 {
-		compatible = "renesas,sh-mmcif";
-		reg = <0xe6bd0000 0x100>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 140 0x4
-			      0 141 0x4>;
-		reg-io-width = <4>;
-	};
-};
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 8a59465..c89be38 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -97,4 +97,48 @@
 			      0 189 0x4
 			      0 190 0x4>;
 	};
+
+	mmcif: mmcif@0x10010000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 140 0x4
+			      0 141 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	sdhi0: sdhi@0xee100000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee100000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 83 4
+				0 84 4
+				0 85 4>;
+		toshiba,mmc-has-idle-wait;
+		status = "disabled";
+	};
+
+	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
+	sdhi1: sdhi@0xee120000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee120000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 88 4
+				0 89 4>;
+		toshiba,mmc-wrprotect-disable;
+		toshiba,mmc-has-idle-wait;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi@0xee140000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee140000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 104 4
+				0 105 4>;
+		toshiba,mmc-wrprotect-disable;
+		toshiba,mmc-has-idle-wait;
+		status = "disabled";
+	};
 };
-- 
1.7.10.4

