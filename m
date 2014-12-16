From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 16 Dec 2014 16:25:59 +0000
Subject: [PATCH v2 3/7] ARM: shmobile: ape6evm: Add keypad to the device tree
Message-Id: <1418747163-21729-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index b939a37..6b7bc1f 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "r8a73a4.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "APE6EVM";
@@ -110,6 +111,46 @@
 			label = "BBRESETOUT";
 		};
 	};
+
+	keyboard {
+		compatible = "gpio-keys";
+
+		zero-key {
+			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_0>;
+			label = "S16";
+		};
+
+		menu-key {
+			gpios = <&pfc 325 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+			label = "S17";
+		};
+
+		home-key {
+			gpios = <&pfc 326 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			label = "S18";
+		};
+
+		back-key {
+			gpios = <&pfc 327 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			label = "S19";
+		};
+
+		volup-key {
+			gpios = <&pfc 328 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			label = "S20";
+		};
+
+		voldown-key {
+			gpios = <&pfc 329 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			label = "S21";
+		};
+	};
 };
 
 &i2c5 {
-- 
1.8.4.5

