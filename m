From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 07 Jan 2014 08:22:53 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Add VIN clocks to device tree
Message-Id: <1389082976-22254-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7d7d441..ae7d77e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -707,10 +707,13 @@
 		mstp8_clks: mstp8_clks@e6150990 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&p_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_ETHER>;
-			clock-output-names = "ether";
+			renesas,clock-indices = <
+				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
+				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
+			>;
+			clock-output-names = "vin3", "vin2", "vin1", "vin0", "ether";
 		};
 		mstp9_clks: mstp9_clks@e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.8.3.2

