From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Dec 2013 20:34:34 +0000
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: Add SSI clocks in device tree
Message-Id: <1388003675-26554-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372236040-16737-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1372236040-16737-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 18 ++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7d7d441..5f68149b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -726,5 +726,23 @@
 			clock-output-names  				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
+		mstp10_clks: mstp10_clks@e6150998 {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>, <&mstp10_clks 0>, <&mstp10_clks 0>,
+				 <&mstp10_clks 0>, <&mstp10_clks 0>, <&mstp10_clks 0>,
+				 <&mstp10_clks 0>, <&mstp10_clks 0>, <&mstp10_clks 0>,
+				 <&mstp10_clks 0>, <&mstp10_clks 0>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7790_CLK_SSI R8A7790_CLK_SSI9 R8A7790_CLK_SSI8
+				R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
+				R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2
+				R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
+			>;
+			clock-output-names +				"ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
+				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 859e9be..dbb262a 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -104,4 +104,17 @@
 #define R8A7790_CLK_I2C1		30
 #define R8A7790_CLK_I2C0		31
 
+/* MSTP10 */
+#define R8A7790_CLK_SSI			5
+#define R8A7790_CLK_SSI9		6
+#define R8A7790_CLK_SSI8		7
+#define R8A7790_CLK_SSI7		8
+#define R8A7790_CLK_SSI6		9
+#define R8A7790_CLK_SSI5		10
+#define R8A7790_CLK_SSI4		11
+#define R8A7790_CLK_SSI3		12
+#define R8A7790_CLK_SSI2		13
+#define R8A7790_CLK_SSI1		14
+#define R8A7790_CLK_SSI0		15
+
 #endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
-- 
1.8.3.2

