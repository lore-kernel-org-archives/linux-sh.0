From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 18 Dec 2014 02:26:08 +0000
Subject: [PATCH 2/4] ARM: shmobile: sh73a0: kzm9g: Add touchscreen controller to DT
Message-Id: <1418869570-13529-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable the kzm9g touchscreen controller in the board's DT file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index ec787696c2d7..2118692895ff 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -290,6 +290,17 @@
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
2.0.4

