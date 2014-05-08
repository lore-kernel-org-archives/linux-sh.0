From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 08 May 2014 12:06:40 +0000
Subject: [PATCH/RFC] ARM: shmobile: armadillo-reference dts: Add matching LED labels
Message-Id: <1399550800-25656-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should the node names be changed from "led[1-4]" to "led[3-6]", too?

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 486007d7ffe4..8c7255438292 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -106,15 +106,19 @@
 		compatible = "gpio-leds";
 		led1 {
 			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
+			label = "LED3";
 		};
 		led2 {
 			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
+			label = "LED4";
 		};
 		led3 {
 			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
+			label = "LED5";
 		};
 		led4 {
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
 		};
 	};
 
-- 
1.7.9.5

