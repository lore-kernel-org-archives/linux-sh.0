From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 04 Jul 2013 18:17:27 +0000
Subject: [PATCH v7 14/19] ARM: shmobile: armadillo-reference: Add LED1-LED4 to the device tree
Message-Id: <1372961852-28490-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 8ec4cd1..366f729 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -34,6 +34,21 @@
 		regulator-boot-on;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
+		};
+		led2 {
+			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
+		};
+		led3 {
+			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
+		};
+		led4 {
+			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &i2c0 {
-- 
1.8.1.5

