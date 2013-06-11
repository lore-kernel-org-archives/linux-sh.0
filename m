From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 11 Jun 2013 22:22:40 +0000
Subject: [PATCH v5 11/22] ARM: shmobile: r8a7790: Add GPIO controller devices to device tree
Message-Id: <1370989371-30846-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add GPIO controller nodes to the r8a7790 core device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 13caf12..1b75c1d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -38,6 +38,66 @@
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
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
@@ -58,5 +118,6 @@
 	pfc: pfc@e6060000 {
 		compatible = "renesas,pfc-r8a7790";
 		reg = <0 0xe6060000 0 0x250>;
+		#gpio-range-cells = <3>;
 	};
 };
-- 
1.8.1.5

