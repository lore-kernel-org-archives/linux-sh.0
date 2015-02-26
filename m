From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 26 Feb 2015 10:46:29 +0000
Subject: [PATCH] ARM: shmobile: ape6evm dts: Fix polarity of LEDs
Message-Id: <1424947589-8303-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

While the LEDs on r8a73a4/ape6evm are tied to VSUPPLY, they're driven by
an N-channel MOSFET. Hence the GPIO signal should be active high.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index f9e81512201a2ec4..b355fafc32f188dc 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -75,27 +75,27 @@
 	leds {
 		compatible = "gpio-leds";
 		led1 {
-			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
+			gpios = <&pfc 28 GPIO_ACTIVE_HIGH>;
 			label = "GNSS_EN";
 		};
 		led2 {
-			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
+			gpios = <&pfc 126 GPIO_ACTIVE_HIGH>;
 			label = "NFC_NRST";
 		};
 		led3 {
-			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
+			gpios = <&pfc 132 GPIO_ACTIVE_HIGH>;
 			label = "GNSS_NRST";
 		};
 		led4 {
-			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
+			gpios = <&pfc 232 GPIO_ACTIVE_HIGH>;
 			label = "BT_WAKEUP";
 		};
 		led5 {
-			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
+			gpios = <&pfc 250 GPIO_ACTIVE_HIGH>;
 			label = "STROBE";
 		};
 		led6 {
-			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
+			gpios = <&pfc 288 GPIO_ACTIVE_HIGH>;
 			label = "BBRESETOUT";
 		};
 	};
-- 
1.9.1

