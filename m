From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 24 Jul 2013 00:32:33 +0000
Subject: [PATCH 06/19] ARM: shmobile: r8a7779: Add GPIO controller devices to device tree
Message-Id: <f5c771b5610b4c0d4daf9729aa03539ef1779a92.1374625203.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add GPIO controller nodes to the r8a7779 core device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 9dfc438..e9fbe3d 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -48,6 +48,90 @@
                       <0xf0000100 0x100>;
         };
 
+	gpio0: gpio@ffc40000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc40000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 141 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio1: gpio@ffc41000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc41000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 142 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio2: gpio@ffc42000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc42000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 143 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio3: gpio@ffc43000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc43000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 144 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio4: gpio@ffc44000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc44000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 145 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio5: gpio@ffc45000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc45000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 146 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio6: gpio@ffc46000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc46000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 147 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 192 9>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
 	irqpin0: irqpin@fe780010 {
 		compatible = "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
@@ -104,6 +188,7 @@
 	pfc: pfc@fffc0000 {
 		compatible = "renesas,pfc-r8a7779";
 		reg = <0xfffc0000 0x23c>;
+		#gpio-range-cells = <3>;
 	};
 
 	thermal@ffc48000 {
-- 
1.8.2.1

