From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 18 Dec 2014 02:26:10 +0000
Subject: [PATCH 4/4] ARM: shmobile: sh73a0: kzm9g: Specify the ak8975 interrupt
Message-Id: <1418869570-13529-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the device interrupt to avoid polling for end of conversion.

While at it rename the DT node to compass@c to describe the device's
function instead of its model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index de39c92287da..bf2f4edd96ea 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -192,10 +192,11 @@
 &i2c0 {
 	status = "okay";
 
-	ak8975@c {
+	compass@c {
 		compatible = "asahi-kasei,ak8975";
 		reg = <0x0c>;
-		// FIXME gpios = <...>;	// irq_pin(28), /* IRQ28 */
+		interrupt-parent = <&irqpin3>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 	};
 
 	ak4648: ak4648@12 {
-- 
2.0.4

