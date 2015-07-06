From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 06 Jul 2015 21:46:08 +0000
Subject: [PATCH 4/5] ARM: shmobile: emev2: add IIC cores to dtsi
Message-Id: <1436219188-4325-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/emev2.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index bb45694d91bc1e..edad0c4eea3505 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -21,6 +21,8 @@
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
 		gpio4 = &gpio4;
+		i2c0 = &iic0;
+		i2c1 = &iic1;
 	};
 
 	cpus {
@@ -66,6 +68,30 @@
 			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
+		iic0_sclkdiv: iic0_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x624 0>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		iic0_sclk: iic0_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x48c 1>;
+			clocks = <&iic0_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		iic1_sclkdiv: iic1_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x624 16>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		iic1_sclk: iic1_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x490 1>;
+			clocks = <&iic1_sclkdiv>;
+			#clock-cells = <0>;
+		};
 		pll3_fo: pll3_fo {
 			compatible = "fixed-factor-clock";
 			clocks = <&c32ki>;
@@ -234,4 +260,26 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	iic0: i2c@e0070000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe0070000 0x28>;
+		interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic0_sclk>;
+		clock-names = "sclk";
+		status = "disabled";
+	};
+
+	iic1: i2c@e10a0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe10a0000 0x28>;
+		interrupts = <0 33 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic1_sclk>;
+		clock-names = "sclk";
+		status = "disabled";
+	};
 };
-- 
2.1.4

