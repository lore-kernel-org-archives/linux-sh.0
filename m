From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 27 Feb 2015 17:48:38 +0000
Subject: [PATCH 1/2] ARM: shmobile: ape6evm dts: Enable pull-up for GPIO switches
Message-Id: <1425059319-13403-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425059319-13403-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425059319-13403-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The switches on r8a73a4/ape6evm do not have pull-up registers.  The
schematics say: "Need to use APE6 internal PullUp", hence enable pull-up
using pinctrl.

Without this, the switches don't really work, as the GPIO inputs are
more likely to pick up ghost signals through capacitive coupling than
actual keypresses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index b355fafc32f188dc..5baada97bc715838 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -103,6 +103,9 @@
 	keyboard {
 		compatible = "gpio-keys";
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&keyboard_pins>;
+
 		zero-key {
 			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_0>;
@@ -203,6 +206,12 @@
 		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
 		renesas,function = "sdhi1";
 	};
+
+	keyboard_pins: keyboard {
+		renesas,pins = "PORT324", "PORT325", "PORT326", "PORT327",
+			       "PORT328", "PORT329";
+		bias-pull-up;
+	};
 };
 
 &mmcif0 {
-- 
1.9.1

