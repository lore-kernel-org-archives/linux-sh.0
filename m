From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 12:49:59 +0000
Subject: [PATCH 2/2] ARM: shmobile: kzm9g-reference dts: Add labels for the LEDs
Message-Id: <1415278199-1975-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1385428879-26849-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385428879-26849-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The LEDs on the kzm9g board are labeled using upper-case characters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8c913d9b18241a16..0a34c90105e9fcd6 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -101,15 +101,19 @@
 		compatible = "gpio-leds";
 		led1 {
 			gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
+			label = "LED1";
 		};
 		led2 {
 			gpios = <&pfc 21 GPIO_ACTIVE_LOW>;
+			label = "LED2";
 		};
 		led3 {
 			gpios = <&pfc 22 GPIO_ACTIVE_LOW>;
+			label = "LED3";
 		};
 		led4 {
 			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
+			label = "LED4";
 		};
 	};
 
-- 
1.9.1

