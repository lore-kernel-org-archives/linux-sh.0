From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:10:29 +0000
Subject: [PROTOTYPE 3/8] ARM: shmobile: r8a7790: add dmac0,dmac1 clocks
Message-Id: <87ionyy455.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add clocks for the SYS-DMAC0 and SYS-DMAC1 hardware blocks.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 994330e..c9eb5e4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -758,16 +758,17 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>;
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
 				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
 				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
+				R8A7790_CLK_SYS_DMAC0 R8A7790_CLK_SYS_DMAC1
 			>;
 			clock-output-names  				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-				"scifb1", "msiof1", "msiof3", "scifb2";
+				"scifb1", "msiof1", "msiof3", "scifb2", "dmac0", "dmac1";
 		};
 		mstp3_clks: mstp3_clks@e615013c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.7.9.5

