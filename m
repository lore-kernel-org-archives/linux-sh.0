From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:42:09 +0000
Subject: [PATCH 6/6] ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node
Message-Id: <1420573329-12762-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Enable the kzm9g touchscreen controller in the board's DT file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0b007ceae9e50cec..bf365f7fef47213a 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -287,6 +287,17 @@
 	};
 };
 
+&i2c1 {
+	status = "okay";
+
+	touchscreen@55 {
+		compatible = "sitronix,st1232";
+		reg = <0x55>;
+		interrupt-parent = <&irqpin1>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

