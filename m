From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 02:48:18 +0000
Subject: [PATCH 4/4] ARM: shmobile: armadillo: dts: Add PWM backlight enable GPIO
Message-Id: <1386730098-26641-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Armadillo 800 EVA panel module has a backlight enable signal
connected to GPIO 61. Report this in the backlight DT node.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 4705759..e916aae 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -96,6 +96,7 @@
 		pinctrl-0 = <&backlight_pins>;
 		pinctrl-names = "default";
 		power-supply = <&reg_5p0v>;
+		enable-gpios = <&pfc 61 GPIO_ACTIVE_HIGH>;
 	};
 
 	sound {
-- 
1.8.3.2

