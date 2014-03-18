From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Mar 2014 12:57:48 +0000
Subject: [PATCH] ARM: shmobile: Add DTS gpio-keys support for SW2 on Lager
Message-Id: <20140318125748.21994.38046.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add DTS gpio-keys support for SW2 on the Lager board.
This makes the DT code match the legacy board code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-rc7-20140318

 arch/arm/boot/dts/r8a7790-lager.dts |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790-lager.dts
+++ work/arch/arm/boot/dts/r8a7790-lager.dts	2014-03-18 21:13:46.000000000 +0900
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
