From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 18 Dec 2014 02:26:09 +0000
Subject: [PATCH 3/4] ARM: shmobile: sh73a0: kzm9g: Specify the adxl325 interrupts
Message-Id: <1418869570-13529-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The device needs an interrupt to operate properly. Specify the two
interrupts used on the board.

While at it rename the DT node to accelerometer@1d to describe the
device's function instead of its model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 2118692895ff..de39c92287da 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -204,13 +204,12 @@
 		#sound-dai-cells = <0>;
 	};
 
-	adxl345@1d {
+	accelerometer@1d {
 		compatible = "adi,adxl345", "adi,adxl34x";
 		reg = <0x1d>;
-		// FIXME interrupt-parent = <&gic>;
-		// FIXME interrupts = < 0 32 4 >;
-		// irq_pin(26), /* IRQ26 */
-		// irq_pin(27), /* IRQ27 */
+		interrupt-parent = <&irqpin3>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
+			     <3 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	rtc@32 {
-- 
2.0.4

