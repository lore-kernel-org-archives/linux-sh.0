From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Dec 2013 14:19:31 +0000
Subject: [PATCH 01/21] ARM: shmobile: armadillo: dts: Add PWM backlight power supply
Message-Id: <aeb193606d44bd37b2178c6b2b6f25ff679656a3.1387893834.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add
power supply support") added a mandatory power supply for the PWM
backlight. Add a fixed 5V regulator and reference it for the backlight
power supply.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 6d6fd3d..4705759 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -63,6 +63,15 @@
 		enable-active-high;
 	};
 
+	reg_5p0v: regulator@3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5.0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -86,6 +95,7 @@
 		default-brightness-level = <9>;
 		pinctrl-0 = <&backlight_pins>;
 		pinctrl-names = "default";
+		power-supply = <&reg_5p0v>;
 	};
 
 	sound {
-- 
1.8.4

