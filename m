From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:25:39 +0000
Subject: [PATCH 11/33] ARM: shmobile: Add DTS gpio-keys support for SW2 on Lager
Message-Id: <f7dcd382a8d6ce8c6da12786c8311e71e214290d.1398216022.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DTS gpio-keys support for SW2 on the Lager board.
This makes the DT code match the legacy board code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index cdec1af..c3d8b17 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 #include "r8a7790.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Lager";
@@ -36,6 +37,39 @@
 		#size-cells = <1>;
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		button@1 {
+			linux,code = <KEY_1>;
+			label = "SW2-1";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		};
+		button@2 {
+			linux,code = <KEY_2>;
+			label = "SW2-2";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
+		};
+		button@3 {
+			linux,code = <KEY_3>;
+			label = "SW2-3";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+			gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
+		};
+		button@4 {
+			linux,code = <KEY_4>;
+			label = "SW2-4";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+			gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led6 {
-- 
1.8.5.2

