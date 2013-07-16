From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 09:45:56 +0000
Subject: [PATCH] ARM: shmobile: lager-reference: Add LED6-LED8 to the device tree
Message-Id: <1373967956-3651-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LED6 to LED8 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

The patch is based on renesas-devel-20130716.

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index fa5b81b..5ee71cf5 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 /include/ "r8a7790.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Lager";
@@ -28,4 +29,17 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+		};
+		led7 {
+			gpios = <&gpio4 23 GPIO_ACTIVE_HIGH>;
+		};
+		led8 {
+			gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
-- 
Regards,

Laurent Pinchart

