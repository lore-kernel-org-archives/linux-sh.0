From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Nov 2014 01:20:16 +0000
Subject: [PATCH 25/25] ARM: shmobile: kzm9g-reference dts: Add labels for the LEDs
Message-Id: <2887bd4265cfbec6ccdd099c1728f82b4bebb69b.1415755881.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The LEDs on the kzm9g board are labeled using upper-case characters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0dac0e6..e59e674 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -101,15 +101,19 @@
 		compatible = "gpio-leds";
 		led1 {
 			gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
+			label = "LED1";
 		};
 		led2 {
 			gpios = <&pfc 21 GPIO_ACTIVE_LOW>;
+			label = "LED2";
 		};
 		led3 {
 			gpios = <&pfc 22 GPIO_ACTIVE_LOW>;
+			label = "LED3";
 		};
 		led4 {
 			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
+			label = "LED4";
 		};
 	};
 
-- 
2.1.1

