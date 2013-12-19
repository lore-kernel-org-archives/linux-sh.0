From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 19 Dec 2013 15:28:43 +0000
Subject: [PATCH v6 15.2/17] ARM: shmobile: Remove Koelsch reference DTS
Message-Id: <1387466923-8800-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the DTS file r8a7790-koelsch.dts can be used with
board-koelsch.c and board-koelsch-reference.c, proceed with removing
r8a7790-koelsch-reference.dts.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/Makefile                      |   1 -
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 115 ------------------------
 2 files changed, 116 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts

Changes since v5:

- Moved the Makefile change from patch 11/17 here.

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 00aa144..ee0f2bd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -226,7 +226,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
deleted file mode 100644
index 588ca17..0000000
--- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Device Tree Source for the Koelsch board
- *
- * Copyright (C) 2013 Renesas Electronics Corporation
- * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "r8a7791.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Koelsch";
-	compatible = "renesas,koelsch-reference", "renesas,r8a7791";
-
-	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0 0x40000000 0 0x80000000>;
-	};
-
-	lbsc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		key-a {
-			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
-			linux,code = <30>;
-			label = "SW30";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-		key-b {
-			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
-			linux,code = <48>;
-			label = "SW31";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-		key-c {
-			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
-			linux,code = <46>;
-			label = "SW32";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-		key-d {
-			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
-			linux,code = <32>;
-			label = "SW33";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-		key-e {
-			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
-			linux,code = <18>;
-			label = "SW34";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-		key-f {
-			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
-			linux,code = <33>;
-			label = "SW35";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-		key-g {
-			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-			linux,code = <34>;
-			label = "SW36";
-			gpio-key,wakeup;
-			debounce-interval = <20>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led6 {
-			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		};
-		led7 {
-			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
-		};
-		led8 {
-			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-};
-
-&pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
-	pinctrl-names = "default";
-
-	scif0_pins: serial0 {
-		renesas,groups = "scif0_data_d";
-		renesas,function = "scif0";
-	};
-
-	scif1_pins: serial1 {
-		renesas,groups = "scif1_data_d";
-		renesas,function = "scif1";
-	};
-};
-- 
1.8.3.2

