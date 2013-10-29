From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 15:04:34 +0000
Subject: [PATCH 02/10] ARM: shmobile: r8a7790: Add clocks
Message-Id: <1383059082-26315-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Declare all core clocks and DIV6 clocks, as well as all MSTP clocks
currently used by r8a7790 boards.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 297 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee845fa..423500d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -274,4 +274,301 @@
 		cap-sd-highspeed;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* External root clock */
+		extal_clk: extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overriden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "extal";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks {
+			compatible = "renesas,r8a7790-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll1", "pll3", "lb",
+					     "qspi", "sdh", "sd0", "sd1";
+		};
+
+		/* Variable factor clocks */
+		sd2_clk: sd2_clk {
+			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150078 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sd2";
+		};
+		sd3_clk: sd3_clk {
+			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615007c 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sd3";
+		};
+		mmc0_clk: mmc0_clk {
+			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150240 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc0";
+		};
+		mmc1_clk: mmc1_clk {
+			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150244 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc1";
+		};
+		ssp_clk: ssp_clk {
+			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150248 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "ssp";
+		};
+		ssprs_clk: ssprs_clk {
+			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615024c 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "ssprs";
+		};
+
+		/* Fixed factor clocks */
+		pll1_div2_clk: pll1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div2";
+		};
+		zg_clk: zg_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+			clock-output-names = "zg";
+		};
+		zx_clk: zx_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+			clock-output-names = "zx";
+		};
+		zs_clk: zs_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+			clock-output-names = "zs";
+		};
+		hp_clk: hp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "hp";
+		};
+		i_clk: i_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "i";
+		};
+		b_clk: b_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "b";
+		};
+		p_clk: p_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "p";
+		};
+		cl_clk: cl_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <48>;
+			clock-mult = <1>;
+			clock-output-names = "cl";
+		};
+		m2_clk: m2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "m2";
+		};
+		imp_clk: imp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "imp";
+		};
+		rclk_clk: rclk_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(48 * 1024)>;
+			clock-mult = <1>;
+			clock-output-names = "rclk";
+		};
+		oscclk_clk: oscclk_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(12 * 1024)>;
+			clock-mult = <1>;
+			clock-output-names = "oscclk";
+		};
+		zb3_clk: zb3_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "zb3";
+		};
+		zb3d2_clk: zb3d2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "zb3d2";
+		};
+		ddr_clk: ddr_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "ddr";
+		};
+		mp_clk: mp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <15>;
+			clock-mult = <1>;
+			clock-output-names = "mp";
+		};
+		cp_clk: cp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&extal_clk>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "cp";
+		};
+
+		/* Gate clocks */
+		mstp1_clks: mstp1_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
+			clocks = <&rclk_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7790_CLK_CMT0>;
+			clock-output-names = "cmt0";
+		};
+		mstp2_clks: mstp2_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&mp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
+				R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1 R8A7790_CLK_SCIFB2
+			>;
+			clock-output-names +				"scifa2", "scifa1", "scifa0", "scifb0", "scifb1",
+				"scifb2";
+		};
+		mstp3_clks: mstp3_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
+				 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>,
+				 <&mmc0_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
+				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
+				R8A7790_CLK_MMCIF0
+			>;
+			clock-output-names +				"tpu0", "mmcif1", "sdhi3", "sdhi2",
+				"sdhi1", "sdhi0", "mmcif0";
+		};
+		mstp5_clks: mstp5_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7790_CLK_THERMAL>;
+			clock-output-names = "thermal";
+		};
+		mstp7_clks: mstp7_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zx_clk>,
+				 <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7790_CLK_HSCIF1 R8A7790_CLK_HSCIF0 R8A7790_CLK_SCIF1
+				R8A7790_CLK_SCIF0 R8A7790_CLK_DU2 R8A7790_CLK_DU1
+				R8A7790_CLK_DU0 R8A7790_CLK_LVDS1 R8A7790_CLK_LVDS0
+			>;
+			clock-output-names +				"hscif1", "hscif0", "scif1", "scif0", "du2", "du1",
+				"du0", "lvds1", "lvds0";
+		};
+		mstp8_clks: mstp8_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+			clocks = <&p_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7790_CLK_ETHER>;
+			clock-output-names = "ether";
+		};
+		mstp9_clks: mstp9_clks {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+			clocks = <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1
+				R8A7790_CLK_I2C0
+			>;
+			clock-output-names = "i2c3", "i2c2", "i2c1", "i2c0";
+		};
+	};
 };
-- 
1.8.1.5

