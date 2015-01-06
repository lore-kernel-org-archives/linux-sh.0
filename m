From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:42:06 +0000
Subject: [PATCH 3/6] ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
Message-Id: <1420573329-12762-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a DT node for the AK8975 magnetometer sensor, which is connected to
i2c0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Specify the device interrupt to avoid polling for end of conversion.

While at it rename the DT node to compass@c to describe the device's
function instead of its model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 02fc265332e8fb84..beabc3fd013b9ff0 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -189,6 +189,13 @@
 &i2c0 {
 	status = "okay";
 
+	compass@c {
+		compatible = "asahi-kasei,ak8975";
+		reg = <0x0c>;
+		interrupt-parent = <&irqpin3>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+	};
+
 	ak4648: codec@12 {
 		compatible = "asahi-kasei,ak4648";
 		reg = <0x12>;
-- 
1.9.1

