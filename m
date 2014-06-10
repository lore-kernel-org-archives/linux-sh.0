From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Jun 2014 08:09:57 +0000
Subject: [PATCH 1/3 v2] ARM: shmobile: r8a7790: add MSTP10 support on DTSI
Message-Id: <87d2ehchib.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- using datasheet naming
- fixup clock-output-names

 arch/arm/boot/dts/r8a7790.dtsi            |   32 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |   26 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e990d3c..dcf7e1e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -835,6 +835,38 @@
 				"rcan1", "rcan0", "qspi_mod", "iic3",
 				"i2c3", "i2c2", "i2c1", "i2c0";
 		};
+		mstp10_clks: mstp10_clks@e6150998 {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>, /* parent of SCU */
+				<&p_clk>,
+				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>;
+
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7790_CLK_SCU_ALL
+				R8A7790_CLK_SSI_ALL
+				R8A7790_CLK_SSI9 R8A7790_CLK_SSI8 R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
+				R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2 R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
+				R8A7790_CLK_SCU_DVC1 R8A7790_CLK_SCU_DVC0
+				R8A7790_CLK_SCU_SRC9 R8A7790_CLK_SCU_SRC8 R8A7790_CLK_SCU_SRC7 R8A7790_CLK_SCU_SRC6 R8A7790_CLK_SCU_SRC5
+				R8A7790_CLK_SCU_SRC4 R8A7790_CLK_SCU_SRC3 R8A7790_CLK_SCU_SRC2 R8A7790_CLK_SCU_SRC1 R8A7790_CLK_SCU_SRC0
+			>;
+			clock-output-names +				"scu-all", "ssi-all",
+				"ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
+				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
+				"scu-dvc1", "scu-dvc0",
+				"scu-src9", "scu-src8", "scu-src7", "scu-src6", "scu-src5",
+				"scu-src4", "scu-src3", "scu-src2", "scu-src1", "scu-src0";
+		};
 	};
 
 	qspi: spi@e6b10000 {
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 1118f7a..a16df68 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -107,4 +107,30 @@
 #define R8A7790_CLK_I2C1		30
 #define R8A7790_CLK_I2C0		31
 
+/* MSTP10 */
+#define R8A7790_CLK_SSI_ALL		5
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
+#define R8A7790_CLK_SCU_ALL		17
+#define R8A7790_CLK_SCU_DVC1		18
+#define R8A7790_CLK_SCU_DVC0		19
+#define R8A7790_CLK_SCU_SRC9		22
+#define R8A7790_CLK_SCU_SRC8		23
+#define R8A7790_CLK_SCU_SRC7		24
+#define R8A7790_CLK_SCU_SRC6		25
+#define R8A7790_CLK_SCU_SRC5		26
+#define R8A7790_CLK_SCU_SRC4		27
+#define R8A7790_CLK_SCU_SRC3		28
+#define R8A7790_CLK_SCU_SRC2		29
+#define R8A7790_CLK_SCU_SRC1		30
+#define R8A7790_CLK_SCU_SRC0		31
+
 #endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
-- 
1.7.9.5

