From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Aug 2015 16:34:56 +0000
Subject: [PATCH 1/2] ARM: shmobile: bockw: remove "reference" device tree
Message-Id: <1438965297-12888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replaced by multi-platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 139 ---------------------
 3 files changed, 1 insertion(+), 143 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index f3f96b5..f8aad0b 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -39,8 +39,6 @@ Boards:
     compatible = "renesas,armadillo800eva"
   - BOCK-W
     compatible = "renesas,bockw", "renesas,r8a7778"
-  - BOCK-W - Reference Device Tree Implementation
-    compatible = "renesas,bockw-reference", "renesas,r8a7778"
   - Genmai (RTK772100BC00000BR)
     compatible = "renesas,genmai", "renesas,r7s72100"
   - Gose
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2ddc36d..c005f2e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -501,8 +501,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a7778-bockw.dtb \
-	r8a7778-bockw-reference.dtb
+	r8a7778-bockw.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
deleted file mode 100644
index dffa6ff..0000000
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * Reference Device Tree Source for the Bock-W board
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * based on r8a7779
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Copyright (C) 2013 Simon Horman
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "r8a7778.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "bockw";
-	compatible = "renesas,bockw-reference", "renesas,r8a7778";
-
-	aliases {
-		serial0 = &scif0;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp rw";
-		stdout-path = &scif0;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x60000000 0x10000000>;
-	};
-
-	fixedregulator3v3: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	ethernet@18300000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x18300000 0x1000>;
-
-		phy-mode = "mii";
-		interrupt-parent = <&irqpin>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
-		reg-io-width = <4>;
-		vddvario-supply = <&fixedregulator3v3>;
-		vdd33a-supply = <&fixedregulator3v3>;
-	};
-
-};
-
-&mmcif {
-	pinctrl-0 = <&mmc_pins>;
-	pinctrl-names = "default";
-
-	vmmc-supply = <&fixedregulator3v3>;
-	bus-width = <8>;
-	broken-cd;
-	status = "okay";
-};
-
-&irqpin {
-	status = "okay";
-};
-
-&tmu0 {
-	status = "okay";
-};
-
-&pfc {
-	scif0_pins: serial0 {
-		renesas,groups = "scif0_data_a", "scif0_ctrl";
-		renesas,function = "scif0";
-	};
-
-	mmc_pins: mmc {
-		renesas,groups = "mmc_data8", "mmc_ctrl";
-		renesas,function = "mmc";
-	};
-
-	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl",
-				  "sdhi0_cd";
-		renesas,function = "sdhi0";
-	};
-
-	hspi0_pins: hspi0 {
-		renesas,groups = "hspi0_a";
-		renesas,function = "hspi0";
-	};
-};
-
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
-
-	vmmc-supply = <&fixedregulator3v3>;
-	bus-width = <4>;
-	status = "okay";
-	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
-};
-
-&hspi0 {
-	pinctrl-0 = <&hspi0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spansion,s25fl008k", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <104000000>;
-		m25p,fast-read;
-
-		partition@0 {
-			label = "data(spi)";
-			reg = <0x00000000 0x00100000>;
-		};
-	};
-};
-
-&scif0 {
-	pinctrl-0 = <&scif0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-- 
2.4.6

