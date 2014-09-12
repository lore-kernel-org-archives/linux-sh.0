From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 12 Sep 2014 08:51:12 +0000
Subject: [PATCH 2/6] ARM: shmobile: emev2: sort dtsi file by address
Message-Id: <1410511876-9235-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, Olof Johansson <olof@lixom.net>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/emev2.dtsi | 120 +++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 00eeed3..41d2da7 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -41,6 +41,12 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	gic: interrupt-controller@e0020000 {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
@@ -49,10 +55,60 @@
 		      <0xe0020000 0x0100>;
 	};
 
-	pmu {
-		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 121 IRQ_TYPE_LEVEL_HIGH>;
+	gpio0: gpio@e0050000 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050000 0x2c>, <0xe0050040 0x20>;
+		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 68 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio1: gpio@e0050080 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050080 0x2c>, <0xe00500c0 0x20>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio2: gpio@e0050100 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050100 0x2c>, <0xe0050140 0x20>;
+		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio3: gpio@e0050180 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050180 0x2c>, <0xe00501c0 0x20>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio4: gpio@e0050200 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050200 0x2c>, <0xe0050240 0x20>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <31>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 	};
 
 	smu@e0110000 {
@@ -168,60 +224,4 @@
 		clocks = <&usib_u3_sclk>;
 		clock-names = "sclk";
 	};
-
-	gpio0: gpio@e0050000 {
-		compatible = "renesas,em-gio";
-		reg = <0xe0050000 0x2c>, <0xe0050040 0x20>;
-		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 68 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpios = <32>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-	gpio1: gpio@e0050080 {
-		compatible = "renesas,em-gio";
-		reg = <0xe0050080 0x2c>, <0xe00500c0 0x20>;
-		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 70 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpios = <32>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-	gpio2: gpio@e0050100 {
-		compatible = "renesas,em-gio";
-		reg = <0xe0050100 0x2c>, <0xe0050140 0x20>;
-		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 72 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpios = <32>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-	gpio3: gpio@e0050180 {
-		compatible = "renesas,em-gio";
-		reg = <0xe0050180 0x2c>, <0xe00501c0 0x20>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 74 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpios = <32>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-	gpio4: gpio@e0050200 {
-		compatible = "renesas,em-gio";
-		reg = <0xe0050200 0x2c>, <0xe0050240 0x20>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 76 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpios = <31>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
 };
-- 
1.8.4.5

