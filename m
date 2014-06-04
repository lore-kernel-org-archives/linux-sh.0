From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:14:13 +0000
Subject: [PATCH 6/8] ARM: shmobile: r8a7790: add dmac0,dmac1 clocks
Message-Id: <1401898455-31064-7-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add clocks for the SYS-DMAC0 and SYS-DMAC1 hardware blocks.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

---

Fixes since initial submission:

	- Add sys- to front of the DMA name
	- Use zs_clk for parent of the dmac clocks
	- Re-order to DMAC1/DMAC0
---
 arch/arm/boot/dts/r8a7790.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 618e5b5..e8ca55d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -683,16 +683,17 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>;
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
 				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
 				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
+				R8A7790_CLK_SYS_DMAC1 R8A7790_CLK_SYS_DMAC0
 			>;
 			clock-output-names  				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-				"scifb1", "msiof1", "msiof3", "scifb2";
+				"scifb1", "msiof1", "msiof3", "scifb2", "sys-dmac1", "sys-dmac0";
 		};
 		mstp3_clks: mstp3_clks@e615013c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
2.0.0.rc2

