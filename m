From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:21:21 +0000
Subject: [PATCH 24/32] ARM: shmobile: emev2-kzm9d dts: Add PFC information for uart1
Message-Id: <4a5fcc685a84751bbec5653e942fb3d61470a66c.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

From: Niklas Söderlund <niso@kth.se>

Configure the pinmux on kzm9d to use the serial connector for uart1.

Signed-off-by: Niklas Söderlund <niso@kth.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 667d323..1944627 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -94,3 +94,16 @@
 		vdd33a-supply = <&reg_3p3v>;
 	};
 };
+
+&pfc {
+	uart1_pins: uart@e1030000 {
+		renesas,groups = "uart1_ctrl", "uart1_data";
+		renesas,function = "uart1";
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.1.4

