From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:42:07 +0000
Subject: [PATCH 4/6] ARM: shmobile: kzm9g-reference dts: Add adxl345 accelerometer node
Message-Id: <1420573329-12762-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a DT node for the ADXL345 three-axis digital accelerometer sensor,
which is connected to i2c0.

As trivial i2c devices are matched against the first compatible entry
only, compatibility is declared with "adi,adxl34x" only for now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

The device needs an interrupt to operate properly. Specify the two
interrupts used on the board.

While at it rename the DT node to accelerometer@1d to describe the
device's function instead of its model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index beabc3fd013b9ff0..6f022c300f447afd 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -202,6 +202,14 @@
 		#sound-dai-cells = <0>;
 	};
 
+	accelerometer@1d {
+		compatible = "adi,adxl34x";
+		reg = <0x1d>;
+		interrupt-parent = <&irqpin3>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
+			     <3 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	as3711@40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
-- 
1.9.1

