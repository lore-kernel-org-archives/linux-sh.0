From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Dec 2015 02:52:47 +0000
Subject: [PATCH/RFC 10/19] ARM: shmobile: r8a7793: add audio DMAC clocks to device tree
Message-Id: <1449802376-11301-11-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instantiate Audio DMA clocks in the r8a7791 device tree.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 7ee85a774542..13c0acc44ba7 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -916,10 +916,11 @@
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&extal_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7793_CLK_THERMAL>;
-			clock-output-names = "thermal";
+			clock-indices = <R8A7793_CLK_AUDIO_DMAC0 R8A7793_CLK_AUDIO_DMAC1
+					 R8A7793_CLK_THERMAL>;
+			clock-output-names = "audmac0", "audmac1", "thermal";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
 			compatible = "renesas,r8a7793-mstp-clocks",
-- 
2.1.4

