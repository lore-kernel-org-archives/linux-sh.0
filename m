From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:03:16 +0000
Subject: [PATCH v2 77/77] ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree
Message-Id: <1353974596-30033-78-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
index 7b37901..203efb8 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -19,4 +19,20 @@
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
-- 
1.7.8.6

