From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:32 +0000
Subject: [PATCH 06/69] ARM: shmobile: r8a7791 GPIO device tree node
Message-Id: <ab87e3fc0b3532f8ff1cb08b9f3680bc98be7728.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add GPIO controllers to the r8a7791 DTSI file.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 96 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 765d989..344f1f7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -46,6 +46,102 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	gpio0: gpio@ffc40000 {
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc40000 0 0x50>;
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
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc41000 0 0x50>;
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
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc42000 0 0x50>;
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
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc43000 0 0x50>;
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
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc44000 0 0x50>;
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
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc45000 0 0x50>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio6: gpio@ffc45400 {
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc45400 0 0x50>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 10 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 192 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio7: gpio@ffc45800 {
+		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		reg = <0 0xffc45800 0 0x50>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 11 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 224 26>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
-- 
1.8.4

