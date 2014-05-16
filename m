From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 May 2014 00:58:15 +0000
Subject: [PATCH 06/11] ARM: shmobile: armadillo-reference dts: Add Ethernet support
Message-Id: <15d89dc9bfde872885c6226d86fb25676cbedfb3.1400200395.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 10344e6..486007d 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -158,6 +158,18 @@
 	};
 };
 
+&ether {
+	pinctrl-0 = <&ether_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy0>;
+	status = "ok";
+
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	touchscreen@55 {
@@ -189,6 +201,11 @@
 	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
 
+	ether_pins: ether {
+		renesas,groups = "gether_mii", "gether_int";
+		renesas,function = "gether";
+	};
+
 	scifa1_pins: serial1 {
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
-- 
1.8.5.2

