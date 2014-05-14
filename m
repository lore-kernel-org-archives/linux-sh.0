From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 May 2014 14:51:19 +0000
Subject: [PATCH v3 1/4] ARM: shmobile: armadillo800eva reference dts: Add matching LED labels
Message-Id: <1400079082-6340-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

And make the node name numbering match the label numbering.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
v3:
  - Make node name numbering match label numbering
v2:
  - New
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 486007d7ffe4..f6ef73ff49e8 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -104,17 +104,21 @@
 
 	leds {
 		compatible = "gpio-leds";
-		led1 {
+		led3 {
 			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
+			label = "LED3";
 		};
-		led2 {
+		led4 {
 			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
+			label = "LED4";
 		};
-		led3 {
+		led5 {
 			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
+			label = "LED5";
 		};
-		led4 {
+		led6 {
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
 		};
 	};
 
-- 
1.7.9.5

