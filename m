From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 13 Feb 2013 03:29:19 +0000
Subject: [PATCH 7/9] ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree
Message-Id: <1360726161-16072-8-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

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
1.7.10.4

