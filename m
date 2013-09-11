From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Sep 2013 11:51:13 +0000
Subject: [PATCH] ARM: shmobile: armadillo-reference: Add PWM backlight node to DT
Message-Id: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c638e4a..801442b 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 /include/ "r8a7740.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "armadillo 800 eva reference";
@@ -49,6 +50,15 @@
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <9>;
+		pinctrl-0 = <&backlight_pins>;
+		pinctrl-names = "default";
+	};
 };
 
 &i2c0 {
@@ -76,4 +86,13 @@
 		renesas,groups = "intc_irq10";
 		renesas,function = "intc";
 	};
+
+	backlight_pins: backlight {
+		renesas,groups = "tpu0_to2_1";
+		renesas,function = "tpu0";
+	};
+};
+
+&tpu {
+	status = "okay";
 };
-- 
Regards,

Laurent Pinchart

