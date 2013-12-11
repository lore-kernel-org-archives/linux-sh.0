From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 14:14:01 +0000
Subject: [PATCH v4 15/16] ARM: shmobile: Remove Koelsch reference DTS
Message-Id: <1386771242-21876-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 61 -------------------------
 1 file changed, 61 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts

diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
deleted file mode 100644
index 1919273..0000000
--- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ /dev/null
@@ -1,61 +0,0 @@
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

