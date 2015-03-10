From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 10 Mar 2015 00:44:51 +0000
Subject: [PATCH 14/15] ARM: shmobile: ape6evm dts: Enable pull-up for GPIO switches
Message-Id: <a104662052b5863663d11895667f0f8a755cd826.1425947992.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The switches on r8a73a4/ape6evm do not have pull-up registers.  The
schematics say: "Need to use APE6 internal PullUp", hence enable pull-up
using pinctrl.

Without this, the switches don't really work, as the GPIO inputs are
more likely to pick up ghost signals through capacitive coupling than
actual keypresses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index e8f3f38..9734dd7 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -123,6 +123,9 @@
 	keyboard {
 		compatible = "gpio-keys";
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&keyboard_pins>;
+
 		zero-key {
 			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_0>;
@@ -208,6 +211,12 @@
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
2.1.4

