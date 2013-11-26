From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Nov 2013 01:21:18 +0000
Subject: [PATCH 1/2] ARM: shmobile: kzm9g-reference: Add PCF8575 GPIO extender to DT
Message-Id: <1385428879-26849-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 12fdfaa..d58877d 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -186,6 +186,17 @@
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	pcf8575: gpio@20 {
+		compatible = "nxp,pcf8575";
+		reg = <0x20>;
+		interrupt-parent = <&irqpin2>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
 };
 
 &mmcif {
-- 
1.8.3.2

