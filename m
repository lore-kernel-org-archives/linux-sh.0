From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 10 Mar 2015 00:44:45 +0000
Subject: [PATCH 08/15] ARM: shmobile: ape6evm dts: Fix polarity of LEDs
Message-Id: <ca50ee8f6f7c25d3de7d5da4e7a164e21f08c828.1425947992.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While the LEDs on r8a73a4/ape6evm are tied to VSUPPLY, they're driven by
an N-channel MOSFET. Hence the GPIO signal should be active high.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 0d50bef..e8f3f38 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -95,27 +95,27 @@
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
2.1.4

