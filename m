From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:21:04 +0000
Subject: [PATCH 07/32] ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node
Message-Id: <8ac627fa8ef0f98f914690515aa3bf376d7a880d.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
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
index e3723be..0156fc8 100644
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

