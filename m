From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Nov 2013 00:44:04 +0000
Subject: [PATCH] ARM: shmobile: Koelsch DT reference GPIO LED support
Message-Id: <20131121004404.16471.71617.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add led6, led7 and led8 to the Koelsch DT reference board support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791-koelsch-reference.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0024/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ work/arch/arm/boot/dts/r8a7791-koelsch-reference.dts	2013-11-20 17:15:02.000000000 +0900
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r8a7791.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Koelsch";
@@ -29,6 +30,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		};
+		led7 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+		};
+		led8 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &pfc {
