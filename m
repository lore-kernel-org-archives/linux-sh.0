From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 11 Jun 2013 22:22:49 +0000
Subject: [PATCH v5 20/22] ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree
Message-Id: <1370989371-30846-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 6374965..a416eee 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -89,6 +89,22 @@
 		vddvario-supply = <&reg_1p8v>;
 		vdd33a-supply = <&reg_3p3v>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			gpios = <&pfc 21 GPIO_ACTIVE_LOW>;
+		};
+		led3 {
+			gpios = <&pfc 22 GPIO_ACTIVE_LOW>;
+		};
+		led4 {
+			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &i2c0 {
-- 
1.8.1.5

