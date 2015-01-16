From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 Jan 2015 02:35:18 +0000
Subject: [PATCH 06/17] ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node
Message-Id: <4e5b572c8ddef78aeb10eb37ee32aa88188d3bdc.1421371996.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Enable the kzm9g touchscreen controller in the board's DT file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8a1675a..20aae5d 100644
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
2.1.4

