From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 04 Jan 2013 00:41:00 +0000
Subject: [PATCH 9/9] ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree
Message-Id: <1357260060-32164-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index e24996c..ba321c2 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -19,6 +19,22 @@
 		device_type = "memory";
 		reg = <0x41000000 0x1e800000>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&gpio 20 1>; /* Active low */
+		};
+		led2 {
+			gpios = <&gpio 21 1>; /* Active low */
+		};
+		led3 {
+			gpios = <&gpio 22 1>; /* Active low */
+		};
+		led4 {
+			gpios = <&gpio 23 1>; /* Active low */
+		};
+	};
 };
 
 &gpio {
-- 
1.7.8.6

