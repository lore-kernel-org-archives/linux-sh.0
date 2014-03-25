From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:36:34 +0000
Subject: [PATCH 1/7] ARM: shmobile: r8a7790: add MSTP10 support on DTSI
Message-Id: <877g7idhdb.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369645224-3728-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369645224-3728-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            |   29 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |   24 ++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index da69afc..5e7f23d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -768,6 +768,35 @@
 			clock-output-names  				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
+		mstp10_clks: mstp10_clks@e6150998 {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>, /* parent of SCU */
+				<&p_clk>,
+				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
+				<&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
+				<&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
+				<&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
+				<&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>;
+
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7790_CLK_SCU
+				R8A7790_CLK_SSI
+				R8A7790_CLK_SSI9 R8A7790_CLK_SSI8 R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
+				R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2 R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
+				R8A7790_CLK_SRC9 R8A7790_CLK_SRC8 R8A7790_CLK_SRC7 R8A7790_CLK_SRC6 R8A7790_CLK_SRC5
+				R8A7790_CLK_SRC4 R8A7790_CLK_SRC3 R8A7790_CLK_SRC2 R8A7790_CLK_SRC1 R8A7790_CLK_SRC0
+			>;
+			clock-output-names +				"scu", "ssi",
+				"ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
+				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
+				"src9", "src8", "src7", "src6", "src5",
+				"src4", "src3", "src2", "src1", "src0";
+		};
 	};
 
 	qspi: spi@e6b10000 {
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 6548a5f..f73ccb9 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -104,4 +104,28 @@
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
+#define R8A7790_CLK_SCU			17
+#define R8A7790_CLK_SRC9		22
+#define R8A7790_CLK_SRC8		23
+#define R8A7790_CLK_SRC7		24
+#define R8A7790_CLK_SRC6		25
+#define R8A7790_CLK_SRC5		26
+#define R8A7790_CLK_SRC4		27
+#define R8A7790_CLK_SRC3		28
+#define R8A7790_CLK_SRC2		29
+#define R8A7790_CLK_SRC1		30
+#define R8A7790_CLK_SRC0		31
+
 #endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
-- 
1.7.9.5

