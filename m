From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 04 Jul 2013 18:17:21 +0000
Subject: [PATCH v7 08/19] ARM: shmobile: r8a7790: Add GPIO controller devices to device tree
Message-Id: <1372961852-28490-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add GPIO controller nodes to the r8a7790 core device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 13caf12..9465cfc 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -38,6 +38,78 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	gpio0: gpio@ffc40000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0 0xffc40000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 4 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio1: gpio@ffc41000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0 0xffc41000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 5 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio2: gpio@ffc42000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0 0xffc42000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 6 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio3: gpio@ffc43000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0 0xffc43000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 7 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio4: gpio@ffc44000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0 0xffc44000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 8 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio5: gpio@ffc45000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0 0xffc45000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
@@ -58,5 +130,6 @@
 	pfc: pfc@e6060000 {
 		compatible = "renesas,pfc-r8a7790";
 		reg = <0 0xe6060000 0 0x250>;
+		#gpio-range-cells = <3>;
 	};
 };
-- 
1.8.1.5

